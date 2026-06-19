class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.2/routatic-proxy_darwin-arm64"
      sha256 "4b5c91e7c650670326394cd4bf45df16b55997ce594af0edf89b9c29bb0eea18"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.2/routatic-proxy_darwin-amd64"
      sha256 "d6508dec28010ff198ce650cf43c31fc20dde7d4f81bb44728c5289792c6e587"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.2/routatic-proxy_linux-amd64"
      sha256 "8e55841bf7255d65d104be0746242f5823590e8a6b7fc50fffde84dda5197aa8"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.2/routatic-proxy_linux-arm64"
      sha256 "cb9bc65117b0f8deea589efcb6c812b4f80753298a19a3ce06c3e1140b5ff4b0"
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
