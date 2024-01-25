# STEP 1/2 of multi-stage build: setup the dependencies
FROM golang:alpine AS builder
RUN apk update
# Create appuser. Containers with root will not run on OpenShift
ENV USER=nonrootuser
ENV UID=10001 
# See https://stackoverflow.com/a/55757473/12429735RUN 
RUN adduser \    
    --disabled-password \    
    --gecos "" \    
    --home "/nonexistent" \    
    --shell "/sbin/nologin" \    
    --no-create-home \    
    --uid "${UID}" \    
    "${USER}"
ADD . /src
RUN cd /src && GOOS=linux go build -ldflags="-s -w" -o hello-world

# STEP 2/2 of multi-stage build: build the image. This will be much smaller than just using FROM golang:alpine directly
FROM alpine
# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/group /etc/group
WORKDIR /app
COPY --from=builder /src/hello-world /app/
# Use an unprivileged user.
USER nonrootuser:nonrootuser
EXPOSE 8080
ENTRYPOINT ./hello-world
