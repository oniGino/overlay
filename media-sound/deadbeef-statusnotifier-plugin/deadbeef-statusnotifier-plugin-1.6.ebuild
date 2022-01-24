# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

if [[ -z ${PV%%*9999} ]]; then
	EGIT_REPO_URI="https://github.com/vovochka404/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/vovochka404/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

inherit cmake

DESCRIPTION="Plugin that provides system tray icon for deadbeef using appindicator"
HOMEPAGE="https://github.com/vovochka404/${PN}"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	media-sound/deadbeef
	dev-libs/libdbusmenu
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/glib-utils
"

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DUSE_GTK=OFF
		-DUSE_GTK3=ON
	)
	cmake_src_configure
}

