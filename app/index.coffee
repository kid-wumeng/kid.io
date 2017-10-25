fs     = require('fs-extra-promise')
jade   = require('jade')
marked = require('marked')
Koa    = require('koa')
serve  = require('koa-static')
colors = require('colors')


cwd = process.cwd()


homeTemplate = fs.readFileSync("#{cwd}/templates/home.jade", 'utf-8')
blogTemplate = fs.readFileSync("#{cwd}/templates/blog.jade", 'utf-8')


renderHome = jade.compile(homeTemplate, pretty: true)
renderBlog = jade.compile(blogTemplate, pretty: true)


blogs = fs.readdirSync("#{cwd}/blogs")


blogs = blogs.map (blog) ->
  date    = blog.split(/\s+/)[0]
  title   = blog.split(/\s+/).slice(1).join(' ')
  path    = date + '/' + title.replace(/(\s|\\)+/g, '-')
  title   = title.replace(/\\/g, '/')
  content = fs.readFileSync("#{cwd}/blogs/#{blog}/README.md", 'utf-8')
  content = marked(content, {
    gfm: true
    breaks: true
  })
  return {date, title, path, content}


fs.emptyDirSync("#{cwd}/docs")


homeHTML = renderHome({
  blogs: blogs
})
fs.writeFileSync("#{cwd}/docs/index.html", homeHTML, 'utf-8')


for blog in blogs
  blogHTML = renderBlog({
    blog: blog
  })
  fs.ensureFileSync("#{cwd}/docs/#{blog.path}.html")
  fs.writeFileSync("#{cwd}/docs/#{blog.path}.html", blogHTML, 'utf-8')


fs.copySync("#{cwd}/assets", "#{cwd}/docs/assets")


app = new Koa()
app.use(serve(cwd + '/docs'))
app.listen(8086)
console.log 'KID\'s blog start ~'.green