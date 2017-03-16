#!/usr/bin/env bash
BUILDOPTS=${1}

# docker run
docker run -ti -v ${PWD}:/build --entrypoint "/build/buildpkgs" sellorm/build ${BUILDOPTS}
