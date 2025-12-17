# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.18.0
QTMIN=6.9.1
KDE_ORG_NAME="plasma-workspace"

inherit xdg ecm plasma.kde.org

DESCRIPTION="The goal of this project is to make xembed system trays available in Plasma"

LICENSE="LGPL-2+"
SLOT="6"
KEYWORDS="~amd64"

COMMON_DEPEND="
	>=dev-libs/wayland-1.15
	>=dev-qt/qtbase-${QTMIN}:6=[dbus]
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/kcrash-${KFMIN}:6
	x11-libs/libxcb
	x11-libs/xcb-util-image
	x11-libs/xcb-util
"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"
RDEPEND+=" || ( >=dev-qt/qtbase-6.10:6[wayland] <dev-qt/qtwayland-6.10:6 )"

BDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[wayland]
	virtual/pkgconfig
"
BDEPEND+=" || ( >=dev-qt/qtbase-6.10:6[wayland] <dev-qt/qtwayland-6.10:6 )"

S="${WORKDIR}/${KDE_ORG_NAME}-${PV}/${PN}"

ECM_KDEINSTALLDIRS=true
ECM_HANDBOOK=false
ECM_DEBUG=false

src_prepare() {
	ecm_src_prepare
	mv ../cmake .
	mv ../*.cmake .
	sed -i "1i\
	cmake_minimum_required(VERSION 3.16)\n\n\
	project(xembed-sni-proxy)\n\
	set(PROJECT_DEP_VERSION "${PV}")\n\
	set(QT_MIN_VERSION "${QTMIN}")\n\
	set(KF6_MIN_VERSION "${KFMIN}")\n\
	set(CMAKE_CXX_STANDARD 23)\n\
	set(CMAKE_CXX_STANDARD_REQUIRED ON)\n\
	find_package(ECM ${KF6_MIN_VERSION} REQUIRED NO_MODULE)\n\
	include(KDEInstallDirs)\n\
	find_package(PkgConfig REQUIRED)\n\
	include_directories("${CMAKE_CURRENT_BINARY_DIR}")\n\
	set(HAVE_X11 0)\n\
	set(HAVE_XCURSOR 0)\n\
	set(HAVE_XFIXES 0)\n\
	" CMakeLists.txt || die
	default
}


