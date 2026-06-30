class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.9/routatic-proxy_darwin-arm64"
      sha256 "49377b232a2f4f82aa0aa0c8a08ae93dce2c5c6f00e90c3ba1bc63bac254ce1c"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.9/routatic-proxy_darwin-amd64"
      sha256 "af3b046713e55b8555d12981d69136055de436d8ffa6338726e9d2167a78c80e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.9/routatic-proxy_linux-amd64"
      sha256 "236a787213ecb9e649a9ff503425f2ac26ff5dc40c88a195dfa4f4250a02aace"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.9/routatic-proxy_linux-arm64"
      sha256 "27ee84f6cc459c1b8923b85ff7bdab47af58753a0c9ae2265e9d1c32956ad199"
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
