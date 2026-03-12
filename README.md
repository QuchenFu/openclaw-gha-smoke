# it-came-back

**English:** A tiny macOS/OpenClaw self-heal test.

**中文：** 一个很小的 macOS / OpenClaw 自恢复测试。

## What it does / 它干嘛

This repo tests one thing:

- stop OpenClaw Gateway
- run the watchdog script
- wait 15 seconds
- check whether Gateway becomes healthy again

这个仓库只测一件事：

- 把 OpenClaw Gateway 停掉
- 跑 watchdog 脚本
- 等 15 秒
- 看 Gateway 会不会重新恢复健康

## How to use / 怎么用

### Super simple / 超简单

**Option 1 / 方法 1：**

Open `healthwatch-launchd-setup.sh`, copy everything, paste into Terminal, press Enter.

打开 `healthwatch-launchd-setup.sh`，全选复制，粘贴到终端，回车。

**Option 2 / 方法 2：**

Download the file and run:

下载脚本后运行：

```bash
bash healthwatch-launchd-setup.sh
```

## Files / 文件

- `healthwatch-launchd-setup.sh` → the watchdog setup script
- `.github/workflows/openclaw-smoke.yml` → the GitHub Actions test

- `healthwatch-launchd-setup.sh` → watchdog 安装脚本
- `.github/workflows/openclaw-smoke.yml` → GitHub Actions 测试流程

## Result / 结果

If the final health check passes, then:

**it came back**

如果最后 health 检查通过，那就说明：

**它自己活回来了。**
