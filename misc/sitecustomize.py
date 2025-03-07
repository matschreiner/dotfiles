import tbvaccine

tbvaccine.add_hook(show_vars=False)


try:
    import lovely_tensors as lt

    lt.monkey_patch()
except ImportError:
    pass
