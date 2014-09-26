# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-en/myspell-en-20081002.ebuild,v 1.17 2012/05/17 18:12:22 aballier Exp $

LINGUAS="en_AU en_US en_GB en_CA en_NZ en_ZA en_GB"

MYSPELL_SPELLING_DICTIONARIES=(
"en,US,en_US,English (United States),en_US.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"en,US,hyph_en_GB,English (United States),hyph_en_GB.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"en,US,th_en_US_v2,English (United States),thes_en_US_v2.zip"
)

inherit myspell

DESCRIPTION="English dictionaries for myspell/hunspell"
LICENSE="GPL-2 LGPL-2.1 Princeton myspell-en_CA-KevinAtkinson"
HOMEPAGE="http://lingucomponent.openoffice.org/"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""
