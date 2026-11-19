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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.0/tg-darwin-arm64"
      sha256 "ea257991136c7ac8717e5430fac11decfdb8d22e946f3b88f3e3ab64cb93869b"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.0/tg-darwin-x64"
      sha256 "98371ad2d892d73aba5353196aecbcb0320123c81b8d8d4a4b5a6657dcd39b6d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.0/tg-linux-arm64"
      sha256 "cc3738f5708461d26daf841b997eccc2571b35e90d28a67f8c57be476cbdbbff"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.15.0/tg-linux-x64"
      sha256 "74918dce9e58ffc9dd35ec81ea14ebfe35d5d70cf6ee5599d1aeb424ee25db4f"
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
