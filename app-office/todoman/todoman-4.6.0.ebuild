# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
PYTHON_REQ_USE="sqlite"
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
inherit distutils-r1 pypi

DESCRIPTION="A CalDAV based todo manager"
HOMEPAGE="https://todoman.readthedocs.io/ https://github.com/pimutils/todoman"

RESTRICT="mirror"

if [[ "$PV" = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI=https://github.com/pimutils/todoman.git
else
	SRC_URI="https://github.com/pimutils/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"
fi

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~riscv ~x86"

RDEPEND="
	dev-python/atomicwrites[${PYTHON_USEDEP}]
	dev-python/click-log[${PYTHON_USEDEP}]
	dev-python/click[${PYTHON_USEDEP}]
	dev-python/icalendar[${PYTHON_USEDEP}]
	dev-python/parsedatetime[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/tzlocal[${PYTHON_USEDEP}]
	dev-python/urwid[${PYTHON_USEDEP}]
	dev-python/humanize[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-python/freezegun[${PYTHON_USEDEP}]
		dev-python/hypothesis[${PYTHON_USEDEP}]
	)
"

DOCS=( AUTHORS.rst CHANGELOG.rst docs/source/contributing.rst README.rst config.py.sample )

distutils_enable_tests pytest

export SETUPTOOLS_SCM_PRETEND_VERSION=${PV}

src_prepare() {
		default
		sed -i '/^\[build-system\]/a\
		build-backend="setuptools.build_meta"' pyproject.toml || die
}

src_install() {
	distutils-r1_src_install
	newbin bin/todo todoman
}
