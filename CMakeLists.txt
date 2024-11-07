cmake_minimum_required(VERSION 3.24)

project(kp_ap)

set(CMAKE_CXX_STANDARD 17)

include(FetchContent)
set(FETCHCONTENT_QUIET FALSE)

find_package(cinder)
if(cinder_FOUND)
    get_filename_component(CINDER_PATH "${cinder_DIR}/" ABSOLUTE)
else()
    FetchContent_Declare(
        cinder
        GIT_REPOSITORY "https://github.com/cinder/Cinder.git"
        GIT_TAG "master"
        GIT_PROGRESS TRUE
    )
    FetchContent_MakeAvailable(cinder)
    get_filename_component(CINDER_PATH "${cinder_SOURCE_DIR}/" ABSOLUTE)
endif()

file(GLOB_RECURSE PROJECT_SOURCES CONFIGURE_DEPENDS "${CMAKE_CURRENT_LIST_DIR}/src/*")
set(PROJECT_INCLUDE "${CMAKE_CURRENT_LIST_DIR}/src/")

include("${CINDER_PATH}/proj/cmake/modules/cinderMakeApp.cmake")
ci_make_app(
    APP_NAME    ${PROJECT_NAME}
    SOURCES     ${PROJECT_SOURCES}
    INCLUDES    ${PROJECT_INCLUDE}
    CINDER_PATH ${CINDER_PATH}
)
