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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.1/ai-usage_darwin_arm64"
      sha256 "842b491552716e22573d8c44af79005e719a9ab1d1ae2348e3037565349d97f6"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.1/ai-usage_darwin_amd64"
      sha256 "6fa974665cf4827ea14f0a4f0475805d84bb1dce94180b3810f361b010562d1b"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.1/ai-usage_linux_arm64"
      sha256 "3226cfaed5d21507fe68e6228c80ae94760cf18bd6dd4713567874d5cc462e36"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.8.1/ai-usage_linux_amd64"
      sha256 "2a09eb6b28ef1f3723f0ada53be6188a7e5e5e9a13e13df82b7b6b115aaa116a"
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
      Before `brew uninstall`, run `ai-usage schedule remove`; see
        https://github.com/neoromantic/ai-usage#uninstall
    EOS
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/ai-usage version").strip
  end
end
