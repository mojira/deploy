FROM ubuntu:latest

# Label
LABEL "repository"="http://github.com/mojira/deploy"
LABEL "homepage"="https://github.com/mojira/deploy"

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
