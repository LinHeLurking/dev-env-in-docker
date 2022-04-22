from typing import List

from .common import Installer


class ZshInstaller(Installer):
    def __init__(self, user_name: str) -> None:
        self.user_name = user_name
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
        if selection == 0:
            self.install_zsh = False
            self.install_p10k = False
            return []
        elif selection == 1:
            self.install_zsh = True
            self.install_p10k = False
            return [
                "apt install zsh",
                f"cp /tmp/zsh_install.sh /home/{self.user_name}",
                f"chmod 777 /home/{self.user_name}/zsh_install.sh",
                f"su {self.user_name} -c \"cd / home/{self.user_name} && sh ./zsh_install.sh {self.user_name}\"",
            ]
        elif selection == 2:
            self.install_zsh = True
            self.install_p10k = True
            return [
                "apt install -y zsh fonts-powerline",
                f"cp /tmp/zsh_install.sh /home/{self.user_name}",
                f"chmod 777 /home/{self.user_name}/zsh_install.sh",
                f"su {self.user_name} -c \"cd / home/{self.user_name} && sh ./zsh_install.sh {self.user_name}\"",
                f"cp /tmp/zsh_install_p10k.sh /home/{self.user_name}",
                f"chmod 777 /home/{self.user_name}/zsh_install_p10k.sh",
                f"su {self.user_name} -c \"cd /home/{self.user_name} && sh ./zsh_install_p10k.sh {self.user_name}\"",
            ]
        else:
            raise Exception("Select error!")
