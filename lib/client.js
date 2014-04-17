(function() {
  var print, send_msg, socket;

  print = function(str) {
    return $('#log').prepend($('<p>').text(str));
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
        return print("<" + data.from + "> " + data.body);
    }
  });

  send_msg = function() {
    var data, _ref;
    data = {
      type: 'chat',
      body: $('#msg_body').val(),
      from: $('#msg_from').val()
    };
    if (((_ref = data.msg) != null ? _ref.length : void 0) < 1) {
      return;
    }
    $('#msg_body').val('');
    return socket.send(JSON.stringify(data));
  };

  $('#btn_send').click(send_msg);

  $('#msg_body').on('keydown', function(e) {
    if (e.keyCode === 13) {
      return send_msg();
    }
  });

}).call(this);
