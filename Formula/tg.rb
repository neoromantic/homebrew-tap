class Tg < Formula
  desc "Telegram CLI with a local cache, a sync daemon and full MTProto API access"
  homepage "https://tg.sergeybaus.com"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.0/tg-darwin-arm64"
      sha256 "1965061bfdb6f6036ca80c3c5e193ebcdccfc2ae826390c6114a7bbdbc1f5ebe"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.0/tg-darwin-x64"
      sha256 "ee9f9ca6301a8def8c8f754d200c3d2ba2878b5a5a12080e3fbb21447fe2fcd7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.0/tg-linux-arm64"
      sha256 "d2603b07e7a1a3f0b92821b527de1ef448215f9fadc5217e66019b82feff4e6a"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.0/tg-linux-x64"
      sha256 "43db4bfd4daff8f272fb4b3e29d5ffc6964d93ec8b2db9d63219c9f8c8981dcf"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  def caveats
    <<~EOS
      tg shares usage stats with its author: how often it runs, which features are used,
      errors, version and OS, tied to a random install ID. It never sends your files,
      arguments or account names. Turn it off with "tg telemetry off" or DO_NOT_TRACK=1.
      Details: https://usage.sergeybaus.com
    EOS
  end

  test do
    ENV["TELEGRAM_SYNC_CLI_TELEMETRY"] = "0"
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
    assert_match '"enabled": false', shell_output("#{bin}/tg telemetry status --json")
  end
end
