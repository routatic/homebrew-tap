class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.2/oc-go-cc_darwin-arm64"
      sha256 "01cc7898e699730c76a2a58cd88e9759093e8dd7a44134ba8ccd5e17443b0885"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.2/oc-go-cc_darwin-amd64"
      sha256 "14b80572f83a9cbb09c3a204177f21928b8d22f41c430458831fd9cc79a34633"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.2/oc-go-cc_linux-amd64"
      sha256 "3d98381f142c1843f2cb841e816237863aeda8c5d0aa82c3f0db3864801d3a1d"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.2/oc-go-cc_linux-arm64"
      sha256 "bd86fe1a8eecaa2990b77647f67fc3fe9a5a4f3c2d6d9ac686bd26ca50ba1679"
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
