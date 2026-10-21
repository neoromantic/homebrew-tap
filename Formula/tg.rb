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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.3.0/tg-darwin-arm64"
      sha256 "ae0783f469cca47981cc636e4be9ebaa442ac34cc2ff658621851f9cae4a6830"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.3.0/tg-darwin-x64"
      sha256 "53e3b3130e08a85993f2e96069cf09a3b304b5c4ce261bd8cc97ab622b5e26e3"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.3.0/tg-linux-arm64"
      sha256 "e768be15692fc71821eeb8dd10cb299027d622dd85f5c698df667f050fcdfcaf"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.3.0/tg-linux-x64"
      sha256 "90498725eb29a168298fa7e1e22d2adabd8e737f2307063b4c1df2248d064aed"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
