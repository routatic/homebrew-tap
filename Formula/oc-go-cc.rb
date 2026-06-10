class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.9/oc-go-cc_darwin-arm64"
      sha256 "eb123424acc0faa138b553564b0ddd58af0a3b095187af98229a53f9ef607100"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.9/oc-go-cc_darwin-amd64"
      sha256 "7fcd5fdaccea2a938516496465e47aee35bae7be2ee44e4b03d022fa946c1d28"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.9/oc-go-cc_linux-amd64"
      sha256 "2797f23fb1054eef70c5a7ce1c79e14c7a74ce5b6080841311f233eed1a13215"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.9/oc-go-cc_linux-arm64"
      sha256 "a081d05aa4aa39e7426d4177a01179041be8615e3394873417a3f1039ec75c7e"
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
