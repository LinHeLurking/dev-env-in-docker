from typing import List


class LocaleUtil:
    @classmethod
    def set_locale_cmd(cls) -> List[str]:
        return ["locale-gen en_US.UTF-8"]
