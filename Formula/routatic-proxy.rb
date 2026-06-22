class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.8/routatic-proxy_darwin-arm64"
      sha256 "d77230b149b2ad4719ba5bbefc2efff32f91e21c360eb060d03d305be7a1d9ca"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.8/routatic-proxy_darwin-amd64"
      sha256 "f2236ac23dec64a6c4699538d1dedcbe17b31e6fbaa9efdcd8a0906d619f48ee"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.8/routatic-proxy_linux-amd64"
      sha256 "7ede064f82478cf07406f5f597b191bffab573145166c0e9969123a89da4a644"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.8/routatic-proxy_linux-arm64"
      sha256 "8e2b6ee3568ab1bc08cd275251c232e4167f08ea989090553ff2868dc60e94aa"
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
