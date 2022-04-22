from typing import Iterable, Tuple

from .util import AptUtil, LocaleUtil, UserUtil, DockerCopyUtil
from .installer import *


class ContainerCommandBuilder:
    def __init__(self) -> None:
        self._container_cmd_list: List[str] = []
        self.user_util = UserUtil()

        self.user_util.ask_user_info()

        self.zsh_installer = ZshInstaller(self.user_util.name)

    def _apt_update(self):
        self._container_cmd_list.extend(AptUtil.apt_update_cmd())

    def _apt_change_src(self):
        self._container_cmd_list.extend(AptUtil.apt_change_src_cmd())
        return self

    def _apt_clean(self):
        self._container_cmd_list.extend(AptUtil.apt_clean_cmd())

    def _set_locale(self):
        self._container_cmd_list.extend(LocaleUtil.set_locale_cmd())

    def _set_user(self):
        self._container_cmd_list.extend(
            self.user_util.get_user_set_cmd(self.zsh_installer.install_zsh))

    def gen_container_cmd(self) -> List[str]:
        self._apt_change_src()
        self._apt_update()    

        for installer in (CoreComponentInstaller(),CppInstaller(), PythonInstaller()):
            self._container_cmd_list.extend(installer.get_cmd())
        self._set_locale()
        self._set_user()
        self._container_cmd_list.extend(self.zsh_installer.get_cmd())

        self._apt_clean()

        return self._container_cmd_list


class Builder:
    @classmethod
    def gen_cmd(cls, base_img: str = "ubuntu:20.04") -> str:
        docker_cmd_list = [f"FROM {base_img}"]
        ccb = ContainerCommandBuilder()
        container_cmd = "RUN "
        container_cmd_list = ccb.gen_container_cmd()
        docker_cmd_list.extend(DockerCopyUtil.get_copy_cmd(
            ccb.zsh_installer.install_zsh,
            ccb.zsh_installer.install_p10k
        ))
        for i, cmd in enumerate(container_cmd_list):
            if 0 != i:
                container_cmd += "    "
            container_cmd += cmd
            if len(container_cmd_list)-1 != i:
                container_cmd += " && \\\n"
        docker_cmd_list.append(container_cmd)
        docker_cmd_list.append(f"USER {ccb.user_util.name}")
        docker_cmd_list.append("ENV TERM xterm-256color")
        docker_cmd_list.append(f"WORKDIR /home/{ccb.user_util.name}")
        if ccb.zsh_installer.install_zsh:
            shell = "zsh"
        else:
            shell = "bash"
        docker_cmd_list.append(f"CMD [\"{shell}\"]")
        result = ""
        for cmd in docker_cmd_list:
            result += cmd + "\n"
        return result
