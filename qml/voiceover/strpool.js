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
    ne("I am here, stranded on this island.",1);
    ne("When you close your eyes, the world banishes.",2);
    ne("My life is like a pistaccio icecream.",3)
}

function ne(str, opt) {
    strmdl.append({"name":str, "opt":opt});
}

function clicked(opt) {
    var noskip = false;
    strmdl.clear();
    switch (currentStep) {
    case 0: {
        switch(opt) {
        case 1: {
            ne("I am not sure if I miss people or not.",1);
            ne("I should feel trapped, but I feel free.",1);
            ne("It is not deserted. There is more people than space.",1);

            break; }
        case 2: { break; }
        case 3: { break; }
        }
        break;
    }
    case 1: {
        switch(opt) {
        case 1: { ne("I look towards the horizon. The sea around me.");

            break; }
        case 2: { break; }
        case 3: { break; }
        }
        break;
    }
    case 2: {
        ne("Some days I feel I should get out.\nSome days I want to stay here forever.", opt);
        noskip = true;
        break;
    }
    case 3: {
        switch(opt) {
        case 1: { break; }
        case 2: { break; }
        case 3: { break; }
        }


        break;
    }
    }

    if (!noskip)
        ne("SKIP",opt);
    currentStep++;
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
