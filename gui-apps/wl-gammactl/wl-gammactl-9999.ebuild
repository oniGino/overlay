# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd meson autotools eutils xdg-utils

DESCRIPTION="A screen color temperature adjusting software"
HOMEPAGE="https://github.com/mischw/wl-gammactl"

if [[ ${PV} == 9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/mischw/${PN}.git"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE=""

DEPEND="
	gui-libs/wlroots
	x11-libs/gtk+:3
	>=dev-libs/wayland-1.15.0
	"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=()
	meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
