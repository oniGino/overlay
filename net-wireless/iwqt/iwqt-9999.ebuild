# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson xdg

DESCRIPTION="Lightweight, graphical wifi management utility for Linux"
HOMEPAGE="https://github.com/fingu/iwqt"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/fingu/iwqt.git"
else
	SRC_URI="https://github.com/fingu/iwqt/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	dev-qt/qtbase[gui,widgets,svg]
	dev-cpp/sdbus-c++
"

BDEPEND="${COMMON_DEPEND}"

DEPEND="${COMMON_DEPEND}"

RDEPEND="
	${COMMON_DEPEND}
	>=net-wireless/iwd-1.29
"
