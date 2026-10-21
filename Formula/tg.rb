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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.3/tg-darwin-arm64"
      sha256 "0c46c8ab664a691ff8e161df33cf6768ac5ef23eab80420f4a8bc0b344c34419"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.3/tg-darwin-x64"
      sha256 "3a832b622971215f86376512405e80a9ff31313984d442c59c9a5fd6ec9809a1"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.3/tg-linux-arm64"
      sha256 "584bb19ed4fb24403aaa7251ebe90f54ed8463254754b027b03031253f20d418"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.1.3/tg-linux-x64"
      sha256 "b0a7c013d826a4498576747164610a6a34efcaca5f1acc86c5761cec12f14afc"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
