"""/etc/python3.9/sitecustomize.py"""
try:
    from devtools import debug
except ImportError:
    pass
else:
    __builtins__["debug"] = debug

try:
    import traceback, os

    def pprint_bt(userspace=True, compact=True, limit=20):
        stack = traceback.extract_stack(limit=limit)[:-2]
        out = []
        for i, f in enumerate(reversed(stack)):
            if len(out) > 0 and "site-packages" in f[0]:
                if userspace:
                    break
            out.append(f"{i:2}. ./{os.path.relpath(f[0])}:{f[1]}")
            if compact == False:
                out.append(f'\t in {f[2]}(...) "{f[3]}"')
        print("\n".join(out))

except ImportError:
    pass
else:
    __builtins__["bt"] = pprint_bt
