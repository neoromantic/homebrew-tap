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
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.9.0/tg-darwin-arm64"
      sha256 "c77eeac8a2a3b1f3019a2601c456bf2a55188ed85d545d472bd16cbf4fe711e0"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.9.0/tg-darwin-x64"
      sha256 "815e0ae0d8354eca64a9952152491ce313ef216e493d4c84e36b23fac18c7940"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.9.0/tg-linux-arm64"
      sha256 "07cfeb9242c41494a8e8fdcc29fd97327c55d8ee27523be3be59d71529453abf"
    end
    on_intel do
      url "https://github.com/neoromantic/telegram-sync-cli/releases/download/v0.9.0/tg-linux-x64"
      sha256 "072c1f18b41ab3ef496236d903a52074002564be7957fab8ed76d0c224941321"
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
