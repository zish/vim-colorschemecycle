REPO_BASENAME=$(notdir ${CURDIR})

ZIP_FILE=${REPO_BASENAME}.zip

#--- These entries should all be relative to "../${REPO_BASENAME}" to support
# proper packaging of the .zip file.
#
ZIP_INCLUDES="../${REPO_BASENAME}/doc/colorschemecycle.txt" \
  "../${REPO_BASENAME}/LICENSE" \
  "../${REPO_BASENAME}/plugin/colorschemecycle.vim" \
  "../${REPO_BASENAME}/README.md"

zip:
  @echo "** Generating Zip File '${ZIP_FILE}'..."
  zip --recurse-paths ${ZIP_FILE} \
    ../${REPO_BASENAME}/ \
    --include ${ZIP_INCLUDES} @

zip_clean:
  rm -f ${ZIP_FILE}

tags:
  @echo "** Generating Vim Helptags..."
  vim -c " helptags ${CURDIR}/doc | q"

tags_clean:
  @echo "** Cleaning any generated Vim Helptags..."
  rm -f doc/tags

clean: tags_clean zip_clean

dist: zip

all: dist tags

.DEFAULT_GOAL = all
