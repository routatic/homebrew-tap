class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.8/routatic-proxy_darwin-arm64"
      sha256 "d7bd2535beedbe2a0423d80c08c5c48e3d07325e8fc2ff0e5dd9d0d30d76f247"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.8/routatic-proxy_darwin-amd64"
      sha256 "2e0ce5260c9111a3d9b348eb12dee1ef465f8daba51ad8d4a4e20b10afab982e"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.8/routatic-proxy_linux-amd64"
      sha256 "cc5f051f345beb51f0c6745390cdd64273fcffc170b5dbfd4fd1439781b16f98"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.8/routatic-proxy_linux-arm64"
      sha256 "b553f6efc6cf76ae7a08e697073920b37ebbef27c1c80adf69c0257e5b7b5552"
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
