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
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.12.0/ai-usage_darwin_arm64"
      sha256 "e185309bfa80db1fc04b60f7f2a605b4028af6f9f434299b83d7b9c67f290de7"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.12.0/ai-usage_darwin_amd64"
      sha256 "40759688b9d34be92d21f1b2b6a0a1a91fb9f7f896822f8433867ca36f880966"
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.12.0/ai-usage_linux_arm64"
      sha256 "6713ebef56a59c60640a44d52a9ada1f0392687aca07315da64ae3e615814db3"
    end
    on_intel do
      url "https://github.com/neoromantic/ai-usage/releases/download/v0.12.0/ai-usage_linux_amd64"
      sha256 "321e16581e368285bdf9b58fb1b1fa3b93765905a10b757650df28c72429fe5b"
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
    EOS
  end

  test do
    assert_equal "v#{version}", shell_output("#{bin}/ai-usage version").strip
  end
end
