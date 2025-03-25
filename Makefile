IMAGE_REPOSITORY=registry.cn-hangzhou.aliyuncs.com/bocloud
VERSION ?= latest

ARCH ?= linux/arm64,linux/amd64

# Build the docker image
build:
	docker build -t $(IMAGE_REPOSITORY)/virtvnc:$(VERSION) .
	rm -rf vendor
	docker push $(IMAGE_REPOSITORY)/virtvnc:$(VERSION)

# Push the docker image
release:
	docker buildx build -t $(IMAGE_REPOSITORY)/virtvnc:v0.2 --provenance=false --platform=$(ARCH) . --push

buildx:
	@docker run --privileged --rm $(IMAGE_REPOSITORY)/binfmt --uninstall qemu-* && \
	docker run --privileged --rm $(IMAGE_REPOSITORY)/binfmt --install all && \
	docker buildx rm mybuilder || true && \
	docker buildx create --use --name mybuilder && \
	docker buildx inspect mybuilder --bootstrap && \
	docker buildx ls