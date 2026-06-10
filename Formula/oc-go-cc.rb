class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.0/oc-go-cc_darwin-arm64"
      sha256 "5595cc536685cfc189d402ded7e5a41b55a71f54dc957133631f5c982185b9a9"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.0/oc-go-cc_darwin-amd64"
      sha256 "ab1002cb84246a1d0fc48e9323721744ded03e892bf48577847dd2656c784223"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.0/oc-go-cc_linux-amd64"
      sha256 "111a3058fa937a03f05a8e0207f60697a39fa2f89999ed322fac47dc7b80bb9e"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.3.0/oc-go-cc_linux-arm64"
      sha256 "956758e1063a601c56ab006a22f7ab27ac2b6f572748b798bfb0e1f15b10bf26"
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
