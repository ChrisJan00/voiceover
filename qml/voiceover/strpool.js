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
    ne("Christiaan Janssen");
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
