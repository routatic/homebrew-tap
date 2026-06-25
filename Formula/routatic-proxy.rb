class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.4/routatic-proxy_darwin-arm64"
      sha256 "03cbdcda401d3c0204fc16f810c8d7d1c9e5d4f76fdf999ac6eea24c8bb4b085"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.4/routatic-proxy_darwin-amd64"
      sha256 "20402a882563ecef273583203d0465e6631fea8e3e3b83a992a80e2aae628637"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.4/routatic-proxy_linux-amd64"
      sha256 "4211276e733ddd714e48276cad37cc210c18d915db6b8c8a878f4c630a4f174f"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.4/routatic-proxy_linux-arm64"
      sha256 "5a28a4b7dbbe95b9ee100b12099d8a27f19e9442940aa0c6b0253435cfbf39b8"
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
