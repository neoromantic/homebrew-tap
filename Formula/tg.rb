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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.0/tg-darwin-arm64"
      sha256 "32e690dd4a741c4035f00fb237c10f012831d14f8078bbe952bc3fc8cbe5a0a9"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.0/tg-darwin-x64"
      sha256 "cc814bea4669fd6099c0eea7b8cf22540cade93c83d7b132fbe2db4bd1b8243a"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.0/tg-linux-arm64"
      sha256 "e423e836f69cb6210d5b78411ae701b09253cc24bd41cdd13f84d2c0c1522737"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.0/tg-linux-x64"
      sha256 "cb0703e8a4e4bf2acd676eeede7cb4e557f2ff0ff8d9dfecdded8e0c5cf9b655"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
