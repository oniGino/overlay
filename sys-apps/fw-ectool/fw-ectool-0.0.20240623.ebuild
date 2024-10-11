EAPI=8

GIT_COMMIT="0ac6155abbb7d4622d3bcf2cdf026dde2f80dad7"
SRC_URI="https://gitlab.howett.net/DHowett/ectool/-/archive/${GIT_COMMIT}/ectool-${GIT_COMMIT}.tar.bz2 -> $P.tar.bz2"
DESCRIPTION="EC manipulation tool for the Framework Laptop"
HOMEPAGE="https://gitlab.howett.net/DHowett/ectool"
LICENSE=BSD-3
SLOT=0
KEYWORDS="amd64"
S=$WORKDIR/ectool-$GIT_COMMIT

inherit cmake

CMAKE_BUILD_TYPE=Release

DEPEND="
	virtual/pkgconfig
	dev-libs/libusb:1
	dev-embedded/libftdi
	"

src_install() {
  dosbin ${BUILD_DIR}/src/ectool
}
