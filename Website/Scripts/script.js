$(document).ready(function () {
    //if (!Modernizr.websockets) {
    //    alert('WebSockets are not supported.');
    //    return;
    //}

    //var settings = {
    //	host: 'ws://localhost:1405',
    //	pictureContainerID: 'pictureContainer',
    //	pictureID: 'picture',
    //	titleID: 'title'
    //};

    //pixSocket.connect(settings);
    pixSocket.start_connect('ws://101.99.3.56:1405');
    
});



