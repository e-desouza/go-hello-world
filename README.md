Go hello world that uses the `go:alpine` multi-arch base image and can be built and run on any architecture.

- `docker build . -f Dockerfile -t go-hello-world`
- `docker run -p 8080:8080 go-hello-world`

We optimize from ~600MB to ~11MB image size by:

- Using multi-stage builds
- Stripping out debug info

Further size optimizations can still be done using [upx](https://github.com/reproio/docker-upx) etc to bring it down to a ~2MB image.
