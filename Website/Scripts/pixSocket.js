//var pixSocket = function() {
    
    
    
//    var settings, connection;
//    send = function (data) {
//        connection.send(data);
//    }
//    connect = function(_settings) {
//        settings = _settings;
//        connection = new WebSocket(settings.host);

//        connection.onopen = function () {};

//        connection.onmessage = function (message) {
//            //var pix = JSON.parse(message.data);
//            //showPicture(pix.media.m, pix.title);
//            console.log(message.data);
            
//        };
//    }

//    return {
//        connect: connect
//    };
//    return {
//        send: send
//    };

//}();
var pixSocket = new PixSocket();
function PixSocket() {
    var webSocket;
    var connected = false;
    this.start_connect = function (host) {
        webSocket = new WebSocket(host);
        webSocket.onopen = function () {
            connected = true;
        };

        webSocket.onmessage = function (message) {
            var pix = JSON.parse(message.data);
            //var result = new Float32Array(pix.length);
            //var offset = 0;
            //for (var i = 0; i < pix.length; i++) {
            //    console.log();
            //    //result.set(recBuffers[i], offset);
            //    //offset += recBuffers[i].length;
            //}
            var f32array = new Float32Array(pix.data);

            var myArrayBuffer = contextNew.createBuffer(1, pix.length, pix.sampleRate);
            myArrayBuffer.getChannelData(0).set(f32array);
            addChunkToQueue(myArrayBuffer);
        };
    }
    this.send = function (data) {
        webSocket.send(data);
    }
}