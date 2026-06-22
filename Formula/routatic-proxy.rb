class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.7/routatic-proxy_darwin-arm64"
      sha256 "c0e0ce1e49813a2757e8dddd3c3905f05303f7ca235438fcd28bd39db132bf7d"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.7/routatic-proxy_darwin-amd64"
      sha256 "323d39fe5b0254148dd33347d147808888353ef762a63e44c9cdabcd29891930"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.7/routatic-proxy_linux-amd64"
      sha256 "536e89b0bc5500dd1e33dfb325213bf760b67c4b4bee8d1d617f61aeae004a69"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.7/routatic-proxy_linux-arm64"
      sha256 "299fe8ba9c871e67fd816c1554fb13baf047276ec8ea6af7bb5c26d14eed9936"
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
