from typing import List


class DockerCopyUtil:
    @classmethod
    def get_copy_cmd(
        cls,
        install_omz: bool,
        install_p10k: bool,
        install_lvim:bool,
        use_lvim_config: bool,
    ) -> List[str]:
        f_list = []
        if install_omz:
            f_list.append("omz_install.sh")
        if install_p10k:
            f_list.append("omz_install_p10k.sh")
        if use_lvim_config:
            f_list.append("config.lua")
        if install_lvim:
            f_list.append("lvim_install.sh")
        if len(f_list) == 0:
            return []
        else:
            f_l_s = ""
            for i, f in enumerate(f_list):
                f_l_s += f"\"{f}\""
                if i != len(f_list)-1:
                    f_l_s += ", "
            return [f"COPY [{f_l_s}, \"/tmp/\"]"]
