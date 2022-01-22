# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Wrapper for Basic NeoMutt Stuff"

LICENSE="metapackage"
SLOT="5"
KEYWORDS="amd64 ~arm64 ~x86"

RDEPEND="
	dev-python/vdirsyncer
	mail-client/neomutt
	net-mail/isync
	app-misc/khal
	app-misc/khard
	mail-mta/msmtp
"

