class AiUsage < Formula
  desc "Quota left and token use for Claude Code, Codex, and Grok, per machine and team"
  homepage "https://github.com/neoromantic/ai-usage"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.14.1/ai-usage_darwin_arm64"
      sha256 "f5f0c491de10f3bf2b3866d39d4b01272cd5b5a7939af1e202edb0b74e6d5da3"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.14.1/ai-usage_darwin_amd64"
      sha256 "c2247afdea0ca23f9fec77792ebdae3416ac8e7c071bb5bf3dbc76a4ca0d57d7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.14.1/ai-usage_linux_arm64"
      sha256 "60f920d19400643e9c403d3cdb674e7dd3170c75e1664f67e8f7e2413f792fad"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.14.1/ai-usage_linux_amd64"
      sha256 "e702cf7fbf1cd327f2af11dcad6af46372985dd0a5b3cb2813de41120eefa292"
    end
  end

  # A static binary: no Homebrew glibc or gcc on an older Linux.
  def add_global_deps_to_spec(*); end

  def install
    bin.install Dir["ai-usage_*"].first => "ai-usage"
  end

  def caveats
    <<~EOS
      To join a team, run `ai-usage team join` first and paste the key.
      Then run `ai-usage` once: it collects and registers a 15-minute run
      with launchd or cron. If you once ran `ai-usage schedule remove`,
      run `ai-usage schedule install` instead.
      On macOS 14 or later, `ai-usage app install` adds the menu bar app.
      Update with `brew upgrade neoromantic/tap/ai-usage` or `ai-usage update`.
      If you installed with the script before, remove that copy, such as
        rm ~/.local/bin/ai-usage
      If brew could not link ai-usage over an old copy in its bin folder:
        brew link --overwrite neoromantic/tap/ai-usage
      To remove it, run `ai-usage uninstall` first, then
        brew uninstall neoromantic/tap/ai-usage
      See https://github.com/neoromantic/ai-usage#uninstall

      ai-usage shares usage stats with its author: how often it runs, which
      features are used, errors, version and OS, tied to a random install ID.
      It never sends your files, arguments or account names, and sends
      nothing until its notice has shown once, at your first `ai-usage`.
      Turn it off with `ai-usage telemetry off` or DO_NOT_TRACK=1.
      Details: https://usage.sergeybaus.com
    EOS
  end

  test do
    ENV["AI_USAGE_TELEMETRY"] = "0"
    assert_equal "v#{version}", shell_output("#{bin}/ai-usage version").strip
  end
end
