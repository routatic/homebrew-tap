class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.4/oc-go-cc_darwin-arm64"
      sha256 "cee5fb1781d688684165fd51e6783a140a78991efa0f5694d602f9cf9024a483"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.4/oc-go-cc_darwin-amd64"
      sha256 "dc05d50cb5e4fc9803d6b39b2d0727fc740be156797ded7a13073371618a7ed7"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.4/oc-go-cc_linux-amd64"
      sha256 "5a54ae6e22aedcfdfcff710719370a6e0dc54faa99d1798895c8e8d2cd646e6d"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.4/oc-go-cc_linux-arm64"
      sha256 "8a3406d8ad95298f5e631255108ae9c48602a4eb6690a68a7f61c81e45f86de8"
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
