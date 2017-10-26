fs     = require('fs-extra-promise')

### copyAssets ##
# 拷贝 assets 到 dist
###

module.exports = ->
  fs.copySync("#{CWD}/assets", "#{CWD}/dist/assets")