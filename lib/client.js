(function() {
  var print, send_msg, socket;

  print = function(msg) {
    return $('#log').prepend($('<p>').text(msg));
  };

  socket = eio("" + location.protocol + "//" + location.hostname);

  socket.once('open', function() {
    print("engine.io connect!!!");
    return socket.once('close', function() {
      return print("engine.io closed..");
    });
  });

  socket.on('message', function(recv_data) {
    var data;
    console.log(recv_data);
    try {
      data = JSON.parse(recv_data);
    } catch (_error) {
      return;
    }
    if (data.type == null) {
      return;
    }
    switch (data.type) {
      case 'chat':
        return print(data.body);
    }
  });

  send_msg = function() {
    var msg;
    msg = $('#msg_body').val();
    socket.send(JSON.stringify({
      type: 'chat',
      body: msg
    }));
    return $('#msg_body').val('');
  };

  $('#btn_send').click(send_msg);

  $('#msg_body').on('keydown', function(e) {
    if (e.keyCode === 13) {
      return send_msg();
    }
  });

}).call(this);
