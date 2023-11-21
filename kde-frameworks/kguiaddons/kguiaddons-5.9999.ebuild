# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ECM_NONGUI="false"
QTMIN=6.5.0
inherit ecm frameworks.kde.org

DESCRIPTION="Framework providing assorted high-level user interface components"

LICENSE="LGPL-2+"
KEYWORDS="~amd64"
IUSE="+dbus wayland X"
SLOT="6"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}[gui,dbus?,wayland?]
	wayland? (
		dev-libs/wayland
		>=dev-qt/qtwayland-${QTMIN}:6
	)
	X? (
		x11-libs/libX11
	)
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
	wayland? ( >=dev-libs/plasma-wayland-protocols-1.10.0 )
	X? ( x11-libs/libxcb )
"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DBUILD_GEO_SCHEME_HANDLER=ON # coordinate on/off with KF6
		-DWITH_DBUS=$(usex dbus)
		-DWITH_WAYLAND=$(usex wayland)
		-DWITH_X11=$(usex X)
	)
	ecm_src_configure
}
