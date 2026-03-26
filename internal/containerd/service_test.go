package containerd

import (
	"os"
	"path/filepath"
	"testing"
)

func TestTaskCreatorUsesNullIOWhenLogDirEmpty(t *testing.T) {
	svc := &DefaultService{}

	creator, err := svc.taskCreator("mcp-test")
	if err != nil {
		t.Fatalf("taskCreator returned error: %v", err)
	}
	if creator == nil {
		t.Fatal("expected creator")
	}
}

func TestTaskCreatorCreatesLogDir(t *testing.T) {
	tmpDir := t.TempDir()
	logDir := filepath.Join(tmpDir, "logs")
	svc := &DefaultService{taskLogDir: logDir}

	creator, err := svc.taskCreator("mcp-test")
	if err != nil {
		t.Fatalf("taskCreator returned error: %v", err)
	}
	if creator == nil {
		t.Fatal("expected creator")
	}

	info, err := os.Stat(logDir)
	if err != nil {
		t.Fatalf("stat log dir: %v", err)
	}
	if !info.IsDir() {
		t.Fatalf("expected %s to be a directory", logDir)
	}
}
