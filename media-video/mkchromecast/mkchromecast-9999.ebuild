# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8,9} )

SRC_URI=https://github.com/muammar/mkchromecast/archive/${PV}.tar.gz
if [[ ${PV} == *9999 ]]; then
	SCM="git-r3"
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/muammar/${PN}.git"
fi

inherit distutils-r1 ${SCM}

DESCRIPTION="Cast Audio/Video to your Google Cast and Sonos Devices"
HOMEPAGE="http://mkchromecast.com"

LICENSE="MIT"
SLOT="0"
RESTRICT="mirror"

KEYWORDS="~amd64 ~x86"
IUSE="alsa ffmpeg faac gstreamer nodejs +pulseaudio qt5 sox youtube-dl"

RDEPEND="	gstreamer? ( media-libs/gstreamer )
			pulseaudio? ( media-sound/pulseaudio )
			alsa? ( media-sound/alsa-utils )
			youtube-dl? ( net-misc/youtube-dl[${PYTHON_USEDEP}] )
			nodejs? ( net-libs/nodejs )"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/pychromecast[${PYTHON_USEDEP}]
	media-libs/mutagen[${PYTHON_USEDEP}]
	dev-python/flask[${PYTHON_USEDEP}]
	dev-python/netifaces[${PYTHON_USEDEP}]
	dev-python/psutil[${PYTHON_USEDEP}]
	sox? ( media-sound/sox )
	media-libs/flac
	faac? ( media-libs/faac )
	media-video/ffmpeg
	media-sound/lame
	qt5? ( dev-python/PyQt5[${PYTHON_USEDEP}] )
	"

