# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="Small, lightweight file manager based on pure Qt"
HOMEPAGE="https://qtfm.eu/"
if [ "${PV}" == "9999" ]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rodlie/qtfm/"
else
	SRC_URI="https://github.com/rodlie/qtfm/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi
LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+dbus +udisks imagemagick ffmpeg +tray"

RDEPEND="
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	sys-apps/file
	imagemagick? (
		dev-util/pkgconf
		media-gfx/imagemagick
		ffmpeg? ( media-video/ffmpeg )
	)
	dbus? ( dev-qt/qtdbus:5 )
"
DEPEND="${RDEPEND}"
BDEPEND="
	app-arch/unzip
	dev-qt/linguist-tools:5
"
REQUIRED_USE="
	imagemagick? ( ffmpeg )
	udisks? ( dbus )
	tray? ( dbus )
"
src_configure() {
	local mycmakeargs=(
		-DENABLE_MAGICK=$(usex imagemagick)
		-DENABLE_FFMPEG=$(usex ffmpeg)
		-DENABLE_DBUS=$(usex dbus)
		-DENABLE_UDISKS=$(usex udisks)
		-DENABLE_TRAY=$(usex tray)
	)
	cmake_src_configure
}
