#
# Warning: you may need more libraries than are included here on the
# build line.  The agent frequently needs various libraries in order
# to compile pieces of it, but is OS dependent and we can't list all
# the combinations here.  Instead, look at the libraries that were
# used when linking the snmpd master agent and copy those to this
# file.
#

CC=gcc

OBJS1=snmpapp.o
OBJS2=example-demon.o nstAgentSubagentObject.o
OBJS3=asyncapp.o
OBJS4=snmpproject.c
TARGETS=example-demon snmpapp asyncapp snmpproject

CFLAGS=-I. `net-snmp-config --cflags`
BUILDLIBS=`net-snmp-config --libs`
BUILDAGENTLIBS=`net-snmp-config --agent-libs`

# shared library flags (assumes gcc)
DLFLAGS=-fPIC -shared

all: $(TARGETS)

snmpapp: $(OBJS1)
	$(CC) -o snmpapp $(OBJS1) $(BUILDLIBS)

asyncapp: $(OBJS3)
	$(CC) -o asyncapp $(OBJS3) $(BUILDLIBS)

example-demon: $(OBJS2)
	$(CC) -o example-demon $(OBJS2)  $(BUILDAGENTLIBS)

snmpproject: $(OBJS4)
	$(CC) -o mainSNMP $(OBJS4) $(BUILDLIBS)

clean:
	rm $(OBJS2) $(OBJS2) $(TARGETS)

nstAgentPluginObject.so: nstAgentPluginObject.c Makefile
	$(CC) $(CFLAGS) $(DLFLAGS) -c -o nstAgentPluginObject.o nstAgentPluginObject.c
	$(CC) $(CFLAGS) $(DLFLAGS) -o nstAgentPluginObject.so nstAgentPluginObject.o
