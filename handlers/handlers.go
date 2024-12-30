package handlers

import (
	"fmt"
	"net/http"
	"text/template"
)

func Test() {
	fmt.Println("test")
}

func Startpage(w http.ResponseWriter, r *http.Request) {
	t, err := template.ParseFiles("pages/index.html")
	if err != nil {
		fmt.Println("Error parsing template:", err)
		http.Error(w, "Internal Server Error", http.StatusInternalServerError)
		return
	}
	t.Execute(w, nil)
}
