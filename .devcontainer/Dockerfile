FROM alpine:3

ARG USERNAME
ARG USER_UID=1001
ARG USER_GID=$USER_UID

RUN apk add --no-cache shadow sudo git build-base \
    && groupadd -g $USER_GID $USERNAME \
    && useradd -u $USER_UID -g $USER_GID -m $USERNAME \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/$USERNAME
