# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Highly customizable Wayland bar for Sway and Wlroots based compositors"
HOMEPAGE="https://github.com/Alexays/Waybar"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Alexays/${PN^}.git"
else
	SRC_URI="https://github.com/Alexays/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN^}-${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE="cava evdev experimental gps jack libcxx +libinput +logind +man mpd mpris network pipewire pulseaudio sndio systemd test tray +udev upower wifi"
REQUIRED_USE="
	upower? ( logind )
"

RESTRICT="!test? ( test )"

BDEPEND="
	man? ( >=app-text/scdoc-1.9.2 )
	dev-util/gdbus-codegen
	virtual/pkgconfig
"
RDEPEND="
	dev-cpp/cairomm:0
	dev-cpp/glibmm:2
	dev-cpp/gtkmm:3.0
	dev-libs/jsoncpp:=
	dev-libs/libinput:=
	dev-libs/libsigc++:2
	>=dev-libs/libfmt-9.1.0-r2:=
	>=dev-libs/spdlog-1.10.0:=
	dev-libs/wayland
	gui-libs/gtk-layer-shell
	x11-libs/gtk+:3[wayland]
	x11-libs/libxkbcommon
	cava? ( =media-sound/cava-0.10.4[sdl] )
	evdev? ( dev-libs/libevdev:= )
	gps? ( sci-geosciences/gpsd )
	jack? ( virtual/jack )
	libinput? ( dev-libs/libinput:= )
	logind? (
		|| ( sys-apps/systemd
			 sys-auth/elogind )
	)
	mpd? ( media-libs/libmpdclient )
	mpris? ( >=media-sound/playerctl-2 )
	network? ( dev-libs/libnl:3 )
	pipewire? ( media-video/wireplumber:0/0.5 )
	pulseaudio? ( media-libs/libpulse )
	sndio? ( media-sound/sndio:= )
	systemd? ( sys-apps/systemd:= )
	tray? (
		dev-libs/libayatana-appindicator
		dev-libs/libdbusmenu[gtk3]
	)
	udev? ( virtual/libudev:= )
	upower? ( sys-power/upower:= )
	wifi? ( sys-apps/util-linux )
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
	test? ( dev-cpp/catch:0 )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
		$(meson_feature cava)
		$(meson_feature evdev libevdev)
		$(meson_feature gps)
		$(meson_feature jack)
		$(meson_feature libinput)
		$(meson_feature logind logind login-proxy)
		$(meson_feature mpd)
		$(meson_feature mpris)
		$(meson_feature network libnl)
		$(meson_feature pulseaudio)
		$(meson_feature pipewire wireplumber)
		$(meson_feature pipewire)
		$(meson_feature sndio)
		$(meson_feature systemd)
		$(meson_feature test tests)
		$(meson_feature tray dbusmenu-gtk)
		$(meson_feature udev libudev)
		$(meson_feature upower upower_glib)
		$(meson_feature wifi rfkill)
		$(meson_use libcxx)
		$(meson_use experimental)
	)
	meson_src_configure
}
