package main

import (
	"fmt"
	"net/http"
	"runtime"
)

func main() {
	http.HandleFunc("/", HelloServer)
	http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World, from %s on %s!!!", runtime.GOOS, runtime.GOARCH)
}
