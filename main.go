package main

import (
	"fmt"
	"net/http"
)

func main() {
	fmt.Println("Start server")
	fileserver := http.FileServer(http.Dir("docs"))
	http.Handle("/", fileserver)
	http.ListenAndServe(":8080", nil)
}
