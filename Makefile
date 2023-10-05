-include app.config

AUTOR ?= ""
VERSION ?= ""
DESCRIPTION ?= ""

# Compiler settings
CC = gcc
CFLAGS = -std=c99 -Wall -Wextra
LDFLAGS = -lm

# Settings
APP_NAME = app
SRC_DIR = app/src
INC_DIR = app/include
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = $(BUILD_DIR)/bin

INCS=-I$(INC_DIR)
TARGET = $(BIN_DIR)/$(APP_NAME)																	# output name
SRCS = $(wildcard $(SRC_DIR)/*.c)																# source files
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))			# directory of object files

# function for creating text in right format in make help
define command_comment
	@echo -e "\t$(COLOR_GREEN)$(1)$(RESET) \t# $(2)"
	@for arg in $(3) $(4) $(5); do \
		if [ -n "$$arg" ]; then \
			echo -e "\t\t# $$arg"; \
		fi; \
	done
	@echo -e "\t\t# Run with $(COLOR_BLUE)'make $(1)'$(RESET)\n"
endef

print:
	@echo "$(AUTOR)"

help:
	@clear
	$(call command_comment,help,"This function shows all commands.")
	$(call command_comment,build,"Function for compile your code in src folder.", "Aliases: $(COLOR_GREEN)compile$(RESET)")
	$(call command_comment,run,"Build and run program in one command.")
	$(call command_comment,clear,"Clear all files that was created in build", "Aliases: $(COLOR_GREEN)clean$(RESET)")

build: $(TARGET)


$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@echo -e "\n$(COLOR_BLUE)Building...$(RESET)"
	$(CC) $(CFLAGS) $(INCS) -c -o $@ $<

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	@echo -e "\n$(COLOR_BLUE)Linking...$(RESET)"
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	@if [ $$? -eq 0 ]; then \
		echo -e "\n$(COLOR_GREEN)Build was completed.$(RESET)"; \
	fi

run:
	@cd ./$(BIN_DIR) && ./$(APP_NAME).exe

all: build run

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)
clear: clean

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