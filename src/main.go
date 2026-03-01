// Command md-heading-cli reads a Markdown file and prints its headings as an
// indented list to standard output.
package main

import (
	"fmt"
	"os"
	"strings"

	"md-heading-cli/parser"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Fprintln(os.Stderr, "Usage: md-heading-cli <markdown-file>")
		os.Exit(1)
	}

	filePath := os.Args[1]

	f, err := os.Open(filePath)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v\n", err)
		os.Exit(1)
	}
	defer f.Close()

	headings, err := parser.Parse(f)
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error parsing file: %v\n", err)
		os.Exit(1)
	}

	for _, h := range headings {
		indent := strings.Repeat("  ", h.Level-1)
		fmt.Printf("%s%s\n", indent, h.Text)
	}
}
