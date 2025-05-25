package main

import (
	"fmt"
	"log"
	"net/http"
)

var host = "0.0.0.0"
var port = "8081"

func main() {
	defer func() {
		if err := recover(); err != nil {
			log.Printf("Handler panic: %v", err)
		}
	}()

	handlers := http.NewServeMux()
	handlers.HandleFunc("GET /ping", pingHandler)
	handlers.HandleFunc("GET /panic", panicHandler)

	server := &http.Server{
		Addr:    fmt.Sprintf("%s:%s", host, port),
		Handler: handlers,
	}

	fmt.Printf("Starting server on %s\n", server.Addr)
	server.ListenAndServe()
}

func pingHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("pong"))
}

func panicHandler(w http.ResponseWriter, r *http.Request) {
	panic("This is a test panic")
	w.WriteHeader(http.StatusOK)
}
