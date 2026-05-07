class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.24"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.24/oc-go-cc_darwin-arm64"
      sha256 "eaf156cafb2a7f86fa036dd64f19e197165ec26874263699868b88eea23edbd7"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.24/oc-go-cc_darwin-amd64"
      sha256 "c43791f460f343d835d6aaae0d177ddf66c7e04f7b22b395dbd54e37c67f997a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.24/oc-go-cc_linux-amd64"
      sha256 "0f10b0e3098ea1971f52046eeb84ec5c168e0153c61a71e33420325352f2941d"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.24/oc-go-cc_linux-arm64"
      sha256 "b71bce2ad4a06e87b076b0009548100161c151f6b21e31d50a8681198e010001"
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
