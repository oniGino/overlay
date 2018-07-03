# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python3_5 python3_6 )
DISTUTILS_SINGLE_IMPL=1
DISABLE_AUTOFORMATTING=true
inherit eutils distutils-r1 readme.gentoo git-r3 xdg-utils

DESCRIPTION="A cross-platform music tagger"
HOMEPAGE="http://picard.musicbrainz.org/"
EGIT_REPO_URI="https://github.com/metabrainz/picard.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+acoustid +cdda nls"

LANGS="zh_TW zh_CN vi uk tr te ta sv sr sl sk sco ru ro pt_BR pt pl pa oc nl ne nds nb mr lt ko kn ja  it is id hu hr hi he gl fy fr_CA fr fo fi fa et es eo en_GB en_CA en el de da cy cs ca bg ast ar af"
for lang in ${LANGS}; do
	IUSE+=" l10n_${lang}"
done

DEPEND="dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=media-libs/mutagen-1.40.0[${PYTHON_USEDEP}]
	cdda? ( dev-python/python-discid[${PYTHON_USEDEP}] )
	acoustid? ( >=media-libs/chromaprint-1.0[tools] )"
RDEPEND="${DEPEND}"

RESTRICT="test" # doesn't work with ebuilds
DOCS="AUTHORS.txt NEWS.txt"

DOC_CONTENTS="If you are upgrading Picard and it does not start,
try removing Picard's settings:
    rm ~/.config/MusicBrainz/Picard.conf

You should set the environment variable BROWSER to something like
    firefox '%s' &
to let python know which browser to use."

src_compile() {
	distutils-r1_src_compile $(use nls || echo "--disable-locales")
}

_clean_up_locales() {
	einfo "Cleaning up locales..."
	for lang in ${LANGS}; do
		use "l10n_${lang}" && {
			einfo "- keeping ${lang}"
			continue
		}
		rm -r "${ED}"/usr/share/locale/"${lang}" || die
	done
}

src_install() {
	distutils-r1_src_install --disable-autoupdate --skip-build \
		$(use nls || echo "--disable-locales")

	doicon picard.ico
	domenu picard.desktop
	readme.gentoo_create_doc
	_clean_up_locales
}
