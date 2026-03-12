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

#### Option 1

Open `healthwatch-launchd-setup.sh`, copy everything, paste it into Terminal, and press Enter.

#### Option 2

Download the file and run:

```bash
bash healthwatch-launchd-setup.sh
```

### Files

- `healthwatch-launchd-setup.sh` — the watchdog setup script
- `.github/workflows/openclaw-smoke.yml` — the GitHub Actions test

### Result

If the final health check passes, then:

**it came back**

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

#### 方法 1

打开 `healthwatch-launchd-setup.sh`，全选复制，粘贴到终端，回车。

#### 方法 2

下载脚本后运行：

```bash
bash healthwatch-launchd-setup.sh
```

### 文件

- `healthwatch-launchd-setup.sh` —— watchdog 安装脚本
- `.github/workflows/openclaw-smoke.yml` —— GitHub Actions 测试流程

### 结果

如果最后 health 检查通过，那就说明：

**它自己活回来了。**
