FROM --platform=${BUILDPLATFORM} docker:rc-dind-rootless as build
ARG TARGETARCH
WORKDIR /home/rootless
RUN wget -O docker-credential-ecr-login https://amazon-ecr-credential-helper-releases.s3.us-east-2.amazonaws.com/0.7.1/linux-${TARGETARCH}/docker-credential-ecr-login

FROM --platform=${TARGETPLATFORM} docker:rc-dind-rootless
COPY --from=build /home/rootless/docker-credential-ecr-login /home/rootless/.local/bin/docker-credential-ecr-login
RUN chmod +x /home/rootless/.local/bin/docker-credential-ecr-login
ENV PATH="/home/rootless/.local/bin:${PATH}"
USER rootless
