from typing import Tuple, List
import getpass


class UserUtil:
    def __init__(self) -> None:
        self.name: str = ""
        self.password: str = ""

    def _ask_user_name(self) -> str:
        print("Input a valid unix username for the container")
        default_name = getpass.getuser().lower()
        name = input(f"Input your username(default: {default_name}):")
        name = name.strip()
        if name == "":
            name = default_name
        print()
        return name.lower()

    def _ask_user_password(self) -> str:
        print("Input a password for the container.\nThis does not have to be the same with your current password.")
        password = input(f"Input your password:")
        password = password.strip()
        print()
        if password == "":
            raise Exception("Must input some characters")
        else:
            return password

    def ask_user_info(self) -> Tuple[str, str]:
        self.name, self.password = self._ask_user_name(), self._ask_user_password()

    def get_user_set_cmd(self, use_zsh: bool) -> List[str]:
        if use_zsh:
            shell = "zsh"
        else:
            shell = "bash"
        return [
            f"adduser --quiet --disabled-password --shell /bin/{shell} --home /home/{self.name} --gecos \"User\" {self.name}",
            f"echo \"{self.name}:{self.password}\" | chpasswd",
            f"usermod -aG sudo {self.name}",
        ]
