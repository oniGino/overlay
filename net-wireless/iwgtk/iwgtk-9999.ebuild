# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 xdg

DESCRIPTION="GTK Frontend for IWD"
HOMEPAGE="https://github.com/J-Lentz/iwgtk"
EGIT_REPO_URI="https://github.com/J-Lentz/${PN}.git"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64"

DEPEND="gui-libs/gtk
		net-wireless/iwd"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	sed -i \
		-e 's/^CC=/CC?=/' \
		-e 's/^CFLAGS=/CFLAGS:=$(CFLAGS) /' \
		-e 's/^LDLIBS=/LDLIBS:=$(LDFLAGS) /' \
		-e 's/-O3$/${CFLAGS}/' \
		-e 's/^autostartdir=/autostartdir=$(PREFIX)/' \
		Makefile || die
}

src_install() {
	emake PREFIX="${ED}/usr" install
	gunzip "${ED}/usr/share/man/man1/iwgtk.1.gz" || die
}

