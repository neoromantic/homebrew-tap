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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.7.0/tg-darwin-arm64"
      sha256 "1ee25c2058fa33ef40de054e233b87d34ef1737cf6d6519926e3fb4f62122d98"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.7.0/tg-darwin-x64"
      sha256 "e17bc755907d45debf9c687018b3d5aa35175fe48e99cafb88937c7293c16edf"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.7.0/tg-linux-arm64"
      sha256 "ee819a68b9337fec642d890ecb360fc8d188a1db02378114e83f2f1febafca9f"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.7.0/tg-linux-x64"
      sha256 "0268ecd140ad7d6da97c392a37dd1d4004650201a672594bb31ed7a11ae03f12"
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
