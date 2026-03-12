# it-came-back

**English:** A tiny GitHub Actions repo that tests whether OpenClaw on macOS can **come back after being stopped**.

**中文：** 一个很小的 GitHub Actions 测试仓库，用来验证 OpenClaw 在 macOS 上被停掉以后，能不能**自己恢复**。

---

## What this repo does / 这个仓库是干什么的

**English**

This repository is not a full app. It is a small recovery test.

It checks this flow on a fresh GitHub Actions macOS runner:

1. Install OpenClaw with the official installer
2. Install and start the Gateway service
3. Confirm the Gateway is healthy
4. Stop the Gateway on purpose
5. Confirm health is now failing
6. Run a launchd watchdog script
7. Wait 15 seconds
8. Confirm the Gateway becomes healthy again

If all of that passes, then the answer is basically:

> Yes, it came back.

**中文**

这个仓库不是完整应用，它是一个小型“自动恢复测试”。

它会在全新的 GitHub Actions macOS runner 上验证下面这条流程：

1. 用官方安装脚本安装 OpenClaw
2. 安装并启动 Gateway 服务
3. 确认 Gateway 当前健康
4. 故意把 Gateway 停掉
5. 确认此时 health 失败
6. 运行 launchd watchdog 脚本
7. 等待 15 秒
8. 再确认 Gateway 恢复健康

如果整条链路都通过，意思基本就是：

> 对，它自己又活过来了。

---

## Why this exists / 为什么要做这个

**English**

Beginners often test only the happy path:

- install works
- start works
- health works

That is nice, but not enough.

The more useful question is:

- what happens if the service dies?
- can the watchdog recover it?
- does health actually come back?

This repo tests that recovery path.

**中文**

很多新手只会测“顺风局”：

- 能不能安装
- 能不能启动
- health 是不是绿色

这当然不错，但不够。

更有用的问题是：

- 服务挂了会怎样？
- watchdog 能不能把它拉起来？
- health 会不会真的恢复？

这个仓库测的就是这条恢复链路。

---

## Files / 文件说明

- `.github/workflows/openclaw-smoke.yml`
  - GitHub Actions workflow
  - GitHub Actions 工作流文件

- `healthwatch-launchd-setup.sh`
  - Installs a simple launchd watchdog script for macOS
  - 给 macOS 安装一个简单的 launchd watchdog 脚本

---

## How to use it / 小白怎么用

### 1) Create your own repo / 先建一个自己的仓库

**English**

Create a GitHub repository, then put these files into it:

- `README.md`
- `.github/workflows/openclaw-smoke.yml`
- `healthwatch-launchd-setup.sh`

**中文**

先在 GitHub 上建一个仓库，然后把这几个文件放进去：

- `README.md`
- `.github/workflows/openclaw-smoke.yml`
- `healthwatch-launchd-setup.sh`

### 2) Push to `main` / 推到 `main`

**English**

This workflow runs on:

- manual trigger (`workflow_dispatch`)
- push to `main`

So the easiest way is just pushing your changes.

**中文**

这个 workflow 会在下面两种情况下运行：

- 手动触发（`workflow_dispatch`）
- push 到 `main`

所以最简单的方式就是直接推代码。

### 3) Open the Actions tab / 打开 GitHub Actions 页面

**English**

Go to the **Actions** tab and watch the job.

You should see steps like:

- Install OpenClaw
- Install gateway service and start it
- Stop gateway and confirm health fails
- Run launchd watchdog setup script
- Wait for watchdog recovery and verify health

**中文**

打开仓库的 **Actions** 页面看运行结果。

你会看到类似这些步骤：

- Install OpenClaw
- Install gateway service and start it
- Stop gateway and confirm health fails
- Run launchd watchdog setup script
- Wait for watchdog recovery and verify health

### 4) How to know it passed / 怎么判断成功

**English**

A successful run means:

- Gateway starts normally
- Health fails after stop
- Watchdog runs
- Health becomes good again after waiting

That last part matters most.

**中文**

成功的标准是：

- Gateway 能正常启动
- 停掉之后 health 的确失败
- Watchdog 确实执行了
- 等一会儿以后 health 又恢复成功

最后这一条最重要。

---

## Optional secret / 可选的 Secret

**English**

You can optionally set this GitHub Actions secret:

- `TELEGRAM_BOT_TOKEN`

This repo only checks whether it exists. It does not create a long-running Telegram bot service by itself.

**中文**

你可以选择性地设置这个 GitHub Actions secret：

- `TELEGRAM_BOT_TOKEN`

这个仓库只是检查它有没有存在，并不会自动把 GitHub Actions 变成一个长期运行的 Telegram bot 服务。

---

## Important notes / 重要说明

**English**

- GitHub Actions runners are temporary machines
- This is a test repo, not a permanent hosting setup
- The workflow uses explicit token auth for predictable CI behavior
- mDNS is disabled because ephemeral CI runners are a bad place for cute local-network discovery tricks

**中文**

- GitHub Actions runner 是临时机器
- 这是测试仓库，不是长期托管方案
- workflow 使用显式 token 认证，是为了让 CI 行为更稳定、可预测
- 这里关闭了 mDNS，因为临时 CI 机器并不适合跑那些花里胡哨的本地网络发现逻辑

---

## Who is this for? / 这适合谁

**English**

Use this repo if you want a simple answer to:

- “If OpenClaw dies, can it recover?”

**中文**

如果你只是想快速回答这个问题：

- “OpenClaw 挂了以后，能不能自己恢复？”

那这个仓库就挺适合你。

---

## Current result / 当前验证结果

**English**

This repo has already verified the following path in GitHub Actions:

- start service
- stop service
- confirm unhealthy
- run watchdog
- wait
- confirm healthy again

**中文**

这个仓库已经实际验证过下面这条链路：

- 启动服务
- 停掉服务
- 确认不健康
- 运行 watchdog
- 等待
- 再确认恢复健康

So yes:

**it came back**.

所以答案就是：

**它真的回来了。**
