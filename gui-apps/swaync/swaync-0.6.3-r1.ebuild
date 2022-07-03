# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala gnome2-utils

MY_PN="SwayNotificationCenter"
DESCRIPTION="A simple notification daemon with a GTK gui for notifications and control center"
HOMEPAGE="https://github.com/ErikReider/SwayNotificationCenter"
SRC_URI="https://github.com/ErikReider/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+man scripting systemd bash-completion fish-completion"

DEPEND="
	systemd? ( sys-apps/systemd )
	bash-completion? ( app-shells/bash-completion )
	fish-completion? ( app-shells/fish )
	sys-apps/dbus
	x11-libs/gtk+:3
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/json-glib
	dev-libs/libgee:=
	dev-libs/wayland
	>=gui-libs/gtk-layer-shell-0.6.0
	gui-libs/libhandy:1
"
RDEPEND="${DEPEND}"
BDEPEND="
	$(vala_depend)
	man? ( app-text/scdoc )
"

src_prepare() {
	default
	vala_setup
}

src_configure() {
	local emesonargs=(
		$(meson_use man man-pages)
		$(meson_use scripting)
		$(meson_use systemd systemd-service)
		$(meson_use bash-completion bash-completions)
		$(meson_use fish-completion fish-completions)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
