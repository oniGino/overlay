# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit eutils qmake-utils

DESCRIPTION="Qt5 music player"
HOMEPAGE="http://flavio.tordini.org/musique"
# Same tarball for every release. We repackage it
if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/flaviotordini/${PN}.git"
else
	SRC_URI="https://github.com/flaviotordini/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

LANGS="zh_TW zh_CN vi uk tt tr sr sk ru ro pt_BR pt pl nl nb ms_MY lt_LT ky it ia hu_HU gl fr fi_FI fa_IR es_MX es_ES es en_GB en el de da ca_ES cs_CZ ca bg be ast"

for lang in ${LANGS}; do
	IUSE+=" l10n_${lang}"
done

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets
	dev-qt/qtnetwork
	dev-qt/qtsingleapplication[qt5]
	dev-qt/qtscript
	dev-qt/qtsql:5[sqlite]
	|| ( media-libs/phonon[qt5] dev-qt/qtphonon:5 )
	media-libs/taglib
"
DEPEND="${RDEPEND}"

DOCS="CHANGES TODO"

src_prepare () {
	epatch "${FILESDIR}"/${P}-qtsingle.patch
}

src_configure() {
	eqmake5 ${PN}.pro PREFIX=/usr
}

_clean_up_locales() {
	einfo "Cleaning up locales..."
	for lang in ${LANGS}; do
	use "l10n_${lang}" && {
		einfo "- keeping ${lang}"
		continue
		}
	rm "${ED}"/usr/share/musique/locale/"${lang}".qm || die
	done
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	_clean_up_locales
}
