#
# fdupes Makefile
#

#####################################################################
# Standand User Configuration Section                               #
#####################################################################

#
# PREFIX indicates the base directory used as the basis for the 
# determination of the actual installation directories.
# Suggested values are "/usr/local", "/usr", "/pkgs/fdupes-$(VERSION)"
#
PREFIX ?= /usr/local

#
# When compiling for 32-bit systems, FILEOFFSET_64BIT must be enabled
# for fdupes to handle files greater than (2<<31)-1 bytes.
#
FILEOFFSET_64BIT = -D_FILE_OFFSET_BITS=64

#
# Certain platforms do not support long options (command line options).
# To disable long options, uncomment the following line.
#
#OMIT_GETOPT_LONG = -DOMIT_GETOPT_LONG

#
# To use the md5sum program for calculating signatures (instead of the
# built in MD5 message digest routines) uncomment the following
# line (try this if you're having trouble with built in code).
#
#EXTERNAL_MD5 = -DEXTERNAL_MD5=\"md5sum\"

#####################################################################
# Developer Configuration Section                                   #
#####################################################################

#
# VERSION determines the program's version number.
#
VERSION = 1.51

#
# PROGRAM_NAME determines the installation name and manual page name
#
PROGRAM_NAME=fdupes

#
# BINDIR indicates directory where program is to be installed. 
# Suggested value is "$(PREFIX)/bin"
#
BINDIR ?= $(PREFIX)/bin

#
# MANDIR indicates directory where the fdupes man page is to be 
# installed. Suggested value is "$(PREFIX)/man/man1"
#
MANDIR ?= $(PREFIX)/man
MAN_EXT = 1
MAN_DIR = $(MANDIR)/man$(MAN_EXT)

#
# MACRODIR indicates directory where the RPM macro is to be installed.
# macro.fdupes becomes only installed if set
#
MACRODIR ?=

#
# Required External Tools
#

INSTALL = install	# install : UCB/GNU Install compatiable
#INSTALL = ginstall

RM      = rm -f

MKDIR   = mkdir -p
#MKDIR   = mkdirhier 
#MKDIR   = mkinstalldirs


#
# Make Configuration
#
CC ?= gcc
FLAGS ?=

COMPILER_OPTIONS = -Wall -O -g $(FLAGS)

CFLAGS = $(COMPILER_OPTIONS) -I. -DVERSION=\"$(VERSION)\" $(EXTERNAL_MD5) $(OMIT_GETOPT_LONG) $(FILEOFFSET_64BIT)

INSTALL_PROGRAM = $(INSTALL) -c -m 0755
INSTALL_DATA    = $(INSTALL) -c -m 0644

#
# ADDITIONAL_OBJECTS - some platforms will need additional object files
# to support features not supplied by their vendor. Eg: GNU getopt()
#
#ADDITIONAL_OBJECTS = getopt.o

OBJECT_FILES = fdupes.o md5/md5.o $(ADDITIONAL_OBJECTS)

#####################################################################
# no need to modify anything beyond this point                      #
#####################################################################

all: fdupes

fdupes: $(OBJECT_FILES)
	$(CC) $(CFLAGS) -o fdupes $(OBJECT_FILES)

install: fdupes
	test -d $(DESTDIR)$(BINDIR) || $(MKDIR) $(DESTDIR)$(BINDIR)
	test -d $(DESTDIR)$(MAN_DIR) || $(MKDIR) $(DESTDIR)$(MAN_DIR)
	$(INSTALL_PROGRAM)	fdupes   $(DESTDIR)$(BINDIR)/$(PROGRAM_NAME)
	$(INSTALL_DATA)		fdupes.1 $(DESTDIR)$(MAN_DIR)/$(PROGRAM_NAME).$(MAN_EXT)
	if [ -n "$(MACRODIR)" ]; then \
	  test -d $(DESTDIR)$(MACRODIR) || $(MKDIR) $(DESTDIR)$(MACRODIR); \
	  $(INSTALL_DATA)	macros.fdupes $(DESTDIR)$(MACRODIR)/macros.fdupes; \
	fi
clean:
	$(RM) $(OBJECT_FILES)
	$(RM) fdupes
	$(RM) *~ md5/*~

love:
	@echo You\'re not my type. Go find a human partner.
