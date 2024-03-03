# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="KDSingleApplication is a helper class for single-instance policy applications"
HOMEPAGE="https://github.com/KDAB/KDSingleApplication/"
SRC_URI="https://github.com/KDAB/KDSingleApplication/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="qt6 static"

BDEPEND=""
COMMON_DEPEND="
	!qt6? (
		dev-qt/qtcore:5
	)
	qt6? (
		dev-qt/qtbase
	)
"
RDEPEND="${COMMON_DEPEND}"
DEPEND="${COMMON_DEPEND}"

DOCS=( LICENSE.txt README.md )

src_configure() {
	local mycmakeargs=(
		-DKDSingleApplication_QT6="$(usex qt6)"
		-DKDSingleApplication_STATIC="$(usex static)"
		-DKDSingleApplication_EXAMPLES=false
	)

	cmake_src_configure
}

