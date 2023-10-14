# Start with a base Debian image
FROM ubuntu:22.04 AS base

# Add arguments that can be used when creating the docker container
ARG USER_ID=1000
ARG GROUP_ID=1000

# Install necessary tools and libraries including Qt5 and CMake
RUN apt-get update; \
    apt-get upgrade -y;  \
    apt-get install -y \
    build-essential \
    cmake \
    vim \
    && rm -rf /var/lib/apt/lists/*

RUN \
apt-get update; \
apt-get -y install --fix-missing \
qtbase5-dev \
qtdeclarative5-dev \
libqt5serialport5-dev \
qml-module-qtquick-layouts \
qml-module-qtquick-controls \
qtquickcontrols2-5-dev \
qml-module-qtgraphicaleffects \
qml-module-qttest 

# Adding the user an creating a directory for him
RUN addgroup --gid $GROUP_ID dockergroup \
    && adduser \
       --home /home/dockeruser \
       --uid $USER_ID \
       --ingroup dockergroup \
       dockeruser

RUN mkdir /app && chown dockeruser:dockergroup /app

#Switch container user 
USER dockeruser

# Copy the source code and CMakeLists.txt into the Docker 
# container with user rights adapted
COPY --chown=dockeruser:dockergroup . /app

#Switch working directory
WORKDIR /app

# Navigate into the build directory, run CMake, and compile the application
RUN cmake -B ./build -S ./src && cmake --build build


# Start the second stage
#############################################################################
FROM ubuntu:22.04 AS runtime

# Copy necessary libraries and binaries from the build stage
COPY --from=base /usr/lib /usr/lib
COPY --from=base /usr/share /usr/share

# In the runtime stage:
COPY --from=base /etc/fonts/ /etc/fonts/
COPY --from=base /var/cache/fontconfig/ /var/cache/fontconfig/

# Copy over the user and group information
COPY --from=base /etc/passwd /etc/passwd
COPY --from=base /etc/group /etc/group
COPY --from=base /etc/shadow /etc/shadow

# Copy the compiled application from the build stage
COPY --from=base --chown=dockeruser:dockergroup /app/build/MyQtApp /app/MyQtApp

# Set the user and working directory
USER dockeruser
WORKDIR /app

# Set the entrypoint for the application
ENTRYPOINT ["/app/MyQtApp"]
