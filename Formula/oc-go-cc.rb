class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.5/oc-go-cc_darwin-arm64"
      sha256 "236ec6c7fb4aaf2f6b887da324f2719905df800a2e4e629d665e1de19b2c9049"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.5/oc-go-cc_darwin-amd64"
      sha256 "57e0252591b1c2048903db8b03c9ed333594003dc41bb10a0c6fa0b4b8186dd8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.5/oc-go-cc_linux-amd64"
      sha256 "8e15ef2a7bf1a133f08581e0fea830a8d3b3d1fc87bc95a634a7cdd6ea558087"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.5/oc-go-cc_linux-arm64"
      sha256 "f2c2d18e4fc2b5dcc03872eb9b4af6265650352145104ae1118bc27ae4f79fc5"
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
