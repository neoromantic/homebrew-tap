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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.13.1/ai-usage_darwin_arm64"
      sha256 "61f4c3f61927672a57b90175f57b7bae1869cdcc66ceb082f33a8622a09e2985"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.13.1/ai-usage_darwin_amd64"
      sha256 "8ec5efa57fb31b33e8ee8bb666c5db19b888994472c4352356fb96ccf9d51c0d"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.13.1/ai-usage_linux_arm64"
      sha256 "e637b200fff82d8e27ea2f753544d72127b5a42f8827b25b494cb4f9e57e252b"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.13.1/ai-usage_linux_amd64"
      sha256 "a873a9ff896a85e2d41a488c15de3b60c437c1feea62fc96963e5660e45580ca"
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
