cmake_minimum_required(VERSION 3.16)

project(hole_monitor VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Network)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(apphole_monitor
    main.cpp
    pihole_api.cpp
    pihole_api.h
)

qt_add_qml_module(apphole_monitor
    URI hole_monitor
    QML_FILES
        Main.qml
        MainMenu.qml
        Statistics.qml
        Logs.qml
        QML_FILES Lists.qml
        QML_FILES Settings.qml
        QML_FILES Login.qml
        SOURCES
        SOURCES
        SOURCES
        SOURCES
        SOURCES pihole_api.h pihole_api.cpp
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(apphole_monitor PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.apphole_monitor
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(apphole_monitor
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Network
)

install(TARGETS apphole_monitor
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
