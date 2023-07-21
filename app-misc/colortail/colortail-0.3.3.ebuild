
EAPI=8

inherit autotools

DESCRIPTION="Colortail custom colors your log files and works like tail"
SRC_URI="https://github.com/joakim666/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="https://github.com/joakim666/colortail"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"
BDEPEND=""

#S=${WORKDIR}/${P}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf
}

src_install()  {
	default
	docompress -x "/usr/share/doc/${PF}/conf"
	docinto conf
	dodoc example-conf/conf*
}
