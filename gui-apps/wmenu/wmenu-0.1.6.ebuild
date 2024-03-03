# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="an efficient dynamic menu for Sway and wlroots based Wayland compositors"
HOMEPAGE="https://git.sr.ht/~adnano/wmenu"
SRC_URI="https://git.sr.ht/~adnano/wmenu/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

inherit meson

DEPEND="
	app-text/scdoc
	dev-libs/wayland-protocols
	sys-libs/glibc
	x11-base/xwayland
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libxkbcommon
	"
RDEPEND="${DEPEND}"
BDEPEND=""
