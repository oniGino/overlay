# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

HOMEPAGE="https://github.com/heather7283/pipemixer"
SRC_URI="https://github.com/heather7283/pipemixer/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
SLOT="0"

inherit meson

DEPEND="
	dev-libs/inih
	media-video/pipewire
	sys-libs/ncurses
"

src_configure() {
	emasonargs="
		-Dsystem_libraries=true
	"
	meson_src_configure
}
