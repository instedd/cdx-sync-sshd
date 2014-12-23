TAG_NAME=cdx-sync-sshd

image:
	docker build --rm -t $(TAG_NAME) .

testrun:
	docker run -it --rm \
		-p 2222:22 \
		-v $(if $(SYNC_KEYS),$(SYNC_KEYS),`pwd`/keys):/etc/ssh/keys \
		-v $(if $(SYNC_HOME),$(SYNC_HOME),`pwd`/home):/home/cdx-sync \
		$(TAG_NAME)
