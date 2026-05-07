class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.25"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.25/oc-go-cc_darwin-arm64"
      sha256 "2cb91a3cf2c561d050a35429f1c52e2b4000bf593fb7216abd9d9a42b40099f5"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.25/oc-go-cc_darwin-amd64"
      sha256 "d5f9fff0b7bdda7fd5dffd117d81948caf41d616fe94fa16ae6aa67819ef23d9"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.25/oc-go-cc_linux-amd64"
      sha256 "3d5cc55a87d65024954e734264c3f4f26215754fbbf3b04d8c7e28ed3451d9b3"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.25/oc-go-cc_linux-arm64"
      sha256 "6dc9e602cf12d82908c62e63f02f23eb1cbd720d4b363501b058bf4a2b529737"
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
