# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools xdg git-r3

DESCRIPTION="PulseAudio system tray"
HOMEPAGE="https://github.com/christophgysin/pasystray"

if [[ ${PV} == 9999 ]]
then
	EGIT_REPO_URI="https://github.com/christophgysin/${PN}"
else
	SRC_URI="https://github.com/christophgysin/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
fi

PATCHES="${FILESDIR}/configure.patch"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm ~x86"
IUSE="appindicator libnotify X zeroconf"

RDEPEND="
	dev-libs/glib
	|| (
		media-libs/libpulse[glib]
		media-sound/pulseaudio-daemon[glib,zeroconf?]
	)
	x11-libs/gtk+:3
	appindicator? ( dev-libs/libayatana-appindicator )
	X? ( x11-libs/libX11 )
	zeroconf? ( net-dns/avahi )
	libnotify? ( x11-libs/libnotify )
"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		--disable-appindicator \
		$(use_enable appindicator ayatana-appindicator) \
		$(use_enable X x11) \
		$(use_enable libnotify notify) \
		$(use_enable zeroconf avahi)
}
