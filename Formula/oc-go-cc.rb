class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.6/oc-go-cc_darwin-arm64"
      sha256 "01ea0c758882f383e2eda495fe8cf58f94bda39c716de7cb0ba80f4f8f0f6042"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.6/oc-go-cc_darwin-amd64"
      sha256 "2201c82b8881d9175211d76576ada7d91cc22138b957a18d5ea1fdfc14af48af"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.6/oc-go-cc_linux-amd64"
      sha256 "08dd8fa6eb06d5c5d5187cf51ac51ed75cd2643df6a82f0ca7afae3320548018"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.6/oc-go-cc_linux-arm64"
      sha256 "320e930036cd5060daf9436073df1efd9b9aeeaf4f7b718b4c2cbcb915602732"
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
