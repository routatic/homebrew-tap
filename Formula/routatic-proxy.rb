class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.9/routatic-proxy_darwin-arm64"
      sha256 "d8a4d8470deeb0a3b276d4caa3f5411375d40a81e35acba26effd5439048003a"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.9/routatic-proxy_darwin-amd64"
      sha256 "c8b6663b963de7424e50d1f930dcd3bb6c3b7d4e3bd8aa2ba7aabf7ab4bd324f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.9/routatic-proxy_linux-amd64"
      sha256 "8df27bef2603969f00e830b6869d10d0e2fec29ea3046e90de7c962311421768"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.9/routatic-proxy_linux-arm64"
      sha256 "ccff974b02401f51ba5b3569099f2eeb0f5a6352dcf7cd9539829b20bdd6bde7"
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
