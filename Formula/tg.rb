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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.1/tg-darwin-arm64"
      sha256 "b12eab565f8509e22c080ce0fd9dd0ce5d1dc84620d7bb1ff82456b0354013ac"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.1/tg-darwin-x64"
      sha256 "3ce68ae2ed09e3661e95247c2b0ae2fc9824f3caf9f126719376fc670a5e07d5"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.1/tg-linux-arm64"
      sha256 "69fb41b2d5dd46f8bd4a29426339328c6335b7079bf3452730d5bda458fc0642"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.4.1/tg-linux-x64"
      sha256 "de3adc8340e85353a2bba154ed3e45c7d9951d0a8ed21f27e41a85f3cefb74f8"
    end
  end

  def install
    bin.install Dir["tg-*"].first => "tg"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tg --version").strip
  end
end
