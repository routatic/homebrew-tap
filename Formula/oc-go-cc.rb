class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.0/oc-go-cc_darwin-arm64"
      sha256 "c286f89425d3bb1de08c071d5ae4fa39df356eeaa27a017f6ef91a4db3d610dc"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.0/oc-go-cc_darwin-amd64"
      sha256 "f0642349bc6d1be24e9b716d4951d8c3897b82c029d642129129c180284bebed"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.0/oc-go-cc_linux-amd64"
      sha256 "016532b61858dba5ff00fb051a5947c3f247a94846d487fd6dad233c9ce5e823"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.0/oc-go-cc_linux-arm64"
      sha256 "469870431ef5fca593ab2bc01e8a4f4bb415af763397510a2874e77c41931fa0"
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
