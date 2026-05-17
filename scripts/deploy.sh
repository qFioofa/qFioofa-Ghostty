#!/bin/bash

set -e

GHOSTTY_CONFIG_DIR="$HOME/.config/ghostty"
BACKUP_DIR="${GHOSTTY_CONFIG_DIR}.backup"
CURRENT_DIR="$(pwd)"
CONFIG_SRC_DIR="$CURRENT_DIR/src"

show_help() {
    echo "Развертывание локального конфига Ghostty в $GHOSTTY_CONFIG_DIR"
    echo "Использование: $0 [опции]"
    echo "  -r, --remove    Удалить старый конфиг перед установкой"
    echo "  -b, --backup    Создать бэкап старого конфига"
    echo "  -h, --help      Показать это сообщение"
}

REMOVE=false
BACKUP=false

while [[ $# -gt 0 ]]; do
    case $1 in
        -r|--remove) REMOVE=true; shift ;;
        -b|--backup) BACKUP=true; shift ;;
        -h|--help) show_help; exit 0 ;;
        *) echo "Неизвестный параметр: $1"; show_help; exit 1 ;;
    esac
done

if [ ! -d "$CONFIG_SRC_DIR" ]; then
    echo "Ошибка: Директория конфигурации src не найдена в $CURRENT_DIR"
    exit 1
fi

if [ -d "$GHOSTTY_CONFIG_DIR" ]; then
    if [ "$REMOVE" = true ]; then
        rm -rf "$GHOSTTY_CONFIG_DIR"
        echo "Старый конфиг удален"
    elif [ "$BACKUP" = true ]; then
        if [ -d "$BACKUP_DIR" ]; then
            rm -rf "$BACKUP_DIR"
        fi
        mv "$GHOSTTY_CONFIG_DIR" "$BACKUP_DIR"
        echo "Бэкап создан: $BACKUP_DIR"
    else
        echo "Обнаружена директория конфига. Используйте -r для удаления или -b для бэкапа."
        exit 1
    fi
fi

mkdir -p "$GHOSTTY_CONFIG_DIR"

cp -r "$CONFIG_SRC_DIR/." "$GHOSTTY_CONFIG_DIR"
echo "Конфиг развернут в $GHOSTTY_CONFIG_DIR"
