class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.3/routatic-proxy_darwin-arm64"
      sha256 "473c2f4bf40eea5d9618749f25985650831a5b7dd85b50b94fc38d783f69d233"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.3/routatic-proxy_darwin-amd64"
      sha256 "cc67138c8c9a3c720c1eb43ba895d0e0a6e629ed6c361f0c6287ce0d388ecb16"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.3/routatic-proxy_linux-amd64"
      sha256 "aeff82de6f2c4c304e40a92b1536c210255f58c70c08f49f12eaa6ac26d096f4"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.3/routatic-proxy_linux-arm64"
      sha256 "b7335d51ba4a41c243a03760bc1bcbf143f6d9fe80eb2601610b1c094c28ada4"
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
