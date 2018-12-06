SRCDIR=src
INCDIR=include
LIBDIRBASE=lib
BINDIRBASE=bin
OBJDIRBASE=obj

TARGET=release

CC=cc

EXEC=prog

SRC=$(notdir $(wildcard **/*.c))


ifeq ($(TARGET),debug)
	CFLAGS=-Wall -g -I$(INCDIR) 
else
	CFLAGS=-Wall -O2 -s -I$(INCDIR)
endif

BINDIR=$(BINDIRBASE)/$(TARGET)
OBJDIR=$(OBJDIRBASE)/$(TARGET)
LIBDIR=$(LIBDIRBASE)/$(TARGET)

OBJS:=$(SRC:.c=.o)


VPATH = $(SRCDIR)


.PHONY : clean all run

all : $(BINDIR)/$(EXEC)


$(BINDIR)/$(EXEC) : $(addprefix $(OBJDIR)/,$(OBJS))
	$(CC) -o $@ $^

$(OBJDIR)/%.o : %.c
	$(CC) -c $^ -o $@ $(CFLAGS)

clean :
	rm -f $(OBJDIR)/* $(BINDIR)/$(EXEC) $(LIBDIR)/*


run :
	$(BINDIR)/$(EXEC)


