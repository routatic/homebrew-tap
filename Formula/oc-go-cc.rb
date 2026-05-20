class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.4/oc-go-cc_darwin-arm64"
      sha256 "39f8e52f3c91d8b5a155ff42afcf76b38492ca48551bd6cbb88daa37e8d8cb75"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.4/oc-go-cc_darwin-amd64"
      sha256 "48c31c1f80993768aebfb0361d4e9361fafaf76600fbd41e64d05a8874a37b76"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.4/oc-go-cc_linux-amd64"
      sha256 "2ce67cd4e5967d5b5a793afb878c99bd538bab1a9b3b0edfb27efab974e73003"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.4/oc-go-cc_linux-arm64"
      sha256 "66e81cb69fa117b719a387dfbd8adbbf2d20727ef9d346018cde13e2390b7349"
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
