# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Common C++ classes and routines such as argument parser, IO and conversion utilities"
HOMEPAGE="https://github.com/Martchus/cpp-utilities"
SRC_URI="https://github.com/Martchus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs test"

DEPEND="test? ( dev-util/cppunit )"

RESTRICT="
	!test? ( test )
	mirror
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
		-DBUILD_SHARED_LIBS:BOOL=$(usex !static-libs)
	)
	cmake_src_configure
}
