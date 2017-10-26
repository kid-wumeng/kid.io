watch       = require('watch')
cloneBlogs  = require('./cloneBlogs')
parse       = require('./parse')
clearDist   = require('./clearDist')
renderIndex = require('./renderIndex')
renderBlogs = require('./renderBlogs')
copyAssets  = require('./copyAssets')
serve       = require('./serve')


global.CWD = process.cwd()


# 初始化时
cloneBlogs ->
  blogs = parse()
  clearDist()
  copyAssets()
  renderIndex(blogs)
  renderBlogs(blogs)

  # Github push 时
  serve ->
    cloneBlogs ->
      blogs = parse()
      clearDist()
      copyAssets()
      renderIndex(blogs)
      renderBlogs(blogs)

# 开发调试时
watch.watchTree("#{CWD}/assets", copyAssets)
