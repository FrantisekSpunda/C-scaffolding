# Configuration of creating configuration file
CONFIG_FILE = config.cfg
CONFIG_EXAMPLE = example.config.cfg
-include $(CONFIG_FILE)

define APP_CONFIG_CONTENT
AUTOR=\"Your name\"\nVERSION=\"0.1\"\nDESCRIPTION=\"Description ...\"\nSRC_DIR=\"app/src\"\nINCLUDE_DIR=\"app/include\"
endef

# Settings
OBJ_DIR := $(BUILD_DIR)/obj
BIN_DIR := $(BUILD_DIR)/bin
INCS:=-I$(INCLUDE_DIR)
TARGET := $(BIN_DIR)/$(APPLICATION_NAME)
SRCS := $(shell find $(SOURCE_DIR) -type f -name "*.c")
OBJS = $(patsubst $(SOURCE_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))
HEADER_TEMPLATE := template.h
CURRENT_YEAR := $(shell date +%Y)

define style
$(COLOR_$(2))$(FORMAT_$(3))$(1)$(RESET)
endef

define command_comment 																						# function for help texts
	@echo -e " $(call style,$(1),GREEN)\t\t$(2)"
	@for arg in $(3) $(4) $(5); do \
		if [ -n "$$arg" ]; then \
			echo -e "\t\t$$arg"; \
		fi; \
	done
	@echo -e "\t\tRun with $(call style,"\'make $(1)\'",BLUE)\n"
endef

define find_config
@if [ ! -f $(CONFIG_FILE) ]; then \
	echo -e "\n $(call style,No config file!!,RED,BOLD).\n Run $(call style,'make init',BLUE) to create $(call style,$(CONFIG_FILE),LIGHT_GRAY) file and edit it.\n";\
fi
endef

info:
	@echo -e " Config file:\t\t$(call style,$(CONFIG_FILE),LIGHT_GRAY)"
	@echo -e " Compier:\t\t$(call style,$(COMPILER),LIGHT_GRAY)"
	@echo -e " Compiler flags:\t$(call style,$(COMPILER_FLAGS),LIGHT_GRAY)"
	@echo -e " Source folder:\t\t$(call style,$(SOURCE_DIR),LIGHT_GRAY) (*.c files,LIGHT_GRAY)"
	@echo -e " Include folder:\t$(call style,$(INCLUDE_DIR),LIGHT_GRAY) (*.h files,LIGHT_GRAY)"
	@echo -e " App file:\t\t$(call style,"$(BIN_DIR)/$(APPLICATION_NAME).exe",LIGHT_GRAY)\n"
	@echo -e " You can change these values and more in $(call style,config.cfg,LIGHT_GRAY)\n"
	@echo -e " For list of commands run $(call style,"\'make help\'",BLUE,BOLD)"

help:
	@clear
	$(call command_comment,help,"This command shows this message.", "Aliases: $(call style,list,GREEN)")
	$(call command_comment,init,"Create configuration file with example data")
	$(call command_comment,build,"Function for compile your code in src folder.","For build you need config file", "Aliases: $(COLOR_GREEN)compile$(RESET)")
	$(call command_comment,run,"Run yoour program in one command.")
	$(call command_comment,all,"Run build and run at same time.")
	$(call command_comment,clear,"Clear all files that was created in build", "Aliases: $(call style,clean,GREEN)")
list: help

build: add_header $(TARGET)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(OBJ_DIR)
	@echo -e "\n $(COLOR_BLUE)Building...$(RESET)"
	$(COMPILER) $(COMPILER_FLAGS) $(INCS) -c -o $@ $<

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	@echo -e "\n $(COLOR_BLUE)Linking...$(RESET)"
	$(call find_config)
	$(COMPILER) $(COMPILER_FLAGS) -o $@ $^ $(LD_FLAGS)
	@if [ $$? -eq 0 ]; then \
		echo -e "\n $(COLOR_GREEN)Build was completed.$(RESET)"; \
	fi;

run:
	@if [ ! -f $(BIN_DIR)/$(APPLICATION_NAME).exe ]; then \
		echo -e " $(call style,Cannot run application!,RED,BOLD)\n You have to run $(call style,'make build',BLUE) first.";\
	else \
		cd ./$(BIN_DIR) && ./$(APPLICATION_NAME).exe;\
	fi;

all: build run

init:
	@if [ ! -f $(CONFIG_FILE) ]; then \
		cp $(CONFIG_EXAMPLE) $(CONFIG_FILE); \
		echo -e " $(COLOR_GREEN)Creating $(CONFIG_FILE)$(RESET)";\
	else \
		echo -e " $(COLOR_BLUE)File $(CONFIG_FILE) already exist.$(RESET)"; \
	fi


add_header:
	@for file in $(SRCS); do \
		filename=$$(basename $$file); \
		current_date=$$(stat -c '%y' $$file | awk '{split($$1,a,"-"); print a[1]"-"a[3]"-"a[2]}'); \
		echo -e " Adding header to $(call style,$$file,LIGHT_GRAY)"; \
		if head -1 "$$file" | grep -q '^/\*\*'; then \
			sed -i '1,10d' $$file;\
		fi; \
		sed -e "s/{{filename}}/$$filename/" -e "s/{{author}}/$(AUTHOR)/" -e "s/{{description}}/$(DESCRIPTION)/" -e "s/{{date}}/$$current_date/" -e "s/{{year}}/$(CURRENT_YEAR)/" $(HEADER_TEMPLATE) > $$file.tmp; \
		cat $$file >> $$file.tmp;\
		mv $$file.tmp $$file;\
	done

clean:
	rm -rf $(BUILD_DIR)
clear: clean

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