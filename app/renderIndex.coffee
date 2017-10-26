fs   = require('fs-extra-promise')
jade = require('jade')

### renderIndex ##
# 渲染 index.html 并放至 dist
# @params {object[]} blogs - {date, title, content, path}
###

module.exports = (blogs) ->

  template = fs.readFileSync("#{CWD}/templates/index.jade", 'utf-8')
  render   = jade.compile(template, pretty: true)

  html = render({
    blogs: blogs
  })
  
  fs.writeFileSync("#{CWD}/dist/index.html", html, 'utf-8')