from .common import Installer
from typing import List


class NeoVimInstaller(Installer):
    def __init__(self, username:str) -> None:
        self.username = username
        self.install_nvim = True
        self.install_lvim = True
        self.use_predefined_lvim_config = True
        super().__init__(
            name="NeoVim",
            extra_info=(
                "Even if you choose a configured version, you can change those configurations in the future.",
                "If NeoVim(or LunarVim) is installed, vim will be set as an alias to it in default shell."
            ),
            candidates=(
                "No",
                "Yes",
                "Yes, and use LunarVim",
                "Yes, and use LunarVim with some predefined configurations"
            ),
            default_idx=3,
        )

    def get_cmd(self) -> List[str]:
        self._show_name()
        self._show_extra_info()
        selection = self._get_selection()[0]

        ext_install_nvim = [
            "cd /tmp",
            "wget https://ghproxy.com/https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb",
            "wget https://ghproxy.com/https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb.sha256sum",
            "[ \"$(sha256sum nvim-linux64.deb)\" = \"$(cat nvim-linux64.deb.sha256sum)\" ] && echo 1",
            "apt install ./nvim-linux64.deb",
        ]

        ext_install_lvim = [
            f"cp /tmp/lvim_install.sh /home/{self.username}",
            f"chmod 777 /home/{self.username}/lvim_install.sh",
            f"su {self.username} -c \"cd /home/{self.username} && sh ./lvim_install.sh {self.username}\"",
        ]

        if selection == 0:
            self.install_nvim = False
            self.install_lvim = False
            self.use_predefined_lvim_config = False
        elif selection == 1:
            self.install_nvim = True
            self.install_lvim = False
            self.use_predefined_lvim_config = False
            return ext_install_nvim
        elif selection == 2:
            self.install_nvim = True
            self.install_lvim = True
            self.use_predefined_lvim_config = False
            cmd = []
            cmd.extend(ext_install_nvim)
            cmd.extend(ext_install_lvim)
            return cmd
        elif selection == 3:
            self.install_nvim = True
            self.install_lvim = True
            self.use_predefined_lvim_config = True
            cmd = []
            cmd.extend(ext_install_nvim)
            cmd.extend(ext_install_lvim)
            return cmd
        else:
            raise Exception("Select error!")
