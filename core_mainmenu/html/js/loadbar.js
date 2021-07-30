var count = 0;
var thisCount = 0;
var loadbar = '.progressBar'
window.addEventListener('message', function(e) {
    (handlers[e.data.eventName] || function() {})(e.data);
    $('#loadstuffdiv').show();
});

const handlers = {
    startInitFunctionOrder(data) {
        RotateMessage()
        count = data.count;
    },
    initFunctionInvoking(data) {
        RotateMessage()
        document.querySelector(loadbar).style.left = '0%';
        document.querySelector(loadbar).style.width = ((data.idx / count) * 100) + '%';
    },
    startDataFileEntries(data) {
        RotateMessage()
        count = data.count;
    },
    performMapLoadFunction(data) {
        RotateMessage()
            ++thisCount;
        document.querySelector(loadbar).style.left = '0%';
        document.querySelector(loadbar).style.width = ((thisCount / count) * 100) + '%';
    },
};