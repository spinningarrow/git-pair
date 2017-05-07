test: docker
	docker run --rm -v $(shell pwd)/tests:/tests git-pair-test

docker:
	docker build -t git-pair-test .

clean:
	docker rmi git-pair-test