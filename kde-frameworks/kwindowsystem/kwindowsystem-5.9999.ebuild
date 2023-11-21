# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

QTMIN=6.5.0
inherit ecm frameworks.kde.org

DESCRIPTION="Framework providing access to properties and features of the window manager"

LICENSE="|| ( LGPL-2.1 LGPL-3 ) MIT"
KEYWORDS="~amd64"
IUSE="wayland X"
SLOT="6"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}[gui,wayland?]
	wayland? (
		>=dev-qt/qtdeclarative-${QTMIN}:6
		>=dev-qt/qtwayland-${QTMIN}:6
		>=dev-libs/plasma-wayland-protocols-1.10.0
		dev-libs/wayland-protocols
	)
	X? (
		x11-libs/libX11
		x11-libs/libXfixes
		x11-libs/libxcb
		x11-libs/xcb-util-keysyms
	)
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
"

DOCS=( docs/README.kstartupinfo )

src_configure() {
	local mycmakeargs=(
		-DKWINDOWSYSTEM_QML=$(usex qml)
		-DKWINDOWSYSTEM_WAYLAND=$(usex wayland)
		-DKWINDOWSYSTEM_X11=$(usex x11)
	)

	ecm_src_configure
}
