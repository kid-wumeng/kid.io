path = require('path')
fs   = require('fs-extra-promise')

### readBlogs ##
# 从本地读取日志
# 清除其中的非日志文件
# 适用于本地写作时的预览
# @params {function} callback
###

module.exports = (callback) ->

  localPath = path.resolve(CWD, DIR)

  fs.removeSync("#{CWD}/blogs")
  fs.copySync(localPath, "#{CWD}/blogs")

  files = fs.readdirSync("#{CWD}/blogs")

  for file in files
    isBlog = /^\d{4}-\d{2}-\d{2} /.test(file)

    if(!isBlog)
      fs.removeSync("#{CWD}/blogs/#{file}")

  callback()