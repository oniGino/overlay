
EAPI=8

KEYWORDS="~amd64"
RESTRICT="mirror"
SLOT=0
HOMEPAGE="https://github.com/jurkovic-nikola/OpenLinkHub"
SRC_URI="https://github.com/jurkovic-nikola/OpenLinkHub/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

inherit udev go-module

MY_PN="OpenLinkHub"
S="${WORKDIR}/${MY_PN}-${PV}"

EGO_SUM=(
	"github.com/godbus/dbus/v5 v5.1.0"
	"github.com/godbus/dbus/v5 v5.1.0/go.mod"
	"github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0"
	"github.com/golang/freetype v0.0.0-20170609003504-e2365dfdc4a0/go.mod"
	"github.com/sstallion/go-hid v0.14.1"
	"github.com/sstallion/go-hid v0.14.1/go.mod"
	"golang.org/x/image v0.26.0"
	"golang.org/x/image v0.26.0/go.mod"
	"golang.org/x/sys v0.32.0"
	"golang.org/x/sys v0.32.0/go.mod"
	"golang.org/x/text v0.24.0"
	"golang.org/x/text v0.24.0/go.mod"
)

DEPEND="
	virtual/libusb
	sys-apps/usbutils
"

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

src_compile() {
	ego build
}

src_install() {
	dodir "/opt/${MY_PN}"
	into "/opt/${MY_PN}"
	mv "${S}/database" "${ED}/opt/${MY_PN}"
	mv "${S}/static" "${ED}/opt/${MY_PN}"
	mv "${S}/web" "${ED}/opt/${MY_PN}"
    dobin "${MY_PN}"
	systemd_dounit "${S}/OpenLinkHub.service"
	udev_dorules "${S}/99-openlinkhub.rules"
    einstalldocs
	dodoc LICENSE
}

