package main

import (
	"fmt"
	"generatiemetdromen/handlers" //niet path maar naam van package
	"net/http"
)

func main() {
	fmt.Println("start")
	handlers.Test() // functies uit ander packages aanroepen

	http.HandleFunc("/", handlers.Startpage)
	///////////////  ////////////////////
	fileServer := http.FileServer(http.Dir("static"))
	http.Handle("/static/", http.StripPrefix("/static/", fileServer))

	http.ListenAndServe(":8080", nil)
}
