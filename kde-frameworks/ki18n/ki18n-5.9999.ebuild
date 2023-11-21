# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..12} )
QTMIN=6.5.0
inherit ecm frameworks.kde.org python-single-r1

DESCRIPTION="Framework based on Gettext for internationalizing user interface text"
LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="qml"
SLOT="6"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

COMMON_DEPEND="${PYTHON_DEPS}
	>=dev-qt/qtbase-${QTMIN}
	qml? ( >=dev-qt/qtdeclarative-${QTMIN}:6 )
	sys-devel/gettext
	virtual/libintl
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	app-text/iso-codes
"

pkg_setup() {
	ecm_pkg_setup
	python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_WITH_QML=$(usex qml)
		-DPYTHON_EXECUTABLE="${PYTHON}"
	)
	ecm_src_configure
}

src_test() {
	# requires LANG fr_CH. bugs 823816, 879223
	local myctestargs=( -E "(kcatalogtest|kcountrytest|kcountrysubdivisiontest)" )
	ecm_src_test
}
