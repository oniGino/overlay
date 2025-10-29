
EAPI=8

SLOT="0"
KEYWORDS="~amd64"

inherit meson

DESCRIPTION="clipboard manager for wayland"
HOMEPAGE="https://github.com/heather7283/cclip"
SRC_URI="https://github.com/heather7283/cclip/archive/refs/tags/${PV}.tar.gz -> ${P}.gh.tar.gz"

DEPENDS="
	dev-db/sqlite
	dev-util/wayland-scanner
	dev-libs/wayland
	"
