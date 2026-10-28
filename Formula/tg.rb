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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.6.0/tg-darwin-arm64"
      sha256 "e0f5a2dbc23e72f96a3b5297a75a8fbb981c88df0f9f330fc55b5253482f1ad4"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.6.0/tg-darwin-x64"
      sha256 "706c74069edd05aeb04f5de5079d621788aa4ba612a432141bca1b3551fdc222"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.6.0/tg-linux-arm64"
      sha256 "d477e4bbed1156f8c6eba7719038b75bb1b0a7387d2a74982c1a6daf241ac63e"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.6.0/tg-linux-x64"
      sha256 "f2e1bfcb2d73de2027442a6aa6d6bd1a047fd727f7b21fd8813fba343bb210fc"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
