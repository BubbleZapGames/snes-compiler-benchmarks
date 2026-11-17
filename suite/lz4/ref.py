"""Reference result for lz4: the byte sum of the original (uncompressed) buffer."""
import importlib.util
from pathlib import Path

_spec = importlib.util.spec_from_file_location("lz4_make_data", Path(__file__).with_name("make_data.py"))
make_data = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(make_data)


def expected():
    src = make_data.original()
    assert make_data.decompress(make_data.compress(src)) == src
    return sum(src) & 0xFFFF
