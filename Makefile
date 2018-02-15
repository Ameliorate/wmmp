TARGET=WMmp
LIBS=-lX11 -lXpm -lXext
CC?=gcc
CFLAGS?=-g -Wall
INSTALL_PATH?=/usr/local/bin
MANUAL_PATH?=/usr/share/man/man1

.PHONY: default all clean run format install uninstall

default: $(TARGET)
all: default

OBJECTS = $(patsubst %.c, %.o, $(wildcard src/*.c))
HEADERS = $(wildcard src/*.h)

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) -c $< $(LIBS) -o $@

.PRECIOUS: $(TARGET) $(OBJECTS)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -Wall $(LIBS) -o $@

clean:
	-rm -f src/*.o
	-rm -f $(TARGET)

run: $(TARGET)
	./$(TARGET)

format:
	indent -linux -i8 -nut -l80 src/*.c

install: $(TARGET)
	install $(TARGET) $(INSTALL_PATH)
	cp WMmp.1 $(MANUAL_PATH)

uninstall:
	rm -f $(INSTALL_PATH)/$(TARGET)
	rm -f $(MANUAL_PATH)/WMfd.1

