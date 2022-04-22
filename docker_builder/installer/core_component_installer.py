import enum
from typing import List
from .common import Installer


class CoreComponentInstaller(Installer):
    def __init__(self) -> None:
        self._component = ["sudo", "git", "gnupg", "wget",
                           "curl", "vim", "ca-certificates", "locales", ]
        info = ""
        for i, c in enumerate(self._component):
            info += c
            if i < len(self._component) - 1:
                info += ", "
        info += " will be installed"
        super().__init__(
            name="Core Component",
            extra_info=info,
            candidates=(),
            default_idx=0
        )

    def get_cmd(self) -> List[str]:
        self._show_name()
        self._show_extra_info()
        x = ""
        for y in self._component:
            x += f"{y} "
        return [
            f"apt install -y {x}",
            "echo \"debconf debconf/frontend select Noninteractive\" | debconf-set-selections"
        ]
