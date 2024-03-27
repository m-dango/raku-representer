FROM rakudo-star:2023.08-alpine

WORKDIR /opt/representer

COPY . .

ENTRYPOINT ["sh", "/opt/representer/bin/run.sh"]
