package main

import (
	"fmt"
	"generatiemetdromen/handlers"
	"net/http"
)

func main() {
	fmt.Println("start")
	handlers.Test()

	http.HandleFunc("/", handlers.Startpage)
	///////////////  ////////////////////
	fileServer := http.FileServer(http.Dir("static"))
	http.Handle("/static/", http.StripPrefix("/static/", fileServer))

	http.ListenAndServe(":8080", nil)
}
