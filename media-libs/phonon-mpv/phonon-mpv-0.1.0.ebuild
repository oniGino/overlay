# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake flag-o-matic kde.org multibuild

DESCRIPTION="MPV backend for the Phonon multimedia library"
HOMEPAGE="https://community.kde.org/Phonon"

if [[ ${KDE_BUILD_TYPE} = release ]]; then
	SRC_URI="https://github.com/OpenProgger/${PN}/archive/refs/tags/v${PV}.tar.gz"
	KEYWORDS="amd64 ~arm arm64 ~loong ppc64 ~riscv x86"
fi

LICENSE="LGPL-2.1+ || ( LGPL-2.1 LGPL-3 )"
SLOT="0"
IUSE="debug"

DEPEND="
	>=media-libs/phonon-4.12.0[minimal]
	media-video/mpv:=[vorbis(+)]
	dev-qt/qtbase:6[gui,widgets]
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-libs/libpcre2:*
	>=kde-frameworks/extra-cmake-modules-6.5.0:*
	virtual/pkgconfig
	dev-qt/qttools:6[linguist]
"

pkg_setup() {
	MULTIBUILD_VARIANTS=( "qt6" )
}

src_configure() {
	use debug || append-cppflags -DQT_NO_DEBUG

	myconfigure() {
		local mycmakeargs=(
			-DQT_MAJOR_VERSION=${MULTIBUILD_VARIANT/qt/}
			-DPHONON_BUILD_${MULTIBUILD_VARIANT^^}=ON
			-DKDE_INSTALL_USE_QT_SYS_PATHS=ON # ecm.eclass
			-DKDE_INSTALL_DOCBUNDLEDIR="${EPREFIX}/usr/share/help" # ecm.eclass
			-DPHONON_BUILD_QT5=OFF
		)

		cmake_src_configure
	}

	multibuild_foreach_variant myconfigure
}

src_compile() {
	multibuild_foreach_variant cmake_src_compile
}

src_install() {
	multibuild_foreach_variant cmake_src_install
}
