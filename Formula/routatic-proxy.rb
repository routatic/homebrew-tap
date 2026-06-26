class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.7/routatic-proxy_darwin-arm64"
      sha256 "62963a9b7ac908ea5a457595162fb621a3208984601f90751425afb3a7379599"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.7/routatic-proxy_darwin-amd64"
      sha256 "e6a5b98ba438dae93db5de92a20854014c2594078bd64ce246431ff2ec032679"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.7/routatic-proxy_linux-amd64"
      sha256 "d548c62db2b29cf54d157b6ae51acd778e29308dd6cb3f861fe473d195a930d4"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.7/routatic-proxy_linux-arm64"
      sha256 "0c5b81d6b3e4bad3fcff2b99c31318112cbd2c7074d3065cada167d92cfd2c4a"
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
