path       = require('path')
watch      = require('watch')
run        = require('./run')
copyAssets = require('./copyAssets')
serve      = require('./serve')


global.CWD = process.cwd()
global.DIR = process.argv[2]


# 初始化时
run ->
  # Github push 时
  serve(run)

# 开发调试时
watch.watchTree("#{CWD}/assets", copyAssets)
# 写作调试时
watch.watchTree(path.resolve(CWD, DIR), {ignoreDotFiles: true}, run)