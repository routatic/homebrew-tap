class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.2/routatic-proxy_darwin-arm64"
      sha256 "c874ac824b8fa75bc48da76cf1ffcbefa0c74e2b6986322c1783ec26edd40756"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.2/routatic-proxy_darwin-amd64"
      sha256 "9c4b75baddd861d5828e5e91504923017fdb9f808574473833e8bca8f7b94ecf"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.2/routatic-proxy_linux-amd64"
      sha256 "fb435be9288fa17250b8503705f20679d47a2aa9ef369eb3bc1c0abee9aacd2f"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.2/routatic-proxy_linux-arm64"
      sha256 "b787d375be782b98708885440d8966dae92c495fe648ddc9d4fefcae791aca87"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "routatic-proxy_darwin-arm64" => "routatic-proxy"
    elsif OS.mac?
      bin.install "routatic-proxy_darwin-amd64" => "routatic-proxy"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "routatic-proxy_linux-amd64" => "routatic-proxy"
    else
      bin.install "routatic-proxy_linux-arm64" => "routatic-proxy"
    end
    bin.install_symlink bin/"routatic-proxy" => "oc-go-cc"
  end

  def caveats
    <<~EOS
      To get started with routatic-proxy:

        1. Initialize configuration:
           routatic-proxy init

        2. Set your OpenCode Go API key:
           export ROUTATIC_PROXY_API_KEY=sk-opencode-your-key

        3. Start the proxy:
           routatic-proxy serve

        4. Configure Claude Code:
           export ANTHROPIC_BASE_URL=http://127.0.0.1:3456
           export ANTHROPIC_AUTH_TOKEN=unused

        5. Run Claude Code:
           claude
    EOS
  end

  test do
    system "#{bin}/routatic-proxy", "--version"
    system "#{bin}/oc-go-cc", "--version"
  end
end
