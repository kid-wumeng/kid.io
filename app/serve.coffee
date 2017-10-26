Koa    = require('koa')
stati  = require('koa-static')
colors = require('colors')

### build ##
# 启动静态服务器
# 监听 Github 上的 push 动态，并调用 callback
# @params {function} callback
###

module.exports = (callback) ->

  app = new Koa()
  app.use(stati(CWD + '/dist'))

  app.use (ctx, next) ->
    {method, path} = ctx
    if(method is 'POST' and path is '/push')
      callback()

  app.listen(8086)
  console.log 'KID\'s blog start ~'.green