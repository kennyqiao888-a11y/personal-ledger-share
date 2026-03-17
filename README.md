# Personal Ledger Share

这是给远程查看用的账本静态站点。

## 文件
- `index.html`：账本 share 页面
- `ledger-data.js`：share 页面读取的数据
- `refresh-share.ps1`：从本地主账本同步到 share 版，并自动推送 GitHub

## 用法
在 PowerShell 里运行：

```powershell
powershell -ExecutionPolicy Bypass -File C:\Users\USER\.openclaw\workspace\apps\personal-ledger-share\refresh-share.ps1
```

运行后会：
1. 同步 `index.html`
2. 同步 `ledger-data.js`
3. 自动 git commit / push 到 GitHub
4. 由 Netlify 自动部署
