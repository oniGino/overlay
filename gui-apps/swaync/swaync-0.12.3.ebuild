# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala gnome2-utils cmake

MY_PN="SwayNotificationCenter"
DESCRIPTION="A simple notification daemon with a GTK gui for notifications and control center"
HOMEPAGE="https://github.com/ErikReider/SwayNotificationCenter"
SRC_URI="https://github.com/ErikReider/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+man scripting systemd bash-completion fish-completion pulseaudio zsh-completion"

# Bug: https://github.com/mesonbuild/meson/pull/14647
DEPEND="
	>=dev-build/meson-1.8.2
	bash-completion? ( app-shells/bash-completion )
	fish-completion? ( app-shells/fish )
	pulseaudio? ( media-libs/libpulse[glib] )
	systemd? ( sys-apps/systemd )
	zsh-completion? ( app-shells/zsh )
	dev-lang/sassc
	dev-libs/glib:2
	dev-libs/gobject-introspection
	gui-libs/gtk:4[wayland,introspection]
	gui-libs/gtk4-layer-shell[introspection]
	gui-libs/libadwaita
	sys-apps/dbus
	>=dev-libs/wayland-1.23.0
	>=dev-libs/libgee-0.20.6
	>=dev-libs/json-glib-1.0
	>=dev-libs/granite-7.5.0
	>=dev-util/blueprint-compiler-0.16
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
		$(meson_use pulseaudio pulse-audio)
		$(meson_use systemd systemd-service)
		$(meson_use bash-completion bash-completions)
		$(meson_use fish-completion fish-completions)
		$(meson_use zsh-completion zsh-completions)
	)
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
