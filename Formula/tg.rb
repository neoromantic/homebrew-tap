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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.10.0/tg-darwin-arm64"
      sha256 "cd58519f9394af60e5841b3609f48714004eb7116246c940183b8046c73fa7a1"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.10.0/tg-darwin-x64"
      sha256 "bec549fa95350d7396256bc3a0dc7ad225bcfb1514d4029856e9c0ced3d8fc36"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.10.0/tg-linux-arm64"
      sha256 "4ce6005772e9a7908afd8005991cb3c8e9c2dd3cc105ac4c9792a9bf4d106009"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.10.0/tg-linux-x64"
      sha256 "5b6658ea21123bac6dda19a49c65d998adf1cdb882db2a2205c9ba40b5a46ee8"
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
