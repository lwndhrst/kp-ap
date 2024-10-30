cmake_minimum_required(VERSION 3.24)

project(kp_ap)

set(CMAKE_CXX_STANDARD 17)

include(FetchContent)
set(FETCHCONTENT_QUIET FALSE)

FetchContent_Declare(
    ci
    GIT_REPOSITORY "https://github.com/cinder/Cinder.git"
    GIT_TAG "master"
    GIT_PROGRESS TRUE
)
FetchContent_MakeAvailable(ci)

file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/src/*")
set(PROJECT_INCLUDE "${CMAKE_CURRENT_LIST_DIR}/src/")
get_filename_component(CINDER_PATH "${ci_SOURCE_DIR}/" ABSOLUTE)

include("${CINDER_PATH}/proj/cmake/modules/cinderMakeApp.cmake")
ci_make_app(
    APP_NAME    ${PROJECT_NAME}
    SOURCES     ${PROJECT_SOURCES}
    INCLUDES    ${PROJECT_HEADERS}
    CINDER_PATH ${CINDER_PATH}
)

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT ${PROJECT_NAME})
