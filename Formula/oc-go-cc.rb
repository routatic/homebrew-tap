class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.0/oc-go-cc_darwin-arm64"
      sha256 "0dcd0aba132c9c9f652a17f5bcba484d9d5913b015648059b2d3885e54e038a9"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.0/oc-go-cc_darwin-amd64"
      sha256 "18ce50765cd843368fea7e1db06a221b08347ccca0b11e6e03ff1c876db49fd9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.0/oc-go-cc_linux-amd64"
      sha256 "dc0262d12b54f90dcd3b9c415b735a34efcc5ecc30ab523231c0e83436938691"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.0/oc-go-cc_linux-arm64"
      sha256 "f8c53fa369f10bfe2a0aed0a077c88dd62d3fa74a1ed9253fccfbd95d5b6c769"
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
