# Copyright 1999-2019 Gentoo Authors 
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/snapcore/${PN}"
EGO_SRC="${EGO_PN}/..."

#EGIT_COMMIT="7d3222250d98ff1baf8ad4e7df283b40a35d960c"

EGO_VENDOR=(
	"github.com/kardianos/govendor v1.0.8"
	"github.com/coreos/go-systemd v19"
	"github.com/godbus/dbus v5.0.1"
	"github.com/gorilla/mux v1.7.1"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/juju/ratelimit v1.0.1"
	"github.com/ojii/gettext.go HEAD"
	"github.com/snapcore/bolt v1.3.1"
	"github.com/snapcore/squashfuse HEAD"
	"golang.org/x/crypto HEAD github.com/golang/crypto"
	"golang.org/x/sys HEAD github.com/golang/sys"
	"gopkg.in/macaroon.v1 ab101776739ee61baab9bc50e4b33b5aeb3ac843 github.com/go-macaroon/macaroon"
	"gopkg.in/mgo.v2 9856a29383ce1c59f308dd1cf0363a79b5bef6b5 github.com/go-mgo/mgo"
	"gopkg.in/retry.v1 v1.0.2 github.com/go-retry/retry"
	"gopkg.in/tomb.v2 d5d1b5820637886def9eef33e03a27a9f166942c github.com/go-tomb/tomb"
	"gopkg.in/yaml.v2 v2.2.2 github.com/go-yaml/yaml"
	#Runtimes
	"github.com/mvo5/goconfigparser HEAD"
	#snap-seccomp
	#"github.com/mvo5/libseccomp-golang v0.9.0"
	)

inherit golang-build golang-vcs-snapshot systemd xdg-utils
DESCRIPTION="Service and tools for management of snap packages"
HOMEPAGE="http://snapcraft.io/"
SRC_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${PF}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

IUSE="systemd"

# mirrors are restricted for unofficial packages
RESTRICT="mirror"

RDEPEND="sys-fs/squashfs-tools:*[xz]"
DEPEND="${RDEPEND}
	dev-vcs/git
	dev-vcs/bzr"

# TODO: ensure that used kernel supports xz compression for squashfs
# TODO: enable tests
# TODO: ship man page for snap
# TODO: put /var/lib/snpad/desktop on XDG_DATA_DIRS

src_compile() {
	export GOPATH="${S}:$(get_golibdir_gopath)"
	cd src/${EGO_PN} || die
	./get-deps.sh
	go install -v "${EGO_PN}/cmd/snapd" || die
	go install -v "${EGO_PN}/cmd/snap" || die
	go install -v "${EGO_PN}/cmd/snapctl" || die
	go install -v "${EGO_PN}/cmd/snap-exec" || die
	go install -v "${EGO_PN}/cmd/snap-failure" || die
	go install -v "${EGO_PN}/cmd/snap-repair" || die
	#go install -v "${EGO_PN}/cmd/snap-seccomp" || die #Requires xfs header
	go install -v "${EGO_PN}/cmd/snap-update-ns" || die
}

src_install() {
	# Install snap and snapd
	export GOPATH="${WORKDIR}/${P}"
	exeinto /usr/bin
	dobin "$GOPATH/bin/snap"
	dobin "$GOPATH/bin/snapctl"
	exeinto /usr/lib/snapd/
	doexe "$GOPATH/bin/snapd"
	doexe "$GOPATH/bin/snap-exec"
	doexe "$GOPATH/bin/snap-failure"
	doexe "$GOPATH/bin/snap-repair"
	#doexe "$GOPATH/bin/snap-seccomp"
	doexe "$GOPATH/bin/snap-update-ns"

	if use systemd; then
		cd "src/${EGO_PN}" || die
		# Install systemd units
		systemd_dounit debian/snapd.{service,socket}
		systemd_dounit debian/snapd.refresh.{service,timer}
		# Work around https://github.com/zyga/snapd-gentoo/issues/1
		sed -i -e 's/RandomizedDelaySec=/#RandomizedDelaySec=/' debian/snapd.refresh.timer
		# NOTE: the two "frameworks" units should be dropped upstream soon
		systemd_dounit debian/snapd.frameworks.target
		systemd_dounit debian/snapd.frameworks-pre.target
	fi
	# Put /snap/bin on PATH
	#dodir /etc/profile.d/
	#echo 'PATH=$PATH:/snap/bin' > ${D}/etc/profile.d/snapd.sh
	cd "src/${EGO_PN}"/data || die
	insinto /lib/udev/rules.d
	doins udev/rules.d/66-snapd-autoimport.rules
	insinto /etc/sysctl.d
	doins sysctl/rhel7-snap.conf
	insinto /usr/share/polkit-1/rules.d
	doins polkit/io.snapcraft.snapd.policy
	cd dbus
	emake DESTDIR="${D}" install
	cd ../env
	emake DESTDIR="${D}" install
	cd ../desktop
	emake DESTDIR="${D}" install
}

pkg_postinst() {
	xdg_desktop_database_update()
	if use systemd; then
		systemctl enable snapd.socket
		systemctl enable snapd.refresh.timer
	fi
}

# added package post-removal instructions for tidying up added services
pkg_postrm() {
	if use systemd; then
		systemctl disable snapd.service
		systemctl stop snapd.service
		systemctl disable snapd.socket
		systemctl disable snapd.refresh.timer
	fi
}
