import os

import tbvaccine

tbvaccine.add_hook(isolate=True)

if "LT" in os.environ:
    import lovely_tensors as lt

    lt.monkey_patch()
