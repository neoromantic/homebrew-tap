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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.2/tg-darwin-arm64"
      sha256 "36a65d12c3e2c70ba2e991f0b810b2e5331406a934652f48f21013fbb381b024"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.2/tg-darwin-x64"
      sha256 "14437970026baa6546138700b2c7d86039eb84b61d2044f629223630501d865f"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.2/tg-linux-arm64"
      sha256 "5c32b8aeb2e1000e2c853660fc87dec394d636a9f5ee68591bd73ca37bcd64cf"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.2/tg-linux-x64"
      sha256 "303f27584d7413d3bb1fb595d69b935ca647115e2c404a72f9f3cdcf623923ed"
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
