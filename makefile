# Packaging directory
DESTDIR=
# Prefix directory
PREFIX=/opt/utroff
# Where to place binaries
# and where to find utroff tools
BINDIR=$(PREFIX)/bin
# Where to place manuals
MANDIR=$(PREFIX)/man
# Where to place libraries
LIBDIR=$(PREFIX)/lib
# Where to place refer utilities
REFDIR=$(LIBDIR)/refer

# Install binary
INSTALL = /usr/bin/install
# C compiler
CC=gcc
# compilier flags
CFLAGS=-O
# Compiler warning
WARN=-Wall
# Support for locale specific character 
EUC=-DEUC
# Linker flags
LDFLAGS=
# Additionnal libraries to link with
LIBS=
# C preprocessor flags.
# Use -D_GNU_SOURCE for Linux with GNU libc.
# Use -D_INCLUDE__STDC_A1_SOURCE for HP-UX.
CPPFLAGS=-D_GNU_SOURCE
# Strip
STRIP=strip -s -R .comment -R .note

BIN=refer sortbib
REF=hunt inv mkey
MAN1=hunt.1 inv.1 mkey.1 refer.1 sortbib.1
MAN7=referformat.7

FLAGS= -DREFDIR='"$(REFDIR)"'

HOBJ = hunt1.o hunt2.o hunt3.o hunt5.o hunt6.o hunt7.o glue5.o refer3.o \
	hunt9.o shell.o deliv2.o hunt8.o glue4.o tick.o

IOBJ = inv1.o inv2.o inv3.o inv5.o inv6.o deliv2.o

MOBJ = mkey1.o mkey2.o mkey3.o deliv2.o

ROBJ = glue1.o refer1.o refer2.o refer4.o refer5.o refer6.o mkey3.o \
	refer7.o refer8.o hunt2.o hunt3.o deliv2.o hunt5.o hunt6.o \
	hunt8.o glue3.o hunt7.o hunt9.o glue2.o glue4.o glue5.o refer0.o \
	shell.o

INSTALLEDFILES=$(BIN:%=$(DESTDIR)$(BINDIR)/%) \
	$(REF:%=$(DESTDIR)$(REFDIR)/%) \
	$(MAN1:%=$(DESTDIR)$(MANDIR)/man1/%) \
	$(MAN7:%=$(DESTDIR)$(MANDIR)/man7/%)


SOBJ = sortbib.o

all: $(BIN) $(REF) $(MAN1) $(MAN7)

clean:
	rm -f $(HOBJ) $(IOBJ) $(MOBJ) $(ROBJ) $(SOBJ) $(BIN) $(REF) $(MAN1) $(MAN7)

install: $(INSTALLEDFILES)

uninstall:
	rm -f $(INSTALLEDFILES)

.c.o:
	$(CC) $(CFLAGS) $(WARN) $(FLAGS) $(EUC) $(CPPFLAGS) -c $<

hunt: $(HOBJ)
	$(CC) $(LDFLAGS) $(HOBJ) $(LIBS) -o $@

inv: $(IOBJ)
	$(CC) $(LDFLAGS) $(IOBJ) $(LIBS) -o $@

mkey: $(MOBJ)
	$(CC) $(LDFLAGS) $(MOBJ) $(LIBS) -o $@

refer: $(ROBJ)
	$(CC) $(LDFLAGS) $(ROBJ) $(LIBS) -o $@

sortbib: $(SOBJ)
	$(CC) $(LDFLAGS) $(SOBJ) $(LIBS) -o $@

%.1 %.7: %.man
	sed -e "s|@BINDIR@|$(BINDIR)|g" \
		-e "s|@REFDIR@|$(REFDIR)|g" $< > $@



$(DESTDIR)$(MANDIR)/man1/%: %
	@test -d $(DESTDIR)$(MANDIR)/man1 || mkdir -p $(DESTDIR)$(MANDIR)/man1
	$(INSTALL) -c -m 644 $< $@

$(DESTDIR)$(MANDIR)/man7/%: %
	@test -d  $(DESTDIR)$(MANDIR)/man7 || mkdir -p $(DESTDIR)$(MANDIR)/man7
	$(INSTALL) -c -m 644 $< $@

$(DESTDIR)$(BINDIR)/%: %
	@test -d $(DESTDIR)$(BINDIR) || mkdir -p $(DESTDIR)$(BINDIR)
	$(INSTALL) -c $< $@

$(DESTDIR)$(REFDIR)/%: %
	@test -d $(DESTDIR)$(REFDIR) || mkdir -p $(DESTDIR)$(REFDIR)
	$(INSTALL) -c $< $@


addbib.o: addbib.c
deliv2.o: deliv2.c refer..c
glue1.o: glue1.c refer..c
glue2.o: glue2.c refer..c
glue3.o: glue3.c refer..c
glue4.o: glue4.c refer..c
glue5.o: glue5.c refer..c
hunt1.o: hunt1.c refer..c
hunt2.o: hunt2.c refer..c
hunt3.o: hunt3.c refer..c
hunt5.o: hunt5.c
hunt6.o: hunt6.c refer..c
hunt7.o: hunt7.c refer..c
hunt8.o: hunt8.c refer..c
hunt9.o: hunt9.c
inv1.o: inv1.c refer..c
inv2.o: inv2.c refer..c
inv3.o: inv3.c
inv5.o: inv5.c refer..c
inv6.o: inv6.c refer..c
mkey1.o: mkey1.c refer..c
mkey2.o: mkey2.c refer..c
mkey3.o: mkey3.c refer..c
refer0.o: refer0.c refer..c
refer1.o: refer1.c refer..c
refer2.o: refer2.c refer..c
refer3.o: refer3.c refer..c
refer4.o: refer4.c refer..c
refer5.o: refer5.c refer..c
refer6.o: refer6.c refer..c
refer7.o: refer7.c refer..c
refer8.o: refer8.c refer..c
shell.o: shell.c
sortbib.o: sortbib.c
tick.o: tick.c

