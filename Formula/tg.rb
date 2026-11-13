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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.1/tg-darwin-arm64"
      sha256 "f1ba86d163488afc0bb176d75670657b6fd4f4e31b2748e06463140d5d2a0434"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.1/tg-darwin-x64"
      sha256 "30c1cca8c9320381baf5bbf83f6bcad3bed668b0a4222502f40896487ba446b9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.1/tg-linux-arm64"
      sha256 "1ab3bb73dd283b850e5cafda84d8123a3df906061de63137f5613eb43282c00c"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.12.1/tg-linux-x64"
      sha256 "b761287455abd45d8dd671e07a8ab2f4dd017ad04a3a6f80245e8b61258857e4"
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
