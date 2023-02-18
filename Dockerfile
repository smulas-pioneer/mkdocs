FROM python
# COPY ./Nethereum.Docs/ /Nethereum.Docs/
# WORKDIR /Nethereum.Docs/
RUN pip install mkdocs
RUN pip install mkdocs-bootstrap386
RUN pip install mkdocs-simple-blog
RUN pip install mkdocs-gitbook
RUN pip install mkdocs-terminal
RUN pip install mkdocs-material

RUN mkdir /src

EXPOSE 8080
CMD ["mkdocs", "serve"]