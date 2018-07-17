# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Plasma Widget for Syncthing Daemon"
HOMEPAGE="https://github.com/Martchus/syncthingtray"

inherit cmake-utils

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Martchus/${PN}.git"
else
	SRC_URI="https://github.com/Martchus/${PN}/archive/${PV}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+kde +cli +systray systemd"

DEPEND="
		dev-qt/qtnetwork
		dev-qt/qtsvg
		dev-qt/qtgui
		dev-qt/qtwidgets
		dev-qt/qtcore:5
		systemd? ( dev-qt/qtdbus )
		kde? ( dev-qt/qtdeclarative 
			   kde-frameworks/plasma 
			 )
		dev-qt/qtwebengine
		net-p2p/syncthing"
RDEPEND="
		${DEPEND}"

src_unpack() {
	default
	
	if [[ ${PV} = *9999* ]]; then
		git-r3_fetch "https://github.com/Martchus/syncthingtray.git"
		git-r3_checkout "https://github.com/Martchus/syncthingtray.git" "${WORKDIR}"/syncthingtray
		git-r3_fetch "https://github.com/Martchus/cpp-utilities.git" 
		git-r3_checkout "https://github.com/Martchus/cpp-utilities.git" "${WORKDIR}"/c++utilities
		git-r3_fetch "https://github.com/Martchus/qtutilities.git"
		git-r3_checkout "https://github.com/Martchus/qtutilities.git" "${WORKDIR}"/qtutilities
		git-r3_fetch "https://github.com/Martchus/subdirs.git"
		git-r3_checkout "https://github.com/Martchus/subdirs.git" "${WORKDIR}"/subdirs
	else
		true
	fi
}

S="${WORKDIR}/${PN}"
CMAKE_USE_DIR="${WORKDIR}"/subdirs/syncthingtray

src_compile() {
	local mycmakeargs=(
		-DUSE_LIBSYNCTHING=OFF
		-DWEBVIEW_PROVIDER=webengine
		-DNO_MODEL=OFF
		-DNO_DOXYGEN=ON
		-DNO_LIBSYNCTHING=ON
		-DNO_PLASMOID=$(usex kde false true)
		-DNO_WIDGETS=$(usex kde false true)
		-DNO_CLI=$(usex cli false true)
		-DNO_TRAY=$(usex systray false true)
		-DSYSTEMD_SUPPORT=$(usex systemd)
	)
}
