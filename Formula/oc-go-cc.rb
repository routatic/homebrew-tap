class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.8/oc-go-cc_darwin-arm64"
      sha256 "93e26e6b14bcd722dd8c129a6955a6b8c3784ec0466e410c1e93b13db9f9fe7b"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.8/oc-go-cc_darwin-amd64"
      sha256 "8420e51fb3757c58083684f798925eb4a0d7ca417eea07a594f49a18c15240dd"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.8/oc-go-cc_linux-amd64"
      sha256 "2a240cd629d36c723837f4bca10b4b0b684a74c0401057b93030853c37d7c043"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.8/oc-go-cc_linux-arm64"
      sha256 "e8af17f967149dd804c752ac92523250b2b03de454da62327af03bdc30bdfd05"
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
