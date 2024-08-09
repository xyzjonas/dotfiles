#! /usr/bin/env python
import os
import sys
import site
from pathlib import Path


SOLV_FILES = ["solv.py", "_solv.so"]


def get_current_site_packages_path(lib64: bool = True) -> Path:
    site_packages_paths = site.getsitepackages()

    if lib64:
        site_packages_paths = [path for path in site_packages_paths if "lib64" in path]

    if not site_packages_paths:
        raise Exception(f"No site packages {lib64=}")

    return Path(site_packages_paths[0])


def main():
    """
    Usually the "python(3)-solv" package (python bindings for the libsolv library)
    is available only for the system's primary python version.
    Simple workaround seems to be to just symlink the system python"s bindings
    to the current python site packages (.py and .so files).

    Usage: add-missing-solv-symlink.py <python-version>

    specify a python version (major.minor) for which bindings are installed,
    * see `rpm -ql python3-solv`
    """
    assert len(sys.argv) == 2, "Missing 'from python' argument"

    from_python = sys.argv[1]
    assert len(from_python.split(".")) == 2, "Use only major.minor versions as argument, e.g.: '3.11'"

    system_site_packages = Path("/") / "usr" / "lib64" / f"python{from_python}" / "site-packages"
    for file in SOLV_FILES:
        link_target = system_site_packages / file
        assert link_target.exists(), (
            f"{link_target=} does not exist, wrong python version specified "
            f"or python3-solv system package is missing."
        )

        link_name = get_current_site_packages_path() / file
        try:
            os.symlink(link_target, link_name)
        except FileExistsError:
            pass


if __name__ == "__main__":
    main()

