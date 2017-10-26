cloneBlogs  = require('./cloneBlogs')
readBlogs   = require('./readBlogs')
parse       = require('./parse')
clearDist   = require('./clearDist')
copyAssets  = require('./copyAssets')
renderIndex = require('./renderIndex')
renderBlogs = require('./renderBlogs')

### run ##
# 跑一遍通用流程
# @params {function} callback
###

module.exports = (callback) ->
  if DIR
    loadBlogs = readBlogs
  else
    loadBlogs = cloneBlogs

  loadBlogs ->
    blogs = parse()
    clearDist()
    copyAssets()
    renderIndex(blogs)
    renderBlogs(blogs)

    if typeof(callback) is 'function'
      callback()