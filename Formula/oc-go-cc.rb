class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.23"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.23/oc-go-cc_darwin-arm64"
      sha256 "73b995cd24206b4ebd0564fa8b09209ef331d16e3823b838d1653065e6801838"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.23/oc-go-cc_darwin-amd64"
      sha256 "0f040677e65b9e781195f8a2e77cf7ec173fa16522ab3d4e2affbc88bf271894"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.23/oc-go-cc_linux-amd64"
      sha256 "7492950dfd2b3efd45b77e42b4b604bf4dc2f90041af31436d50fb76884c7bc4"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.23/oc-go-cc_linux-arm64"
      sha256 "a6d2d8cfd00552738f87d45a066eedbf6597274138a4174bf4b50254f4f2aed7"
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
