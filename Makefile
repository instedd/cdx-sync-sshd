TAG_NAME  := instedd/cdx-sync-sshd

docker:
	docker build --tag $(TAG_NAME) .
