class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.8/oc-go-cc_darwin-arm64"
      sha256 "2240de64d81f44e251c4dd8d0fc99388f02d8b011232d48d0751a076c448a441"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.8/oc-go-cc_darwin-amd64"
      sha256 "8705d2e6e1e75135976e82aa8937f74c0e14a61e10856da12dede4ab620040e4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.8/oc-go-cc_linux-amd64"
      sha256 "6ea4a3247f7df323b7aaf535be42b36f6373d9d85d14d212df01dac2fbfbd217"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.8/oc-go-cc_linux-arm64"
      sha256 "9905ada906d150a440fca12cc3f7cd2afc60deb6ceb82b8187c3923f18e48eae"
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
