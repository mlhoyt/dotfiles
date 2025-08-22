#!/usr/bin/env python3

import argparse
from datetime import datetime
import subprocess
import sys
import time

argParser = argparse.ArgumentParser(description="swatch - repeat shell command")
argParser.add_argument( "--delay", type=float, dest="delay", default=2, help="Seconds between command invocations")
argParser.add_argument( "--command", dest="cmd", help="The command to invoke")
args = argParser.parse_args()

if args.cmd == "":
    print("--command argument is required", file=sys.stderr)
    sys.exit(1)

try:
    while True:
        print("--> ", end="")
        print(datetime.now().strftime("%FT%T%z"))

        try:
            result = subprocess.run(args.cmd, shell=True, capture_output=True, text=True, check=True)
            print(result.stdout, end="")
            if result.stderr:
                print(result.stderr, end="")
        except subprocess.CalledProcessError as e:
            print(f"[ERROR] failed executing command: {e}")

        time.sleep(args.delay)
except KeyboardInterrupt:
    print("\n--> Ctrl+C detected. Exiting gracefully...")
