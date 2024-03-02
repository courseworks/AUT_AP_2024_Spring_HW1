# Start with the GCC base image at version 13.2.0
# This image is selected for its inclusion of the GNU Compiler Collection, 
# enabling compilation of C and C++ applications directly within the container.
FROM gcc:13.2.0

# Perform system updates and install essential tools in a single RUN statement to minimize the image layer size.
# The tools installed serve various purposes:
# - openssh-server: For setting up an SSH server to allow remote access to the container.
# - sudo: To allow escalated privileges, useful for installations and configurations requiring root access.
# - cmake: A build system generator, vital for configuring and generating standard build files.
# - rsync: A utility for efficiently transferring and synchronizing files across systems, useful for development workflows.
# - valgrind: A tool for memory debugging, memory leak detection, and profiling, essential for C++ development.
# - git: Distributed version control system, necessary for cloning and managing source code repositories.
# Following installation, the apt cache is cleaned to reduce the size of the final image.
RUN apt-get -qq update && apt-get -qq install --no-install-recommends \
    openssh-server sudo cmake rsync valgrind git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the root password to enable root login via SSH.
# This is a critical step for enabling SSH access, especially for initial setup and configuration tasks.
RUN echo 'root:123456' | chpasswd

# Configure the SSH daemon for improved usability within the container.
# - Create the runtime directory for the SSH daemon, required for its operation.
# - Adjust SSH daemon configurations to disable strict mode, allowing for more flexible permissions on mounted volumes.
# - Enable root login via SSH, facilitating initial access and setup by the container administrator.
RUN mkdir /var/run/sshd && \
    echo 'StrictModes no' >> /etc/ssh/sshd_config

# This RUN instruction uses the `sed` command to modify the SSH server configuration file `/etc/ssh/sshd_config`.
# It searches for the line that contains 'PermitRootLogin' (which may be commented out by default, as indicated by the leading '#'),
# and replaces it with 'PermitRootLogin yes', effectively enabling root login over SSH.
# The `-Ei` flags are used with `sed` for extended regular expressions and in-place editing of the file, respectively.
RUN sed -Ei 's/#(PermitRootLogin).+/\1 yes/' /etc/ssh/sshd_config
RUN service ssh start

# Expose port 22 to enable SSH access from outside the container.
# This instruction informs Docker that the container listens on port 22 at runtime, 
# which is the standard port for SSH connections.
EXPOSE 22

# Clone the Google Test repository and install it.
# Google Test is used for unit testing C++ applications, an essential part of modern development practices.
# The WORKDIR instruction sets the context for subsequent commands and organizes the build process.
WORKDIR /usr/src/libraries
RUN git clone --depth=1 -b main https://github.com/google/googletest.git
WORKDIR /usr/src/libraries/googletest/build
RUN cmake .. && make && make install

# Setup the application's build environment.
# - Change the working directory to where the application's source code will reside.
# - Copy the current directory's contents into the container, facilitating the transfer of source code.
# - Create a new directory for building the application, ensuring a clean build environment.
# - Compile the application using cmake and make, demonstrating a typical C++ build workflow.
WORKDIR /usr/src/app
COPY . .
RUN sudo rm -rf build && mkdir build && cd build && cmake .. && make

# Define the container's default behavior at runtime to start the SSH daemon.
# Starting the SSH daemon in foreground mode (-D) keeps the container running and accessible via SSH.
# This setup is crucial for enabling remote development workflows, especially when integrating with tools like VSCode.
CMD ["/usr/sbin/sshd", "-D"]

# Optional: Set the default command to execute the compiled main program.
# This CMD is commented out as it conflicts with the SSH daemon command above.
# Uncommenting this line and commenting out the previous CMD would switch the container's default behavior
# to run the compiled application instead of starting the SSH daemon.
# CMD ["./main"]
