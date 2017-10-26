fs     = require('fs-extra-promise')
jade   = require('jade')
marked = require('marked')

### parse ##
# 解析全部日志
# @return {object[]} blogs - {date, title, content, path}
###

module.exports = ->

  blogs = fs.readdirSync("#{CWD}/blogs")

  blogs = blogs.map (blog) ->

    [_, date, titleOrigin] = blog.match(/(^\d{4}-\d{2}-\d{2}) (.+)/)

    title = titleOrigin.replace(/\\/g, '/')

    path = date + '/' + titleOrigin.replace(/(\s|\\)+/g, '-')

    content = fs.readFileSync("#{CWD}/blogs/#{blog}/README.md", 'utf-8')
    content = marked(content, {
      gfm: true
      breaks: true
    })

    return {date, title, content, path}

  return blogs