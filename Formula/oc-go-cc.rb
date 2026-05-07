class OcGoCc < Formula
  desc "Proxy Claude Code requests to OpenCode Go API"
  homepage "https://github.com/samueltuyizere/oc-go-cc"
  version "0.0.26"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.26/oc-go-cc_darwin-arm64"
      sha256 "36e67f90469f4f0b80d7006a1ac0fd8ef20cf8b4fc2bfafca257ccfa01c2c9f6"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.26/oc-go-cc_darwin-amd64"
      sha256 "db5696767a58d8c80b3af582b50c6dfbe5e0ed57baa4fa43c62a9cae6f6be813"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.26/oc-go-cc_linux-amd64"
      sha256 "c4b7de2a159e3c0571719c9b5fec9ada2fee9d945ddf0e26f4f03f8ee918a664"
    else
      url "https://github.com/samueltuyizere/oc-go-cc/releases/download/v0.0.26/oc-go-cc_linux-arm64"
      sha256 "8436981eaf54e33acda4f01f64dd75577aac6b3ad5c86fd2a33d94f2e218606b"
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "oc-go-cc_darwin-arm64" => "oc-go-cc"
    elsif OS.mac?
      bin.install "oc-go-cc_darwin-amd64" => "oc-go-cc"
    elsif OS.linux? && Hardware::CPU.intel?
      bin.install "oc-go-cc_linux-amd64" => "oc-go-cc"
    else
      bin.install "oc-go-cc_linux-arm64" => "oc-go-cc"
    end
  end

  def caveats
    <<~EOS
      To get started with oc-go-cc:

        1. Initialize configuration:
           oc-go-cc init

        2. Set your OpenCode Go API key:
           export OC_GO_CC_API_KEY=sk-opencode-your-key

        3. Start the proxy:
           oc-go-cc serve

        4. Configure Claude Code:
           export ANTHROPIC_BASE_URL=http://127.0.0.1:3456
           export ANTHROPIC_AUTH_TOKEN=unused

        5. Run Claude Code:
           claude
    EOS
  end

  test do
    system "#{bin}/oc-go-cc", "--version"
  end
end
