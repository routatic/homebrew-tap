class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.1/oc-go-cc_darwin-arm64"
      sha256 "25b55b983eea2a2c3d3c4ca8ddc9b98106118369ade84dcba6ec788278f5ae92"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.1/oc-go-cc_darwin-amd64"
      sha256 "b7256ed11396e68ae4d737886d094219ff08e48512c4fa5ee0d420c1ad48038a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.1/oc-go-cc_linux-amd64"
      sha256 "420f320a0de9429f14b0d141f991ff1fa7f59cb1344f18be24a708deea92fe1a"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.1/oc-go-cc_linux-arm64"
      sha256 "40b1794d2bc8ffcfa3cd7a7f6fab413c663a93250140db65cc2bd90347220a1c"
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
