class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.22"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.22/oc-go-cc_darwin-arm64"
      sha256 "f024632c9905d634f7242dac2626c0deada9d20cba2915560b6197005eef684f"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.22/oc-go-cc_darwin-amd64"
      sha256 "9f4ad90390e8f19e3635730dcf4f3ebf66ddf0a4665c0fe3a392ca61c2562a65"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.22/oc-go-cc_linux-amd64"
      sha256 "04753c33ce1eb77e8618dd7886aba8c8d2e8fc28163dfa22e8f4af6dc395d1c7"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.22/oc-go-cc_linux-arm64"
      sha256 "ae65c2373ba1e89fac9e4fc6568889d81e7d67a33172407ddfa3ffb0bbbdee0c"
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
