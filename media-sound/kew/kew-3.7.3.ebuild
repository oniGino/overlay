

EAPI=8

SLOT="0"
KEYWORDS="~amd64"


DESCRIPTION="Music for the Shell"
HOMEPAGE="https://github.com/ravachol/kew"
SRC_URI="https://github.com/ravachol/kew/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
IUSE="faad"
RESTRICT="mirror"

DEPEND="
	sci-libs/fftw
	media-gfx/chafa
	media-libs/opus
	media-libs/opusfile
	media-libs/libvorbis
	media-libs/libogg
	media-libs/taglib
	dev-libs/glib
	virtual/pkgconfig
	faad? ( media-libs/faad2 )
	"

src_install() {
    # We explicitly tell make that PREFIX should be /usr
    # and DESTDIR is the temporary sandbox (ED is 'EPREFIX/D')
    emake DESTDIR="${D}" PREFIX="/usr" install
}

