# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )

inherit autotools edo python-any-r1 toolchain-funcs xdg

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/HandBrake/HandBrake.git"
	inherit git-r3
else
	MY_P="HandBrake-${PV}"
	SRC_URI="https://github.com/HandBrake/HandBrake/releases/download/${PV}/${MY_P}-source.tar.bz2 -> ${P}.tar.bz2"
	S="${WORKDIR}/${MY_P}"
	KEYWORDS="~amd64 ~arm64 ~x86"
fi

DESCRIPTION="Open-source, GPL-licensed, multiplatform, multithreaded video transcoder"
HOMEPAGE="https://handbrake.fr/ https://github.com/HandBrake/HandBrake"

LICENSE="GPL-2"
SLOT="0"
IUSE="dolby +fdk gstreamer gtk3 gtk4 numa nvenc x265" # TODO: qsv vce

REQUIRED_USE="
	numa? ( x265 )
	?? ( gtk3 gtk4 )
"

RDEPEND="
	media-libs/a52dec
	>=media-libs/dav1d-1.3.0:=
	>=media-video/ffmpeg-6.1:=[postproc,fdk?]
	dev-libs/fribidi
	dev-libs/jansson:=
	media-sound/lame
	>=media-libs/libass-0.17.0:=
	media-libs/libdvdnav
	>=media-libs/libdvdread-6.1.3:=
	>=media-libs/libbluray-1.3.4:=
	>=media-libs/libjpeg-turbo-3.0.1:=
	>=media-libs/libogg-1.3.5
	media-libs/libtheora
	media-libs/libvorbis
	>=media-libs/libvpx-1.13.1:=
	>=dev-libs/libxml2-2.11.5
	>=media-libs/opus-1.4
	>=media-libs/speex-1.2.1
	>=media-libs/svt-av1-1.8
	>=media-libs/x264-0.0.20220222:=
	>=app-arch/xz-utils-5.4.5
	>=media-libs/zimg-3.0.5
	>=sys-libs/zlib-1.3
	dolby? ( >=media-libs/libdovi-3.2.0 )
	fdk? ( media-libs/fdk-aac:= )
	gstreamer? (
		media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0
		media-libs/gst-plugins-good:1.0
		media-libs/gst-plugins-bad:1.0
		media-libs/gst-plugins-ugly:1.0
		media-plugins/gst-plugins-a52dec:1.0
		media-plugins/gst-plugins-libav:1.0
		media-plugins/gst-plugins-x264:1.0
		media-plugins/gst-plugins-gdkpixbuf:1.0
	)
	gtk4? (
		>=gui-libs/gtk-4.4
	)
	gtk3? (
		>=x11-libs/gtk+-3.22
		dev-libs/dbus-glib
		>=dev-libs/glib-2.56
		dev-libs/libgudev:=
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/libnotify
		x11-libs/pango
	)
	nvenc? (
		media-libs/nv-codec-headers
		media-video/ffmpeg[nvenc]
	)
	x265? ( >=media-libs/x265-3.5-r2:=[10bit,12bit,numa?] )
"
DEPEND="${RDEPEND}"
# cmake needed for custom script: bug #852701
BDEPEND="
	${PYTHON_DEPS}
	dev-lang/nasm
	dev-util/cmake
"

src_prepare() {
	# Get rid of leftover bundled library build definitions,
	sed -i 's:.*\(/contrib\|contrib/\).*::g' \
		"${S}"/make/include/main.defs \
		|| die "Contrib removal failed."

	default
}

src_configure() {
	tc-export AR RANLIB STRIP

	local myconfargs=(
		--force
		--verbose
		--prefix="${EPREFIX}/usr"
		--disable-flatpak
		$(use_enable gtk3 gtk)
		$(use_enable gtk4)
		$(use_enable gstreamer gst )
		$(use_enable x265)
		$(use_enable numa)
		$(use_enable dolby libdovi)
		$(use_enable fdk fdk-aac)
		--enable-ffmpeg-aac # Forced on
		$(use_enable nvenc)
	)
		# TODO: $(use_enable qsv)
		# TODO: $(use_enable vce)
	edo ./configure "${myconfargs[@]}"
}

src_compile() {
	emake -C build
}

src_install() {
	emake -C build DESTDIR="${D}" install
	dodoc README.markdown AUTHORS.markdown NEWS.markdown THANKS.markdown
}

pkg_postinst() {
	einfo "Gentoo builds of HandBrake are NOT SUPPORTED by upstream as they"
	einfo "do not use the bundled (and often patched) upstream libraries."
	einfo ""
	einfo "Please do not raise bugs with upstream because of these ebuilds,"
	einfo "report bugs to Gentoo's bugzilla or Multimedia forum instead."

	einfo "For the CLI version of HandBrake, you can use \`HandBrakeCLI\`."
	if use gtk3 || use gtk4; then
		einfo "For the GTK+ version of HandBrake, you can run \`ghb\`."
	fi

	xdg_pkg_postinst
}
