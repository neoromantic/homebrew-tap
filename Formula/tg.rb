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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.0/tg-darwin-arm64"
      sha256 "6cc5caf61f716ec08100178d786bd1a5bf7f66e201d768207c6456f86f41f8bb"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.0/tg-darwin-x64"
      sha256 "a3ff28703c6b319d8e18bbfc94f34a9036378107e086c87de6e4b33c2c042af3"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.0/tg-linux-arm64"
      sha256 "653498ca107173706549b9a9f87d7569268de32cf13198232bc18d1ed9662b26"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.0/tg-linux-x64"
      sha256 "c324b9ba4dd91bb71ab3530754a2ab35097274793d52f1cdefdba390a3ccee28"
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
