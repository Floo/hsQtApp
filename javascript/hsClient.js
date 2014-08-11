//.pragma library //um Variablenzugriff von überall zu ermöglichen
.import "global.js" as Global


//Hilfsfunktionen
function stringToBoolean(string){
    if (typeof string === 'boolean') {
        return(string);
    }
    switch(string.toLowerCase()){
    case "true": case "yes": case "1": return true;
                             case "false": case "no": case "0": case null: case "": return false;
                                                                           default: return Boolean(string);
    }
}

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

function getXMLfirstChild(rootElement, tagname) {
    return getElementsByTagName(rootElement, tagname)[0].firstChild.data
}

function getStatus () {
    if (!Global.networkconfigOK) return;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var a = xmlhttp.responseXML.documentElement;
            temperatur.text = getXMLfirstChild(a, 'TempInnen') + " °C<br>"
                    + getXMLfirstChild(a, 'TempAussen') + " °C";
            aktuellesWetter.source = "../images/" + getXMLfirstChild(a, 'Symbol');
            var jal0text = getXMLfirstChild(a, 'posJal_0') + "/" + getXMLfirstChild(a, 'drvJal_0');
            var jal1text = getXMLfirstChild(a, 'posJal_1') + "/" + getXMLfirstChild(a, 'drvJal_1');
            var jal2text = getXMLfirstChild(a, 'posJal_2') + "/" + getXMLfirstChild(a, 'drvJal_2');
            var jal3text = getXMLfirstChild(a, 'posJal_3') + "/" + getXMLfirstChild(a, 'drvJal_3');
            jalousie.text = jal0text + "<br>" + jal1text + "<br>" + jal2text + "<br>" + jal3text;
            sasu.text = getXMLfirstChild(a, 'SA') + " Uhr<br>" + getXMLfirstChild(a, 'SU') + " Uhr"
            lueftung.text = getXMLfirstChild(a, 'Orient') + "<br>" + getXMLfirstChild(a, 'HWR')
            var hellText = getXMLfirstChild(a, 'EmpfangHell');
            var wetterText = getXMLfirstChild(a, 'EmpfangWetter');
            empfang.text = hellText.substr(0, hellText.length - 1) +
                    "<br>" + wetterText.substr(0, wetterText.length - 1);
            regen.text = getXMLfirstChild(a, 'Regen_1h') + " l/m²<br>" + getXMLfirstChild(a, 'Regen_24h') +
                    " l/m²<br>" + getXMLfirstChild(a, 'Regen_7d') + " l/m²";
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/weather.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

function getStatusJal() {
    if (!Global.networkconfigOK) return;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var a = xmlhttp.responseXML.documentElement;
            var jal0text = getXMLfirstChild(a, 'posJal_0') + "/" + getXMLfirstChild(a, 'drvJal_0');
            var jal1text = getXMLfirstChild(a, 'posJal_1') + "/" + getXMLfirstChild(a, 'drvJal_1');
            var jal2text = getXMLfirstChild(a, 'posJal_2') + "/" + getXMLfirstChild(a, 'drvJal_2');
            var jal3text = getXMLfirstChild(a, 'posJal_3') + "/" + getXMLfirstChild(a, 'drvJal_3');
            listSingle.model.setProperty( 0, "position", jal0text);
            listSingle.model.setProperty( 1, "position", jal1text);
            listSingle.model.setProperty( 2, "position", jal2text);
            listSingle.model.setProperty( 3, "position", jal3text);
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/weather.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

function getStatusBewaesserung() {
    if (!Global.networkconfigOK) return;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var a = xmlhttp.responseXML.documentElement;
            beete.statusText = "Status: " + getXMLfirstChild(a, 'Ventil_1')
            kuebel.statusText = "Status: " + getXMLfirstChild(a, 'Ventil_2')
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/weather.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

//"up_time":"20:00","down_time":"10:00","auto_time":false,"jal_2_open":false,"weather":"0",
//"wind_protection":false,"open_on_rain":false,"close_to_sun":"1"
function getSetupJal() {
    if (!Global.networkconfigOK) return;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            rootJalSetupPage.init = true;
            luecke.checked = stringToBoolean(obj.blinds.close_to_sun);
            wetter.checked = stringToBoolean(obj.blinds.weather);
            wind.checked = stringToBoolean(obj.blinds.wind_protection);
            tuer.checked = stringToBoolean(obj.blinds.jal_2_open);
            regen.checked = stringToBoolean(obj.blinds.open_on_rain);
            zeit.checked = stringToBoolean(obj.blinds.auto_time);
            zeitOeffnen.value = obj.blinds.up_time;
            zeitSchliessen.value = obj.blinds.down_time;
            rootJalSetupPage.init = false;
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/setup_m.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

function setSetupJal () {
    if (!Global.networkconfigOK) return;

    var data = "txtAuf=" + zeitOeffnen.value.replace("+", "g") + "&txtZu=" + zeitSchliessen.value.replace("+", "g")
            + "&chkLuecke=" + luecke.checked + "&chkAuto=" + zeit.checked + "&chkTuer=" + tuer.checked +
            "&chkWeather=" + wetter.checked + "&chkRain=" + regen.checked + "&chkWind=" + wind.checked;
    httpPost("setJalousie.php", data);
}

function initJalTimeDialog(value) {
    if (value.search(/S/) !== -1) {
        dialog.sasu = true;
        dialog.hour = 8;
        dialog.minute = 0;
        dialog.sonne = (value.substr(0, 2) === "SA") ? 0 : 1;
        dialog.offset = value.substring(2, value.length);
    } else {
        dialog.sasu = false;
        dialog.hour = value.substring(0, value.indexOf(":"));
        dialog.minute = value.substring(value.indexOf(":") + 1, value.length);
        dialog.sonne = 0;
        dialog.offset = 0;
    }
}

//"ventil_1_start":"20:30","ventil_2_start":"21:00","ventil_1_duration":"9","ventil_2_duration":"8",
//"ventil_1_auto":"0","ventil_2_auto":"1","ventil_1_rain":"","ventil_2_rain":""
function getSetupBewaesserung() {
    if (!Global.networkconfigOK) return;

    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            rootBewaesserungSetupPage.init = true;
            beeteRegen.checked = stringToBoolean(obj.irrigation.ventil_1_rain);
            kuebelRegen.checked = stringToBoolean(obj.irrigation.ventil_2_rain);
            beeteAuto.checked = stringToBoolean(obj.irrigation.ventil_1_auto);
            kuebelAuto.checked = stringToBoolean(obj.irrigation.ventil_2_auto);
            beeteDauer.value = obj.irrigation.ventil_1_duration + " min";
            kuebelDauer.value = obj.irrigation.ventil_2_duration + " min";
            beeteZeit.value = obj.irrigation.ventil_1_start;
            kuebelZeit.value = obj.irrigation.ventil_2_start;
            rootBewaesserungSetupPage.init = false;
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/setup_m.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

function setSetupBewaesserung() {
    if (!Global.networkconfigOK) return;

    var data = "txtV1Start=" + beeteZeit.value + "&txtV2Start=" + kuebelZeit.value + "&txtV1Dauer=" +
            beeteDauer.value.substring(0, beeteDauer.value.indexOf(" ")) + "&txtV2Dauer=" +
            kuebelDauer.value.substring(0, kuebelDauer.value.indexOf(" ")) + "&chkV1Auto=" + beeteAuto.checked +
            "&chkV2Auto=" + kuebelAuto.checked + "&chkV1Rain=" + beeteRegen.checked + "&chkV2Rain=" + kuebelRegen.checked;
    httpPost("setTerrasse.php", data);
}

function initDauerDialog (value) {
    Global.mainobj.state = "";
    valuepickerdialog.value = value.substring(0, value.indexOf(" "));
}

function initZeitDialog(value) {
    Global.mainobj.state = "";
    timepickerdialog.hour = value.substring(0, value.indexOf(":"));
    timepickerdialog.minute = value.substring(value.indexOf(":") + 1, value.length);
}

//"HWRthreshold":"35","HWRpermanent":"0","HWRauto":"0","AClow":"1"
function getSetupAbluft() {
    if (!Global.networkconfigOK) return;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            rootAbluftSetupPage.init = true;
            valuepickerdialog.value = obj.abluft.HWRthreshold;
            if (stringToBoolean(obj.abluft.HWRpermanent)) {
                hwrAus.checked = false;
                hwrAn.checked = true;
                hwrTemp.checked = false;
            } else if (stringToBoolean(obj.abluft.HWRauto)) {
                hwrAus.checked = false;
                hwrAn.checked = false;
                hwrTemp.checked = true;
            } else {
                hwrAus.checked = true;
                hwrAn.checked = false;
                hwrTemp.checked = false;
            }
            abluft.checked = stringToBoolean(obj.abluft.AClow)
            rootAbluftSetupPage.init = false;
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/setup_m.php", "true", Global.username, Global.password)
    xmlhttp.send()
}

function initAbluftTempDialog (value) {
    valuepickerdialog.value = value.substring(0, value.indexOf(" "));
}

function setSetupAbluft() {
    if (!Global.networkconfigOK) return;
    var data = "txtTemp=" + hwrTempValue.value.substring(0, hwrTempValue.value.indexOf(" "))  +  "&chkAClow=" +
            abluft.checked +  "&chkHWRpermanent=" + hwrAn.checked  + "&chkHWRauto=" + hwrTemp.checked;
    httpPost("setLueftung.php", data)
}

//"display_wakeup":"7:00"
function getSetupSystem() {
    if (!Global.networkconfigOK) return;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);

            rootSystemSetupPage.init = true;
            if(obj.hsgui.display_wakeup === "") {
                autostartGUIZeit.value = "7:00";
                autostartGUI.checked = false;
            } else {
                autostartGUIZeit.value = obj.hsgui.display_wakeup;
                autostartGUI.checked = true;
            }
            rootSystemSetupPage.init = false;
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/setup_m.php", "true", Global.username, Global.password)
    xmlhttp.send()
}


function getLogfile() {
    var http = new XMLHttpRequest()
    var now = +(new Date);
    var data = "device=LOGFILE_INVERS&timestamp=" + now;

    http.open("POST", "http://" + Global.hostname + "/drv.php", "true", Global.username, Global.password);

    // Send the proper header information along with the request
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    http.setRequestHeader("Content-length", data.length);
    http.setRequestHeader("Connection", "close");

    http.onreadystatechange = function() { // Call a function when the state changes.
        if (http.readyState === XMLHttpRequest.DONE) {
            var foo = http.responseText;
            var text = foo.substring(foo.indexOf("<log_inv>") + 9, foo.indexOf("</log_inv>"));
            text.replace(/\n/g, "<br>");
            logtext.text = text;
        }
    }
    http.send(data);
}

function setSetupSystem() {
    if (!Global.networkconfigOK) return;
    var data = "txtStartGUI=";
    if(autostartGUI.checked) data = data + autostartGUIZeit.value;
    httpPost("setSystem", data)
}

function getLicht () {
    if (!Global.networkconfigOK) return;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            lichtModel.clear();
            for (var i = 0; i  < obj.items.length; i++) {
                lichtModel.append( { "id": obj.items[i].id, "name": obj.items[i].name, "checked": false } );
            }
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/licht_m.php?id=licht", "true", Global.username, Global.password)
    xmlhttp.send()
}

function getSzene () {
    if (!Global.networkconfigOK) return;
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState === XMLHttpRequest.DONE) {
            var json = xmlhttp.responseText;
            var obj = JSON.parse(json);
            szeneModel.clear();
            for (var i = 0; i  < obj.items.length; i++) {
                szeneModel.append( { "name": obj.items[i].name } );
            }
        }
    }
    xmlhttp.open("POST", "http://" + Global.hostname + "/licht_m.php?id=szene", "true", Global.username, Global.password)
    xmlhttp.send()
}

function setSzene(name) {
    if (!Global.networkconfigOK) return;
    var data = "device=SZENE&txtSzene=" + name;
    httpPost("drv.php", data);
}

function setLicht(lampenID, wert) {
    if (!Global.networkconfigOK) return;
    var data = "device=LICHT&txtLampe=" + lampenID + "&txtWert=" + wert;
    httpPost("drv.php", data);
}

function setBewaesserung(ventil, state, time) {
    if (!Global.networkconfigOK) return;
    var data = "";
    if (state === true) {
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
    if (!Global.networkconfigOK) return;
    var data = "";
    for (var i = 0; i < jalNr.length; i++) {
        data = "device=JAL&txtButtonName=" + command + "_" + jalNr[i];
        httpPost("drv.php", data);
    }
}


function httpPost (destination, data) {
    var http = new XMLHttpRequest()
    http.open("POST", "http://" + Global.hostname + "/" + destination, "true", Global.username, Global.password);

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
    console.log(data);
    http.send(data);
}

function checkNetworkSettings() {
    Global.networkconfigOK = !(Global.hostname === "" || Global.username === "" || Global.password === "");
}







