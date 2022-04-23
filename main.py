#!/usr/bin/env python3

from os import path, rename
from docker_builder import Builder


def main():
    if path.isfile("Dockerfile"):
        print("There is already a Dokerfile. It will be renamed as Dockerfile.old")
        rename("Dockerfile", "Dockerfile.old")
    with open("Dockerfile", "w") as f:
        f.write(Builder.gen_cmd())


if __name__ == "__main__":
    main()
