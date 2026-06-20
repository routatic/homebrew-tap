class RoutaticProxy < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/routatic/proxy"
  version "0.3.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/routatic/proxy/releases/download/v0.3.3/routatic-proxy_darwin-arm64"
      sha256 "dce7e945a7e9c6d6df0641d0f7e9ba52993f4a5b0e0aac5dea67295407d67d36"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.3/routatic-proxy_darwin-amd64"
      sha256 "83d80b58952ee9aa6f58751d26ee10b1934beedf04e79a68c659106412792f74"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/routatic/proxy/releases/download/v0.3.3/routatic-proxy_linux-amd64"
      sha256 "c531fe866c3de0eb56ad290a6c36879db7d0745eb6809662d4cc41d4d60f00bf"
    else
      url "https://github.com/routatic/proxy/releases/download/v0.3.3/routatic-proxy_linux-arm64"
      sha256 "b0b5f4a6c1511a5c1abb9b26a12e9552365ce7466e7432d02bb589b365862ae6"
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
