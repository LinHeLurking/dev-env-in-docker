from typing import List

class AptUtil:
    @classmethod
    def apt_update_cmd(cls) -> List[str]:
        return ["apt update"]

    @classmethod
    def apt_clean_cmd(cls) -> List[str]:
        return ["apt clean"]

    @classmethod
    def apt_change_src_cmd(cls) -> List[str]:
        s_list = [
            "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal main restricted universe multiverse",
            "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-updates main restricted universe multiverse",
            "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-backports main restricted universe multiverse",
            "deb http://mirrors.bfsu.edu.cn/ubuntu/ focal-security main restricted universe multiverse",
        ]
        cmd_list = [
            "mv /etc/apt/sources.list /etc/apt/sources.list.bak",
        ]
        for s in s_list:
            cmd = f"echo \"{s}\" >> /etc/apt/sources.list"
            cmd_list.append(cmd)
        return cmd_list