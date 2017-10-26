fs        = require('fs-extra-promise')
jade      = require('jade')
marked    = require('marked')
highlight = require('highlight.js')

### parse ##
# 解析全部日志
# @return {object[]} blogs - {date, title, content, urlPath, localPath}
###

module.exports = ->

  blogs = fs.readdirSync("#{CWD}/blogs")

  blogs = blogs.map (localPath) ->

    [_, date, titleOrigin] = localPath.match(/(^\d{4}-\d{2}-\d{2}) (.+)/)

    title = titleOrigin.replace(/\\/g, '/')

    urlPath = date + '/' + titleOrigin.replace(/(\s|\\)+/g, '-')

    content = fs.readFileSync("#{CWD}/blogs/#{localPath}/README.md", 'utf-8')
    content = marked(content, {
      gfm: true
      breaks: true
      highlight: (code) -> highlight.highlightAuto(code).value;
    })

    return {date, title, content, urlPath, localPath}

  return blogs.reverse()