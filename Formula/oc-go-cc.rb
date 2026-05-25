class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.7/oc-go-cc_darwin-arm64"
      sha256 "75657b92cd19cdf0cbbbadd3eeda02091bbfc590c0e186e6995d3bc7c42b7603"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.7/oc-go-cc_darwin-amd64"
      sha256 "d23331fe5162ce6a4571c578785bf73d223732640d9965f1e501fa7568605edb"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.7/oc-go-cc_linux-amd64"
      sha256 "46810d005eb75c8e3c262976ebfc2f89546492de326a65de7d6495b536a3f8b9"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.7/oc-go-cc_linux-arm64"
      sha256 "c6aaef403e096da6eb74408bd1b1a69c3f172a8fcb4193377ca9d3528f6c95fe"
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
