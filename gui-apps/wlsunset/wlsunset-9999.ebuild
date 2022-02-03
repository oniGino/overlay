# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd meson autotools eutils

DESCRIPTION="Sunset RedShift Daemon"
HOMEPAGE="https://git.sr.ht/~kennylevinsen/wlsunset"

if [[ ${PV} == 9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://git.sr.ht/~kennylevinsen/${PN}"
		EGIT_BRANCH="main"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm64 ~x86"
IUSE="+man"

DEPEND="dev-libs/wayland"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/ninja
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
	)
	meson_src_configure
}

