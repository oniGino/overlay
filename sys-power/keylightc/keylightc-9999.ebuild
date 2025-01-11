

EAPI=8

HOMEPAGE="https://gitlab.com/mamarley/keylightc#keylightc"
DESCRIPTION="a small system daemon for Framework laptops that listens to keyboard and touchpad input"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.com/mamarley/keylightc.git"
else
	exit 1
fi

SLOT="0"
LICENSE="GPL-2 GPL-3"
KEYWORDS="~amd64"

DEPEND="sys-libs/glibc"

src_compile() {
        emake CFLAGS="" CC="gcc"
}
