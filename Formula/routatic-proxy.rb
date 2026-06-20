class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.5/routatic-proxy_darwin-arm64"
      sha256 "371fa90bf72052454cd77501af6a2749c133417150dcc545f0b24889157848e3"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.5/routatic-proxy_darwin-amd64"
      sha256 "4775a22ea6d0d680c507565effe23e2ad4cbcbe134b50c9d9810b8f599a972f2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.5/routatic-proxy_linux-amd64"
      sha256 "cdd50f5d03a040fa677e2ac8da2e7497445d789db526f606aedfa8ff7f24a58b"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.5/routatic-proxy_linux-arm64"
      sha256 "b822afef076cde6c644310fb4fbe83e305ff1b4eeda44c40adf4e59c5294f37c"
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
