fs   = require('fs-extra-promise')
jade = require('jade')

### renderBlogs ##
# 渲染全部 blog.html 并放至 dist
# @params {object[]} blogs - {date, title, content, urlPath, localPath}
###

module.exports = (blogs) ->

  template = fs.readFileSync("#{CWD}/templates/blog.jade", 'utf-8')
  render   = jade.compile(template, pretty: true)

  for blog in blogs

    html = render({
      blog: blog
    })

    fs.ensureFileSync("#{CWD}/dist/#{blog.urlPath}.html")
    fs.writeFileSync("#{CWD}/dist/#{blog.urlPath}.html", html, 'utf-8')

    if fs.existsSync("#{CWD}/blogs/#{blog.localPath}/images")
      fs.copySync("#{CWD}/blogs/#{blog.localPath}/images", "#{CWD}/dist/#{blog.date}/images")