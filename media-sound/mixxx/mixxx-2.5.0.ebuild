# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg udev

MY_PV=$(ver_cut 1-2)
DESCRIPTION="Advanced Digital DJ tool based on Qt"
HOMEPAGE="https://mixxx.org/"
if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	if [[ ${PV} == ?.?.9999 ]] ; then
		EGIT_BRANCH=${PV%.9999}
	fi
	EGIT_REPO_URI="https://github.com/mixxxdj/${PN}.git"
else
	SRC_URI="https://github.com/mixxxdj/${PN}/archive/refs/tags/${PV/_/-}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm64 x86"
fi
LICENSE="GPL-2"
SLOT="0"
IUSE="aac +ffmpeg hid keyfinder lv2 modplug mp3 mp4 opus qtkeychain +rubberband shout test wavpack"
RESTRICT=""
S="${WORKDIR}/${P/_/-}"

RDEPEND="
	dev-cpp/benchmark
	dev-cpp/gtest
	dev-cpp/ms-gsl
	dev-db/sqlite
	dev-libs/glib:2
	dev-libs/protobuf:=
	dev-qt/qtbase[concurrent,cups,dbus,gui,network,opengl,sql,widgets,xml]
	dev-qt/qt5compat:6
	dev-qt/qtsvg:6
	dev-qt/qtdeclarative:6
	media-libs/chromaprint
	media-libs/flac:=
	media-libs/libebur128
	media-libs/libid3tag:=
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libsoundtouch
	media-libs/libvorbis
	media-libs/portaudio
	media-libs/portmidi
	rubberband? ( media-libs/rubberband )
	media-libs/taglib
	media-libs/vamp-plugin-sdk
	media-sound/lame
	sys-power/upower
	sys-libs/zlib
	virtual/glu
	virtual/libusb:1
	virtual/opengl
	virtual/udev
	test? (
		dev-util/gperf
	)
	aac? (
		media-libs/faad2
		media-libs/libmp4v2
	)
	ffmpeg? ( media-video/ffmpeg:= )
	hid? ( dev-libs/hidapi )
	keyfinder? ( media-libs/libkeyfinder )
	!keyfinder? ( sci-libs/fftw:3.0= )
	lv2? ( media-libs/lilv )
	modplug? ( media-libs/libmodplug )
	mp3? ( media-libs/libmad )
	mp4? ( media-libs/libmp4v2:= )
	opus? (	media-libs/opusfile )
	qtkeychain? (
		dev-libs/qtkeychain:=[qt6(+)]
	)
	wavpack? ( media-sound/wavpack )
"
	# libshout-idjc-2.4.6 is required. Please check and re-add once it's
	# available in ::gentoo
	# Meanwhile we're using the bundled libshout-idjc. See bug #775443
	#shout? ( >=media-libs/libshout-idjc-2.4.6 )

DEPEND="${RDEPEND}
"
BDEPEND="
	virtual/pkgconfig
"

PATCHES=(
	"${FILESDIR}"/${PN}-2.3.0-docs.patch
	"${FILESDIR}"/${PN}-2.3.0-cmake.patch
)

PLOCALES="
	ca cs de en es fi fr gl id it ja nl pl pt ro ru sl sq sr tr
"

mixxx_set_globals() {
	local lang
	local MANUAL_URI_BASE="https://downloads.mixxx.org/manual/${MY_PV}"
	for lang in ${PLOCALES} ; do
		SRC_URI+=" l10n_${lang}? ( ${MANUAL_URI_BASE}/${PN}-manual-${MY_PV}-${lang}.pdf )"
		IUSE+=" l10n_${lang/ en/ +en}"
	done
	SRC_URI+=" ${MANUAL_URI_BASE}/${PN}-manual-${MY_PV}-en.pdf"
}
mixxx_set_globals

src_configure() {
	local mycmakeargs=(
		-DGPERFTOOLS="$(usex test on off)"
		-DGPERFTOOLSPROFILER="$(usex test on off)"
		-DBATTERY="off"
		-DBROADCAST="$(usex shout on off)"
		-DCCACHE_SUPPORT="off"
		-DENGINEPRIME="OFF"
		-DFAAD="$(usex aac on off)"
		-DFFMPEG="$(usex ffmpeg on off)"
		-DHID="$(usex hid on off)"
		-DINSTALL_USER_UDEV_RULES=OFF
		-DKEYFINDER="$(usex keyfinder on off)"
		-DLILV="$(usex lv2 on off)"
		-DMAD="$(usex mp3 on off)"
		-DMODPLUG="$(usex modplug on off)"
		-DOPTIMIZE="off"
		-DOPUS="$(usex opus on off)"
		-DQT6="on"
		-DQTKEYCHAIN="$(usex qtkeychain on off)"
		-DRUBBERBAND="$(usex rubberband on off)"
		-DVINYLCONTROL="on"
		-DWAVPACK="$(usex wavpack on off)"
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install
	udev_newrules "${S}"/res/linux/mixxx-usb-uaccess.rules 69-mixxx-usb-uaccess.rules
	dodoc README.md CHANGELOG.md
	local locale
	for locale in ${PLOCALES} ; do
		if use l10n_${locale} ; then
			dodoc "${DISTDIR}"/${PN}-manual-${MY_PV}-${locale}.pdf
		fi
	done
}

pkg_postinst() {
	xdg_pkg_postinst
	udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	udev_reload
}
