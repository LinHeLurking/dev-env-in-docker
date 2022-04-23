from typing import List
from .common import Installer


class CppInstaller(Installer):
    def __init__(self) -> None:
        super().__init__(
            name="C++",
            candidates=(
                "No",
                "gcc/g++",
                "gcc/g++, clang/clang++, llvm"
            ),
            extra_info="Unless 'No' is selected, build-essential(including make), cmake, ninja-build will be installed",
            default_idx=2,
        )

    def get_cmd(self) -> List[str]:
        self._show_name()
        self._show_extra_info()
        selection = self._get_selection()[0]
        if selection == 0:
            return []
        elif selection == 1:
            return ["apt install -y build-essential cmake ninja-build"]
        elif selection == 2:
            return ["apt install -y build-essential cmake ninja-build clang llvm"]
        else:
            raise Exception("Select error!")
