package main

import (
	"fmt"
	"log"
	"net/http"
)

// Hàm đơn giản cần kiểm tra
func Add(a, b int) int {
	return a + b
}

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Hello, World!")
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":8080", nil))
}
