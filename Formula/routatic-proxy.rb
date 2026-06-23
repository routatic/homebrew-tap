class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.4.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.4.1/routatic-proxy_darwin-arm64"
      sha256 "276acd2116971c1a13b913cd416b60979871ee7e13dfca10d2cdca130224823c"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.1/routatic-proxy_darwin-amd64"
      sha256 "181dfd15470d950d5497bdb7bce9e46968ea89f190943c84d17b9d9309f3b858"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.4.1/routatic-proxy_linux-amd64"
      sha256 "67c70d921b3639d41f33e5fd9f1028b7c4ab438590fec77f80950632ac62a8cf"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.4.1/routatic-proxy_linux-arm64"
      sha256 "75e6df9f0bba23213cb93f249b78d25d83b38cc5758d8ac4f93216ab156fc32d"
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
