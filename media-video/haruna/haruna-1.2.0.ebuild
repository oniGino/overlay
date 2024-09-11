# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.0.0
QTMIN=6.6.0

inherit kde.org ecm

DESCRIPTION="Video player built with Qt/QML on top of libmpv"
HOMEPAGE="https://invent.kde.org/multimedia/haruna"
SRC_URI="https://download.kde.org/stable/${PN}/${PV}/${P}.tar.xz"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="youtube"

RDEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,dbus]
	>=dev-qt/qtdeclarative-${QTMIN}:6
	>=dev-libs/kirigami-addons-1.4.0:6
	>=kde-frameworks/breeze-icons-${KFMIN}:6
	>=kde-frameworks/kcolorscheme-${KFMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdoctools-${KFMIN}:6
	>=kde-frameworks/kfilemetadata-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kiconthemes-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-frameworks/qqc2-desktop-style-${KFMIN}:6
	media-video/ffmpeg
	media-libs/mpvqt
	youtube? ( net-misc/yt-dlp )"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext"

src_configure() {
	local mycmakeargs=(
		$(cmake_use_find_package youtube Ytdlp)
	)
	ecm_src_configure
	cmake_src_configure
}
