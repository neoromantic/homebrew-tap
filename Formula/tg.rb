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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.14.0/tg-darwin-arm64"
      sha256 "95238c5d0fc2dbaf677e844dc3999c34bd7a18c05e932cf4c802cec194e28d9d"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.14.0/tg-darwin-x64"
      sha256 "41a5242803a1b99343c94bb9a034002efa13942fc9bf79dcfaa5afc2aa5053cb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.14.0/tg-linux-arm64"
      sha256 "d1326f4b6964f44c33af6bfcb77f8e7e4b6045049a2f726057ae22942c4b130b"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.14.0/tg-linux-x64"
      sha256 "f06f8d4ccd2f36bc1645a860c91bce670b6bb8644fcd92427c91d568041d9eb9"
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
