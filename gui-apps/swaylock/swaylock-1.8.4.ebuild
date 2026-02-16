# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit fcaps meson

DESCRIPTION="Screen locker for Wayland"
HOMEPAGE="https://github.com/swaywm/swaylock"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
else
	SRC_URI="https://github.com/swaywm/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="bash-completion zsh-completion fish-completion +gdk-pixbuf +man +pam"

DEPEND="
	dev-libs/wayland
	x11-libs/cairo
	x11-libs/libxkbcommon
	virtual/libcrypt:=
	gdk-pixbuf? ( x11-libs/gdk-pixbuf:2 )
	pam? ( sys-libs/pam )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-libs/wayland-protocols-1.25
	>=dev-util/wayland-scanner-1.15
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		"$(meson_feature pam)"
		"$(meson_feature gdk-pixbuf)"
		"$(meson_feature man man-pages)"
		"$(meson_use fish-completion fish-completions)"
		"$(meson_use zsh-completion zsh-completions)"
		"$(meson_use bash-completion bash-completions)"
	)

	meson_src_configure
}

src_install() {
	meson_src_install
	use pam || fperms u+s /usr/bin/swaylock
}

pkg_postinst() {
	use pam || fcaps -M u-s cap_dac_read_search usr/bin/swaylock
}
