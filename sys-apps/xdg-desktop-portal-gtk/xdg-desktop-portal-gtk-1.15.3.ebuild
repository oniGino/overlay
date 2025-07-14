# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson systemd

MY_PV="${PV//_pre*}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Backend implementation for xdg-desktop-portal using GTK+"
HOMEPAGE="https://flatpak.org/ https://github.com/flatpak/xdg-desktop-portal-gtk"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${MY_PV}/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"
IUSE="wayland X +appchooser +settings +lockdown +wallpaper"

BDEPEND="
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
"

DEPEND="
	dev-libs/glib:2
	settings? (
		gnome-base/gsettings-desktop-schemas
		media-libs/fontconfig
	)
	wallpaper? (
		gnome-base/gnome-desktop
	)
	lockdown? (
		gnome-base/gsettings-desktop-schemas
	)
	sys-apps/dbus
	>=sys-apps/xdg-desktop-portal-1.14.0
	x11-libs/cairo[X?]
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[wayland?,X?]
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local emesonargs=(
		-Dsystemd-user-unit-dir="$(systemd_get_userunitdir)"
		$(meson_feature appchooser)
		$(meson_feature settings)
		$(meson_feature lockdown)
		$(meson_feature wallpaper)
	)

	meson_src_configure
}
