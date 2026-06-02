class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.1/oc-go-cc_darwin-arm64"
      sha256 "0509847a74d73e346e9456709fed713f025f6cf137384b2195b714adbd7af412"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.1/oc-go-cc_darwin-amd64"
      sha256 "7a716ed1bf45d7ff4137e6e33b908140e1386627eb97305717c79539bfeab96b"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.1/oc-go-cc_linux-amd64"
      sha256 "b9ee7f1bc54ea0ad69591b530ab22f7733668d66853a4fada934afb7ba7440de"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.2.1/oc-go-cc_linux-arm64"
      sha256 "6c87d9d7e69d75dfe3ed319a85a5bb87a6e1ef7cf437de070a49ffee924d6606"
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
