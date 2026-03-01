package parser

import (
	"strings"
	"testing"
)

func TestParseMultipleLevels(t *testing.T) {
	input := `# Heading 1
## Heading 2
### Heading 3
#### Heading 4
##### Heading 5
###### Heading 6
`
	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	expected := []Heading{
		{Level: 1, Text: "Heading 1"},
		{Level: 2, Text: "Heading 2"},
		{Level: 3, Text: "Heading 3"},
		{Level: 4, Text: "Heading 4"},
		{Level: 5, Text: "Heading 5"},
		{Level: 6, Text: "Heading 6"},
	}

	if len(headings) != len(expected) {
		t.Fatalf("expected %d headings, got %d", len(expected), len(headings))
	}

	for i, h := range headings {
		if h.Level != expected[i].Level {
			t.Errorf("heading[%d]: expected level %d, got %d", i, expected[i].Level, h.Level)
		}
		if h.Text != expected[i].Text {
			t.Errorf("heading[%d]: expected text %q, got %q", i, expected[i].Text, h.Text)
		}
	}
}

func TestParseIgnoresNonHeadingLines(t *testing.T) {
	input := `# Title

This is a paragraph with some text.

- List item 1
- List item 2

## Section

More text here.
`
	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(headings) != 2 {
		t.Fatalf("expected 2 headings, got %d", len(headings))
	}

	if headings[0].Text != "Title" || headings[0].Level != 1 {
		t.Errorf("heading[0]: expected (1, Title), got (%d, %s)", headings[0].Level, headings[0].Text)
	}
	if headings[1].Text != "Section" || headings[1].Level != 2 {
		t.Errorf("heading[1]: expected (2, Section), got (%d, %s)", headings[1].Level, headings[1].Text)
	}
}

func TestParseCodeBlockExclusion(t *testing.T) {
	input := "# Real Heading\n\n```\n# Not a heading\n## Also not a heading\n```\n\n## Another Real Heading\n"

	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(headings) != 2 {
		t.Fatalf("expected 2 headings, got %d", len(headings))
	}

	if headings[0].Text != "Real Heading" {
		t.Errorf("heading[0]: expected 'Real Heading', got %q", headings[0].Text)
	}
	if headings[1].Text != "Another Real Heading" {
		t.Errorf("heading[1]: expected 'Another Real Heading', got %q", headings[1].Text)
	}
}

func TestParseNoHeadings(t *testing.T) {
	input := `Just some text.

No headings here at all.

- A list item
- Another list item
`
	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(headings) != 0 {
		t.Fatalf("expected 0 headings, got %d", len(headings))
	}
}

func TestParseInvalidHeadingFormat(t *testing.T) {
	input := `#NoSpace
##AlsoNoSpace
#######SevenHashes
# Valid Heading
`
	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(headings) != 1 {
		t.Fatalf("expected 1 heading, got %d", len(headings))
	}

	if headings[0].Text != "Valid Heading" {
		t.Errorf("expected 'Valid Heading', got %q", headings[0].Text)
	}
}

func TestParseNestedCodeBlocks(t *testing.T) {
	input := "# Before\n\n````\n# Inside outer code\n```\n# Still inside\n```\n````\n\n# After\n"

	headings, err := Parse(strings.NewReader(input))
	if err != nil {
		t.Fatalf("unexpected error: %v", err)
	}

	if len(headings) != 2 {
		t.Fatalf("expected 2 headings, got %d", len(headings))
	}

	if headings[0].Text != "Before" {
		t.Errorf("heading[0]: expected 'Before', got %q", headings[0].Text)
	}
	if headings[1].Text != "After" {
		t.Errorf("heading[1]: expected 'After', got %q", headings[1].Text)
	}
}
