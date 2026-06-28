FROM rocker/r-ver:4.6.1
LABEL org.opencontainers.image.title="r-stakeholder"
LABEL org.opencontainers.image.description="Deterministic Rscript CLI for stakeholder-circus Tranche C"
WORKDIR /app
COPY . /app
RUN Rscript bin/stakeholder.R --list-values >/tmp/list-values.json \
    && Rscript tests/test_cli.R
ENTRYPOINT ["Rscript", "bin/stakeholder.R"]
CMD ["--list-values"]
