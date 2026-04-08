
EAPI="8"

inherit go-module go-env

SRC_URI="https://github.com/Cladamos/clawea/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"
SLOT="0"

EGO_SUM=(
	"github.com/NimbleMarkets/ntcharts v0.4.0"
	"github.com/NimbleMarkets/ntcharts v0.4.0/go.mod"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
	"github.com/charmbracelet/bubbles v0.21.0"
	"github.com/charmbracelet/bubbles v0.21.0/go.mod"
	"github.com/charmbracelet/bubbletea v1.3.10"
	"github.com/charmbracelet/bubbletea v1.3.10/go.mod"
	"github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc"
	"github.com/charmbracelet/colorprofile v0.2.3-0.20250311203215-f60798e515dc/go.mod"
	"github.com/charmbracelet/lipgloss v1.1.0"
	"github.com/charmbracelet/lipgloss v1.1.0/go.mod"
	"github.com/charmbracelet/x/ansi v0.10.1"
	"github.com/charmbracelet/x/ansi v0.10.1/go.mod"
	"github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd"
	"github.com/charmbracelet/x/cellbuf v0.0.13-0.20250311204145-2c3ea96c31dd/go.mod"
	"github.com/charmbracelet/x/term v0.2.1"
	"github.com/charmbracelet/x/term v0.2.1/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f"
	"github.com/erikgeiser/coninput v0.0.0-20211004153227-1c3628e74d0f/go.mod"
	"github.com/lrstanley/bubblezone v0.0.0-20240914071701-b48c55a5e78e"
	"github.com/lrstanley/bubblezone v0.0.0-20240914071701-b48c55a5e78e/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-localereader v0.0.1"
	"github.com/mattn/go-localereader v0.0.1/go.mod"
	"github.com/mattn/go-runewidth v0.0.16"
	"github.com/mattn/go-runewidth v0.0.16/go.mod"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6"
	"github.com/muesli/ansi v0.0.0-20230316100256-276c6243b2f6/go.mod"
	"github.com/muesli/cancelreader v0.2.2"
	"github.com/muesli/cancelreader v0.2.2/go.mod"
	"github.com/muesli/termenv v0.16.0"
	"github.com/muesli/termenv v0.16.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/stretchr/testify v1.11.1"
	"github.com/stretchr/testify v1.11.1/go.mod"
	"github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e"
	"github.com/xo/terminfo v0.0.0-20220910002029-abceb7e1c41e/go.mod"
	"golang.org/x/exp v0.0.0-20220909182711-5c715a9e8561"
	"golang.org/x/exp v0.0.0-20220909182711-5c715a9e8561/go.mod"
	"golang.org/x/sys v0.0.0-20210809222454-d867a43fc93e/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.36.0"
	"golang.org/x/sys v0.36.0/go.mod"
	"golang.org/x/text v0.20.0"
	"golang.org/x/text v0.20.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/ini.v1 v1.67.1"
	"gopkg.in/ini.v1 v1.67.1/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
)

go-module_set_globals
SRC_URI+="${EGO_SUM_SRC_URI}"

LICENSE="MIT"

src_compile() {
	go-env_set_compile_environment
	ego build
}

src_install() {
	dobin ${PN}
}

