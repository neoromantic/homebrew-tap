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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.1/tg-darwin-arm64"
      sha256 "aba22ec4d44e88ca707cf3ad64eea2eb91d5dde2037a100ed3e684ed819f2993"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.1/tg-darwin-x64"
      sha256 "df9ec801b1b9d58ff485ca8d61e36e56a9736ddda84e00317d4928d558554355"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.1/tg-linux-arm64"
      sha256 "165b1fa77f903197db7dbf1288c17226a9fc9a8a9b82e5298537a0cbe47b5741"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.13.1/tg-linux-x64"
      sha256 "86ec4a741eb9558065e2be91f527adf9c759ae6f09189974ca665943f25f4934"
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
