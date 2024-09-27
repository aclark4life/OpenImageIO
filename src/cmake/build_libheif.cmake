# Copyright Contributors to the OpenImageIO project.
# SPDX-License-Identifier: Apache-2.0
# https://github.com/AcademySoftwareFoundation/OpenImageIO

######################################################################
# libheif by hand!
######################################################################

set_cache (Imath_BUILD_VERSION 1.18.2 "libheif version for local builds")
set (Imath_GIT_REPOSITORY "https://github.com/strukturag/libheif"
set (Imath_GIT_TAG "v${libheif_BUILD_VERSION}")
set_cache (Imath_BUILD_SHARED_LIBS ${LOCAL_BUILD_SHARED_LIBS_DEFAULT}
           DOC "Should a local libheif build, if necessary, build shared libraries" ADVANCED)

string (MAKE_C_IDENTIFIER ${libheif_BUILD_VERSION} libheif_VERSION_IDENT)

build_dependency_with_cmake(libheif
    VERSION         ${libheif_BUILD_VERSION}
    GIT_REPOSITORY  ${libheif_GIT_REPOSITORY}
    GIT_TAG         ${libheif_GIT_TAG}
    CMAKE_ARGS
        -D BUILD_SHARED_LIBS=${libheif_BUILD_SHARED_LIBS}
        # Don't built unnecessary parts of libheif
        -D BUILD_TESTING=OFF
        # Give the library a custom name and symbol namespace so it can't
        # conflict with any others in the system or linked into the same app.
        # not needed -D IMATH_NAMESPACE_CUSTOM=1
        # not needed -D IMATH_INTERNAL_NAMESPACE=${PROJ_NAMESPACE_V}_libheif_${libheif_VERSION_IDENT}
        -D libheif_LIB_SUFFIX=_v${libheif_VERSION_IDENT}_${PROJ_NAMESPACE_V}
    )


# Signal to caller that we need to find again at the installed location
set (libheif_REFIND TRUE)
set (libheif_REFIND_ARGS CONFIG)
set (libheif_REFIND_VERSION ${libheif_BUILD_VERSION})

if (libheif_BUILD_SHARED_LIBS)
    install_local_dependency_libs (libheif libheif)
endif ()
