class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.0/routatic-proxy_darwin-arm64"
      sha256 "ae3805d9501d23a21628e3fe3f878689de8c19a89157cc12538d8c88e248fa4f"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.0/routatic-proxy_darwin-amd64"
      sha256 "2d198fcb111a79b78a5bdc5875a781cb797c787688c9d68d0b43c500f8024fe5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.0/routatic-proxy_linux-amd64"
      sha256 "f6a81e9d701e328a6f6519b6618614543d9eb22f534adafa30ff45080c6b6125"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.0/routatic-proxy_linux-arm64"
      sha256 "ecbaf207a94f0f518a364dcbfd7c45846c2c8237453f37bcd940a4062fd322a3"
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
