# Copyright 2020-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit systemd toolchain-funcs

DESCRIPTION="small audio and MIDI framework part of the OpenBSD project"
HOMEPAGE="http://www.sndio.org/"
if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://caoua.org/git/sndio"
	EGIT_MIN_CLONE_TYPE="single+tags"
else
	SRC_URI="http://www.sndio.org/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~riscv ~sparc ~x86"
fi

LICENSE="ISC"
SLOT="0/7.1"
IUSE="alsa"

DEPEND="
	dev-libs/libbsd
	alsa? ( media-libs/alsa-lib )
"
RDEPEND="
	${DEPEND}
	acct-user/sndiod
"

PATCHES=( "${FILESDIR}"/sndio-1.8.0-fix-hardcoded-pkgconfdir.patch )

src_configure() {
	tc-export CC

	./configure \
		--prefix="${EPREFIX}"/usr \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--privsep-user=sndiod \
		--with-libbsd \
		$(use_enable alsa) \
	|| die "Configure failed"
}

src_install() {
	systemd_dounit "contrib/sndiod.service"
	doinitd "${FILESDIR}/sndiod"
	mkdir -p "${D}/etc/default"
	mv -vf "${S}/contrib/default.sndiod" "${D}/etc/default/sndiod" || die
	default
}
