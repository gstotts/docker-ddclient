FROM alpine:latest

# Install required packages
RUN apk --no-cache add ca-certificates ddclient openrc supervisor

# Define the build arguments
ARG USER=username
ARG PASSWORD=password

# Copy and modify the configuration file
COPY ddclient.conf /etc/ddclient/ddclient.conf
RUN sed -i -e "s|dnsomatic_username|${USER}|g" /etc/ddclient/ddclient.conf && \
    sed -i -e "s|dnsomatic_password|${PASSWORD}|g" /etc/ddclient/ddclient.conf

# Ensure the OpenRC directories are set up
RUN mkdir -p /run/openrc && touch /run/openrc/softlevel

# Copy the wrapper script and make it executable
COPY run-ddclient.sh /usr/local/bin/run-ddclient.sh
RUN chmod +x /usr/local/bin/run-ddclient.sh

# Update supervisord.conf to use the wrapper script
COPY supervisord.conf /etc/supervisor.d/supervisord.conf

# Command to run supervisord
CMD ["supervisord", "-c", "/etc/supervisor.d/supervisord.conf"]
