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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.11.1/tg-darwin-arm64"
      sha256 "250eb7598931dc92eec77854fa34c3dd0d826d2c383c854b6305c9f76a54933e"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.11.1/tg-darwin-x64"
      sha256 "3958783bff36e48a2845c82155378cf775d47f96f7a28881bf1dea39619721f0"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.11.1/tg-linux-arm64"
      sha256 "f238de9e298cb68a2d49740ca49d389948d36626f2f296bd38aa02c2a54e63a4"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.11.1/tg-linux-x64"
      sha256 "a5c58cad29238de912d828449f7e4041c551e78b9891bee9b1223d0c5e62c82b"
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
