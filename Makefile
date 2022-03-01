# To get these values, view ECR repo in the AWS MC & click "view push commands"
ECR := 575296055612.dkr.ecr.us-east-1.amazonaws.com
REPO := public.ecr.aws/b7r0k8v0
IMAGE := mkdocs-material
TAG := latest

PIP := pip
PUBLISH_SRC := site/
PUBLISH_TARGET := www.zuar.com:static/w3/api/mitto/__stage__

pyenv:
	[ ! -f requirements.txt ] || $(PIP) install -r requirements.txt
.PHONY: pyenv

css:
	[ -d docs/css ] || mkdir docs/css
	pygmentize -S default -f html -a .codehilite > docs/css/pygments.css
.PHONY: css	

pull:
	docker pull $(REPO)/$(IMAGE):$(TAG)
.PHONY: pull

docs:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs $(REPO)/$(IMAGE):$(TAG)
.PHONY: docs

serve:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs $(REPO)/$(IMAGE):$(TAG) serve
.PHONY: serve

gh-deploy:
	docker run --rm -it -p 8000:8000 -v ${PWD}:/docs $(REPO)/$(IMAGE):$(TAG) gh-deploy || true
	echo "================================================================================"
	echo "Now run the command 'git push origin gh-pages' to publish your documentation"
	echo "================================================================================"
.PHONY: gh-deploy

clean:
	@rm -rf site
	@mkdir site
	@touch site/.nojekyll
.PHONY: clean

## You must have the proper AWS credentials to publish content to AWS
publish:
	rsync -arv $(PUBLISH_SRC) $(PUBLISH_TARGET)
.PHONY: publish

docker-pull:
	docker pull $(REPO)/$(IMAGE):$(TAG)
.PHONY: docker-pull
