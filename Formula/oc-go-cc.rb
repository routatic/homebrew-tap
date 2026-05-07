class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.1/oc-go-cc_darwin-arm64"
      sha256 "faa82c8bcfc8c927885f8429acc2667d20655354c108fdf9de1c727f89bc3ddd"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.1/oc-go-cc_darwin-amd64"
      sha256 "79236d8f7624c24b6ef920b6f971f269b9506b4d3d969c97611d84996defea90"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.1/oc-go-cc_linux-amd64"
      sha256 "56f117ebd12b40a2686c12b982a3cbd691aa81adad3328a371617be9b7a97710"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.1.1/oc-go-cc_linux-arm64"
      sha256 "c35600a260c048765aa227fe7d5cda0574d3372b771bc6de6913e3329012e77e"
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
