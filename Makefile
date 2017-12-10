.PHONY: test clean

test: docker
	docker run -e CI=${CI} -t --rm -v $(shell pwd)/tests:/tests git-pair-test

docker: Dockerfile
	docker build -t git-pair-test .
	touch docker

clean:
	docker rmi git-pair-test
	rm docker
