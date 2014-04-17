http = require 'http'
fs   = require 'fs'
url  = require 'url'

app_handler = (req, res) ->
  _url = url.parse(decodeURI(req.url), true);
  path = if _url.pathname == '/' then '/index.html' else _url.pathname
  console.log "#{req.method} - #{path}"
  fs.readFile __dirname+path, (err, data) ->
    if err
      res.writeHead 500
      return res.end 'error load file'
    res.writeHead 200
    res.end data

app = http.createServer(app_handler)
engine = require('engine.io').attach(app)

engine.on 'connection', (socket) ->
  console.log "new client"
  setImmediate ->
    socket.send JSON.stringify {type: 'chat', body: 'hello new client!!'}

  socket.once 'close', ->
    console.log "client closed"

  socket.on 'message', (recv_data) ->
    console.log recv_data
    try
      data = JSON.parse recv_data
    catch
      return
    return unless data.type?
    switch data.type
      when 'chat'
        for client_id, client of engine.clients
          setImmediate ->
            client.send recv_data

process.env.PORT ||= 5000
app.listen(process.env.PORT)
console.log "server start - port:#{process.env.PORT}"
