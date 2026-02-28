// Package parser provides functionality to parse Markdown files and extract headings.
package parser

import (
	"bufio"
	"io"
	"strings"
)

// Heading represents a single Markdown ATX heading with its level and text.
type Heading struct {
	Level int
	Text  string
}

// Parse reads Markdown content from the given reader and returns a slice of
// Heading values found in the content. It recognizes ATX-style headings
// (lines beginning with one or more '#' characters) and ignores any '#' lines
// that appear inside fenced code blocks (delimited by ``` or more backticks).
func Parse(r io.Reader) ([]Heading, error) {
	var headings []Heading
	scanner := bufio.NewScanner(r)
	inCodeBlock := false
	codeBlockFenceLen := 0

	for scanner.Scan() {
		line := scanner.Text()
		trimmed := strings.TrimSpace(line)

		// Check for fenced code block delimiters (three or more backticks).
		// A closing fence must have at least as many backticks as the opening fence.
		if strings.HasPrefix(trimmed, "```") {
			backtickCount := 0
			for _, ch := range trimmed {
				if ch == '`' {
					backtickCount++
				} else {
					break
				}
			}
			if !inCodeBlock {
				inCodeBlock = true
				codeBlockFenceLen = backtickCount
			} else if backtickCount >= codeBlockFenceLen {
				inCodeBlock = false
				codeBlockFenceLen = 0
			}
			continue
		}

		// Skip lines inside code blocks.
		if inCodeBlock {
			continue
		}

		// Check for ATX heading: line starts with one or more '#' followed by
		// a space or end of line.
		if !strings.HasPrefix(trimmed, "#") {
			continue
		}

		level := 0
		for _, ch := range trimmed {
			if ch == '#' {
				level++
			} else {
				break
			}
		}

		// Valid ATX headings have levels 1-6.
		if level < 1 || level > 6 {
			continue
		}

		rest := trimmed[level:]

		// A heading must be followed by a space or be empty (e.g., just "##").
		if len(rest) > 0 && rest[0] != ' ' {
			continue
		}

		text := strings.TrimSpace(rest)

		headings = append(headings, Heading{
			Level: level,
			Text:  text,
		})
	}

	if err := scanner.Err(); err != nil {
		return nil, err
	}

	return headings, nil
}
