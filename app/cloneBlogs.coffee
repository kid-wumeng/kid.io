fs  = require('fs-extra-promise')
git = require('simple-git')

### cloneBlogs ##
# 从 Github 上克隆日志仓库
# 清除其中的非日志文件
# @params {function} callback
###

module.exports = (callback) ->

  fs.emptyDirSync("#{CWD}/blogs")

  git().clone 'https://github.com/kid-wumeng/blogs.git', "#{CWD}/blogs", {
    '--depth': 1
  }, ->

    files = fs.readdirSync("#{CWD}/blogs")

    for file in files
      isBlog = /^\d{4}-\d{2}-\d{2} /.test(file)

      if(!isBlog)
        fs.removeSync("#{CWD}/blogs/#{file}")

    callback()