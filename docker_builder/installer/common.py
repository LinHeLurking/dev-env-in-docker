from typing import Union, Any, Iterable, List
from ..util import ask_selection


class Installer:
    def __init__(
        self,
        name: str,
        extra_info: Union[None, str, Iterable[str]],
        candidates: Iterable[Any],
        default_idx: Union[None, int, Iterable[int]] = None,
        allow_multiple: bool = False,
        allow_no_choice: bool = False,
    ) -> None:
        self._name = name
        self._candidates = candidates
        self._extra_info = extra_info
        self._default_idx = default_idx
        self._allow_multiple = allow_multiple
        self._allow_no_choice = allow_no_choice

    def _show_name(self):
        print(f"Install {self._name}")

    def _show_extra_info(self):
        if self._extra_info is None:
            return
        elif type(self._extra_info) is str:
            if self._extra_info == "":
                return
            info_iterable = [self._extra_info]
        else:
            if len(self._extra_info) == 0:
                return
            info_iterable = self._extra_info
        print("Additional explanation:")
        for info in info_iterable:
            print(info)
        print()

    def _get_selection(self) -> List[int]:
        return ask_selection(
            self._candidates,
            self._default_idx,
            self._allow_multiple,
            self._allow_no_choice,
        )

    def get_cmd(self) -> List[str]:
        raise NotImplementedError()
