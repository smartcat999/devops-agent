COMMIT := $(shell git rev-parse --short HEAD)
VERSION := dev-$(shell git describe --tags $(shell git rev-list --tags --max-count=1))
REPO ?= 2030047311
HTTPS_PROXY ?= ''

build-base-podman:
	docker build base -f base/podman/Dockerfile -t kubespheredev/builder-base:$(VERSION)-podman
push-base-podman:
	docker push kubespheredev/builder-base:$(VERSION)-podman

build-maven-podman:
	docker build maven -f maven/podman/Dockerfile -t kubespheredev/builder-maven:$(VERSION)-podman
push-maven-podman:
	docker push kubespheredev/builder-maven:$(VERSION)-podman

build-maven-jdk11:
	docker build maven -f maven/Dockerfile -t kubespheredev/builder-maven:$(VERSION)-jdk11 \
--build-arg JDK_VERSION=11
push-maven-jdk11:
	docker push kubespheredev/builder-maven:$(VERSION)-jdk11

build-maven-jdk17:
	docker build maven -f maven/Dockerfile -t kubespheredev/builder-maven:$(VERSION)-jdk17 \
--build-arg JDK_VERSION=17 --build-arg JDK_HOME=/usr/java/default
push-maven-jdk17:
	docker push kubespheredev/builder-maven:$(VERSION)-jdk17

build-maven-jdk17-podman:
	docker build maven -f maven/podman/Dockerfile -t kubespheredev/builder-maven:$(VERSION)-jdk17-podman \
--build-arg JDK_VERSION=17 --build-arg JDK_HOME=/usr/java/default
push-maven-jdk17-podman:
	docker push kubespheredev/builder-maven:$(VERSION)-jdk17-podman

# buildx
build-base-buildx:
	docker build base -f base/buildx/Dockerfile --build-arg HTTPS_PROXY=${HTTPS_PROXY} -t ${REPO}/builder-base:$(VERSION)-buildx
push-base-buildx:
	docker push ${REPO}/builder-base:$(VERSION)-buildx
pushx-base-buildx:
	skopeo copy docker-daemon:${REPO}/builder-base:$(VERSION)-buildx docker://${REPO}/builder-base:$(VERSION)-buildx

build-go-buildx:
	docker build go -f go/buildx/Dockerfile --build-arg HTTPS_PROXY=${HTTPS_PROXY} -t ${REPO}/builder-go:$(VERSION)-buildx
push-go-buildx:
	docker push ${REPO}/builder-go:$(VERSION)-buildx
pushx-go-buildx:
	skopeo copy docker-daemon:${REPO}/builder-go:$(VERSION)-buildx docker://${REPO}/builder-go:$(VERSION)-buildx

build-nodejs-buildx:
	docker build nodejs -f nodejs/buildx/Dockerfile --build-arg HTTPS_PROXY=${HTTPS_PROXY} -t ${REPO}/builder-nodejs:$(VERSION)-buildx
push-nodejs-buildx:
	docker push ${REPO}/builder-nodejs:$(VERSION)-buildx
pushx-nodejs-buildx:
	skopeo copy docker-daemon:${REPO}/builder-nodejs:$(VERSION)-buildx docker://${REPO}/builder-nodejs:$(VERSION)-buildx

build-python-buildx:
	docker build python -f python/buildx/Dockerfile --build-arg HTTPS_PROXY=${HTTPS_PROXY} -t ${REPO}/builder-python:$(VERSION)-buildx
push-python-buildx:
	docker push ${REPO}/builder-python:$(VERSION)-buildx
pushx-python-buildx:
	skopeo copy docker-daemon:${REPO}/builder-python:$(VERSION)-buildx docker://${REPO}/builder-python:$(VERSION)-buildx

build-all-buildx:
	docker buildx bake -f docker-bake.hcl --push
