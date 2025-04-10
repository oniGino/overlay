# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit meson python-single-r1 vala udev xdg

DESCRIPTION="Aims to make updating firmware on Linux automatic, safe and reliable"
HOMEPAGE="https://fwupd.org"
SRC_URI="https://github.com/${PN}/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~loong ppc64 ~riscv x86"
IUSE="+archive bash-completion fish-completion bluetooth cbor +daemon +drm flashrom gnutls gtk-doc introspection modemmanager protobuf policykit systemd test uefi man"
REQUIRED_USE="${PYTHON_REQUIRED_USE}
	test? ( archive )
"
RESTRICT="!test? ( test )"

BDEPEND="$(vala_depend)
	$(python_gen_cond_dep '
		dev-python/jinja2[${PYTHON_USEDEP}]
	')
	>=dev-build/meson-1.3.2
	virtual/pkgconfig
	sys-apps/hwdata
	gtk-doc? (
		$(python_gen_cond_dep '
			>=dev-python/markdown-3.2[${PYTHON_USEDEP}]
		')
		>=dev-util/gi-docgen-2021.1
	)
	bash-completion? ( >=app-shells/bash-completion-2.0 )
	fish-completion? ( app-shells/fish )
	introspection? ( dev-libs/gobject-introspection )
	test? (
		net-libs/gnutls[tools]
	)
"
COMMON_DEPEND="${PYTHON_DEPS}
	app-arch/xz-utils
	>=app-arch/gcab-1.0
	dev-db/sqlite
	>=dev-libs/glib-2.72:2
	>=dev-libs/json-glib-1.6.0
	>=dev-libs/libjcat-0.1.4[gpg,pkcs7]
	>=dev-libs/libxmlb-0.3.19:=[introspection?]
	$(python_gen_cond_dep '
		dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	')
	>=net-misc/curl-7.62.0
	archive? ( app-arch/libarchive:= )
	cbor? ( >=dev-libs/libcbor-0.7.0:= )
	drm? ( >=x11-libs/libdrm-2.4.124 )
	flashrom? ( >=sys-apps/flashrom-1.2-r3 )
	gnutls? ( >=net-libs/gnutls-3.6.0 )
	virtual/libusb:1
	modemmanager? ( net-misc/modemmanager[mbim,qmi] )
	protobuf? ( dev-libs/protobuf-c )
	policykit? ( >=sys-auth/polkit-0.114 )
	systemd? ( >=sys-apps/systemd-211 )
"
RDEPEND="
	${COMMON_DEPEND}
	sys-apps/dbus
"

DEPEND="
	${COMMON_DEPEND}
	x11-libs/pango[introspection]
"

src_prepare() {
	default

	vala_setup

	sed -e "/install_dir.*'doc'/s/doc/gtk-doc/" \
		-i docs/meson.build || die

	python_fix_shebang "${S}"/contrib/*.py
}

src_configure() {
	local plugins=(
	)

	local emesonargs=(
		--localstatedir "${EPREFIX}"/var
		-Dbuild="$(usex daemon all standalone )"
		-Defi_binary="false"
		-Dsupported_build="enabled"
		-Dsystemd_unit_user=""
		-Dpassim="disabled"
		$(meson_feature archive libarchive)
		$(meson_use bash-completion bash_completion)
		$(meson_use fish-completion fish_completion)
		$(meson_feature bluetooth bluez)
		$(meson_feature cbor)
		$(meson_feature drm libdrm)
		$(meson_feature gnutls)
		$(meson_feature gtk-doc docs)
		$(meson_feature introspection)
		$(meson_use man)
		$(meson_feature policykit polkit)
		$(meson_feature systemd)
		$(meson_use test tests)
		$(meson_feature protobuf)
		$(meson_use uefi plugin_uefi_capsule_splash)
		$(meson_feature flashrom plugin_flashrom)
		$(meson_feature modemmanager plugin_modem_manager)
	)
	emesonargs+=( -Defi_os_dir="gentoo" )
	export CACHE_DIRECTORY="${T}"
	meson_src_configure
}

src_test() {
	LC_ALL="C" meson_src_test
}

src_install() {
	meson_src_install

	if use daemon; then
		newinitd "${FILESDIR}"/${PN}-r2 ${PN}
	fi

	if use test; then
		# Preventing tests from being installed in the first place is a moving target,
		# just axe them all afterwards.
		rm -rf \
			"${ED}"/usr/libexec/installed-tests \
			"${ED}"/usr/share/fwupd/device-tests \
			"${ED}"/usr/share/fwupd/host-emulate.d/thinkpad-p1-iommu.json.gz \
			"${ED}"/usr/share/fwupd/remotes.d/fwupd-tests.conf \
			"${ED}"/usr/share/installed-tests \
		|| die
	fi
}

pkg_postinst() {
	xdg_pkg_postinst
	! use daemon|| udev_reload
}

pkg_postrm() {
	xdg_pkg_postrm
	! use daemon|| udev_reload
}
