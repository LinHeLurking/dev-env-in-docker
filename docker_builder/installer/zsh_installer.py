from typing import List

from .common import Installer


class ZshInstaller(Installer):
    def __init__(self, username: str) -> None:
        self.username = username
        self.install_zsh = True
        self.install_p10k = True
        super().__init__(
            name="zsh",
            extra_info="You can change the zsh themes after installing",
            candidates=(
                "No",
                "Yes, but leave the theme as default",
                "Yes, and install powerline10k theme",
            ),
            default_idx=2,
        )

    def get_cmd(self) -> List[str]:
        self._show_name()
        self._show_extra_info()
        selection = self._get_selection()[0]
        ext_zsh = [
            "apt install -y zsh fonts-powerline",
            f"cp /tmp/omz_install.sh /home/{self.username}",
            f"chmod 777 /home/{self.username}/omz_install.sh",
            f"su {self.username} -c \"cd /home/{self.username} && sh ./omz_install.sh {self.username}\"",
        ]
        ext_p10k = [
            f"cp /tmp/omz_install_p10k.sh /home/{self.username}",
            f"chmod 777 /home/{self.username}/omz_install_p10k.sh",
            f"su {self.username} -c \"cd /home/{self.username} && sh ./omz_install_p10k.sh {self.username}\"",
        ]
        if selection == 0:
            self.install_zsh = False
            self.install_p10k = False
            return []
        elif selection == 1:
            self.install_zsh = True
            self.install_p10k = False
            cmd = []
            cmd.extend(ext_zsh)
            return cmd
        elif selection == 2:
            self.install_zsh = True
            self.install_p10k = True
            cmd = []
            cmd.extend(ext_zsh)
            cmd.extend(ext_p10k)
            return cmd
        else:
            raise Exception("Select error!")
