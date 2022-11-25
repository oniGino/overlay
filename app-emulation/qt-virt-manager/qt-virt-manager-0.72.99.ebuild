# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/F1ash/qt-virt-manager.git"
	EGIT_BRANCH="master"
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="https://github.com/F1ash/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A GUI application for managing virtual machines"
HOMEPAGE="https://github.com/F1ash/qt-virt-manager"

LICENSE="GPL-2"
SLOT="0"
IUSE="lxc smartcard spice vnc"

DEPEND="
	lxc? ( app-containers/lxc )
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtmultimedia:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtnetwork:5
	lxc? ( >=x11-libs/qtermwidget-0.7.0 )
	smartcard? ( >=app-emulation/libcacard-2.5.0 )
	dev-libs/glib
	spice? ( net-misc/spice-gtk )
	vnc? ( net-libs/libvncserver )
	app-emulation/libvirt
"
REQUIRED_USE="smartcard? ( spice )"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/cmake
"

src_configure() {
	local mycmakeargs=(
		-DWITH_SPICE_SUPPORT="$(usex spice ON OFF)"
		-DWITH_VNC_SUPPORT="$(usex vnc ON OFF)"
		-DWITH_LXC_SUPPORT="$(usex lxc ON OFF)"
		-DWITH_LIBCACARD="$(usex smartcard ON OFF)"
	)
	cmake_src_configure
}

