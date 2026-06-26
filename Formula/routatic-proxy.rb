class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.6/routatic-proxy_darwin-arm64"
      sha256 "20e5cbda3702bfd7bf2e08d79a555c00cb035a6ee3eaa30b33773026373d634b"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.6/routatic-proxy_darwin-amd64"
      sha256 "7b106274043a36f4f7c2a43dc44a6a2d86edb723d3ded4bb521ec4172e99a13f"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.6/routatic-proxy_linux-amd64"
      sha256 "12df75ef6d2c67652e6f679f940b6127eebe6dcc02ed06074a9696fd5c14d181"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.6/routatic-proxy_linux-arm64"
      sha256 "9c70e17880fc7b5b77ed14a81306a54bee004e3dba8f6b5f8ffcf6b266f2cfcd"
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
