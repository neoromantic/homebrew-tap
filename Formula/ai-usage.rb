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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.11.0/ai-usage_darwin_arm64"
      sha256 "739853fb694d6780c81f2c1bda0c2cc4e2f9811b631ffb96ea3d1018acb01d8a"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.11.0/ai-usage_darwin_amd64"
      sha256 "ad40c7f6d559804714f653537e59394270049b5c7ecc0802e1963b7b3d0de38c"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.11.0/ai-usage_linux_arm64"
      sha256 "63f71e810b49b221c098fdcbf58274bdf74936460e8141d9ca12d29f81a3f456"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.11.0/ai-usage_linux_amd64"
      sha256 "b38f8edc23ce5278d8b4eaca8c94a9eb7ff43441eced1568f0862126780af72e"
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
