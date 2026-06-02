package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	self, err := os.Executable()
	if err != nil {
		fmt.Fprintf(os.Stderr, "vkim: failed to resolve executable path: %v\n", err)
		os.Exit(1)
	}

	// Follow symlinks so the root is always the real install dir
	self, err = filepath.EvalSymlinks(self)
	if err != nil {
		fmt.Fprintf(os.Stderr, "vkim: failed to resolve symlinks: %v\n", err)
		os.Exit(1)
	}

	root := filepath.Dir(self)
	nvim := filepath.Join(root, "bin", "nvim-win64", "bin", "nvim.exe")

	if _, err := os.Stat(nvim); err != nil {
		fmt.Fprintf(os.Stderr, "vkim: nvim not found at %s\n", nvim)
		fmt.Fprintf(os.Stderr, "      Extract vkim-windows-x64.zip to a short path (e.g. C:\\vkim)\n")
		os.Exit(1)
	}

	os.Setenv("NVIM_APPNAME", "vkim")
	os.Setenv("XDG_CONFIG_HOME", filepath.Join(root, "config"))
	os.Setenv("XDG_DATA_HOME", filepath.Join(root, "data"))
	os.Setenv("XDG_STATE_HOME", filepath.Join(root, "state"))
	os.Setenv("XDG_CACHE_HOME", filepath.Join(root, "cache"))

	cmd := exec.Command(nvim, os.Args[1:]...)
	cmd.Stdin = os.Stdin
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		if exitErr, ok := err.(*exec.ExitError); ok {
			os.Exit(exitErr.ExitCode())
		}
		os.Exit(1)
	}
}
