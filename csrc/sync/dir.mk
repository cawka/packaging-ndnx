# sync/dir.mk
# 
# Part of the CCNx distribution.
#
# Copyright (C) 2009, 2011 Palo Alto Research Center, Inc.
#
# This work is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License version 2 as published by the
# Free Software Foundation.
# This work is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.
#

LDLIBS = -L$(CCNLIBDIR) $(MORE_LDLIBS) -lccn
CCNLIBDIR = ../lib
# Override conf.mk or else we don't pick up all the includes
CPREFLAGS = -I../include -I..

INSTALLED_PROGRAMS = 
PROGRAMS = $(INSTALLED_PROGRAMS) SyncTest
DEBRIS = 

BROKEN_PROGRAMS = 
CSRC = IndexSorter.c SyncActions.c SyncBase.c SyncHashCache.c SyncNode.c SyncTest.c SyncRoot.c SyncTreeWorker.c SyncUtil.c
HSRC = IndexSorter.h SyncActions.h SyncBase.h SyncHashCache.h SyncMacros.h SyncPrivate.h SyncNode.h SyncRoot.h SyncTreeWorker.h SyncUtil.h
LIBS = libsync.a
LIB_OBJS = IndexSorter.o SyncActions.o SyncBase.o SyncHashCache.o SyncNode.o SyncRoot.o SyncTreeWorker.o SyncUtil.o
SCRIPTSRC = 
 
default: $(PROGRAMS) $(LIBS)

all: default $(BROKEN_PROGRAMS)

$(PROGRAMS): $(CCNLIBDIR)/libccn.a

lib:	libsync.a

libsync.a:	$(LIB_OBJS)
	ar crus $@ $(LIB_OBJS)

SYNC_OBJ = IndexSorter.o SyncActions.o SyncBase.o SyncHashCache.o SyncNode.o SyncRoot.o SyncTreeWorker.o SyncUtil.o SyncTest.o
SyncTest: $(SYNC_OBJ) Sync_built.sh
	$(CC) $(CFLAGS) -o $@ $(SYNC_OBJ) $(LDLIBS) $(OPENSSL_LIBS) -lcrypto
	sh ./Sync_built.sh

Sync_built.sh:
	touch Sync_built.sh

clean:
	rm -f *.o *.a $(PROGRAMS) $(BROKEN_PROGRAMS) depend
	rm -rf *.dSYM *.gcov *.gcda *.gcno $(DEBRIS)

check test: SyncTest $(SCRIPTSRC)
	@echo No sync tests hooked up yet.
	: ---------------------- :
	:  sync unit tests pass  :
	: ---------------------- :

###############################
# Dependencies below here are checked by depend target
# but must be updated manually.
###############################
IndexSorter.o: IndexSorter.c IndexSorter.h
SyncActions.o: SyncActions.c SyncActions.h SyncBase.h \
  ../include/ccn/ccn.h ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncNode.h SyncRoot.h \
  SyncUtil.h IndexSorter.h SyncPrivate.h SyncTreeWorker.h SyncHashCache.h \
  ../ccnr/ccnr_msg.h ../ccnr/ccnr_private.h ../ccnr/ccnr_sync.h
SyncBase.o: SyncBase.c SyncActions.h SyncBase.h ../include/ccn/ccn.h \
  ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncNode.h SyncRoot.h \
  SyncUtil.h IndexSorter.h SyncPrivate.h ../ccnr/ccnr_msg.h \
  ../ccnr/ccnr_private.h ../ccnr/ccnr_sync.h
SyncHashCache.o: SyncHashCache.c SyncBase.h ../include/ccn/ccn.h \
  ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncHashCache.h SyncUtil.h \
  IndexSorter.h SyncNode.h SyncRoot.h ../ccnr/ccnr_msg.h \
  ../ccnr/ccnr_private.h
SyncNode.o: SyncNode.c SyncNode.h SyncBase.h ../include/ccn/ccn.h \
  ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncUtil.h IndexSorter.h
SyncTest.o: SyncTest.c SyncActions.h SyncBase.h ../include/ccn/ccn.h \
  ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncNode.h SyncRoot.h \
  SyncUtil.h IndexSorter.h SyncHashCache.h SyncPrivate.h SyncTreeWorker.h \
  ../include/ccn/digest.h ../include/ccn/fetch.h ../ccnr/ccnr_sync.h \
  ../ccnr/ccnr_private.h
SyncRoot.o: SyncRoot.c ../include/ccn/ccn.h ../include/ccn/coding.h \
  ../include/ccn/charbuf.h ../include/ccn/indexbuf.h \
  ../include/ccn/digest.h ../include/ccn/schedule.h ../ccnr/ccnr_msg.h \
  ../ccnr/ccnr_private.h ../include/ccn/ccn_private.h \
  ../include/ccn/reg_mgmt.h ../include/ccn/seqwriter.h SyncPrivate.h \
  SyncBase.h ../include/ccn/uri.h ../ccnr/ccnr_private.h SyncMacros.h \
  SyncRoot.h SyncUtil.h IndexSorter.h SyncActions.h SyncNode.h \
  SyncHashCache.h
SyncTreeWorker.o: SyncTreeWorker.c SyncMacros.h SyncNode.h SyncBase.h \
  ../include/ccn/ccn.h ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncTreeWorker.h SyncUtil.h IndexSorter.h \
  SyncHashCache.h
SyncUtil.o: SyncUtil.c SyncBase.h ../include/ccn/ccn.h \
  ../include/ccn/coding.h ../include/ccn/charbuf.h \
  ../include/ccn/indexbuf.h ../include/ccn/schedule.h \
  ../include/ccn/uri.h ../ccnr/ccnr_private.h \
  ../include/ccn/ccn_private.h ../include/ccn/reg_mgmt.h \
  ../include/ccn/seqwriter.h SyncMacros.h SyncActions.h SyncNode.h \
  SyncRoot.h SyncUtil.h IndexSorter.h SyncHashCache.h ../ccnr/ccnr_msg.h \
  ../ccnr/ccnr_private.h ../ccnr/ccnr_sync.h
