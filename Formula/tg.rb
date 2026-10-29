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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.8.0/tg-darwin-arm64"
      sha256 "df02a3cf9940eda6375e2247324f5ddf5253823f1d1b476d8b0e122cf5a0127a"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.8.0/tg-darwin-x64"
      sha256 "4a043bfdf911093009e0ae43b189d1b724e52b90e0e20512545ac5434a3901b8"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.8.0/tg-linux-arm64"
      sha256 "b36bc9228b799663582374448c1928aa955d02987b5875595d68748cc526e96f"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.8.0/tg-linux-x64"
      sha256 "31e8c04d7fbaf914d106b8c473544a1354fad523ee9813aeeafe4d8c088643b5"
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
