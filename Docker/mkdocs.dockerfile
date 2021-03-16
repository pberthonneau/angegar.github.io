FROM squidfunk/mkdocs-material


COPY requirements.txt /requirements.txt
RUN python3 -m pip install -r /requirements.txt 