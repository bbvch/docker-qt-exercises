cmake_minimum_required(VERSION 3.16)
project(MyQtApp VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt5 COMPONENTS Core Quick Gui REQUIRED)

qt5_add_resources(RESOURCES resources.qrc)

add_executable(MyQtApp
    main.cpp
    ${RESOURCES}
)

target_link_libraries(MyQtApp PRIVATE 
	Qt5::Core
       	Qt5::Quick
       	Qt5::Gui
       	)

