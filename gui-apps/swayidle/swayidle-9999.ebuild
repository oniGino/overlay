# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Idle management daemon for Wayland"
HOMEPAGE="https://github.com/swaywm/swayidle"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/swaywm/${PN}.git"
else
	SRC_URI="https://github.com/swaywm/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 arm64 ~loong ~ppc64 ~riscv x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE="elogind +man systemd bash-completion fish-completion zsh-completion"
REQUIRED_USE="?? ( elogind systemd )"

DEPEND="
	dev-libs/wayland
	elogind? ( >=sys-auth/elogind-237[policykit] )
	systemd? ( >=sys-apps/systemd-237[policykit] )
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-libs/wayland-protocols-1.27
	virtual/pkgconfig
	man? ( app-text/scdoc )
"

PATCHES=( "${FILESDIR}/${PN}-${PV}-dbus-inhibit.patch" )

src_configure() {
	local emesonargs=(
		-Dman-pages=$(usex man enabled disabled)
		"$(meson_use fish-completion fish-completions)"
		"$(meson_use zsh-completion zsh-completions)"
		"$(meson_use bash-completion bash-completions)"
	)
	if use systemd; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=systemd")
	elif use elogind; then
		emesonargs+=("-Dlogind=enabled" "-Dlogind-provider=elogind")
	else
		emesonargs+=("-Dlogind=disabled")
	fi

	meson_src_configure
}
