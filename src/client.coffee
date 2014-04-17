print = (msg) ->
  $('#log').prepend $('<p>').text(msg)

socket = eio("#{location.protocol}//#{location.hostname}")

socket.on 'open', ->
  print "connect!!!"
  socket.on 'close'

socket.on 'message', (recv_data) ->
  try
    data = JSON.parse recv_data
  catch
    return
  return unless data.type?
  switch data.type
    when 'chat'
      print data.body

send_msg = ->
  msg = $('#msg_body').val()
  socket.send JSON.stringify {type: 'chat', body: msg}
  $('#msg_body').val('')

$('#btn_send').click send_msg
$('#msg_body').on 'keydown', (e) ->
  send_msg() if e.keyCode == 13
