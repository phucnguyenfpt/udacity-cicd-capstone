## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt
	echo
	chmod +x ./scripts/install_shellcheck.sh
	echo "Installing: shellcheck"
	./scripts/install_shellcheck.sh
	echo
	chmod +x ./scripts/install_hadolint.sh
	echo "Installing: hadolint"
	./scripts/install_hadolint.sh
	echo
	chmod +x ./scripts/install_kubectl.sh
	echo "Installing: kubectl"
	./scripts/install_kubectl.sh
	echo
	chmod +x ./scripts/install_eksctl.sh
	echo "Installing: eksctl"
	./scripts/install_eksctl.sh

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	pwd
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 app.py

build-docker:
	./scripts/build-docker.sh

upload-docker:
	./scripts/upload-docker.sh

eks-create-cluster:
	./scripts/create_cluster.sh

all: install lint test
