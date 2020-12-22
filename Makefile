VERSION ?= $(shell cat VERSION)
NEXT_RELEASE ?= $(shell docker run --rm alpine/semver semver -c -i patch $(VERSION))

IMG_REPO ?= rafaelcalleja
IMG_TAG ?= $(VERSION)
IMG_NAME ?= jetty-proxy-keycloak

default: image

image: patch-version
	docker build -t $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG) -f Dockerfile \
	.
push:
	docker push $(IMG_REPO)/$(IMG_NAME):$(IMG_TAG)

patch-version:
	@echo $(NEXT_RELEASE) > VERSION

test:
	./docker-hub/test.sh
