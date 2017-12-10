.PHONY: test shell clean

test: docker
	docker run -e CI=${CI} -t --rm -v $(shell pwd)/tests:/tests git-pair-test

shell: docker
	docker run -it --rm -v $(shell pwd)/tests:/tests --entrypoint bash git-pair-test

docker: Dockerfile git-pair
	docker build -t git-pair-test .
	touch docker

clean:
	docker rmi git-pair-test
	rm docker
