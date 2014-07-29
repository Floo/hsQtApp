//                            function showRequestInfo(text) {
//                                //log.text = log.text + "\n" + text
//                                console.log(text)
//                            }

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

            tempAussen.text = "außen: " + getElementsByTagName(a, 'TempAussen')[0].firstChild.data + " °C"
            tempInnen.text = "innen: " + getElementsByTagName(a, 'TempInnen')[0].firstChild.data + " °C"
            jal1.text = "Jalousie 1: " + getElementsByTagName(a, 'posJal_0')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_0')[0].firstChild.data
            jal2.text = "Jalousie 2: " + getElementsByTagName(a, 'posJal_1')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_1')[0].firstChild.data
            jal3.text = "Jalousie 3: " + getElementsByTagName(a, 'posJal_2')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_2')[0].firstChild.data
            jal4.text = "Jalousie 4: " + getElementsByTagName(a, 'posJal_3')[0].firstChild.data + "/" + getElementsByTagName(a, 'drvJal_3')[0].firstChild.data
            orient.text = "Orientierungslicht: " + getElementsByTagName(a, 'Orient')[0].firstChild.data
            abluftHWR.text = "Abluft HWR: " + getElementsByTagName(a, 'HWR')[0].firstChild.data
            zentraleAbluft.text = "Zentrale Abluft: " + getElementsByTagName(a, 'Abluft')[0].firstChild.data
            sa.text = "Sonnenaufgang: " + getElementsByTagName(a, 'SA')[0].firstChild.data
            su.text = "Sonnenuntergang: " + getElementsByTagName(a, 'SU')[0].firstChild.data
            funkHell.text = "Helligkeit: " + getElementsByTagName(a, 'EmpfangHell')[0].firstChild.data
            funkWetter.text = "Wetter: " + getElementsByTagName(a, 'EmpfangWetter')[0].firstChild.data
        }
    }
    xmlhttp.open("POST", "http://snugata.selfhost.eu/weather.php", "true", "florian", "vegas")
    xmlhttp.send()
}
