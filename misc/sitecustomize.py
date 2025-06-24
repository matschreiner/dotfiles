from argparse import ArgumentParser

import lovely_tensors as lt
import tbvaccine

parser = ArgumentParser()
parser.add_argument(
    "--show_vars", action="store_true", help="Show variables in the output"
)

args = parser.parse_args()

lt.monkey_patch()
tbvaccine.add_hook(isolate=True, show_vars=args.show_vars)
