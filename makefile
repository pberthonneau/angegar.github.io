SHELL:=/bin/bash

# install:
# 	pip install mkdocs \
# 		git+https://github.dxc.com/platform-dxc/docs-mkdocs-theme \
# 		git+https://github.com/ojacques/mkdocs-git-committers-plugin \
# 		git+https://github.com/mementum/lightgallery-markdown.git \
# 		pymdown-extensions \
# 		pygments \
# 		markdown-include \
# 		mkdocs-pdf-export-plugin \
# 		mkdocs-awesome-pages-plugin

install:
	python3 -m venv venv && \
	source venv/bin/activate && \
	pip3 install -r actions/build/requirements.txt

serve:
	source venv/bin/activate && mkdocs serve 

create:
	source venv/bin/activate && mkdocs new tutorials

install-marp-slides:
	wget https://github.com/marp-team/marp-cli/releases/download/v0.21.1/marp-cli-v0.21.1-linux.tar.gz -O marp.tar.gz
	tar xvf marp.tar.gz -C /usr/local/bin

publish-slides:
	marp slidedecks/kubernetes-overview/README.md -o  docs/Kubernetes/kubernetes-overview/README.html
	cp -r slidedecks/kubernetes-overview/img docs/Kubernetes/kubernetes-overview/
	