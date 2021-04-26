# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit desktop python-r1 distutils-r1

MY_PV="${PV/_p/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTON="Kawaii-Player is Audio/Video manager and mutlimedia player (based on mpv and mplayer)"
HOMEPAGE="https://github.com/kanishka-linux/kawaii-player"
SRC_URI="https://github.com/kanishka-linux/kawaii-player/releases/download/v${MY_PV}/${MY_P}.tar.bz2 -> ${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="youtube X bittorrent pycurl mpris"

DEPEND=">=x11-libs/libnotify-0.7.8
	dev-python/beautifulsoup:4
	dev-python/certifi
	mpris? ( dev-python/dbus-python )
	dev-python/lxml
	dev-python/pyopengl
	dev-python/pillow
	pycurl? ( dev-python/pycurl )
	youtube? ( dev-python/PyQtWebEngine )
	dev-python/PyQt5
	media-libs/mutagen
	dev-db/sqlite
	bittorrent? ( net-libs/libtorrent-rasterbar )
	media-video/mpv[libmpv]
	X? ( x11-misc/xvfb-run )
	youtube? ( net-misc/youtube-dl )
	"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	python_foreach_impl distutils-r1_python_install
	newicon "${S}/kawaii_player/resources/tray.png" "${PN}.png"
	make_desktop_entry "${PN}" "Kawaii-Player" "${PN}.png" \
		"AudioVideo;Audio;Video;" "Terminal=false\nStartupNotify=false"
}

