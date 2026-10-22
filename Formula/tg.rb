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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.5.0/tg-darwin-arm64"
      sha256 "c2bf0a340f4c79e2bd2ccc1bebbee7ab2258cb32892da20d0249ad87f2767e65"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.5.0/tg-darwin-x64"
      sha256 "96c599c3e6ac4a1fc2b40c619d5f6e7e37cb237eab591aadbe3d9664afd2fcec"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.5.0/tg-linux-arm64"
      sha256 "14686dd92b2b602e48cc77164cc5dc94dbccf09b0860049e937497aa64ba113f"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.5.0/tg-linux-x64"
      sha256 "c6c5057031b625bc3649803b7816fc2d8174d255621220672ca64d4db2853947"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
