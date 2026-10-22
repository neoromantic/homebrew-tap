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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.2/ai-usage_darwin_arm64"
      sha256 "ad30d1d5b4caada2e17a9cb2cfad70c848ae1b7b484e1fafd0b421a05deaeca5"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.2/ai-usage_darwin_amd64"
      sha256 "d1d19cbec4647d6a875f2f90b6c60167ea0d9f5d70d13233457f5282c5dd86bb"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.2/ai-usage_linux_arm64"
      sha256 "bdf9ae9cd82b294a4f7c276855b9e7a6ad2c93ca4c167f2476c1faf072d67723"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.2/ai-usage_linux_amd64"
      sha256 "2d94cae3ce46d6f356805d22646abfa5c5e5c3686c7231d8503e9b61e43297cd"
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
