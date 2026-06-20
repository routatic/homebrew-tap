class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.4/routatic-proxy_darwin-arm64"
      sha256 "e6f8f0f2673a13963c83277e1e6ef59ab5df69340b1fbfc19b3d1792250448c3"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.4/routatic-proxy_darwin-amd64"
      sha256 "d459542b9078f8432d1731e2eee3a9bf99a6681cd47ce0a47448a6375dea8e7d"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.4/routatic-proxy_linux-amd64"
      sha256 "4075fd13bc11455b781bddcd6ff67bf524909ebf7930b45e88b16e546aea46db"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.4/routatic-proxy_linux-arm64"
      sha256 "8cecf594a40251e0efa4bcf14189c1cf325968f57a2478f1dddf5384441db269"
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
