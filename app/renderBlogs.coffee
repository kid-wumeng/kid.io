fs   = require('fs-extra-promise')
jade = require('jade')

### renderBlogs ##
# 渲染全部 blog.html 并放至 dist
# @params {object[]} blogs - {date, title, content, path}
###

module.exports = (blogs) ->

  template = fs.readFileSync("#{CWD}/templates/blog.jade", 'utf-8')
  render   = jade.compile(template, pretty: true)

  for blog in blogs
    html = render({
      blog: blog
    })
    fs.ensureFileSync("#{CWD}/dist/#{blog.path}.html")
    fs.writeFileSync("#{CWD}/dist/#{blog.path}.html", html, 'utf-8')