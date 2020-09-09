// Copyright 2019 Drone.IO Inc. All rights reserved.
// Use of this source code is governed by the Drone Non-Commercial License
// that can be found in the LICENSE file.

package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/mattn/go-isatty"

	"github.com/ozonep/drone/pkg/runtime"
	"github.com/ozonep/drone/pkg/runtime/engine"
	"github.com/ozonep/drone/pkg/runtime/engine/docker"
	"github.com/ozonep/drone/pkg/runtime/engine/docker/auth"
	"github.com/ozonep/drone/pkg/runtime/engine/kube"
	"github.com/ozonep/drone/pkg/runtime/term"
	"github.com/ozonep/drone/pkg/signal"
)

var tty = isatty.IsTerminal(os.Stdout.Fd())

func main() {
	c := flag.String("config", "", "")
	k := flag.String("kube-config", "", "")
	u := flag.String("kube-url", "", "")
	n := flag.String("kube-node", "", "")
	d := flag.Bool("kube-debug", false, "")
	t := flag.Duration("timeout", time.Hour, "")
	h := flag.Bool("help", false, "")

	flag.BoolVar(h, "h", false, "")
	flag.Usage = usage
	flag.Parse()

	if *h {
		flag.Usage()
		os.Exit(0)
	}

	var source string
	if flag.NArg() > 0 {
		source = flag.Args()[0]
	}

	config, err := engine.ParseFile(source)
	if err != nil {
		log.Fatalln(err)
	}

	if *c != "" {
		auths, err := auth.ParseFile(*c)
		if err != nil {
			log.Fatalln(err)
		}
		config.Docker.Auths = append(config.Docker.Auths, auths...)
	}

	if *d {
		println(kube.Print(config))
		return
	}

	var engine engine.Engine
	if *k == "" {
		engine, err = docker.NewEnv()
		if err != nil {
			log.Fatalln(err)
		}
	} else {
		engine, err = kube.NewFile(*u, *k, *n)
		if err != nil {
			log.Fatalln(err)
		}
	}

	hooks := &runtime.Hook{}
	hooks.GotLine = term.WriteLine(os.Stdout)
	if tty {
		hooks.GotLine = term.WriteLinePretty(os.Stdout)
	}

	r := runtime.New(
		runtime.WithEngine(engine),
		runtime.WithConfig(config),
		runtime.WithHooks(hooks),
	)

	ctx, cancel := context.WithTimeout(context.Background(), *t)
	ctx = signal.WithContext(ctx)
	defer cancel()

	err = r.Run(ctx)
	if err != nil {
		log.Fatalln(err)
	}
}

func usage() {
	fmt.Println(`Usage: drone-runtime [OPTION]... [SOURCE]
      --config      loads a docker config.json file
      --plugin      loads a runtime engine from a .so file
      --kube-config loads a kubernetes config file
      --kube-url    sets a kubernetes endpoint
      --kube-debug  writes a kubernetes configuration to stdout
      --timeout     sets an execution timeout
  -h, --help        display this help and exit`)
}
