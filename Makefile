

# Makefile pro kompilaci základního programu s knihovnou SDL


# Compiler settings
CC = gcc
CFLAGS = -std=c99 -Wall -Wextra
LDFLAGS = -lm

# Settings
APP_FILE = app
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

TARGET = $(BIN_DIR)/$(APP_FILE)																					# output name
SRCS = $(wildcard $(SRC_DIR)/*.c)																# source files
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))			# directory of object files

define command_comment
	@echo -e "\t$(COLOR_GREEN)$(1)$(RESET) \t# $(2)"
	@echo -e "\t\t# Run with $(COLOR_BLUE)'make $(1)'$(RESET)\n"
endef

help:
	@clear
	$(call command_comment,help,"This function shows all commands.")
	$(call command_comment,build,"Function for compile your code in src folder.")
	$(call command_comment,run,"Run compile and run program at the same time.")

# Nastavení cílů
build: $(TARGET)

run:
	@cd ./$(BIN_DIR) && ./$(APP_FILE).exe

all: build run

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: help

# ANSI escape sekvence pro barvy
RESET = \033[0m
COLOR_BLACK = \033[0;30m
COLOR_RED = \033[0;31m
COLOR_GREEN = \033[0;32m
COLOR_BROWN = \033[0;33m
COLOR_BLUE = \033[0;34m
COLOR_PURPLE = \033[0;35m
COLOR_CYAN = \033[0;36m
COLOR_WHITE = \033[0;37m
COLOR_LIGHT_GRAY = \033[0;90m
COLOR_LIGHT_RED = \033[0;91m
COLOR_LIGHT_GREEN = \033[0;92m
COLOR_LIGHT_BROWN = \033[0;93m
COLOR_LIGHT_BLUE = \033[0;94m
COLOR_LIGHT_PURPLE = \033[0;95m
COLOR_LIGHT_CYAN = \033[0;96m
COLOR_LIGHT_WHITE = \033[0;97m

# ANSI escape sekvence pro formátování
FORMAT_RESET = \033[0m
FORMAT_BOLD = \033[1m
FORMAT_ITALIC = \033[3m
FORMAT_UNDERLINE = \033[4m
FORMAT_STRIKETHROUGH = \033[9m

# ANSI escape sekvence pro barvu pozadí
BACKGROUND_RESET = \033[49m
BACKGROUND_BLACK = \033[40m
BACKGROUND_RED = \033[41m
BACKGROUND_GREEN = \033[42m
BACKGROUND_BROWN = \033[43m
BACKGROUND_BLUE = \033[44m
BACKGROUND_PURPLE = \033[45m
BACKGROUND_CYAN = \033[46m
BACKGROUND_WHITE = \033[47m
BACKGROUND_LIGHT_GRAY = \033[100m
BACKGROUND_LIGHT_RED = \033[101m
BACKGROUND_LIGHT_GREEN = \033[102m
BACKGROUND_LIGHT_BROWN = \033[103m
BACKGROUND_LIGHT_BLUE = \033[104m
BACKGROUND_LIGHT_PURPLE = \033[105m
BACKGROUND_LIGHT_CYAN = \033[106m
BACKGROUND_LIGHT_WHITE = \033[107m