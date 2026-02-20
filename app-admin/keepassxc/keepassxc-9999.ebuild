# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg git-r3

DESCRIPTION="KeePassXC - KeePass Cross-platform Community Edition"
HOMEPAGE="https://keepassxc.org"

FORK_OWNER="varjolintu"
FORK_BRANCH="qt6_ver2"


EGIT_BRANCH="develop"
EGIT_REPO_URI="https://github.com/keepassxreboot/${PN}"

KEYWORDS="~amd64 ~arm64 ~ppc64 ~riscv ~x86"
# COPYING order
LICENSE="|| ( GPL-2 GPL-3 ) BSD LGPL-2.1 MIT LGPL-2 CC0-1.0 Apache-2.0 GPL-2+ BSD-2"
SLOT="0"
IUSE="X autotype browser doc keeshare +keyring +network +ssh-agent test yubikey"

RESTRICT="!test? ( test )"
REQUIRED_USE="autotype? ( X )"

RDEPEND="
	app-crypt/argon2:=
	dev-libs/botan:3=
	dev-libs/zxcvbn-c
	dev-qt/qtbase[concurrent,dbus,gui,network,widgets]
	dev-qt/qtsvg:6
	media-gfx/qrencode:=
	sys-libs/readline:0=
	virtual/minizip:=
	autotype? (
		x11-libs/libX11
		x11-libs/libXtst
	)
	yubikey? (
		dev-libs/libusb:1
		sys-apps/pcsc-lite
	)
"
DEPEND="
	${RDEPEND}
"
BDEPEND="
	doc? (
		dev-ruby/asciidoctor
	)
"

src_unpack() {
	default
	git-r3_src_unpack

	git-r3_fetch "https://github.com/${FORK_OWNER}/keepassxc.git" refs/heads/${FORK_BRANCH} fork

	# Merge the Qt6_ver2 branch
	git merge --no-ff fork -m "Merge Qt6_ver2 branch from varjolintu" || {
		einfo "Merge conflicts detected. Attempting automatic conflict resolution..."
		git merge --abort || die "Failed to abort merge"

		# Alternative: cherry-pick if full merge fails
		einfo "Trying cherry-pick approach instead..."
		git cherry-pick -X recursive -X theirs fork/${FORK_BRANCH} || {
			ewarn "Merge and cherry-pick both failed. Manual intervention may be needed."
			einfo "Continuing with develop branch only..."
			git merge --abort || true
		}
	}
}


src_prepare() {
	if ! [[ "${PV}" =~ _beta|9999 ]]; then
		echo "${PV}" > .version || die
	fi

	# Unbundle zxcvbn, bug 958062
	rm -r ./src/thirdparty/zxcvbn || die

	cmake_src_prepare
}

src_configure() {
	local -a mycmakeargs=(
		# Gentoo users enable ccache via e.g. FEATURES=ccache or
		# other means. We don't want the build system to enable it for us.
		-DWITH_CCACHE="OFF"
		-DWITH_GUI_TESTS="OFF"
		-DWITH_XC_BOTAN3="ON"
		-DWITH_XC_UPDATECHECK="OFF"

		-DWITH_TESTS="$(usex test)"
		-DWITH_XC_AUTOTYPE="$(usex autotype)"
		-DWITH_XC_BROWSER="$(usex browser)"
		-DWITH_XC_BROWSER_PASSKEYS="$(usex browser)"
		-DWITH_XC_DOCS="$(usex doc)"
		-DWITH_XC_FDOSECRETS="$(usex keyring)"
		-DWITH_XC_KEESHARE="$(usex keeshare)"
		-DWITH_XC_NETWORKING="$(usex network)"
		-DWITH_XC_SSHAGENT="$(usex ssh-agent)"
		-DWITH_XC_X11="$(usex X)"
		-DWITH_XC_YUBIKEY="$(usex yubikey)"
	)

	if [[ "${PV}" == *_beta* ]] ; then
		mycmakeargs+=(
			-DOVERRIDE_VERSION="${PV/_/-}"
		)
	fi

	cmake_src_configure
}
