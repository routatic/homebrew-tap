class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.9/oc-go-cc_darwin-arm64"
      sha256 "d2996c9db1d8e1ef2e86fe48858837182b0200f61a2ba926b92890e3c4315ad0"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.9/oc-go-cc_darwin-amd64"
      sha256 "d38c9a386e1189aee0da734da91fc838e9c2cdd9731a874f49abfa4b1c65686e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.9/oc-go-cc_linux-amd64"
      sha256 "d2f564b05542ad69fe3056c695f167aef9b14ee6035680dde1be320a78580e0c"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.9/oc-go-cc_linux-arm64"
      sha256 "81b1a0e5abe3644da4a7516b46b66c1bdd9221e37689feb17da10f657d5ac457"
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
