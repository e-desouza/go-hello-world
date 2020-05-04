Go hello world that uses the `go:alpine` multi-arch base image and can be built and run on any architecture.

- `docker build . -f Dockerfile -t go-hello-world`
- `docker run -p 8080:8080 go-hello-world`

We optimize from ~600MB to ~5MB image size by:

- Using multi-stage builds (600MB->16MB) 97% reduction
- Stripping out debug info (16MB-12MB) 25% reduction
- UPX (12MB->7MB) 41% reduction
- Storing on Dockerhub (7MB->5MB) 28% reduction

Total image size is 120x smaller than original !
