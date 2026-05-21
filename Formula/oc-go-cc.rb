class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.6/oc-go-cc_darwin-arm64"
      sha256 "415853ed9d6209a46a63e58ad2318b981fad4d961ab422f8721f34175364e58f"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.6/oc-go-cc_darwin-amd64"
      sha256 "52ff4bc11b7d926b5e1424702db491d072ff3bf3aeb973433bcfc714491fd7a7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.6/oc-go-cc_linux-amd64"
      sha256 "a0ba4f3b934e6692341f6001ec4a8cdeed5d8ca4479268b62e41ffdd9b1d0613"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.6/oc-go-cc_linux-arm64"
      sha256 "caa338df107defb5e5c9364c026fc63134276f1516111e9751fdb3ea1d4e05e0"
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
