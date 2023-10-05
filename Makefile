# Makefile pro kompilaci základního programu s knihovnou SDL

# Nastavení kompilátoru a jeho přepínačů
CC = gcc
CFLAGS = -std=c99 -Wall -Wextra
LDFLAGS = -lm

# Adresáře pro zdrojové soubory, objektové soubory a výstupní soubory
SRC_DIR = src
OBJ_DIR = obj
BIN_DIR = bin

# Jméno výstupního spustitelného souboru
TARGET = $(BIN_DIR)/app

# Zdrojové soubory
SRCS = $(wildcard $(SRC_DIR)/*.c)

# Objektové soubory
OBJS = $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRCS))

# Nastavení cílů
all: $(TARGET)

$(TARGET): $(OBJS)
	@mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)
	./bin/app.exe

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(OBJ_DIR) $(BIN_DIR)

.PHONY: all clean