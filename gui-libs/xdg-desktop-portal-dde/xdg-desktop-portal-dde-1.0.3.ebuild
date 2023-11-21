# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A backend implementation for xdg-desktop-portal on Deepin desktop environment"
HOMEPAGE="https://github.com/linuxdeepin/xdg-desktop-portal-dde"
SRC_URI="https://github.com/linuxdeepin/${PN}/archive/refs/tags/${PV}.tar.gz"

inherit ecm cmake

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"
KFMIN="5.54"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtdbus:5
	dev-qt/qtdbus:5
	dev-qt/qtwidgets:5
	dev-qt/qtwaylandscanner:5
	sys-apps/xdg-desktop-portal
	dev-libs/wayland
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/knotifications-${KFMIN}:5
"
RDEPEND="${DEPEND}"
BDEPEND=""
