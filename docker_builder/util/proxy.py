from typing import List, Union


class ProxyUtil:
    @classmethod
    def _ask_proxy(cls) -> Union[str, None]:
        print("Do you need proxy while docker building? If you do not use proxy, you might fail to install LunarVim.")
        x = input("[Y]es/[N]o (default Yes)").lower()
        if "y" in x or x == "":
            use = True
        elif "n" in x:
            use = False
        else:
            raise Exception("Invalid Input!")
        if not use:
            return None
        print("Input your host proxy address(such as \"http://127.0.0.1:1080\"). You do not have to include quote mark in input")
        x = input().strip(" \"")
        if x == "":
            raise Exception("Invalid Input!")
        return x

    @classmethod
    def get_cmd(cls) -> List[str]:
        proxy = cls._ask_proxy()
        if proxy is None:
            return []
        else:
            return [
                f"ARG HTTP_PROXY=\"{proxy}\"",
                f"ARG HTTPS_PROXY=\"{proxy}\"",
            ]
