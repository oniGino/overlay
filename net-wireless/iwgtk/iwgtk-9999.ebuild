# Copyright 2020-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson xdg

DESCRIPTION="Lightweight, graphical wifi management utility for Linux"
HOMEPAGE="https://github.com/J-Lentz/iwgtk"
if [[ ${PV} == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/J-Lentz/iwgtk.git"
else
	SRC_URI="https://github.com/J-Lentz/iwgtk/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

COMMON_DEPEND="
	app-accessibility/at-spi2-core:2
	dev-libs/glib:2
	gui-libs/gtk:4
	media-gfx/qrencode:=
	x11-libs/cairo:0
	x11-libs/gdk-pixbuf:2
	x11-libs/pango:0
"

BDEPEND="app-text/scdoc"

DEPEND="
	${COMMON_DEPEND}
	x11-base/xorg-proto
"

RDEPEND="
	${COMMON_DEPEND}
	>=net-wireless/iwd-1.29
"
