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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.1/tg-darwin-arm64"
      sha256 "cf2a61589cccf633646c0eb76c3947aee19422520de32ed2f0334fae86fc8e8e"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.1/tg-darwin-x64"
      sha256 "d209e8e26b8fb80214d297b2c5f89e0d3c7f5d43c28c7c1e5aadc8365d7f7339"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.1/tg-linux-arm64"
      sha256 "7a83a2d2dc95dfaf6c9fa36abc520c15bc4dae4ca0db084ad19f32884d483ac0"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.1/tg-linux-x64"
      sha256 "585f54292c9251662a50dc116b5f93caa66c155c42d992467a66cd95ec4c13ae"
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
