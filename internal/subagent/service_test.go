package subagent

import (
	"testing"

	"github.com/jackc/pgx/v5/pgtype"
)

func TestParseNullableUUID(t *testing.T) {
	got, err := parseNullableUUID("11111111-1111-1111-1111-111111111111")
	if err != nil {
		t.Fatalf("parseNullableUUID returned error: %v", err)
	}
	if !got.Valid {
		t.Fatalf("expected UUID to be valid")
	}
	if got.String() != "11111111-1111-1111-1111-111111111111" {
		t.Fatalf("unexpected UUID value: %s", got.String())
	}
}

func TestParseNullableUUIDEmpty(t *testing.T) {
	got, err := parseNullableUUID("")
	if err != nil {
		t.Fatalf("parseNullableUUID returned error: %v", err)
	}
	if got != (pgtype.UUID{}) {
		t.Fatalf("expected zero UUID for empty input, got %#v", got)
	}
}
