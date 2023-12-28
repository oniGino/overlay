# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson desktop

DESCRIPTION="graphical application for configuring displays in Wayland compositors"
HOMEPAGE="https://github.com/artizirk/wdisplays"
SRC_URI="https://github.com/artizirk/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3 MIT"
IUSE=""
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	media-libs/libepoxy
	x11-libs/gtk+[wayland]
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"
DOCS="CHANGELOG.md README.md"

