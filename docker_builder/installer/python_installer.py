from typing import List
from .common import Installer

class PythonInstaller(Installer):
    def __init__(self) -> None:
        super().__init__(
            name="Python",
            extra_info=(
                "If both Python 2 and Python 3 are installed, default python will be configured to python3",
                "If Python 3 is installed, so will be pip."
            ),
            candidates=("No","Python 2", "Python 3", "both"),
            default_idx=3,
        )

    def get_cmd(self) -> List[str]:
        self._show_name()
        self._show_extra_info()
        selection = self._get_selection()[0]
        if selection == 0:
            return []
        elif selection == 1:
            return ["apt install -y python2"]
        elif selection == 2:
            return ["apt install -y python3 python3-pip"]
        elif selection == 3:
            return [
                "apt install -y python2 python3 python3-pip",
                "update-alternatives --install /usr/local/bin/python python /usr/bin/python2 2",
                "update-alternatives --install /usr/local/bin/python python /usr/bin/python3 3",
                "python3 -m pip install -i https://mirrors.bfsu.edu.cn/pypi/web/simple --upgrade pip",
                "python3 -m pip config set global.index-url https://mirrors.bfsu.edu.cn/pypi/web/simple",
            ]
        else:
            raise Exception("Select error!")