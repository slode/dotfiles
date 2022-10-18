try:
    import traceback, os

    from devtools import debug
    from devtools.ansi import sformat

    def print_trace(full: bool = False):
        """Pretty prints a compact backtrace.

        Args:
          full: If true, also print stack frames from site-packages.
                False by default.
        """
        stack = traceback.extract_stack()[:-1]
        out = []
        for i, f in enumerate(reversed(stack)):
            if out and "site-packages" in f[0] and not full:
                out.append(
                    sformat(
                        f"\n... and {len(stack) - i} more levels",
                        sformat.dim,
                        sformat.italic,
                    )
                )
                break

            out.append(
                sformat(f"{i}. ./{os.path.relpath(f[0])}", sformat.magenta)
                + ":"
                + sformat(f[1], sformat.green)
                + " "
                + sformat(f[2], sformat.green, sformat.italic)
                + "\n    "
                + sformat(f[3], sformat.dim)
            )

        print("\n".join(out) + "\n", flush=True)

except ImportError:
    pass
else:
    __builtins__["debug"] = debug
    __builtins__["dbg"] = debug
    __builtins__["trace"] = print_trace
    __builtins__["bt"] = print_trace


try:
    import sqlparse

    def print_sql(sql: str):
        print(sqlparse.format(sql, reindent=True, keyword_case="upper"), flush=True)

except ImportError:

    def print_sql(sql: str):
        print(sql, flush=True)


__builtins__["dumpsql"] = print_sql
