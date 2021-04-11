commands:
  date +%Y/%m | xargs mkdir -p

# Tutorial

### 2020-09-12

check proxies
	https://gist.github.com/sempr/de5559d0e3b99213dacf proxy check by golang

https://blog.golang.org/defer-panic-and-recover Defer, Panic, and Recover - The Go Blog

https://blog.golang.org/protobuf-apiv2 A new Go API for Protocol Buffers - The Go Blog

# Prepare

go-fiber

proxy

website downloader

blockchain-in-go

proxy_pool
  https://github.com/jhao104/proxy_pool

import "fmt"
import "net/http"

func main() {
	fmt.Println("run a file server")
	http.ListenAndServe(":9999", http.FileServer(http.Dir(".")))
}

package main

import (
    "log"
    "fmt"
    "database/sql"
    _ "github.com/go-sql-driver/mysql"
)

type Company struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

func main() {
    fmt.Println("Go MySQL Tutorial")
    
    // Open up our database connection.
    // I've set up a database on my local machine using phpmyadmin.
    // The database is called testDb
    db, err := sql.Open("mysql", "root:password@tcp(127.0.0.1:3306)/googledrive")
    
    // if there is an error opening the connection, handle it
    if err != nil {
        panic(err.Error())
    }
    
    // defer the close till after the main function has finished
    // executing 
    defer db.Close()
    
    // perform a db.Query insert 
    // insert, err := db.Query("INSERT INTO test VALUES ( 2, 'TEST' )")
    
    // if there is an error inserting, handle it
    // if err != nil {
    //     panic(err.Error())
    // }
    // be careful deferring Queries if you are using transactions
	// defer insert.Close()
	
	// Execute the query
	results, err := db.Query("SELECT id, name FROM companies")
	if err != nil {
		panic(err.Error()) // proper error handling instead of panic in your app
	}

	for results.Next() {
		var company Company
		// for each row, scan the result into our tag composite object
		err = results.Scan(&company.ID, &company.Name)
		if err != nil {
			panic(err.Error()) // proper error handling instead of panic in your app
		}
				// and then print out the tag's Name attribute
		log.Printf(company.Name)
	}
}

import (
	"bufio"
	"fmt"
	"os"
)

func main() {

	fileHandle, _ := os.Open("fileserver.go")
	defer fileHandle.Close()
	fileScanner := bufio.NewScanner(fileHandle)

	for fileScanner.Scan() {
		fmt.Println(fileScanner.Text())
	}
}%
