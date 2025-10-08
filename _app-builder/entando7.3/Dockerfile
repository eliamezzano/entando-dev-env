FROM node:14.17.6 AS builder

WORKDIR /app

RUN git clone -b release/7.3 https://github.com/entando/app-builder/ . 

COPY .env.local /app/.env.local

RUN npm install
RUN npm run build


FROM registry.access.redhat.com/ubi8/nginx-122:1-18
ARG VERSION

### Required OpenShift Labels
LABEL name="Entando App Builder" \
      maintainer="dev@entando.com" \
      vendor="Entando Inc." \
      version="v${VERSION}" \
      release="7.3.0" \
      summary="Entando App Builder" \
      description="The Entando App Builder is the front end environment to interact with the micro frontends, the WCMS, and other Entando components"

COPY --from=builder /app/licenses /licenses

COPY --from=builder /app/build /opt/app-root/src/app-builder
COPY --from=builder /app/nginx.conf ${NGINX_CONF_PATH}
COPY --from=builder /app/docker-entrypoint.sh /usr/local/bin

EXPOSE 8081
USER root

RUN fix-permissions /opt/app-root/src/app-builder

USER default

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]