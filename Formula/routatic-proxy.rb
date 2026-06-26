class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.5/routatic-proxy_darwin-arm64"
      sha256 "eb791e2d4e52aa1c843847b4dbb184c664e01556223c04cd72caca4986095e25"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.5/routatic-proxy_darwin-amd64"
      sha256 "b8aa0860535c677a1d92b85e2366b462197665396c516745d5ddae3fc0c2eeb8"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.5/routatic-proxy_linux-amd64"
      sha256 "37dea6149816f03f3daa6609054b461433bcebfeaba73b101d9585548af67e89"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.5/routatic-proxy_linux-arm64"
      sha256 "dbe86c70448aa0f68dd1c8c426923d878726078d2519aeb2b6531a84bb8ad22d"
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
