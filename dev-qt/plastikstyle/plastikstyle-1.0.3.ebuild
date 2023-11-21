# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="This is a fork of QPlastiqueStyle from qt5-styleplugins and a port to qt6."
HOMEPAGE="https://github.com/MartinF99/PlastikStyle"
SRC_URI="https://github.com/MartinF99/PlastikStyle/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/PlastikStyle-${PV}"

inherit cmake

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+qt6 +qt5"
DEPEND="
	qt6? ( dev-qt/qtbase )
	qt5? ( dev-qt/qtcore )"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DENABLE_QT6="$(usex qt6)"
		-DENABLE_QT5="$(usex qt5)"
	)
	cmake_src_configure
}
