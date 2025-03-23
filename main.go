package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"time"
)

func main() {
	fmt.Println("Start server")
	fileserver := http.FileServer(http.Dir("docs"))
	http.HandleFunc("/syspromtsfeedback", systemprompts_feedback)
	http.Handle("/", fileserver)
	http.ListenAndServe(":8080", nil)
}

func systemprompts_feedback(w http.ResponseWriter, r *http.Request) {
	fmt.Println(r.Body)
	// fmt.Println(r.GetBody())
	responseData, err := io.ReadAll(r.Body)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println(string(responseData))
	f, err := os.OpenFile("docs/blog/systemprompts_log.txt",
		os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Println(err)
		return
	}
	defer f.Close()
	f.WriteString(time.Now().Format(time.RFC822) + ": " + string(responseData) + " \n" + "-----------------" + "\n")
}
