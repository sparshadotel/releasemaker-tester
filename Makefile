SHELL :=/bin/bash
TRAVIS_BRANCH := master

last_tag := $(shell git tag --sort=-creatordate | head -n 1)
new_tag := $(shell semver bump patch "${last_tag}")
timestamp := $(date -u +%Y%m%d%H%M%S)
# The new version is tagged as pre-release for master. Once we are good to go for production, remove the -prerelease suffix
new_version := $(shell if [ "${TRAVIS_BRANCH}" = "master" ]; then echo "${new_tag}-prerelease"; else echo "${new_tag}-${TRAVIS_BRANCH}.${timestamp}"; fi)

tag:
	@echo "Bump version :- $(last_tag) -> $(new_version)"
	@sed -i "s/version.*=.*/version = '$(new_version)'/" __init__.py  && \
		git add __init__.py && \
		git commit -m "Update $(last_tag) to $(new_version)" -m "[skip ci]" && \
		git tag $(new_version) && \
		git push origin ${TRAVIS_BRANCH} --tags 

