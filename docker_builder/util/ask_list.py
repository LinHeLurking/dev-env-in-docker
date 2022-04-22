from typing import Union, Any,  Iterable, List


def ask_selection(
    candidates: Iterable[Any],
    default_idx: Union[None, int, Iterable[int]] = None,
    allow_multiple: bool = False,
    allow_no_choice: bool = False,
) -> List[int]:
    if default_idx is None:
        default = set()
    elif type(default_idx) is int:
        default = set([default_idx])
    else:
        default = set(default_idx)
    for i, item in enumerate(candidates):
        if i in default:
            extra = "(default)"
        else:
            extra = ""
        print(f"({i}) {item} {extra}")
    print(f"Default: {default}")
    print("Input the number you want:")
    selection = input()
    selection = selection.strip(" ,;")
    selection = selection.split(" ,;")

    if len(selection) == 1 and selection[0] == "":
        if len(default) == 0 and not allow_no_choice:
            raise Exception("Empty choice is not allowed! Must input!")
        else:
            return list(default)
    elif len(selection) > 1 and not allow_multiple:
        raise Exception("Multiple choices are not allowed! Select one of them")
    else:
        ret = []
        for i_str in selection:
            ret.append(int(i_str))
        return ret
