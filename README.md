# it-came-back

## English

A tiny macOS / OpenClaw self-heal test.

### What it does

This repo tests one thing:

- stop OpenClaw Gateway
- run the watchdog script
- wait 15 seconds
- check whether Gateway becomes healthy again

### How to use

For beginners, this should be one sentence:

- copy the content of `healthwatch-launchd-setup.sh` into Terminal and run it
- or download the file and run `bash healthwatch-launchd-setup.sh`

Even more directly:

**copy, paste, press Enter**

Step by step:

1. Open the script
2. Copy all
3. Paste into Terminal
4. Press Enter
5. Check the logs and see whether it brought Gateway back

### Files

- `healthwatch-launchd-setup.sh` — the watchdog setup script
- `.github/workflows/openclaw-smoke.yml` — the GitHub Actions test

### Result

If the final health check passes, then:

**it came back**

### License

This repo uses **The Unlicense**.
You can copy it, modify it, reuse it, or throw it into your own project with very little drama.

---

## 中文

一个很小的 macOS / OpenClaw 自恢复测试。

### 它干嘛

这个仓库只测一件事：

- 把 OpenClaw Gateway 停掉
- 跑 watchdog 脚本
- 等 15 秒
- 看 Gateway 会不会重新恢复健康

### 怎么用

对小白来说，其实就一句话：

- 把 `healthwatch-launchd-setup.sh` 里的内容复制到终端直接跑
- 或者下载这个 `.sh` 文件后执行：`bash healthwatch-launchd-setup.sh`

更直白一点就是：

**复制、粘贴、回车。**

一步一步来：

1. 打开脚本
2. 全选复制
3. 粘贴进终端
4. 回车运行
5. 看日志确认有没有把 Gateway 拉起来

### 文件

- `healthwatch-launchd-setup.sh` —— watchdog 安装脚本
- `.github/workflows/openclaw-smoke.yml` —— GitHub Actions 测试流程

### 结果

如果最后 health 检查通过，那就说明：

**它自己活回来了。**

### 许可证

这个仓库使用 **The Unlicense**。
基本就是完全放开，别人拿去复制、修改、复用都行。
