from typing import List


class DockerCopyUtil:
    @classmethod
    def get_copy_cmd(cls, install_zsh: bool, install_p10k: bool) -> List[str]:
        f_list = []
        if install_zsh:
            f_list.append("zsh_install.sh")
        if install_p10k:
            f_list.append("zsh_install_p10k.sh")
        if len(f_list) == 0:
            return []
        else:
            f_l_s = ""
            for i, f in enumerate(f_list):
                f_l_s += f"\"{f}\""
                if i != len(f_list)-1:
                    f_l_s += ", "
            return [f"COPY [{f_l_s}, \"/tmp/\"]"]
