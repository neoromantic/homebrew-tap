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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.0/ai-usage_darwin_arm64"
      sha256 "c21f23beff2307866921a715c1bc6e4ed97d142f4a95a7a0d7c5158048f8ccb9"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.0/ai-usage_darwin_amd64"
      sha256 "944ae2bd845b2a1901fd99cc8365045464d21ba688aa16c082a0c156becbcba9"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.0/ai-usage_linux_arm64"
      sha256 "6d5711f334ed5548d955b61a0d1f08abbef8bd5e9c7f26ab9ff894816cafd1cf"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.10.0/ai-usage_linux_amd64"
      sha256 "093acbf6a9c287758fa93f98b51bbe4bd5294ac0d59768122b9bb95b8bdc7279"
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
