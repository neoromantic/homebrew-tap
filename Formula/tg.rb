class Tg < Formula
  desc "Telegram CLI with a local cache, a sync daemon and full MTProto API access"
  homepage "https://github.com/neoromantic/telegram-sync-cli"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.4/tg-darwin-arm64"
      sha256 "c3695af8667d9c5081ff7582f928645e511cf1ea58ae22306351ae5be14d4e28"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.4/tg-darwin-x64"
      sha256 "c253ba5ef2bbaf5fe675facbf74db3e1a52d2b1b802812395691a0fd3f67073d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.4/tg-linux-arm64"
      sha256 "ebb145621662f3e0b423d25cd23043283c2fd90f386e2471ccf6fa325ed0dde2"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.4/tg-linux-x64"
      sha256 "a4dc6b535868d38f79dab799949838aa176f6e46876e8285fd48aeded5572d3a"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
