//.pragma library //um Variablenzugriff von überall zu ermöglichen


var hostname = "snugata.selfhost.eu";
var username = "florian";
var password = "vegas";

var	FS20_AUS = 0,
    FS20_AN = 17,
    FS20_DIMM_UP = 19,
    FS20_DIMM_DOWN = 20,
    DIMM_UP_START = 1,
    DIMM_UP_STOP = 2,
    DIMM_DOWN_START = 3,
    DIMM_DOWN_STOP = 4;


function getElementsByTagName(rootElement, tagName) {
    var childNodes = rootElement.childNodes;
    var elements = [];
    for(var i = 0; i < childNodes.length; i++) {
        if(childNodes[i].nodeName === tagName) {
            elements.push(childNodes[i]);
        }
    }
    return elements;
}

function getStatus () {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.HEADERS_RECEIVED) {
            //                                        showRequestInfo("Headers -->");
            //                                        showRequestInfo(xmlhttp.getAllResponseHeaders ());
            //                                        showRequestInfo("Last modified -->");
            //                                        showRequestInfo(xmlhttp.getResponseHeader ("Last-Modified"));

        } else if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var a = xmlhttp.responseXML.documentElement;
            //                                        for (var ii = 0; ii < a.childNodes.length; ++ii) {
            //                                            showRequestInfo(a.childNodes[ii].nodeName);
            //                                        }
            //                                        showRequestInfo("Headers -->");
            //                                        showRequestInfo(xmlhttp.getAllResponseHeaders ());
            //                                        showRequestInfo("Last modified -->");
            //                                        showRequestInfo(xmlhttp.getResponseHeader ("Last-Modified"));

            tempAussen.text = "außen: " + getElementsByTagName(a, 'TempAussen')[0].firstChild.data + " °C";
            tempInnen.text = "innen: " + getElementsByTagName(a, 'TempInnen')[0].firstChild.data + " °C";
            var jal0text = getElementsByTagName(a, 'posJal_0')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_0')[0].firstChild.data;
            var jal1text = getElementsByTagName(a, 'posJal_1')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_1')[0].firstChild.data;
            var jal2text = getElementsByTagName(a, 'posJal_2')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_2')[0].firstChild.data;
            var jal3text = getElementsByTagName(a, 'posJal_3')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_3')[0].firstChild.data;
            jal1.text = "Jalousie 1: " + jal0text;
            jal2.text = "Jalousie 2: " + jal1text;
            jal3.text = "Jalousie 3: " + jal2text;
            jal4.text = "Jalousie 4: " + jal3text;
            listSingle.model.setProperty( 0, "subtext", jal0text);
            listSingle.model.setProperty( 1, "subtext", jal1text);
            listSingle.model.setProperty( 2, "subtext", jal2text);
            listSingle.model.setProperty( 3, "subtext", jal3text);
            orient.text = "Orientierungslicht: " + getElementsByTagName(a, 'Orient')[0].firstChild.data
            abluftHWR.text = "Abluft HWR: " + getElementsByTagName(a, 'HWR')[0].firstChild.data
            zentraleAbluft.text = "Zentrale Abluft: " + getElementsByTagName(a, 'Abluft')[0].firstChild.data
            sa.text = "Sonnenaufgang: " + getElementsByTagName(a, 'SA')[0].firstChild.data
            su.text = "Sonnenuntergang: " + getElementsByTagName(a, 'SU')[0].firstChild.data
            funkHell.text = "Helligkeit: " + getElementsByTagName(a, 'EmpfangHell')[0].firstChild.data
            funkWetter.text = "Wetter: " + getElementsByTagName(a, 'EmpfangWetter')[0].firstChild.data
            beete.statusText = "Status: " + getElementsByTagName(a, 'Ventil_1')[0].firstChild.data
            kuebel.statusText = "Status: " + getElementsByTagName(a, 'Ventil_2')[0].firstChild.data
        }
    }
    xmlhttp.open("POST", "http://" + hostname + "/weather.php", "true", username, password)
    xmlhttp.send()
}

function getLicht () {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            lichtModel.clear();
            for (var i = 0; i  < obj.items.length; i++) {
                lichtModel.append( { "id": obj.items[i].id, "name": obj.items[i].name, "checked": false } );
            }
        }
    }
    xmlhttp.open("POST", "http://" + hostname + "/licht_m.php?id=licht", "true", username, password)
    xmlhttp.send()
}

function getSzene () {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            szeneModel.clear();
            for (var i = 0; i  < obj.items.length; i++) {
                szeneModel.append( { "name": obj.items[i].name } );
            }
        }
    }
    xmlhttp.open("POST", "http://" + hostname + "/licht_m.php?id=szene", "true", username, password)
    xmlhttp.send()
}

function setSzene(name) {
    var data = "device=SZENE&txtSzene=" + name;
    httpPost("drv.php", data);
}

function setLicht(lampenID, wert) {
    var data = "device=LICHT&txtLampe=" + lampenID + "&txtWert=" + wert;
    httpPost("drv.php", data);
}

function setBewaesserung(ventil, state, time) {
    var data = "";
    if (state == true) {
        if (ventil === 1)
            data = "device=VENTIL&txtButtonName=VENTIL_1_TIMER:" + time;
        else
            data = "device=VENTIL&txtButtonName=VENTIL_2_TIMER:" + time;
    } else {
        if (ventil === 1)
            data = "device=VENTIL&txtButtonName=VENTIL_1_STOP";
        else
            data = "device=VENTIL&txtButtonName=VENTIL_2_STOP";
    }
    httpPost("drv.php", data);
}

function drvJalousie(jalNr, command) {
    var data = "";
    for (var i = 0; i < jalNr.length; i++) {
        data = "device=JAL&txtButtonName=" + command + "_" + jalNr[i];
        httpPost("drv.php", data);
    }
}


function httpPost (destination, data) {
    var http = new XMLHttpRequest()
    http.open("POST", "http://" + hostname + "/" + destination, "true", username, password);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.setRequestHeader("Content-length", data.length);
    http.setRequestHeader("Connection", "close");

    http.onreadystatechange = function() { // Call a function when the state changes.
                if (http.readyState == 4) {
                    if (http.status == 200) {
                        console.log("ok")
                    } else {
                        console.log("error: " + http.status)
                    }
                }
            }
    http.send(data);
}




