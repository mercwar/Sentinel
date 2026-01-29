/* 
 * AVIS_SPEC: START_JS_NERVE
 * IDENT: CVBGOD_SENTINEL_POLL
 * LAKE_VER: AVIS-DATALAKE-V1.0
 * ROLE: Layer 4 Handshake - Polling Nerve (tmrPoll)
 * avis_coord: index.js, layer: NERVE, role: Dispatch_Poll
 */

function pollSentinel() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/cgi-bin/sentinel_fluid.pl', true);
    xhr.setRequestHeader('X-CVBGOD-SEED', '0xDEADBEEF');
    xhr.setRequestHeader('X-CVBGOD-SIG', 'CVBGODDLK');
    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            var con = document.getElementById('console');
            con.innerHTML += xhr.responseText;
            con.scrollTop = con.scrollHeight;
        }
    };
    xhr.send();
}

// Initialize the 100ms tmrPoll cycle
window.onload = function() {
    setInterval(pollSentinel, 100);
};
