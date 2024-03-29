# Add more folders to ship with the application, here
folder_01.source = qml/voiceover
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
# CONFIG += mobility
# MOBILITY +=

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
# CONFIG += qdeclarative-boostable

LIBS += -lSDL -lSDL_mixer

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    secondview.cpp \
    controller.cpp \
    soundclip.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    secondview.h \
    controller.h \
    soundclip.h

RESOURCES += \
    voiceover.qrc

OTHER_FILES += \
    qml/voiceover/main.qml \
    qml/voiceover/secondscreen.qml \
    qml/voiceover/AnimatedScene.qml
