# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=5.245.0
QTMIN=6.5.0
inherit ecm frameworks.kde.org

DESCRIPTION="Framework for solving common problems such as caching, randomisation, and more"

LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="qch"
SLOT="6"

DEPEND="
	>=dev-qt/qtbase-${QTMIN}[gui]
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kguiaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DBUILD_QCH=$(use qch)
	)

	ecm_src_configure
}

