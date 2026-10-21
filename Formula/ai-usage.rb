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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.0/ai-usage_darwin_arm64"
      sha256 "7b2f634236936df3aa7cf6647d716f38e28e4ccff59836c28dfceeaa5a901d8b"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.0/ai-usage_darwin_amd64"
      sha256 "ff1861af0506f00d1320f7b776f3030455ac8707facf0f0214394883d38637d7"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.0/ai-usage_linux_arm64"
      sha256 "0dae27007499aeac50825ec5ca8a9c37872535bea2a226665da5f42f37f48457"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.9.0/ai-usage_linux_amd64"
      sha256 "a626bfad05198c41465f9948ed91ba8c01b15af1cd366a47661132fdb879a7c7"
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
