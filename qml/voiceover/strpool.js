var currentStep = 0;

function redoList() {
//    rootMain.sentenceSelected("HOLA");
    strmdl.clear();
    strmdl.append({"name":"first sntc"});
    strmdl.append({"name":"sec sntc"});

}

function restart() {
    currentStep = 0;
    strmdl.clear();
    ne("This was the most strange of all the days.  He could not believe\nwhat his eyes were seeing.");
    ne("Start");
}

function ne(str, opt) {
    strmdl.append({"name":str, "opt":opt});
}

function clicked(opt) {

    strmdl.clear();
    switch (currentStep) {
    case 0: {
        ne("hola");
        ne("wat");
        currentStep++;
        break;
    }
    case 1: {
        ne("hey");
        ne("my");
        currentStep++;
        break;
    }
    }
}

function getColor(ndx) {
    switch(ndx) {
    case 0: return "#776238"; break;
    case 1: return "#816B3E"; break;
    case 2: return "#8C7444"; break;
    case 3: return "#977D49"; break;
    case 4: return "#A18650"; break;
    case 5: return "#AB8F57"; break;
    case 6: return "#B09662"; break;
    case 7: return "#B59D6E"; break;
    case -1: return "#3E3B62"; break;
    case -2: return "#45416B"; break;
    case -3: return "#4B4773"; break;
    case -4: return "#514D7C"; break;
    case -5: return "#575485"; break;
    case -6: return "#5E5A8E"; break;
    case -7: return "#646097"; break;
    case -8: return "#6C689E"; break;
    }
}
