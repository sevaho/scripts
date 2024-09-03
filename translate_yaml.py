#!/usr/bin/env python

# ==========================================================
# Author: https://github.com/sevaho
# Repo: https://github.com/sevaho/scripts
#
# Not sure if this is still up to date...
# ==========================================================

import yaml
from enum import Enum

from pathlib import Path
from yaml.loader import BaseLoader
import yaml

import typer

from typing_extensions import Annotated

from deep_translator import GoogleTranslator as GoogleTranslate
from deep_translator import ChatGptTranslator

OPENAI_KEY = "<TODO>"


def translate_with_google(text: str, target_lang: str) -> str:
    translator = GoogleTranslate(source="en", target=target_lang)
    result = translator.translate(text)
    return result


def translate_with_chat_gpt(text: str, target_lang: str) -> str:
    translator = ChatGptTranslator(api_key=OPENAI_KEY, source="en", target=target_lang)
    result = translator.translate(text)
    return result


def translate_file_with_chat_gpt(path: str, target_lang: str) -> str:
    translator = ChatGptTranslator(api_key=OPENAI_KEY, source="en", target=target_lang)
    result = translator.translate_file(path)
    return result


def read_and_parse_yml_to_dict(path: str):
    with open(path, "r") as f_read:
        return yaml.load(f_read, BaseLoader)


def write_dict_to_yaml(filename: str, data: dict):
    print("Writing changes to YAML file")
    with open(filename, "w") as f_write:
        yaml.dump(data, f_write, allow_unicode=True, width=float("inf"), sort_keys=False, default_flow_style=False)


class LANGUAGE_CODES(Enum):
    nl = "nl"
    de = "de"
    en = "en"
    fr = "fr"


def main(
    file: Annotated[Path, typer.Option()],
    lang_in: Annotated[
        LANGUAGE_CODES,
        typer.Option("--in", "-in"),
    ],
    lang_out: Annotated[LANGUAGE_CODES, typer.Option("--out", "-out")],
):
    content = read_and_parse_yml_to_dict(file)
    for k, v in content.items():
        if to_translate := v.get(lang_in.value):
            content[k][lang_out.value] = translate_with_google(to_translate, target_lang=lang_out.value)
    write_dict_to_yaml(file, content)


translate_file_with_chat_gpt("/tmp/en.py", target_lang="de")
# if __name__ == "__main__":
#     typer.run(main)
