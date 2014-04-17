print = (str) ->
  $('#log').prepend $('<p>').text(str)

socket = eio("#{location.protocol}//#{location.hostname}")

socket.once 'open', ->
  print "engine.io connect!!!"
  socket.once 'close', ->
    print "engine.io closed.."

socket.on 'message', (recv_data) ->
  console.log recv_data
  try
    data = JSON.parse recv_data
  catch
    return
  return unless data.type?
  switch data.type
    when 'chat'
      print "<#{data.from}> #{data.body}"

send_msg = ->
  data = {
    type: 'chat'
    body: $('#msg_body').val()
    from: $('#msg_from').val()
  }
  return if data.msg?.length < 1
  $('#msg_body').val('')
  socket.send JSON.stringify data

$('#btn_send').click send_msg
$('#msg_body').on 'keydown', (e) ->
  send_msg() if e.keyCode == 13
