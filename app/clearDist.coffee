fs = require('fs-extra-promise')

### clearDist ##
# 清空 dist 目录
###

module.exports = (blogs) ->
  fs.emptyDirSync("#{CWD}/dist")