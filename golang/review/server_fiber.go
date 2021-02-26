//
// server_fiber.go
// Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
//
// Distributed under terms of the MIT license.
//

// import "github.com/gofiber/fiber/v2"

// Install: go get -u github.com/gofiber/fiber/v2

package main

import (
	"github.com/gofiber/fiber/v2"

	"fmt"
	"log"
)

func main() {
	app := fiber.New()

	app.Get("/:name", func(c *fiber.Ctx) error {
		msg := fmt.Sprintf("Hello, %s 👋!", c.Params("name"))
		return c.SendString(msg)
	})
	log.Fatal(app.Listen(":9900"))
}
