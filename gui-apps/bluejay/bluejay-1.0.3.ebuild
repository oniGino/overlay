# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

SRC_URI="https://github.com/EbonJaeger/bluejay/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="MPL-2.0"
SLOT="0"

DESCRIPTION="A Bluetooth manager and Bluez front-end"
HOMEPAGE="https://github.com/EbonJaeger/bluejay"

DEPEND="
	dev-libs/kirigami-addons
	dev-qt/qtbase[dbus,gui,widgets]
	dev-qt/qtquick3d:6
	kde-frameworks/extra-cmake-modules
	kde-frameworks/bluez-qt
	kde-frameworks/kcoreaddons
	kde-frameworks/kdbusaddons
	kde-frameworks/ki18n
	kde-frameworks/kirigami
	kde-frameworks/qqc2-desktop-style
"
