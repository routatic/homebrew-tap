class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.2/oc-go-cc_darwin-arm64"
      sha256 "de85c70904d69ea113e3824bf5beef41c569243c101fdbc41044e1c3be215225"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.2/oc-go-cc_darwin-amd64"
      sha256 "25e24f1f3134e72039123181b551e178b3ce6e82efec503af0aff8bfbde27746"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.2/oc-go-cc_linux-amd64"
      sha256 "0d6a180b741bd7dd75cf9caf4dcddf6092dbfa58f2f31efafadd048c2b597ffb"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.2/oc-go-cc_linux-arm64"
      sha256 "b576b6a93f113a4b795d18d5b1c3a48a12c96724212c098e48fb4a49bb7bc7a1"
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
