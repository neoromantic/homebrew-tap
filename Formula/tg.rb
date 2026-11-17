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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.2/tg-darwin-arm64"
      sha256 "1daddf0dc1000434b934f2af8ed8a2ed3a5e09b4887062e77c8f86f1d9a9719a"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.2/tg-darwin-x64"
      sha256 "1b0a9ced74f99f2f5ecfe9a4623b0727b21ba3feffdac3292a644c516d618efa"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.2/tg-linux-arm64"
      sha256 "0a276d15f36b5f2f77f743d885a3c38336cf3991bf9ef606378c9b3a45d43625"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.2/tg-linux-x64"
      sha256 "0d10a886ee1701d8821eabd22db7388bd505f391ec0971945e180971b56a736e"
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
