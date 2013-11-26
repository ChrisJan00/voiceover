var currentStep = 0;
var recording = [];
var recordNdx = 0;
var startTime = 0;

function redoList() {
//    rootMain.sentenceSelected("HOLA");
    strmdl.clear();
    strmdl.append({"name":"first sntc"});
    strmdl.append({"name":"sec sntc"});

}

function restart() {
    currentStep = 0;
    startTime = new Date();
    recordNdx = 0;
    strmdl.clear();
    ne("I am here, stranded on this island.",1);
    ne("When you close your eyes, the world banishes.",2);
    ne("My life is like a pistaccio icecream.",3);
    ne("SKIP",2);
}

function startRecording() {
    recording = [];
}

function recorded() {
    return recording.length > 0;
}

function recordSentence(sentence) {
    var currentTime = new Date();
    var mark = currentTime - startTime;
    startTime = currentTime;

    recording.push([sentence, mark]);
}

function getNextSentence() {
    if (recordNdx == recording.length)
        return -1;
    var retval = recording[recordNdx];
    recordNdx++;
    return retval;
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
        case 2: {
            ne("The people are not there. The cars are not there.\nThe colors remain in your mind.",2);
            ne("It is only an illusion.",2);
            ne("I'm in the intimacy of myself.",2);
            break; }
        case 3: {
            ne("And the people around me are other flavors of icecream.",3);
            ne("I am exotic enough to stand out.",3);
            break; }
        }
        break;
    }
    case 1: {
        switch(opt) {
        case 1: { ne("I look towards the horizon. The sea around me.",1);
            ne("I feel connected to others.\n Sometimes I feel overwhelmed.",1);
            ne("I am the king of this little island.",1);
            break; }
        case 2: {
            ne("The noises of the outside remind you of the world's existence.",2);
            ne("My secret space of freedom.",2);
            break; }
        case 3: {
            ne("My friends are strawberry, and lemon, and stracciatella.",3);
            ne("Not everyone wants to try me.",3);
            ne("But I am not cold in the inside.",3);
            break; }
        }
        break;
    }
    case 2: {
        ne("Some days I feel I should get out.\nSome days I want to stay here forever.", opt);
//        noskip = true;
        break;
    }
    case 3: {
        switch(opt) {
        case 1: {
            ne("Inside, I feel like I am an island too.",1);
            ne("I like to wander to the hidden corners of the island.",1);
            ne("I don't want to leave my people behind.",1);
            break; }
        case 2: {
            ne("You can't get outside of yourself,\nbut you can try to connect to others.",2);
            ne("I like to imagine how it would be if everyone\nclosed their eyes at the same time",2);
            break; }
        case 3: {
            ne("I have never been good at metaphores.",3);
            ne("Some people like pistaccio, though.",3);
            break; }
        }
        break;
    }
    case 4: {
        switch(opt) {
        case 1: {
            ne("I'm part of an archipelago.",1);
            ne("Every one of us is also an island.",1);
            ne("You always know there is another island around the corner.",1);
            break; }
        case 2: {
            ne("Some people are willing to listen.",2);
            ne("If we could all meet in this invisible space",2);
            break; }
        case 3: {
            ne("Someone will come to the icecream shop.\nAnd buy a part of me.",3);
            ne("There is a pleasant surprise waiting inside me.",3);
            ne("I am best served in summer.",3);
            break; }
        }
        break;
    }
    case 5: {
        switch(opt) {
        case 1: {
            ne("You just have to swim there if you want.",1);
            ne("The other islands around me are part of me in a sense.",1);

            break; }
        case 2: {
            ne("Close your eyes and open your heart.",2);
            ne("If we could dance togheter, in our minds.",2);
            break; }
        case 3: {
            ne("I hope I will make that customer happy.",3);
            ne("The best icecreams have two flavors.",3);
            ne("It's about time to try me.",3);
            break; }
        }
        break;
    }
    case 6: {
//        switch(opt) {
//        case 1: {
            ne("I am not alone.",1);
//             break; }
//        case 2: { break; }
//        case 3: { break; }
//        }
        break;
    }

    default: {
        noskip = true;
        break;
    }

    }

    if (!noskip)
        ne("SKIP",opt);
    currentStep++;
}
