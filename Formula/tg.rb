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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.2.0/tg-darwin-arm64"
      sha256 "25d3ba80e0db2aaf3d6dbbece314985b9a3fca588c5b8772051054a9994879d7"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.2.0/tg-darwin-x64"
      sha256 "10423528c77c01e04cb68f152d62ef99ed967109ea9b88b8f6a71c283e292a59"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.2.0/tg-linux-arm64"
      sha256 "01ab655719b21157c1228b72f7017490dce63e3b9df2c4de1281ac88d7a6b600"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.2.0/tg-linux-x64"
      sha256 "7d7c0cc8049ea2d792d48830b29563cdf9e2b91011e6bc2dfb1c888b32203cb6"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
