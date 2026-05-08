class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.3/oc-go-cc_darwin-arm64"
      sha256 "dce41116e622aa15e0b8493c98e7b8615eae3afdc5e638959fcf97f44c19e5dd"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.3/oc-go-cc_darwin-amd64"
      sha256 "25e7a94f905bac732724795fbc88ecde98c1d2000a5fc9fcad0023c24c3f35b4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.3/oc-go-cc_linux-amd64"
      sha256 "6345da0ae9294c741b5e3c2fab12b947c4785950b3edfb323c7bf410434d9c03"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.3/oc-go-cc_linux-arm64"
      sha256 "139fa8b897ed54fdca9c92314de92efff2b7406213b4971b7ce7ba84143553a5"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oc-go-cc_darwin-arm64" => "oc-go-cc"
    elsif OS.mac?
      bin.install "oc-go-cc_darwin-amd64" => "oc-go-cc"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "oc-go-cc_linux-amd64" => "oc-go-cc"
    else
      bin.install "oc-go-cc_linux-arm64" => "oc-go-cc"
    end
  end

  def caveats
    <<~EOS
      To get started with oc-go-cc:

        1. Initialize configuration:
           oc-go-cc init

        2. Set your OpenCode Go API key:
           export OC_GO_CC_API_KEY=sk-opencode-your-key

        3. Start the proxy:
           oc-go-cc serve

        4. Configure Claude Code:
           export ANTHROPIC_BASE_URL=http://127.0.0.1:3456
           export ANTHROPIC_AUTH_TOKEN=unused

        5. Run Claude Code:
           claude
    EOS
  end

  test do
    system "#{bin}/oc-go-cc", "--version"
  end
end
