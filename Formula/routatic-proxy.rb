class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.6/routatic-proxy_darwin-arm64"
      sha256 "facb44e4cbd1f27bd6c7f168b5186b7f204dedec0ccd600194b47c1265adb704"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.6/routatic-proxy_darwin-amd64"
      sha256 "81ea0f1a28f36f4165d12f40f35c3e4fbfc285828dc6a24204d35b6b322fff57"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.6/routatic-proxy_linux-amd64"
      sha256 "a7b741d1c8771507d64d84f5307634986a6c6950249de56baebb7a9b2efa62b5"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.6/routatic-proxy_linux-arm64"
      sha256 "6ba84c3abaf87e478642b6a97be8f508f53950b70cbb9a17bb272f730bb93182"
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
