TAG_NAME  := instedd/cdx-sync-sshd
VERSION   := $(shell git describe 2>/dev/null || echo "`date -u \"+%Y%m%d.%H%M%S\"`-`git describe --always`")

docker:
	echo $(VERSION) > VERSION
	docker build --tag $(TAG_NAME):$(VERSION) .
	docker build --tag $(TAG_NAME) .

docker-push: docker
	docker push $(TAG_NAME):$(VERSION)
	docker push $(TAG_NAME)

testrun:
	docker run -it --rm \
		-p 2222:22 \
		--name cdx-sync-sshd \
		-v $(if $(SYNC_KEYS),$(SYNC_KEYS),`pwd`/keys):/etc/ssh/keys \
		-v $(if $(SYNC_SSH), $(SYNC_SSH), `pwd`/ssh):/home/cdx-sync/.ssh \
		-v $(if $(SYNC_HOME),$(SYNC_HOME),`pwd`/home):/home/cdx-sync/tmp/sync \
		$(TAG_NAME)
