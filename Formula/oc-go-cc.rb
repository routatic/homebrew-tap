class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.3/oc-go-cc_darwin-arm64"
      sha256 "e6582128e28f5f5f1ffd902b0de71c51a793702a203599e8fb588457211daf87"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.3/oc-go-cc_darwin-amd64"
      sha256 "c8b3366a6117dd1bc5a7daaf20ed46ca6e0f79a478158f88985042087557291a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.3/oc-go-cc_linux-amd64"
      sha256 "e29a0bb0fbe66ebd2cf464a160a922f4be92b40bcf09b7a3d1ead4950c92dc9f"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.3/oc-go-cc_linux-arm64"
      sha256 "1a4af2221249481d4d156131151b55dbe93008b37f01c736b24fa11711c10926"
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
