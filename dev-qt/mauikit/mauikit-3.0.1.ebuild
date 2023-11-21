# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_QTHELP="true"
KDE_ORG_CATEGORY="maui"
KFMIN=5.95.0
QTMIN=5.15.2
inherit ecm kde.org

SRC_URI="https://invent.kde.org/maui/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.bz2"
DESCRIPTION="Templated convergent controls and multiplatform utilities for Maui applications"
S="${WORKDIR}/${PN}-v${PV}"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtdeclarative-${QTMIN}:5
	>=dev-qt/qtconcurrent-${QTMIN}:5
	>=dev-qt/qtquickcontrols2-${QTMIN}:5
	>=dev-qt/qtsvg-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=dev-qt/mauiman-${PV}
"
RDEPEND="${DEPEND}
	>=x11-libs/libxcb-1.16
	>=dev-qt/qtgraphicaleffects-${QTMIN}:5
"

