# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit kde.org ecm

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://invent.kde.org/multimedia/${PN}.git"
else
	SRC_URI="https://download.kde.org/stable/${PN}/${P}.tar.xz"
fi
KFMIN=5.112.0
QTMIN=5.15.11

DESCRIPTION="Video player built with Qt/QML on top of libmpv"
HOMEPAGE="https://invent.kde.org/multimedia/haruna"
LICENSE="GPL-3"
KEYWORDS=""
SLOT="0"
IUSE="youtube"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[concurrent,dbus,gui,widgets,xml]
	>=kde-frameworks/breeze-icons-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
	media-video/mpv[libmpv]
	youtube? ( net-misc/yt-dlp )"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext"

src_configure() {
	local mycmakeargs=(
		-DQT_MAJOR_VERSION=6
		$(cmake_use_find_package youtube Ytdlp)
	)
	ecm_src_configure
	cmake_src_configure
}
