#!/usr/bin/env ./tcltestrunner.lua

# 2001 September 15
#
# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.
#
#***********************************************************************
# This file implements regression tests for SQLite library.  The
# focus of this file is testing the sqlite_*_printf() interface.
#
# $Id: printf.test,v 1.31 2009/02/01 00:21:10 drh Exp $

set testdir [file dirname $argv0]
source $testdir/tester.tcl


do_test printf-1.1.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       1 1 1
} {abc: 1 1 1 :xyz}
do_test printf-1.1.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       1 1 1
} {abc: (     1) (     1) (     1) :xyz}
do_test printf-1.1.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       1 1 1
} {abc: (1     ) (1     ) (1     ) :xyz}
do_test printf-1.1.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       1 1 1
} {abc: (    +1) (     1) (     1) :xyz}
do_test printf-1.1.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       1 1 1
} {abc: (000001) (000001) (000001) :xyz}
do_test printf-1.1.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       1 1 1
} {abc: (     1) (     1) (     1) :xyz}
do_test printf-1.1.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       1 1 1
} {abc: (     1) (   0x1) (    01) :xyz}
do_test printf-1.2.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       2 2 2
} {abc: 2 2 2 :xyz}
do_test printf-1.2.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       2 2 2
} {abc: (     2) (     2) (     2) :xyz}
do_test printf-1.2.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       2 2 2
} {abc: (2     ) (2     ) (2     ) :xyz}
do_test printf-1.2.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       2 2 2
} {abc: (    +2) (     2) (     2) :xyz}
do_test printf-1.2.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       2 2 2
} {abc: (000002) (000002) (000002) :xyz}
do_test printf-1.2.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       2 2 2
} {abc: (     2) (     2) (     2) :xyz}
do_test printf-1.2.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       2 2 2
} {abc: (     2) (   0x2) (    02) :xyz}
do_test printf-1.3.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       5 5 5
} {abc: 5 5 5 :xyz}
do_test printf-1.3.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       5 5 5
} {abc: (     5) (     5) (     5) :xyz}
do_test printf-1.3.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       5 5 5
} {abc: (5     ) (5     ) (5     ) :xyz}
do_test printf-1.3.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       5 5 5
} {abc: (    +5) (     5) (     5) :xyz}
do_test printf-1.3.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       5 5 5
} {abc: (000005) (000005) (000005) :xyz}
do_test printf-1.3.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       5 5 5
} {abc: (     5) (     5) (     5) :xyz}
do_test printf-1.3.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       5 5 5
} {abc: (     5) (   0x5) (    05) :xyz}
do_test printf-1.4.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       10 10 10
} {abc: 10 a 12 :xyz}
do_test printf-1.4.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       10 10 10
} {abc: (    10) (     a) (    12) :xyz}
do_test printf-1.4.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       10 10 10
} {abc: (10    ) (a     ) (12    ) :xyz}
do_test printf-1.4.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       10 10 10
} {abc: (   +10) (     a) (    12) :xyz}
do_test printf-1.4.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       10 10 10
} {abc: (000010) (00000a) (000012) :xyz}
do_test printf-1.4.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       10 10 10
} {abc: (    10) (     a) (    12) :xyz}
do_test printf-1.4.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       10 10 10
} {abc: (    10) (   0xa) (   012) :xyz}
do_test printf-1.5.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       99 99 99
} {abc: 99 63 143 :xyz}
do_test printf-1.5.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       99 99 99
} {abc: (    99) (    63) (   143) :xyz}
do_test printf-1.5.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       99 99 99
} {abc: (99    ) (63    ) (143   ) :xyz}
do_test printf-1.5.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       99 99 99
} {abc: (   +99) (    63) (   143) :xyz}
do_test printf-1.5.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       99 99 99
} {abc: (000099) (000063) (000143) :xyz}
do_test printf-1.5.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       99 99 99
} {abc: (    99) (    63) (   143) :xyz}
do_test printf-1.5.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       99 99 99
} {abc: (    99) (  0x63) (  0143) :xyz}
do_test printf-1.6.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       100 100 100
} {abc: 100 64 144 :xyz}
do_test printf-1.6.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       100 100 100
} {abc: (   100) (    64) (   144) :xyz}
do_test printf-1.6.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       100 100 100
} {abc: (100   ) (64    ) (144   ) :xyz}
do_test printf-1.6.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       100 100 100
} {abc: (  +100) (    64) (   144) :xyz}
do_test printf-1.6.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       100 100 100
} {abc: (000100) (000064) (000144) :xyz}
do_test printf-1.6.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       100 100 100
} {abc: (   100) (    64) (   144) :xyz}
do_test printf-1.6.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       100 100 100
} {abc: (   100) (  0x64) (  0144) :xyz}
do_test printf-1.7.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       1000000 1000000 1000000
} {abc: 1000000 f4240 3641100 :xyz}
do_test printf-1.7.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       1000000 1000000 1000000
} {abc: (1000000) ( f4240) (3641100) :xyz}
do_test printf-1.7.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       1000000 1000000 1000000
} {abc: (1000000) (f4240 ) (3641100) :xyz}
do_test printf-1.7.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       1000000 1000000 1000000
} {abc: (+1000000) ( f4240) (3641100) :xyz}
do_test printf-1.7.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       1000000 1000000 1000000
} {abc: (1000000) (0f4240) (3641100) :xyz}
do_test printf-1.7.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       1000000 1000000 1000000
} {abc: ( 1000000) ( f4240) (3641100) :xyz}
do_test printf-1.7.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       1000000 1000000 1000000
} {abc: (1000000) (0xf4240) (03641100) :xyz}
do_test printf-1.8.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       999999999 999999999 999999999
} {abc: 999999999 3b9ac9ff 7346544777 :xyz}
do_test printf-1.8.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       999999999 999999999 999999999
} {abc: (999999999) (3b9ac9ff) (7346544777) :xyz}
do_test printf-1.8.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       999999999 999999999 999999999
} {abc: (999999999) (3b9ac9ff) (7346544777) :xyz}
do_test printf-1.8.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       999999999 999999999 999999999
} {abc: (+999999999) (3b9ac9ff) (7346544777) :xyz}
do_test printf-1.8.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       999999999 999999999 999999999
} {abc: (999999999) (3b9ac9ff) (7346544777) :xyz}
do_test printf-1.8.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       999999999 999999999 999999999
} {abc: ( 999999999) (3b9ac9ff) (7346544777) :xyz}
do_test printf-1.8.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       999999999 999999999 999999999
} {abc: (999999999) (0x3b9ac9ff) (07346544777) :xyz}
do_test printf-1.9.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0 0 0
} {abc: 0 0 0 :xyz}
do_test printf-1.9.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0 0 0
} {abc: (     0) (     0) (     0) :xyz}
do_test printf-1.9.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0 0 0
} {abc: (0     ) (0     ) (0     ) :xyz}
do_test printf-1.9.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0 0 0
} {abc: (    +0) (     0) (     0) :xyz}
do_test printf-1.9.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0 0 0
} {abc: (000000) (000000) (000000) :xyz}
do_test printf-1.9.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0 0 0
} {abc: (     0) (     0) (     0) :xyz}
do_test printf-1.9.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0 0 0
} {abc: (     0) (     0) (     0) :xyz}
# 0xffffffff == -1
do_test printf-1.10.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: -1 ffffffff 37777777777 :xyz}
do_test printf-1.10.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (    -1) (ffffffff) (37777777777) :xyz}
do_test printf-1.10.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (-1    ) (ffffffff) (37777777777) :xyz}
do_test printf-1.10.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (    -1) (ffffffff) (37777777777) :xyz}
do_test printf-1.10.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (-00001) (ffffffff) (37777777777) :xyz}
do_test printf-1.10.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (    -1) (ffffffff) (37777777777) :xyz}
do_test printf-1.10.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xffffffff 0xffffffff 0xffffffff
} {abc: (    -1) (0xffffffff) (037777777777) :xyz}
# 0xfffffffe == -2
do_test printf-1.11.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: -2 fffffffe 37777777776 :xyz}
do_test printf-1.11.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (    -2) (fffffffe) (37777777776) :xyz}
do_test printf-1.11.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (-2    ) (fffffffe) (37777777776) :xyz}
do_test printf-1.11.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (    -2) (fffffffe) (37777777776) :xyz}
do_test printf-1.11.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (-00002) (fffffffe) (37777777776) :xyz}
do_test printf-1.11.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (    -2) (fffffffe) (37777777776) :xyz}
do_test printf-1.11.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xfffffffe 0xfffffffe 0xfffffffe
} {abc: (    -2) (0xfffffffe) (037777777776) :xyz}
# 0xfffffffb == -5
do_test printf-1.12.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: -5 fffffffb 37777777773 :xyz}
do_test printf-1.12.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (    -5) (fffffffb) (37777777773) :xyz}
do_test printf-1.12.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (-5    ) (fffffffb) (37777777773) :xyz}
do_test printf-1.12.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (    -5) (fffffffb) (37777777773) :xyz}
do_test printf-1.12.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (-00005) (fffffffb) (37777777773) :xyz}
do_test printf-1.12.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (    -5) (fffffffb) (37777777773) :xyz}
do_test printf-1.12.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xfffffffb 0xfffffffb 0xfffffffb
} {abc: (    -5) (0xfffffffb) (037777777773) :xyz}
# 0xfffffff6 == -10
do_test printf-1.13.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: -10 fffffff6 37777777766 :xyz}
do_test printf-1.13.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (   -10) (fffffff6) (37777777766) :xyz}
do_test printf-1.13.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (-10   ) (fffffff6) (37777777766) :xyz}
do_test printf-1.13.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (   -10) (fffffff6) (37777777766) :xyz}
do_test printf-1.13.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (-00010) (fffffff6) (37777777766) :xyz}
do_test printf-1.13.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (   -10) (fffffff6) (37777777766) :xyz}
do_test printf-1.13.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xfffffff6 0xfffffff6 0xfffffff6
} {abc: (   -10) (0xfffffff6) (037777777766) :xyz}
# 0xffffff9d == -99
do_test printf-1.14.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: -99 ffffff9d 37777777635 :xyz}
do_test printf-1.14.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (   -99) (ffffff9d) (37777777635) :xyz}
do_test printf-1.14.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (-99   ) (ffffff9d) (37777777635) :xyz}
do_test printf-1.14.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (   -99) (ffffff9d) (37777777635) :xyz}
do_test printf-1.14.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (-00099) (ffffff9d) (37777777635) :xyz}
do_test printf-1.14.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (   -99) (ffffff9d) (37777777635) :xyz}
do_test printf-1.14.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xffffff9d 0xffffff9d 0xffffff9d
} {abc: (   -99) (0xffffff9d) (037777777635) :xyz}
# 0xffffff9c == -100
do_test printf-1.15.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: -100 ffffff9c 37777777634 :xyz}
do_test printf-1.15.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (  -100) (ffffff9c) (37777777634) :xyz}
do_test printf-1.15.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (-100  ) (ffffff9c) (37777777634) :xyz}
do_test printf-1.15.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (  -100) (ffffff9c) (37777777634) :xyz}
do_test printf-1.15.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (-00100) (ffffff9c) (37777777634) :xyz}
do_test printf-1.15.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (  -100) (ffffff9c) (37777777634) :xyz}
do_test printf-1.15.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xffffff9c 0xffffff9c 0xffffff9c
} {abc: (  -100) (0xffffff9c) (037777777634) :xyz}
# 0xff676981 == -9999999
do_test printf-1.16.1 {
  sqlite3_mprintf_int {abc: %d %x %o :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: -9999999 ff676981 37731664601 :xyz}
do_test printf-1.16.2 {
  sqlite3_mprintf_int {abc: (%6d) (%6x) (%6o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (ff676981) (37731664601) :xyz}
do_test printf-1.16.3 {
  sqlite3_mprintf_int {abc: (%-6d) (%-6x) (%-6o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (ff676981) (37731664601) :xyz}
do_test printf-1.16.4 {
  sqlite3_mprintf_int {abc: (%+6d) (%+6x) (%+6o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (ff676981) (37731664601) :xyz}
do_test printf-1.16.5 {
  sqlite3_mprintf_int {abc: (%06d) (%06x) (%06o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (ff676981) (37731664601) :xyz}
do_test printf-1.16.6 {
  sqlite3_mprintf_int {abc: (% 6d) (% 6x) (% 6o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (ff676981) (37731664601) :xyz}
do_test printf-1.16.7 {
  sqlite3_mprintf_int {abc: (%#6d) (%#6x) (%#6o) :xyz}\
       0xff676981 0xff676981 0xff676981
} {abc: (-9999999) (0xff676981) (037731664601) :xyz}
do_test printf-1.17.1 {
  sqlite3_mprintf_int {abd: %2147483647d %2147483647x %2147483647o} 1 1 1
} {}
do_test printf-1.17.2 {
  sqlite3_mprintf_int {abd: %*d %x} 2147483647 1 1
} {}
do_test printf-1.17.3 {
  sqlite3_mprintf_int {abd: %*d %x} -2147483648 1 1
} {abd: 1 1}
do_test printf-1.17.4 {
  sqlite3_mprintf_int {abd: %.2147483648d %x %x} 1 1 1
} {/.*/}
do_test printf-2.1.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 0.001
} {abc: (0.0) :xyz}
do_test printf-2.1.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 0.001
} {abc: (1.0e-03) :xyz}
do_test printf-2.1.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 0.001
} {abc: (0.001) :xyz}
do_test printf-2.1.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 0.001
} {abc: 1 1 (0.001) :xyz}
do_test printf-2.1.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 0.001
} {abc: 1 1 (0.00100000) :xyz}
do_test printf-2.1.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 0.001
} {abc: 1 1 (000000.001) :xyz}
do_test printf-2.1.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 0.001
} {abc: 1 1 (0.0) :xyz}
do_test printf-2.1.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 0.001
} {abc: 1 1 (1.0e-03) :xyz}
do_test printf-2.1.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 0.001
} {abc: 1 1 (0.001) :xyz}
do_test printf-2.1.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 1.0e-20
} {abc: (0.0) :xyz}
do_test printf-2.1.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 1.0e-20
} {abc: (1.0e-20) :xyz}
do_test printf-2.1.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.1.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 1.0e-20
} {abc: 1 1 (1e-20) :xyz}
do_test printf-2.1.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 1.0e-20
} {abc: 1 1 (1.00000e-20) :xyz}
do_test printf-2.1.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 1.0e-20
} {abc: 1 1 (000001e-20) :xyz}
do_test printf-2.1.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 1.0e-20
} {abc: 1 1 (0.0) :xyz}
do_test printf-2.1.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 1.0e-20
} {abc: 1 1 (1.0e-20) :xyz}
do_test printf-2.1.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 1.0e-20
} {abc: 1 1 (1e-20) :xyz}
do_test printf-2.1.2.10 {
  sqlite3_mprintf_double {abc: %*.*f}  2000000000 1000000000 1.0e-20
} {abc: }
do_test printf-2.1.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 1.0
} {abc: (1.0) :xyz}
do_test printf-2.1.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 1.0
} {abc: (1.0e+00) :xyz}
do_test printf-2.1.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 1.0
} {abc: (1) :xyz}
do_test printf-2.1.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 1.0
} {abc: 1 1 (1) :xyz}
do_test printf-2.1.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 1.0
} {abc: 1 1 (1.00000) :xyz}
do_test printf-2.1.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 1.0
} {abc: 1 1 (0000000001) :xyz}
do_test printf-2.1.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 1.0
} {abc: 1 1 (1.0) :xyz}
do_test printf-2.1.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 1.0
} {abc: 1 1 (1.0e+00) :xyz}
do_test printf-2.1.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 1.0
} {abc: 1 1 (1) :xyz}
do_test printf-2.1.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 0.0
} {abc: (0.0) :xyz}
do_test printf-2.1.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 0.0
} {abc: (0.0e+00) :xyz}
do_test printf-2.1.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 0.0
} {abc: (0) :xyz}
do_test printf-2.1.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 0.0
} {abc: 1 1 (0) :xyz}
do_test printf-2.1.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 0.0
} {abc: 1 1 (0.00000) :xyz}
do_test printf-2.1.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 0.0
} {abc: 1 1 (0000000000) :xyz}
do_test printf-2.1.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 0.0
} {abc: 1 1 (0.0) :xyz}
do_test printf-2.1.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 0.0
} {abc: 1 1 (0.0e+00) :xyz}
do_test printf-2.1.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 0.0
} {abc: 1 1 (0) :xyz}
do_test printf-2.1.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 100.0
} {abc: (100.0) :xyz}
do_test printf-2.1.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 100.0
} {abc: (1.0e+02) :xyz}
do_test printf-2.1.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 100.0
} {abc: (1e+02) :xyz}
do_test printf-2.1.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 100.0
} {abc: 1 1 (100) :xyz}
do_test printf-2.1.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 100.0
} {abc: 1 1 (100.000) :xyz}
do_test printf-2.1.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 100.0
} {abc: 1 1 (0000000100) :xyz}
do_test printf-2.1.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 100.0
} {abc: 1 1 (100.0) :xyz}
do_test printf-2.1.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 100.0
} {abc: 1 1 (1.0e+02) :xyz}
do_test printf-2.1.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 100.0
} {abc: 1 1 (1e+02) :xyz}
do_test printf-2.1.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 9.99999
} {abc: (10.0) :xyz}
do_test printf-2.1.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 9.99999
} {abc: (1.0e+01) :xyz}
do_test printf-2.1.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 9.99999
} {abc: (1e+01) :xyz}
do_test printf-2.1.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 9.99999
} {abc: 1 1 (9.99999) :xyz}
do_test printf-2.1.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 9.99999
} {abc: 1 1 (9.99999) :xyz}
do_test printf-2.1.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 9.99999
} {abc: 1 1 (0009.99999) :xyz}
do_test printf-2.1.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 9.99999
} {abc: 1 1 (10.0) :xyz}
do_test printf-2.1.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 9.99999
} {abc: 1 1 (1.0e+01) :xyz}
do_test printf-2.1.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 9.99999
} {abc: 1 1 (1e+01) :xyz}
do_test printf-2.1.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 -0.00543
} {abc: (-0.0) :xyz}
do_test printf-2.1.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 -0.00543
} {abc: (-5.4e-03) :xyz}
do_test printf-2.1.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 -0.00543
} {abc: (-0.005) :xyz}
do_test printf-2.1.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 -0.00543
} {abc: 1 1 (-0.00543) :xyz}
do_test printf-2.1.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 -0.00543
} {abc: 1 1 (-0.00543000) :xyz}
do_test printf-2.1.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 -0.00543
} {abc: 1 1 (-000.00543) :xyz}
do_test printf-2.1.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 -0.00543
} {abc: 1 1 (-0.0) :xyz}
do_test printf-2.1.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 -0.00543
} {abc: 1 1 (-5.4e-03) :xyz}
do_test printf-2.1.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 -0.00543
} {abc: 1 1 (-0.005) :xyz}
do_test printf-2.1.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 -1.0
} {abc: (-1.0) :xyz}
do_test printf-2.1.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 -1.0
} {abc: (-1.0e+00) :xyz}
do_test printf-2.1.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 -1.0
} {abc: (-1) :xyz}
do_test printf-2.1.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 -1.0
} {abc: 1 1 (-1) :xyz}
do_test printf-2.1.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 -1.0
} {abc: 1 1 (-1.00000) :xyz}
do_test printf-2.1.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 -1.0
} {abc: 1 1 (-000000001) :xyz}
do_test printf-2.1.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 -1.0
} {abc: 1 1 (-1.0) :xyz}
do_test printf-2.1.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 -1.0
} {abc: 1 1 (-1.0e+00) :xyz}
do_test printf-2.1.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 -1.0
} {abc: 1 1 (-1) :xyz}
do_test printf-2.1.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 -99.99999
} {abc: (-100.0) :xyz}
do_test printf-2.1.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 -99.99999
} {abc: (-1.0e+02) :xyz}
do_test printf-2.1.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 -99.99999
} {abc: (-1e+02) :xyz}
do_test printf-2.1.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 -99.99999
} {abc: 1 1 (-100) :xyz}
do_test printf-2.1.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 -99.99999
} {abc: 1 1 (-100.000) :xyz}
do_test printf-2.1.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 -99.99999
} {abc: 1 1 (-000000100) :xyz}
do_test printf-2.1.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 -99.99999
} {abc: 1 1 (-100.0) :xyz}
do_test printf-2.1.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 -99.99999
} {abc: 1 1 (-1.0e+02) :xyz}
do_test printf-2.1.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 -99.99999
} {abc: 1 1 (-1e+02) :xyz}
do_test printf-2.1.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 3.14e+9
} {abc: (3140000000.0) :xyz}
do_test printf-2.1.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 3.14e+9
} {abc: (3.1e+09) :xyz}
do_test printf-2.1.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 3.14e+9
} {abc: (3e+09) :xyz}
do_test printf-2.1.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 3.14e+9
} {abc: 1 1 (3.14e+09) :xyz}
do_test printf-2.1.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 3.14e+9
} {abc: 1 1 (3.14000e+09) :xyz}
do_test printf-2.1.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 3.14e+9
} {abc: 1 1 (003.14e+09) :xyz}
do_test printf-2.1.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 3.14e+9
} {abc: 1 1 (3140000000.0) :xyz}
do_test printf-2.1.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 3.14e+9
} {abc: 1 1 (3.1e+09) :xyz}
do_test printf-2.1.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 3.14e+9
} {abc: 1 1 (3e+09) :xyz}
do_test printf-2.1.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 -4.72732e+88
} {abc: (-4.7e+88) :xyz}
do_test printf-2.1.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 -4.72732e+88
} {abc: (-5e+88) :xyz}
do_test printf-2.1.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 -4.72732e+88
} {abc: 1 1 (-4.72732e+88) :xyz}
do_test printf-2.1.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 -4.72732e+88
} {abc: 1 1 (-4.72732e+88) :xyz}
do_test printf-2.1.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 -4.72732e+88
} {abc: 1 1 (-4.72732e+88) :xyz}
do_test printf-2.1.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 -4.72732e+88
} {abc: 1 1 (-4.7e+88) :xyz}
do_test printf-2.1.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 -4.72732e+88
} {abc: 1 1 (-5e+88) :xyz}
do_test printf-2.1.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 9.87991e+143
} {abc: (9.9e+143) :xyz}
do_test printf-2.1.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 9.87991e+143
} {abc: (1e+144) :xyz}
do_test printf-2.1.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 9.87991e+143
} {abc: 1 1 (9.87991e+143) :xyz}
do_test printf-2.1.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 9.87991e+143
} {abc: 1 1 (9.87991e+143) :xyz}
do_test printf-2.1.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 9.87991e+143
} {abc: 1 1 (9.87991e+143) :xyz}
do_test printf-2.1.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 9.87991e+143
} {abc: 1 1 (9.9e+143) :xyz}
do_test printf-2.1.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 9.87991e+143
} {abc: 1 1 (1e+144) :xyz}
do_test printf-2.1.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 -6.287291e-9
} {abc: (-0.0) :xyz}
do_test printf-2.1.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 -6.287291e-9
} {abc: (-6.3e-09) :xyz}
do_test printf-2.1.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 -6.287291e-9
} {abc: (-6e-09) :xyz}
do_test printf-2.1.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-6.28729e-09) :xyz}
do_test printf-2.1.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-6.28729e-09) :xyz}
do_test printf-2.1.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-6.28729e-09) :xyz}
do_test printf-2.1.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-0.0) :xyz}
do_test printf-2.1.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-6.3e-09) :xyz}
do_test printf-2.1.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 -6.287291e-9
} {abc: 1 1 (-6e-09) :xyz}
do_test printf-2.1.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 1 1 3.38826392e-110
} {abc: (0.0) :xyz}
do_test printf-2.1.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 1 1 3.38826392e-110
} {abc: (3.4e-110) :xyz}
do_test printf-2.1.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 1 1 3.38826392e-110
} {abc: (3e-110) :xyz}
do_test printf-2.1.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (3.38826e-110) :xyz}
do_test printf-2.1.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (3.38826e-110) :xyz}
do_test printf-2.1.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (3.38826e-110) :xyz}
do_test printf-2.1.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%1.1f) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (0.0) :xyz}
do_test printf-2.1.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%1.1e) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (3.4e-110) :xyz}
do_test printf-2.1.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%1.1g) :xyz} 1 1 3.38826392e-110
} {abc: 1 1 (3e-110) :xyz}
do_test printf-2.2.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 0.001
} {abc: (0.00100) :xyz}
do_test printf-2.2.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 0.001
} {abc: (1.00000e-03) :xyz}
do_test printf-2.2.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 0.001
} {abc: (0.001) :xyz}
do_test printf-2.2.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 0.001
} {abc: 5 5 (0.001) :xyz}
do_test printf-2.2.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 0.001
} {abc: 5 5 (0.00100000) :xyz}
do_test printf-2.2.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 0.001
} {abc: 5 5 (000000.001) :xyz}
do_test printf-2.2.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 0.001
} {abc: 5 5 (0.00100) :xyz}
do_test printf-2.2.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 0.001
} {abc: 5 5 (1.00000e-03) :xyz}
do_test printf-2.2.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 0.001
} {abc: 5 5 (0.001) :xyz}
do_test printf-2.2.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 1.0e-20
} {abc: (0.00000) :xyz}
do_test printf-2.2.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 1.0e-20
} {abc: (1.00000e-20) :xyz}
do_test printf-2.2.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.2.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 1.0e-20
} {abc: 5 5 (1e-20) :xyz}
do_test printf-2.2.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 1.0e-20
} {abc: 5 5 (1.00000e-20) :xyz}
do_test printf-2.2.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 1.0e-20
} {abc: 5 5 (000001e-20) :xyz}
do_test printf-2.2.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 1.0e-20
} {abc: 5 5 (0.00000) :xyz}
do_test printf-2.2.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 1.0e-20
} {abc: 5 5 (1.00000e-20) :xyz}
do_test printf-2.2.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 1.0e-20
} {abc: 5 5 (1e-20) :xyz}
do_test printf-2.2.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 1.0
} {abc: (1.00000) :xyz}
do_test printf-2.2.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 1.0
} {abc: (1.00000e+00) :xyz}
do_test printf-2.2.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 1.0
} {abc: (    1) :xyz}
do_test printf-2.2.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 1.0
} {abc: 5 5 (1) :xyz}
do_test printf-2.2.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 1.0
} {abc: 5 5 (1.00000) :xyz}
do_test printf-2.2.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 1.0
} {abc: 5 5 (0000000001) :xyz}
do_test printf-2.2.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 1.0
} {abc: 5 5 (1.00000) :xyz}
do_test printf-2.2.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 1.0
} {abc: 5 5 (1.00000e+00) :xyz}
do_test printf-2.2.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 1.0
} {abc: 5 5 (    1) :xyz}
do_test printf-2.2.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 0.0
} {abc: (0.00000) :xyz}
do_test printf-2.2.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 0.0
} {abc: (0.00000e+00) :xyz}
do_test printf-2.2.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 0.0
} {abc: (    0) :xyz}
do_test printf-2.2.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 0.0
} {abc: 5 5 (0) :xyz}
do_test printf-2.2.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 0.0
} {abc: 5 5 (0.00000) :xyz}
do_test printf-2.2.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 0.0
} {abc: 5 5 (0000000000) :xyz}
do_test printf-2.2.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 0.0
} {abc: 5 5 (0.00000) :xyz}
do_test printf-2.2.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 0.0
} {abc: 5 5 (0.00000e+00) :xyz}
do_test printf-2.2.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 0.0
} {abc: 5 5 (    0) :xyz}
do_test printf-2.2.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 100.0
} {abc: (100.00000) :xyz}
do_test printf-2.2.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 100.0
} {abc: (1.00000e+02) :xyz}
do_test printf-2.2.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 100.0
} {abc: (  100) :xyz}
do_test printf-2.2.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 100.0
} {abc: 5 5 (100) :xyz}
do_test printf-2.2.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 100.0
} {abc: 5 5 (100.000) :xyz}
do_test printf-2.2.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 100.0
} {abc: 5 5 (0000000100) :xyz}
do_test printf-2.2.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 100.0
} {abc: 5 5 (100.00000) :xyz}
do_test printf-2.2.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 100.0
} {abc: 5 5 (1.00000e+02) :xyz}
do_test printf-2.2.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 100.0
} {abc: 5 5 (  100) :xyz}
do_test printf-2.2.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 9.99999
} {abc: (9.99999) :xyz}
do_test printf-2.2.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 9.99999
} {abc: (9.99999e+00) :xyz}
do_test printf-2.2.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 9.99999
} {abc: (   10) :xyz}
do_test printf-2.2.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 9.99999
} {abc: 5 5 (9.99999) :xyz}
do_test printf-2.2.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 9.99999
} {abc: 5 5 (9.99999) :xyz}
do_test printf-2.2.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 9.99999
} {abc: 5 5 (0009.99999) :xyz}
do_test printf-2.2.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 9.99999
} {abc: 5 5 (9.99999) :xyz}
do_test printf-2.2.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 9.99999
} {abc: 5 5 (9.99999e+00) :xyz}
do_test printf-2.2.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 9.99999
} {abc: 5 5 (   10) :xyz}
do_test printf-2.2.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 -0.00543
} {abc: (-0.00543) :xyz}
do_test printf-2.2.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 -0.00543
} {abc: (-5.43000e-03) :xyz}
do_test printf-2.2.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 -0.00543
} {abc: (-0.00543) :xyz}
do_test printf-2.2.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 -0.00543
} {abc: 5 5 (-0.00543) :xyz}
do_test printf-2.2.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 -0.00543
} {abc: 5 5 (-0.00543000) :xyz}
do_test printf-2.2.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 -0.00543
} {abc: 5 5 (-000.00543) :xyz}
do_test printf-2.2.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 -0.00543
} {abc: 5 5 (-0.00543) :xyz}
do_test printf-2.2.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 -0.00543
} {abc: 5 5 (-5.43000e-03) :xyz}
do_test printf-2.2.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 -0.00543
} {abc: 5 5 (-0.00543) :xyz}
do_test printf-2.2.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 -1.0
} {abc: (-1.00000) :xyz}
do_test printf-2.2.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 -1.0
} {abc: (-1.00000e+00) :xyz}
do_test printf-2.2.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 -1.0
} {abc: (   -1) :xyz}
do_test printf-2.2.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 -1.0
} {abc: 5 5 (-1) :xyz}
do_test printf-2.2.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 -1.0
} {abc: 5 5 (-1.00000) :xyz}
do_test printf-2.2.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 -1.0
} {abc: 5 5 (-000000001) :xyz}
do_test printf-2.2.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 -1.0
} {abc: 5 5 (-1.00000) :xyz}
do_test printf-2.2.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 -1.0
} {abc: 5 5 (-1.00000e+00) :xyz}
do_test printf-2.2.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 -1.0
} {abc: 5 5 (   -1) :xyz}
do_test printf-2.2.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 -99.99999
} {abc: (-99.99999) :xyz}
do_test printf-2.2.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 -99.99999
} {abc: (-1.00000e+02) :xyz}
do_test printf-2.2.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 -99.99999
} {abc: ( -100) :xyz}
do_test printf-2.2.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 -99.99999
} {abc: 5 5 (-100) :xyz}
do_test printf-2.2.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 -99.99999
} {abc: 5 5 (-100.000) :xyz}
do_test printf-2.2.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 -99.99999
} {abc: 5 5 (-000000100) :xyz}
do_test printf-2.2.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 -99.99999
} {abc: 5 5 (-99.99999) :xyz}
do_test printf-2.2.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 -99.99999
} {abc: 5 5 (-1.00000e+02) :xyz}
do_test printf-2.2.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 -99.99999
} {abc: 5 5 ( -100) :xyz}
do_test printf-2.2.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 3.14e+9
} {abc: (3140000000.00000) :xyz}
do_test printf-2.2.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 3.14e+9
} {abc: (3.14000e+09) :xyz}
do_test printf-2.2.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 3.14e+9
} {abc: (3.14e+09) :xyz}
do_test printf-2.2.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 3.14e+9
} {abc: 5 5 (3.14e+09) :xyz}
do_test printf-2.2.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 3.14e+9
} {abc: 5 5 (3.14000e+09) :xyz}
do_test printf-2.2.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 3.14e+9
} {abc: 5 5 (003.14e+09) :xyz}
do_test printf-2.2.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 3.14e+9
} {abc: 5 5 (3140000000.00000) :xyz}
do_test printf-2.2.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 3.14e+9
} {abc: 5 5 (3.14000e+09) :xyz}
do_test printf-2.2.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 3.14e+9
} {abc: 5 5 (3.14e+09) :xyz}
do_test printf-2.2.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 -4.72732e+88
} {abc: (-4.72732e+88) :xyz}
do_test printf-2.2.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 -4.72732e+88
} {abc: (-4.7273e+88) :xyz}
do_test printf-2.2.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 -4.72732e+88
} {abc: 5 5 (-4.72732e+88) :xyz}
do_test printf-2.2.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 -4.72732e+88
} {abc: 5 5 (-4.72732e+88) :xyz}
do_test printf-2.2.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 -4.72732e+88
} {abc: 5 5 (-4.72732e+88) :xyz}
do_test printf-2.2.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 -4.72732e+88
} {abc: 5 5 (-4.72732e+88) :xyz}
do_test printf-2.2.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 -4.72732e+88
} {abc: 5 5 (-4.7273e+88) :xyz}
do_test printf-2.2.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 9.87991e+143
} {abc: (9.87991e+143) :xyz}
do_test printf-2.2.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 9.87991e+143
} {abc: (9.8799e+143) :xyz}
do_test printf-2.2.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 9.87991e+143
} {abc: 5 5 (9.87991e+143) :xyz}
do_test printf-2.2.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 9.87991e+143
} {abc: 5 5 (9.87991e+143) :xyz}
do_test printf-2.2.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 9.87991e+143
} {abc: 5 5 (9.87991e+143) :xyz}
do_test printf-2.2.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 9.87991e+143
} {abc: 5 5 (9.87991e+143) :xyz}
do_test printf-2.2.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 9.87991e+143
} {abc: 5 5 (9.8799e+143) :xyz}
do_test printf-2.2.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 -6.287291e-9
} {abc: (-0.00000) :xyz}
do_test printf-2.2.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 -6.287291e-9
} {abc: (-6.28729e-09) :xyz}
do_test printf-2.2.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 -6.287291e-9
} {abc: (-6.2873e-09) :xyz}
do_test printf-2.2.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-6.28729e-09) :xyz}
do_test printf-2.2.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-6.28729e-09) :xyz}
do_test printf-2.2.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-6.28729e-09) :xyz}
do_test printf-2.2.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-0.00000) :xyz}
do_test printf-2.2.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-6.28729e-09) :xyz}
do_test printf-2.2.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 -6.287291e-9
} {abc: 5 5 (-6.2873e-09) :xyz}
do_test printf-2.2.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 5 5 3.38826392e-110
} {abc: (0.00000) :xyz}
do_test printf-2.2.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 5 5 3.38826392e-110
} {abc: (3.38826e-110) :xyz}
do_test printf-2.2.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 5 5 3.38826392e-110
} {abc: (3.3883e-110) :xyz}
do_test printf-2.2.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (3.38826e-110) :xyz}
do_test printf-2.2.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (3.38826e-110) :xyz}
do_test printf-2.2.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (3.38826e-110) :xyz}
do_test printf-2.2.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%5.5f) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (0.00000) :xyz}
do_test printf-2.2.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%5.5e) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (3.38826e-110) :xyz}
do_test printf-2.2.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%5.5g) :xyz} 5 5 3.38826392e-110
} {abc: 5 5 (3.3883e-110) :xyz}
do_test printf-2.3.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 0.001
} {abc: (0.0010000000) :xyz}
do_test printf-2.3.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 0.001
} {abc: (1.0000000000e-03) :xyz}
do_test printf-2.3.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 0.001
} {abc: (     0.001) :xyz}
do_test printf-2.3.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 0.001
} {abc: 10 10 (0.001) :xyz}
do_test printf-2.3.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 0.001
} {abc: 10 10 (0.00100000) :xyz}
do_test printf-2.3.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 0.001
} {abc: 10 10 (000000.001) :xyz}
do_test printf-2.3.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 0.001
} {abc: 10 10 (0.0010000000) :xyz}
do_test printf-2.3.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 0.001
} {abc: 10 10 (1.0000000000e-03) :xyz}
do_test printf-2.3.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 0.001
} {abc: 10 10 (     0.001) :xyz}
do_test printf-2.3.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 1.0e-20
} {abc: (0.0000000000) :xyz}
do_test printf-2.3.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 1.0e-20
} {abc: (1.0000000000e-20) :xyz}
do_test printf-2.3.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 1.0e-20
} {abc: (     1e-20) :xyz}
do_test printf-2.3.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 1.0e-20
} {abc: 10 10 (1e-20) :xyz}
do_test printf-2.3.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 1.0e-20
} {abc: 10 10 (1.00000e-20) :xyz}
do_test printf-2.3.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 1.0e-20
} {abc: 10 10 (000001e-20) :xyz}
do_test printf-2.3.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 1.0e-20
} {abc: 10 10 (0.0000000000) :xyz}
do_test printf-2.3.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 1.0e-20
} {abc: 10 10 (1.0000000000e-20) :xyz}
do_test printf-2.3.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 1.0e-20
} {abc: 10 10 (     1e-20) :xyz}
do_test printf-2.3.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 1.0
} {abc: (1.0000000000) :xyz}
do_test printf-2.3.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 1.0
} {abc: (1.0000000000e+00) :xyz}
do_test printf-2.3.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 1.0
} {abc: (         1) :xyz}
do_test printf-2.3.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 1.0
} {abc: 10 10 (1) :xyz}
do_test printf-2.3.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 1.0
} {abc: 10 10 (1.00000) :xyz}
do_test printf-2.3.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 1.0
} {abc: 10 10 (0000000001) :xyz}
do_test printf-2.3.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 1.0
} {abc: 10 10 (1.0000000000) :xyz}
do_test printf-2.3.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 1.0
} {abc: 10 10 (1.0000000000e+00) :xyz}
do_test printf-2.3.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 1.0
} {abc: 10 10 (         1) :xyz}
do_test printf-2.3.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 0.0
} {abc: (0.0000000000) :xyz}
do_test printf-2.3.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 0.0
} {abc: (0.0000000000e+00) :xyz}
do_test printf-2.3.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 0.0
} {abc: (         0) :xyz}
do_test printf-2.3.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 0.0
} {abc: 10 10 (0) :xyz}
do_test printf-2.3.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 0.0
} {abc: 10 10 (0.00000) :xyz}
do_test printf-2.3.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 0.0
} {abc: 10 10 (0000000000) :xyz}
do_test printf-2.3.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 0.0
} {abc: 10 10 (0.0000000000) :xyz}
do_test printf-2.3.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 0.0
} {abc: 10 10 (0.0000000000e+00) :xyz}
do_test printf-2.3.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 0.0
} {abc: 10 10 (         0) :xyz}
do_test printf-2.3.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 100.0
} {abc: (100.0000000000) :xyz}
do_test printf-2.3.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 100.0
} {abc: (1.0000000000e+02) :xyz}
do_test printf-2.3.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 100.0
} {abc: (       100) :xyz}
do_test printf-2.3.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 100.0
} {abc: 10 10 (100) :xyz}
do_test printf-2.3.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 100.0
} {abc: 10 10 (100.000) :xyz}
do_test printf-2.3.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 100.0
} {abc: 10 10 (0000000100) :xyz}
do_test printf-2.3.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 100.0
} {abc: 10 10 (100.0000000000) :xyz}
do_test printf-2.3.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 100.0
} {abc: 10 10 (1.0000000000e+02) :xyz}
do_test printf-2.3.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 100.0
} {abc: 10 10 (       100) :xyz}
do_test printf-2.3.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 9.99999
} {abc: (9.9999900000) :xyz}
do_test printf-2.3.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 9.99999
} {abc: (9.9999900000e+00) :xyz}
do_test printf-2.3.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 9.99999
} {abc: (   9.99999) :xyz}
do_test printf-2.3.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 9.99999
} {abc: 10 10 (9.99999) :xyz}
do_test printf-2.3.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 9.99999
} {abc: 10 10 (9.99999) :xyz}
do_test printf-2.3.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 9.99999
} {abc: 10 10 (0009.99999) :xyz}
do_test printf-2.3.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 9.99999
} {abc: 10 10 (9.9999900000) :xyz}
do_test printf-2.3.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 9.99999
} {abc: 10 10 (9.9999900000e+00) :xyz}
do_test printf-2.3.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 9.99999
} {abc: 10 10 (   9.99999) :xyz}
do_test printf-2.3.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 -0.00543
} {abc: (-0.0054300000) :xyz}
do_test printf-2.3.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 -0.00543
} {abc: (-5.4300000000e-03) :xyz}
do_test printf-2.3.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 -0.00543
} {abc: (  -0.00543) :xyz}
do_test printf-2.3.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 -0.00543
} {abc: 10 10 (-0.00543) :xyz}
do_test printf-2.3.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 -0.00543
} {abc: 10 10 (-0.00543000) :xyz}
do_test printf-2.3.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 -0.00543
} {abc: 10 10 (-000.00543) :xyz}
do_test printf-2.3.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 -0.00543
} {abc: 10 10 (-0.0054300000) :xyz}
do_test printf-2.3.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 -0.00543
} {abc: 10 10 (-5.4300000000e-03) :xyz}
do_test printf-2.3.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 -0.00543
} {abc: 10 10 (  -0.00543) :xyz}
do_test printf-2.3.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 -1.0
} {abc: (-1.0000000000) :xyz}
do_test printf-2.3.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 -1.0
} {abc: (-1.0000000000e+00) :xyz}
do_test printf-2.3.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 -1.0
} {abc: (        -1) :xyz}
do_test printf-2.3.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 -1.0
} {abc: 10 10 (-1) :xyz}
do_test printf-2.3.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 -1.0
} {abc: 10 10 (-1.00000) :xyz}
do_test printf-2.3.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 -1.0
} {abc: 10 10 (-000000001) :xyz}
do_test printf-2.3.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 -1.0
} {abc: 10 10 (-1.0000000000) :xyz}
do_test printf-2.3.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 -1.0
} {abc: 10 10 (-1.0000000000e+00) :xyz}
do_test printf-2.3.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 -1.0
} {abc: 10 10 (        -1) :xyz}
do_test printf-2.3.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 -99.99999
} {abc: (-99.9999900000) :xyz}
do_test printf-2.3.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 -99.99999
} {abc: (-9.9999990000e+01) :xyz}
do_test printf-2.3.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 -99.99999
} {abc: ( -99.99999) :xyz}
do_test printf-2.3.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 -99.99999
} {abc: 10 10 (-100) :xyz}
do_test printf-2.3.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 -99.99999
} {abc: 10 10 (-100.000) :xyz}
do_test printf-2.3.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 -99.99999
} {abc: 10 10 (-000000100) :xyz}
do_test printf-2.3.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 -99.99999
} {abc: 10 10 (-99.9999900000) :xyz}
do_test printf-2.3.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 -99.99999
} {abc: 10 10 (-9.9999990000e+01) :xyz}
do_test printf-2.3.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 -99.99999
} {abc: 10 10 ( -99.99999) :xyz}
do_test printf-2.3.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 3.14e+9
} {abc: (3140000000.0000000000) :xyz}
do_test printf-2.3.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 3.14e+9
} {abc: (3.1400000000e+09) :xyz}
do_test printf-2.3.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 3.14e+9
} {abc: (3140000000) :xyz}
do_test printf-2.3.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 3.14e+9
} {abc: 10 10 (3.14e+09) :xyz}
do_test printf-2.3.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 3.14e+9
} {abc: 10 10 (3.14000e+09) :xyz}
do_test printf-2.3.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 3.14e+9
} {abc: 10 10 (003.14e+09) :xyz}
do_test printf-2.3.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 3.14e+9
} {abc: 10 10 (3140000000.0000000000) :xyz}
do_test printf-2.3.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 3.14e+9
} {abc: 10 10 (3.1400000000e+09) :xyz}
do_test printf-2.3.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 3.14e+9
} {abc: 10 10 (3140000000) :xyz}
do_test printf-2.3.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 -4.72732e+88
} {abc: (-4.7273200000e+88) :xyz}
do_test printf-2.3.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 -4.72732e+88
} {abc: (-4.72732e+88) :xyz}
do_test printf-2.3.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 -4.72732e+88
} {abc: 10 10 (-4.72732e+88) :xyz}
do_test printf-2.3.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 -4.72732e+88
} {abc: 10 10 (-4.72732e+88) :xyz}
do_test printf-2.3.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 -4.72732e+88
} {abc: 10 10 (-4.72732e+88) :xyz}
do_test printf-2.3.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 -4.72732e+88
} {abc: 10 10 (-4.7273200000e+88) :xyz}
do_test printf-2.3.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 -4.72732e+88
} {abc: 10 10 (-4.72732e+88) :xyz}
do_test printf-2.3.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 9.87991e+143
} {abc: (9.8799100000e+143) :xyz}
do_test printf-2.3.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 9.87991e+143
} {abc: (9.87991e+143) :xyz}
do_test printf-2.3.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 9.87991e+143
} {abc: 10 10 (9.87991e+143) :xyz}
do_test printf-2.3.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 9.87991e+143
} {abc: 10 10 (9.87991e+143) :xyz}
do_test printf-2.3.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 9.87991e+143
} {abc: 10 10 (9.87991e+143) :xyz}
do_test printf-2.3.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 9.87991e+143
} {abc: 10 10 (9.8799100000e+143) :xyz}
do_test printf-2.3.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 9.87991e+143
} {abc: 10 10 (9.87991e+143) :xyz}
do_test printf-2.3.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 -6.287291e-9
} {abc: (-0.0000000063) :xyz}
do_test printf-2.3.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 -6.287291e-9
} {abc: (-6.2872910000e-09) :xyz}
do_test printf-2.3.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 -6.287291e-9
} {abc: (-6.287291e-09) :xyz}
do_test printf-2.3.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-6.28729e-09) :xyz}
do_test printf-2.3.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-6.28729e-09) :xyz}
do_test printf-2.3.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-6.28729e-09) :xyz}
do_test printf-2.3.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-0.0000000063) :xyz}
do_test printf-2.3.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-6.2872910000e-09) :xyz}
do_test printf-2.3.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 -6.287291e-9
} {abc: 10 10 (-6.287291e-09) :xyz}
do_test printf-2.3.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 10 3.38826392e-110
} {abc: (0.0000000000) :xyz}
do_test printf-2.3.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 10 3.38826392e-110
} {abc: (3.3882639200e-110) :xyz}
do_test printf-2.3.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 10 3.38826392e-110
} {abc: (3.38826392e-110) :xyz}
do_test printf-2.3.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (3.38826e-110) :xyz}
do_test printf-2.3.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (3.38826e-110) :xyz}
do_test printf-2.3.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (3.38826e-110) :xyz}
do_test printf-2.3.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.10f) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (0.0000000000) :xyz}
do_test printf-2.3.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.10e) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (3.3882639200e-110) :xyz}
do_test printf-2.3.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.10g) :xyz} 10 10 3.38826392e-110
} {abc: 10 10 (3.38826392e-110) :xyz}
do_test printf-2.4.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 0.001
} {abc: (   0.00100) :xyz}
do_test printf-2.4.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 0.001
} {abc: (1.00000e-03) :xyz}
do_test printf-2.4.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 0.001
} {abc: (     0.001) :xyz}
do_test printf-2.4.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 0.001
} {abc: 10 5 (0.001) :xyz}
do_test printf-2.4.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 0.001
} {abc: 10 5 (0.00100000) :xyz}
do_test printf-2.4.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 0.001
} {abc: 10 5 (000000.001) :xyz}
do_test printf-2.4.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 0.001
} {abc: 10 5 (   0.00100) :xyz}
do_test printf-2.4.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 0.001
} {abc: 10 5 (1.00000e-03) :xyz}
do_test printf-2.4.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 0.001
} {abc: 10 5 (     0.001) :xyz}
do_test printf-2.4.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 1.0e-20
} {abc: (   0.00000) :xyz}
do_test printf-2.4.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 1.0e-20
} {abc: (1.00000e-20) :xyz}
do_test printf-2.4.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 1.0e-20
} {abc: (     1e-20) :xyz}
do_test printf-2.4.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 1.0e-20
} {abc: 10 5 (1e-20) :xyz}
do_test printf-2.4.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 1.0e-20
} {abc: 10 5 (1.00000e-20) :xyz}
do_test printf-2.4.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 1.0e-20
} {abc: 10 5 (000001e-20) :xyz}
do_test printf-2.4.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 1.0e-20
} {abc: 10 5 (   0.00000) :xyz}
do_test printf-2.4.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 1.0e-20
} {abc: 10 5 (1.00000e-20) :xyz}
do_test printf-2.4.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 1.0e-20
} {abc: 10 5 (     1e-20) :xyz}
do_test printf-2.4.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 1.0
} {abc: (   1.00000) :xyz}
do_test printf-2.4.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 1.0
} {abc: (1.00000e+00) :xyz}
do_test printf-2.4.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 1.0
} {abc: (         1) :xyz}
do_test printf-2.4.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 1.0
} {abc: 10 5 (1) :xyz}
do_test printf-2.4.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 1.0
} {abc: 10 5 (1.00000) :xyz}
do_test printf-2.4.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 1.0
} {abc: 10 5 (0000000001) :xyz}
do_test printf-2.4.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 1.0
} {abc: 10 5 (   1.00000) :xyz}
do_test printf-2.4.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 1.0
} {abc: 10 5 (1.00000e+00) :xyz}
do_test printf-2.4.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 1.0
} {abc: 10 5 (         1) :xyz}
do_test printf-2.4.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 0.0
} {abc: (   0.00000) :xyz}
do_test printf-2.4.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 0.0
} {abc: (0.00000e+00) :xyz}
do_test printf-2.4.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 0.0
} {abc: (         0) :xyz}
do_test printf-2.4.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 0.0
} {abc: 10 5 (0) :xyz}
do_test printf-2.4.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 0.0
} {abc: 10 5 (0.00000) :xyz}
do_test printf-2.4.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 0.0
} {abc: 10 5 (0000000000) :xyz}
do_test printf-2.4.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 0.0
} {abc: 10 5 (   0.00000) :xyz}
do_test printf-2.4.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 0.0
} {abc: 10 5 (0.00000e+00) :xyz}
do_test printf-2.4.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 0.0
} {abc: 10 5 (         0) :xyz}
do_test printf-2.4.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 100.0
} {abc: ( 100.00000) :xyz}
do_test printf-2.4.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 100.0
} {abc: (1.00000e+02) :xyz}
do_test printf-2.4.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 100.0
} {abc: (       100) :xyz}
do_test printf-2.4.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 100.0
} {abc: 10 5 (100) :xyz}
do_test printf-2.4.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 100.0
} {abc: 10 5 (100.000) :xyz}
do_test printf-2.4.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 100.0
} {abc: 10 5 (0000000100) :xyz}
do_test printf-2.4.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 100.0
} {abc: 10 5 ( 100.00000) :xyz}
do_test printf-2.4.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 100.0
} {abc: 10 5 (1.00000e+02) :xyz}
do_test printf-2.4.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 100.0
} {abc: 10 5 (       100) :xyz}
do_test printf-2.4.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 9.99999
} {abc: (   9.99999) :xyz}
do_test printf-2.4.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 9.99999
} {abc: (9.99999e+00) :xyz}
do_test printf-2.4.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 9.99999
} {abc: (        10) :xyz}
do_test printf-2.4.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 9.99999
} {abc: 10 5 (9.99999) :xyz}
do_test printf-2.4.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 9.99999
} {abc: 10 5 (9.99999) :xyz}
do_test printf-2.4.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 9.99999
} {abc: 10 5 (0009.99999) :xyz}
do_test printf-2.4.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 9.99999
} {abc: 10 5 (   9.99999) :xyz}
do_test printf-2.4.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 9.99999
} {abc: 10 5 (9.99999e+00) :xyz}
do_test printf-2.4.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 9.99999
} {abc: 10 5 (        10) :xyz}
do_test printf-2.4.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 -0.00543
} {abc: (  -0.00543) :xyz}
do_test printf-2.4.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 -0.00543
} {abc: (-5.43000e-03) :xyz}
do_test printf-2.4.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 -0.00543
} {abc: (  -0.00543) :xyz}
do_test printf-2.4.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 -0.00543
} {abc: 10 5 (-0.00543) :xyz}
do_test printf-2.4.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 -0.00543
} {abc: 10 5 (-0.00543000) :xyz}
do_test printf-2.4.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 -0.00543
} {abc: 10 5 (-000.00543) :xyz}
do_test printf-2.4.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 -0.00543
} {abc: 10 5 (  -0.00543) :xyz}
do_test printf-2.4.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 -0.00543
} {abc: 10 5 (-5.43000e-03) :xyz}
do_test printf-2.4.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 -0.00543
} {abc: 10 5 (  -0.00543) :xyz}
do_test printf-2.4.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 -1.0
} {abc: (  -1.00000) :xyz}
do_test printf-2.4.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 -1.0
} {abc: (-1.00000e+00) :xyz}
do_test printf-2.4.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 -1.0
} {abc: (        -1) :xyz}
do_test printf-2.4.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 -1.0
} {abc: 10 5 (-1) :xyz}
do_test printf-2.4.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 -1.0
} {abc: 10 5 (-1.00000) :xyz}
do_test printf-2.4.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 -1.0
} {abc: 10 5 (-000000001) :xyz}
do_test printf-2.4.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 -1.0
} {abc: 10 5 (  -1.00000) :xyz}
do_test printf-2.4.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 -1.0
} {abc: 10 5 (-1.00000e+00) :xyz}
do_test printf-2.4.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 -1.0
} {abc: 10 5 (        -1) :xyz}
do_test printf-2.4.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 -99.99999
} {abc: ( -99.99999) :xyz}
do_test printf-2.4.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 -99.99999
} {abc: (-1.00000e+02) :xyz}
do_test printf-2.4.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 -99.99999
} {abc: (      -100) :xyz}
do_test printf-2.4.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 -99.99999
} {abc: 10 5 (-100) :xyz}
do_test printf-2.4.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 -99.99999
} {abc: 10 5 (-100.000) :xyz}
do_test printf-2.4.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 -99.99999
} {abc: 10 5 (-000000100) :xyz}
do_test printf-2.4.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 -99.99999
} {abc: 10 5 ( -99.99999) :xyz}
do_test printf-2.4.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 -99.99999
} {abc: 10 5 (-1.00000e+02) :xyz}
do_test printf-2.4.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 -99.99999
} {abc: 10 5 (      -100) :xyz}
do_test printf-2.4.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 3.14e+9
} {abc: (3140000000.00000) :xyz}
do_test printf-2.4.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 3.14e+9
} {abc: (3.14000e+09) :xyz}
do_test printf-2.4.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 3.14e+9
} {abc: (  3.14e+09) :xyz}
do_test printf-2.4.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 3.14e+9
} {abc: 10 5 (3.14e+09) :xyz}
do_test printf-2.4.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 3.14e+9
} {abc: 10 5 (3.14000e+09) :xyz}
do_test printf-2.4.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 3.14e+9
} {abc: 10 5 (003.14e+09) :xyz}
do_test printf-2.4.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 3.14e+9
} {abc: 10 5 (3140000000.00000) :xyz}
do_test printf-2.4.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 3.14e+9
} {abc: 10 5 (3.14000e+09) :xyz}
do_test printf-2.4.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 3.14e+9
} {abc: 10 5 (  3.14e+09) :xyz}
do_test printf-2.4.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 -4.72732e+88
} {abc: (-4.72732e+88) :xyz}
do_test printf-2.4.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 -4.72732e+88
} {abc: (-4.7273e+88) :xyz}
do_test printf-2.4.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 -4.72732e+88
} {abc: 10 5 (-4.72732e+88) :xyz}
do_test printf-2.4.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 -4.72732e+88
} {abc: 10 5 (-4.72732e+88) :xyz}
do_test printf-2.4.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 -4.72732e+88
} {abc: 10 5 (-4.72732e+88) :xyz}
do_test printf-2.4.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 -4.72732e+88
} {abc: 10 5 (-4.72732e+88) :xyz}
do_test printf-2.4.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 -4.72732e+88
} {abc: 10 5 (-4.7273e+88) :xyz}
do_test printf-2.4.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 9.87991e+143
} {abc: (9.87991e+143) :xyz}
do_test printf-2.4.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 9.87991e+143
} {abc: (9.8799e+143) :xyz}
do_test printf-2.4.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 9.87991e+143
} {abc: 10 5 (9.87991e+143) :xyz}
do_test printf-2.4.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 9.87991e+143
} {abc: 10 5 (9.87991e+143) :xyz}
do_test printf-2.4.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 9.87991e+143
} {abc: 10 5 (9.87991e+143) :xyz}
do_test printf-2.4.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 9.87991e+143
} {abc: 10 5 (9.87991e+143) :xyz}
do_test printf-2.4.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 9.87991e+143
} {abc: 10 5 (9.8799e+143) :xyz}
do_test printf-2.4.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 -6.287291e-9
} {abc: (  -0.00000) :xyz}
do_test printf-2.4.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 -6.287291e-9
} {abc: (-6.28729e-09) :xyz}
do_test printf-2.4.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 -6.287291e-9
} {abc: (-6.2873e-09) :xyz}
do_test printf-2.4.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (-6.28729e-09) :xyz}
do_test printf-2.4.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (-6.28729e-09) :xyz}
do_test printf-2.4.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (-6.28729e-09) :xyz}
do_test printf-2.4.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (  -0.00000) :xyz}
do_test printf-2.4.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (-6.28729e-09) :xyz}
do_test printf-2.4.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 -6.287291e-9
} {abc: 10 5 (-6.2873e-09) :xyz}
do_test printf-2.4.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 10 5 3.38826392e-110
} {abc: (   0.00000) :xyz}
do_test printf-2.4.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 10 5 3.38826392e-110
} {abc: (3.38826e-110) :xyz}
do_test printf-2.4.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 10 5 3.38826392e-110
} {abc: (3.3883e-110) :xyz}
do_test printf-2.4.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (3.38826e-110) :xyz}
do_test printf-2.4.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (3.38826e-110) :xyz}
do_test printf-2.4.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (3.38826e-110) :xyz}
do_test printf-2.4.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%10.5f) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (   0.00000) :xyz}
do_test printf-2.4.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%10.5e) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (3.38826e-110) :xyz}
do_test printf-2.4.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%10.5g) :xyz} 10 5 3.38826392e-110
} {abc: 10 5 (3.3883e-110) :xyz}
do_test printf-2.5.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 0.001
} {abc: (0.00) :xyz}
do_test printf-2.5.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 0.001
} {abc: (1.00e-03) :xyz}
do_test printf-2.5.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 0.001
} {abc: (0.001) :xyz}
do_test printf-2.5.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 0.001
} {abc: 2 2 (0.001) :xyz}
do_test printf-2.5.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 0.001
} {abc: 2 2 (0.00100000) :xyz}
do_test printf-2.5.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 0.001
} {abc: 2 2 (000000.001) :xyz}
do_test printf-2.5.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 0.001
} {abc: 2 2 (0.00) :xyz}
do_test printf-2.5.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 0.001
} {abc: 2 2 (1.00e-03) :xyz}
do_test printf-2.5.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 0.001
} {abc: 2 2 (0.001) :xyz}
do_test printf-2.5.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 1.0e-20
} {abc: (0.00) :xyz}
do_test printf-2.5.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 1.0e-20
} {abc: (1.00e-20) :xyz}
do_test printf-2.5.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.5.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 1.0e-20
} {abc: 2 2 (1e-20) :xyz}
do_test printf-2.5.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 1.0e-20
} {abc: 2 2 (1.00000e-20) :xyz}
do_test printf-2.5.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 1.0e-20
} {abc: 2 2 (000001e-20) :xyz}
do_test printf-2.5.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 1.0e-20
} {abc: 2 2 (0.00) :xyz}
do_test printf-2.5.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 1.0e-20
} {abc: 2 2 (1.00e-20) :xyz}
do_test printf-2.5.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 1.0e-20
} {abc: 2 2 (1e-20) :xyz}
do_test printf-2.5.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 1.0
} {abc: (1.00) :xyz}
do_test printf-2.5.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 1.0
} {abc: (1.00e+00) :xyz}
do_test printf-2.5.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 1.0
} {abc: ( 1) :xyz}
do_test printf-2.5.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 1.0
} {abc: 2 2 (1) :xyz}
do_test printf-2.5.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 1.0
} {abc: 2 2 (1.00000) :xyz}
do_test printf-2.5.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 1.0
} {abc: 2 2 (0000000001) :xyz}
do_test printf-2.5.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 1.0
} {abc: 2 2 (1.00) :xyz}
do_test printf-2.5.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 1.0
} {abc: 2 2 (1.00e+00) :xyz}
do_test printf-2.5.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 1.0
} {abc: 2 2 ( 1) :xyz}
do_test printf-2.5.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 0.0
} {abc: (0.00) :xyz}
do_test printf-2.5.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 0.0
} {abc: (0.00e+00) :xyz}
do_test printf-2.5.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 0.0
} {abc: ( 0) :xyz}
do_test printf-2.5.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 0.0
} {abc: 2 2 (0) :xyz}
do_test printf-2.5.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 0.0
} {abc: 2 2 (0.00000) :xyz}
do_test printf-2.5.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 0.0
} {abc: 2 2 (0000000000) :xyz}
do_test printf-2.5.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 0.0
} {abc: 2 2 (0.00) :xyz}
do_test printf-2.5.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 0.0
} {abc: 2 2 (0.00e+00) :xyz}
do_test printf-2.5.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 0.0
} {abc: 2 2 ( 0) :xyz}
do_test printf-2.5.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 100.0
} {abc: (100.00) :xyz}
do_test printf-2.5.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 100.0
} {abc: (1.00e+02) :xyz}
do_test printf-2.5.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 100.0
} {abc: (1e+02) :xyz}
do_test printf-2.5.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 100.0
} {abc: 2 2 (100) :xyz}
do_test printf-2.5.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 100.0
} {abc: 2 2 (100.000) :xyz}
do_test printf-2.5.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 100.0
} {abc: 2 2 (0000000100) :xyz}
do_test printf-2.5.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 100.0
} {abc: 2 2 (100.00) :xyz}
do_test printf-2.5.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 100.0
} {abc: 2 2 (1.00e+02) :xyz}
do_test printf-2.5.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 100.0
} {abc: 2 2 (1e+02) :xyz}
do_test printf-2.5.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 9.99999
} {abc: (10.00) :xyz}
do_test printf-2.5.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 9.99999
} {abc: (1.00e+01) :xyz}
do_test printf-2.5.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 9.99999
} {abc: (10) :xyz}
do_test printf-2.5.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 9.99999
} {abc: 2 2 (9.99999) :xyz}
do_test printf-2.5.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 9.99999
} {abc: 2 2 (9.99999) :xyz}
do_test printf-2.5.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 9.99999
} {abc: 2 2 (0009.99999) :xyz}
do_test printf-2.5.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 9.99999
} {abc: 2 2 (10.00) :xyz}
do_test printf-2.5.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 9.99999
} {abc: 2 2 (1.00e+01) :xyz}
do_test printf-2.5.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 9.99999
} {abc: 2 2 (10) :xyz}
do_test printf-2.5.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 -0.00543
} {abc: (-0.01) :xyz}
do_test printf-2.5.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 -0.00543
} {abc: (-5.43e-03) :xyz}
do_test printf-2.5.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 -0.00543
} {abc: (-0.0054) :xyz}
do_test printf-2.5.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 -0.00543
} {abc: 2 2 (-0.00543) :xyz}
do_test printf-2.5.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 -0.00543
} {abc: 2 2 (-0.00543000) :xyz}
do_test printf-2.5.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 -0.00543
} {abc: 2 2 (-000.00543) :xyz}
do_test printf-2.5.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 -0.00543
} {abc: 2 2 (-0.01) :xyz}
do_test printf-2.5.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 -0.00543
} {abc: 2 2 (-5.43e-03) :xyz}
do_test printf-2.5.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 -0.00543
} {abc: 2 2 (-0.0054) :xyz}
do_test printf-2.5.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 -1.0
} {abc: (-1.00) :xyz}
do_test printf-2.5.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 -1.0
} {abc: (-1.00e+00) :xyz}
do_test printf-2.5.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 -1.0
} {abc: (-1) :xyz}
do_test printf-2.5.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 -1.0
} {abc: 2 2 (-1) :xyz}
do_test printf-2.5.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 -1.0
} {abc: 2 2 (-1.00000) :xyz}
do_test printf-2.5.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 -1.0
} {abc: 2 2 (-000000001) :xyz}
do_test printf-2.5.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 -1.0
} {abc: 2 2 (-1.00) :xyz}
do_test printf-2.5.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 -1.0
} {abc: 2 2 (-1.00e+00) :xyz}
do_test printf-2.5.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 -1.0
} {abc: 2 2 (-1) :xyz}
do_test printf-2.5.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 -99.99999
} {abc: (-100.00) :xyz}
do_test printf-2.5.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 -99.99999
} {abc: (-1.00e+02) :xyz}
do_test printf-2.5.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 -99.99999
} {abc: (-1e+02) :xyz}
do_test printf-2.5.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 -99.99999
} {abc: 2 2 (-100) :xyz}
do_test printf-2.5.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 -99.99999
} {abc: 2 2 (-100.000) :xyz}
do_test printf-2.5.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 -99.99999
} {abc: 2 2 (-000000100) :xyz}
do_test printf-2.5.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 -99.99999
} {abc: 2 2 (-100.00) :xyz}
do_test printf-2.5.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 -99.99999
} {abc: 2 2 (-1.00e+02) :xyz}
do_test printf-2.5.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 -99.99999
} {abc: 2 2 (-1e+02) :xyz}
do_test printf-2.5.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 3.14e+9
} {abc: (3140000000.00) :xyz}
do_test printf-2.5.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 3.14e+9
} {abc: (3.14e+09) :xyz}
do_test printf-2.5.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 3.14e+9
} {abc: (3.1e+09) :xyz}
do_test printf-2.5.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 3.14e+9
} {abc: 2 2 (3.14e+09) :xyz}
do_test printf-2.5.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 3.14e+9
} {abc: 2 2 (3.14000e+09) :xyz}
do_test printf-2.5.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 3.14e+9
} {abc: 2 2 (003.14e+09) :xyz}
do_test printf-2.5.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 3.14e+9
} {abc: 2 2 (3140000000.00) :xyz}
do_test printf-2.5.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 3.14e+9
} {abc: 2 2 (3.14e+09) :xyz}
do_test printf-2.5.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 3.14e+9
} {abc: 2 2 (3.1e+09) :xyz}
do_test printf-2.5.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 -4.72732e+88
} {abc: (-4.73e+88) :xyz}
do_test printf-2.5.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 -4.72732e+88
} {abc: (-4.7e+88) :xyz}
do_test printf-2.5.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 -4.72732e+88
} {abc: 2 2 (-4.72732e+88) :xyz}
do_test printf-2.5.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 -4.72732e+88
} {abc: 2 2 (-4.72732e+88) :xyz}
do_test printf-2.5.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 -4.72732e+88
} {abc: 2 2 (-4.72732e+88) :xyz}
do_test printf-2.5.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 -4.72732e+88
} {abc: 2 2 (-4.73e+88) :xyz}
do_test printf-2.5.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 -4.72732e+88
} {abc: 2 2 (-4.7e+88) :xyz}
do_test printf-2.5.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 9.87991e+143
} {abc: (9.88e+143) :xyz}
do_test printf-2.5.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 9.87991e+143
} {abc: (9.9e+143) :xyz}
do_test printf-2.5.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 9.87991e+143
} {abc: 2 2 (9.87991e+143) :xyz}
do_test printf-2.5.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 9.87991e+143
} {abc: 2 2 (9.87991e+143) :xyz}
do_test printf-2.5.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 9.87991e+143
} {abc: 2 2 (9.87991e+143) :xyz}
do_test printf-2.5.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 9.87991e+143
} {abc: 2 2 (9.88e+143) :xyz}
do_test printf-2.5.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 9.87991e+143
} {abc: 2 2 (9.9e+143) :xyz}
do_test printf-2.5.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 -6.287291e-9
} {abc: (-0.00) :xyz}
do_test printf-2.5.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 -6.287291e-9
} {abc: (-6.29e-09) :xyz}
do_test printf-2.5.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 -6.287291e-9
} {abc: (-6.3e-09) :xyz}
do_test printf-2.5.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-6.28729e-09) :xyz}
do_test printf-2.5.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-6.28729e-09) :xyz}
do_test printf-2.5.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-6.28729e-09) :xyz}
do_test printf-2.5.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-0.00) :xyz}
do_test printf-2.5.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-6.29e-09) :xyz}
do_test printf-2.5.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 -6.287291e-9
} {abc: 2 2 (-6.3e-09) :xyz}
do_test printf-2.5.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 2 3.38826392e-110
} {abc: (0.00) :xyz}
do_test printf-2.5.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 2 3.38826392e-110
} {abc: (3.39e-110) :xyz}
do_test printf-2.5.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 2 3.38826392e-110
} {abc: (3.4e-110) :xyz}
do_test printf-2.5.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (3.38826e-110) :xyz}
do_test printf-2.5.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (3.38826e-110) :xyz}
do_test printf-2.5.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (3.38826e-110) :xyz}
do_test printf-2.5.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.2f) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (0.00) :xyz}
do_test printf-2.5.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.2e) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (3.39e-110) :xyz}
do_test printf-2.5.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.2g) :xyz} 2 2 3.38826392e-110
} {abc: 2 2 (3.4e-110) :xyz}
do_test printf-2.6.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 0.001
} {abc: (0.001) :xyz}
do_test printf-2.6.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 0.001
} {abc: (1.000e-03) :xyz}
do_test printf-2.6.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 0.001
} {abc: (0.001) :xyz}
do_test printf-2.6.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 0.001
} {abc: 2 3 (0.001) :xyz}
do_test printf-2.6.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 0.001
} {abc: 2 3 (0.00100000) :xyz}
do_test printf-2.6.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 0.001
} {abc: 2 3 (000000.001) :xyz}
do_test printf-2.6.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 0.001
} {abc: 2 3 (0.001) :xyz}
do_test printf-2.6.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 0.001
} {abc: 2 3 (1.000e-03) :xyz}
do_test printf-2.6.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 0.001
} {abc: 2 3 (0.001) :xyz}
do_test printf-2.6.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 1.0e-20
} {abc: (0.000) :xyz}
do_test printf-2.6.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 1.0e-20
} {abc: (1.000e-20) :xyz}
do_test printf-2.6.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.6.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 1.0e-20
} {abc: 2 3 (1e-20) :xyz}
do_test printf-2.6.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 1.0e-20
} {abc: 2 3 (1.00000e-20) :xyz}
do_test printf-2.6.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 1.0e-20
} {abc: 2 3 (000001e-20) :xyz}
do_test printf-2.6.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 1.0e-20
} {abc: 2 3 (0.000) :xyz}
do_test printf-2.6.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 1.0e-20
} {abc: 2 3 (1.000e-20) :xyz}
do_test printf-2.6.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 1.0e-20
} {abc: 2 3 (1e-20) :xyz}
do_test printf-2.6.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 1.0
} {abc: (1.000) :xyz}
do_test printf-2.6.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 1.0
} {abc: (1.000e+00) :xyz}
do_test printf-2.6.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 1.0
} {abc: ( 1) :xyz}
do_test printf-2.6.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 1.0
} {abc: 2 3 (1) :xyz}
do_test printf-2.6.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 1.0
} {abc: 2 3 (1.00000) :xyz}
do_test printf-2.6.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 1.0
} {abc: 2 3 (0000000001) :xyz}
do_test printf-2.6.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 1.0
} {abc: 2 3 (1.000) :xyz}
do_test printf-2.6.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 1.0
} {abc: 2 3 (1.000e+00) :xyz}
do_test printf-2.6.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 1.0
} {abc: 2 3 ( 1) :xyz}
do_test printf-2.6.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 0.0
} {abc: (0.000) :xyz}
do_test printf-2.6.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 0.0
} {abc: (0.000e+00) :xyz}
do_test printf-2.6.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 0.0
} {abc: ( 0) :xyz}
do_test printf-2.6.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 0.0
} {abc: 2 3 (0) :xyz}
do_test printf-2.6.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 0.0
} {abc: 2 3 (0.00000) :xyz}
do_test printf-2.6.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 0.0
} {abc: 2 3 (0000000000) :xyz}
do_test printf-2.6.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 0.0
} {abc: 2 3 (0.000) :xyz}
do_test printf-2.6.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 0.0
} {abc: 2 3 (0.000e+00) :xyz}
do_test printf-2.6.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 0.0
} {abc: 2 3 ( 0) :xyz}
do_test printf-2.6.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 100.0
} {abc: (100.000) :xyz}
do_test printf-2.6.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 100.0
} {abc: (1.000e+02) :xyz}
do_test printf-2.6.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 100.0
} {abc: (100) :xyz}
do_test printf-2.6.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 100.0
} {abc: 2 3 (100) :xyz}
do_test printf-2.6.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 100.0
} {abc: 2 3 (100.000) :xyz}
do_test printf-2.6.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 100.0
} {abc: 2 3 (0000000100) :xyz}
do_test printf-2.6.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 100.0
} {abc: 2 3 (100.000) :xyz}
do_test printf-2.6.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 100.0
} {abc: 2 3 (1.000e+02) :xyz}
do_test printf-2.6.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 100.0
} {abc: 2 3 (100) :xyz}
do_test printf-2.6.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 9.99999
} {abc: (10.000) :xyz}
do_test printf-2.6.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 9.99999
} {abc: (1.000e+01) :xyz}
do_test printf-2.6.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 9.99999
} {abc: (10) :xyz}
do_test printf-2.6.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 9.99999
} {abc: 2 3 (9.99999) :xyz}
do_test printf-2.6.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 9.99999
} {abc: 2 3 (9.99999) :xyz}
do_test printf-2.6.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 9.99999
} {abc: 2 3 (0009.99999) :xyz}
do_test printf-2.6.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 9.99999
} {abc: 2 3 (10.000) :xyz}
do_test printf-2.6.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 9.99999
} {abc: 2 3 (1.000e+01) :xyz}
do_test printf-2.6.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 9.99999
} {abc: 2 3 (10) :xyz}
do_test printf-2.6.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 -0.00543
} {abc: (-0.005) :xyz}
do_test printf-2.6.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 -0.00543
} {abc: (-5.430e-03) :xyz}
do_test printf-2.6.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 -0.00543
} {abc: (-0.00543) :xyz}
do_test printf-2.6.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 -0.00543
} {abc: 2 3 (-0.00543) :xyz}
do_test printf-2.6.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 -0.00543
} {abc: 2 3 (-0.00543000) :xyz}
do_test printf-2.6.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 -0.00543
} {abc: 2 3 (-000.00543) :xyz}
do_test printf-2.6.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 -0.00543
} {abc: 2 3 (-0.005) :xyz}
do_test printf-2.6.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 -0.00543
} {abc: 2 3 (-5.430e-03) :xyz}
do_test printf-2.6.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 -0.00543
} {abc: 2 3 (-0.00543) :xyz}
do_test printf-2.6.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 -1.0
} {abc: (-1.000) :xyz}
do_test printf-2.6.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 -1.0
} {abc: (-1.000e+00) :xyz}
do_test printf-2.6.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 -1.0
} {abc: (-1) :xyz}
do_test printf-2.6.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 -1.0
} {abc: 2 3 (-1) :xyz}
do_test printf-2.6.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 -1.0
} {abc: 2 3 (-1.00000) :xyz}
do_test printf-2.6.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 -1.0
} {abc: 2 3 (-000000001) :xyz}
do_test printf-2.6.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 -1.0
} {abc: 2 3 (-1.000) :xyz}
do_test printf-2.6.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 -1.0
} {abc: 2 3 (-1.000e+00) :xyz}
do_test printf-2.6.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 -1.0
} {abc: 2 3 (-1) :xyz}
do_test printf-2.6.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 -99.99999
} {abc: (-100.000) :xyz}
do_test printf-2.6.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 -99.99999
} {abc: (-1.000e+02) :xyz}
do_test printf-2.6.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 -99.99999
} {abc: (-100) :xyz}
do_test printf-2.6.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 -99.99999
} {abc: 2 3 (-100) :xyz}
do_test printf-2.6.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 -99.99999
} {abc: 2 3 (-100.000) :xyz}
do_test printf-2.6.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 -99.99999
} {abc: 2 3 (-000000100) :xyz}
do_test printf-2.6.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 -99.99999
} {abc: 2 3 (-100.000) :xyz}
do_test printf-2.6.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 -99.99999
} {abc: 2 3 (-1.000e+02) :xyz}
do_test printf-2.6.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 -99.99999
} {abc: 2 3 (-100) :xyz}
do_test printf-2.6.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 3.14e+9
} {abc: (3140000000.000) :xyz}
do_test printf-2.6.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 3.14e+9
} {abc: (3.140e+09) :xyz}
do_test printf-2.6.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 3.14e+9
} {abc: (3.14e+09) :xyz}
do_test printf-2.6.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 3.14e+9
} {abc: 2 3 (3.14e+09) :xyz}
do_test printf-2.6.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 3.14e+9
} {abc: 2 3 (3.14000e+09) :xyz}
do_test printf-2.6.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 3.14e+9
} {abc: 2 3 (003.14e+09) :xyz}
do_test printf-2.6.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 3.14e+9
} {abc: 2 3 (3140000000.000) :xyz}
do_test printf-2.6.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 3.14e+9
} {abc: 2 3 (3.140e+09) :xyz}
do_test printf-2.6.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 3.14e+9
} {abc: 2 3 (3.14e+09) :xyz}
do_test printf-2.6.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 -4.72732e+88
} {abc: (-4.727e+88) :xyz}
do_test printf-2.6.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 -4.72732e+88
} {abc: (-4.73e+88) :xyz}
do_test printf-2.6.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 -4.72732e+88
} {abc: 2 3 (-4.72732e+88) :xyz}
do_test printf-2.6.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 -4.72732e+88
} {abc: 2 3 (-4.72732e+88) :xyz}
do_test printf-2.6.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 -4.72732e+88
} {abc: 2 3 (-4.72732e+88) :xyz}
do_test printf-2.6.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 -4.72732e+88
} {abc: 2 3 (-4.727e+88) :xyz}
do_test printf-2.6.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 -4.72732e+88
} {abc: 2 3 (-4.73e+88) :xyz}
do_test printf-2.6.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 9.87991e+143
} {abc: (9.880e+143) :xyz}
do_test printf-2.6.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 9.87991e+143
} {abc: (9.88e+143) :xyz}
do_test printf-2.6.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 9.87991e+143
} {abc: 2 3 (9.87991e+143) :xyz}
do_test printf-2.6.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 9.87991e+143
} {abc: 2 3 (9.87991e+143) :xyz}
do_test printf-2.6.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 9.87991e+143
} {abc: 2 3 (9.87991e+143) :xyz}
do_test printf-2.6.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 9.87991e+143
} {abc: 2 3 (9.880e+143) :xyz}
do_test printf-2.6.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 9.87991e+143
} {abc: 2 3 (9.88e+143) :xyz}
do_test printf-2.6.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 -6.287291e-9
} {abc: (-0.000) :xyz}
do_test printf-2.6.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 -6.287291e-9
} {abc: (-6.287e-09) :xyz}
do_test printf-2.6.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 -6.287291e-9
} {abc: (-6.29e-09) :xyz}
do_test printf-2.6.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-6.28729e-09) :xyz}
do_test printf-2.6.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-6.28729e-09) :xyz}
do_test printf-2.6.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-6.28729e-09) :xyz}
do_test printf-2.6.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-0.000) :xyz}
do_test printf-2.6.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-6.287e-09) :xyz}
do_test printf-2.6.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 -6.287291e-9
} {abc: 2 3 (-6.29e-09) :xyz}
do_test printf-2.6.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 2 3 3.38826392e-110
} {abc: (0.000) :xyz}
do_test printf-2.6.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 2 3 3.38826392e-110
} {abc: (3.388e-110) :xyz}
do_test printf-2.6.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 2 3 3.38826392e-110
} {abc: (3.39e-110) :xyz}
do_test printf-2.6.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (3.38826e-110) :xyz}
do_test printf-2.6.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (3.38826e-110) :xyz}
do_test printf-2.6.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (3.38826e-110) :xyz}
do_test printf-2.6.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%2.3f) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (0.000) :xyz}
do_test printf-2.6.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%2.3e) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (3.388e-110) :xyz}
do_test printf-2.6.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%2.3g) :xyz} 2 3 3.38826392e-110
} {abc: 2 3 (3.39e-110) :xyz}
do_test printf-2.7.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 0.001
} {abc: (0.001) :xyz}
do_test printf-2.7.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 0.001
} {abc: (1.000e-03) :xyz}
do_test printf-2.7.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 0.001
} {abc: (0.001) :xyz}
do_test printf-2.7.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 0.001
} {abc: 3 3 (0.001) :xyz}
do_test printf-2.7.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 0.001
} {abc: 3 3 (0.00100000) :xyz}
do_test printf-2.7.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 0.001
} {abc: 3 3 (000000.001) :xyz}
do_test printf-2.7.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 0.001
} {abc: 3 3 (0.001) :xyz}
do_test printf-2.7.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 0.001
} {abc: 3 3 (1.000e-03) :xyz}
do_test printf-2.7.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 0.001
} {abc: 3 3 (0.001) :xyz}
do_test printf-2.7.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 1.0e-20
} {abc: (0.000) :xyz}
do_test printf-2.7.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 1.0e-20
} {abc: (1.000e-20) :xyz}
do_test printf-2.7.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.7.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 1.0e-20
} {abc: 3 3 (1e-20) :xyz}
do_test printf-2.7.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 1.0e-20
} {abc: 3 3 (1.00000e-20) :xyz}
do_test printf-2.7.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 1.0e-20
} {abc: 3 3 (000001e-20) :xyz}
do_test printf-2.7.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 1.0e-20
} {abc: 3 3 (0.000) :xyz}
do_test printf-2.7.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 1.0e-20
} {abc: 3 3 (1.000e-20) :xyz}
do_test printf-2.7.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 1.0e-20
} {abc: 3 3 (1e-20) :xyz}
do_test printf-2.7.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 1.0
} {abc: (1.000) :xyz}
do_test printf-2.7.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 1.0
} {abc: (1.000e+00) :xyz}
do_test printf-2.7.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 1.0
} {abc: (  1) :xyz}
do_test printf-2.7.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 1.0
} {abc: 3 3 (1) :xyz}
do_test printf-2.7.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 1.0
} {abc: 3 3 (1.00000) :xyz}
do_test printf-2.7.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 1.0
} {abc: 3 3 (0000000001) :xyz}
do_test printf-2.7.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 1.0
} {abc: 3 3 (1.000) :xyz}
do_test printf-2.7.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 1.0
} {abc: 3 3 (1.000e+00) :xyz}
do_test printf-2.7.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 1.0
} {abc: 3 3 (  1) :xyz}
do_test printf-2.7.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 0.0
} {abc: (0.000) :xyz}
do_test printf-2.7.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 0.0
} {abc: (0.000e+00) :xyz}
do_test printf-2.7.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 0.0
} {abc: (  0) :xyz}
do_test printf-2.7.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 0.0
} {abc: 3 3 (0) :xyz}
do_test printf-2.7.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 0.0
} {abc: 3 3 (0.00000) :xyz}
do_test printf-2.7.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 0.0
} {abc: 3 3 (0000000000) :xyz}
do_test printf-2.7.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 0.0
} {abc: 3 3 (0.000) :xyz}
do_test printf-2.7.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 0.0
} {abc: 3 3 (0.000e+00) :xyz}
do_test printf-2.7.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 0.0
} {abc: 3 3 (  0) :xyz}
do_test printf-2.7.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 100.0
} {abc: (100.000) :xyz}
do_test printf-2.7.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 100.0
} {abc: (1.000e+02) :xyz}
do_test printf-2.7.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 100.0
} {abc: (100) :xyz}
do_test printf-2.7.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 100.0
} {abc: 3 3 (100) :xyz}
do_test printf-2.7.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 100.0
} {abc: 3 3 (100.000) :xyz}
do_test printf-2.7.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 100.0
} {abc: 3 3 (0000000100) :xyz}
do_test printf-2.7.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 100.0
} {abc: 3 3 (100.000) :xyz}
do_test printf-2.7.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 100.0
} {abc: 3 3 (1.000e+02) :xyz}
do_test printf-2.7.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 100.0
} {abc: 3 3 (100) :xyz}
do_test printf-2.7.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 9.99999
} {abc: (10.000) :xyz}
do_test printf-2.7.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 9.99999
} {abc: (1.000e+01) :xyz}
do_test printf-2.7.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 9.99999
} {abc: ( 10) :xyz}
do_test printf-2.7.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 9.99999
} {abc: 3 3 (9.99999) :xyz}
do_test printf-2.7.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 9.99999
} {abc: 3 3 (9.99999) :xyz}
do_test printf-2.7.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 9.99999
} {abc: 3 3 (0009.99999) :xyz}
do_test printf-2.7.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 9.99999
} {abc: 3 3 (10.000) :xyz}
do_test printf-2.7.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 9.99999
} {abc: 3 3 (1.000e+01) :xyz}
do_test printf-2.7.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 9.99999
} {abc: 3 3 ( 10) :xyz}
do_test printf-2.7.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 -0.00543
} {abc: (-0.005) :xyz}
do_test printf-2.7.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 -0.00543
} {abc: (-5.430e-03) :xyz}
do_test printf-2.7.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 -0.00543
} {abc: (-0.00543) :xyz}
do_test printf-2.7.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 -0.00543
} {abc: 3 3 (-0.00543) :xyz}
do_test printf-2.7.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 -0.00543
} {abc: 3 3 (-0.00543000) :xyz}
do_test printf-2.7.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 -0.00543
} {abc: 3 3 (-000.00543) :xyz}
do_test printf-2.7.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 -0.00543
} {abc: 3 3 (-0.005) :xyz}
do_test printf-2.7.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 -0.00543
} {abc: 3 3 (-5.430e-03) :xyz}
do_test printf-2.7.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 -0.00543
} {abc: 3 3 (-0.00543) :xyz}
do_test printf-2.7.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 -1.0
} {abc: (-1.000) :xyz}
do_test printf-2.7.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 -1.0
} {abc: (-1.000e+00) :xyz}
do_test printf-2.7.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 -1.0
} {abc: ( -1) :xyz}
do_test printf-2.7.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 -1.0
} {abc: 3 3 (-1) :xyz}
do_test printf-2.7.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 -1.0
} {abc: 3 3 (-1.00000) :xyz}
do_test printf-2.7.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 -1.0
} {abc: 3 3 (-000000001) :xyz}
do_test printf-2.7.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 -1.0
} {abc: 3 3 (-1.000) :xyz}
do_test printf-2.7.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 -1.0
} {abc: 3 3 (-1.000e+00) :xyz}
do_test printf-2.7.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 -1.0
} {abc: 3 3 ( -1) :xyz}
do_test printf-2.7.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 -99.99999
} {abc: (-100.000) :xyz}
do_test printf-2.7.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 -99.99999
} {abc: (-1.000e+02) :xyz}
do_test printf-2.7.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 -99.99999
} {abc: (-100) :xyz}
do_test printf-2.7.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 -99.99999
} {abc: 3 3 (-100) :xyz}
do_test printf-2.7.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 -99.99999
} {abc: 3 3 (-100.000) :xyz}
do_test printf-2.7.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 -99.99999
} {abc: 3 3 (-000000100) :xyz}
do_test printf-2.7.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 -99.99999
} {abc: 3 3 (-100.000) :xyz}
do_test printf-2.7.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 -99.99999
} {abc: 3 3 (-1.000e+02) :xyz}
do_test printf-2.7.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 -99.99999
} {abc: 3 3 (-100) :xyz}
do_test printf-2.7.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 3.14e+9
} {abc: (3140000000.000) :xyz}
do_test printf-2.7.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 3.14e+9
} {abc: (3.140e+09) :xyz}
do_test printf-2.7.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 3.14e+9
} {abc: (3.14e+09) :xyz}
do_test printf-2.7.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 3.14e+9
} {abc: 3 3 (3.14e+09) :xyz}
do_test printf-2.7.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 3.14e+9
} {abc: 3 3 (3.14000e+09) :xyz}
do_test printf-2.7.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 3.14e+9
} {abc: 3 3 (003.14e+09) :xyz}
do_test printf-2.7.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 3.14e+9
} {abc: 3 3 (3140000000.000) :xyz}
do_test printf-2.7.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 3.14e+9
} {abc: 3 3 (3.140e+09) :xyz}
do_test printf-2.7.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 3.14e+9
} {abc: 3 3 (3.14e+09) :xyz}
do_test printf-2.7.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 -4.72732e+88
} {abc: (-4.727e+88) :xyz}
do_test printf-2.7.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 -4.72732e+88
} {abc: (-4.73e+88) :xyz}
do_test printf-2.7.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 -4.72732e+88
} {abc: 3 3 (-4.72732e+88) :xyz}
do_test printf-2.7.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 -4.72732e+88
} {abc: 3 3 (-4.72732e+88) :xyz}
do_test printf-2.7.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 -4.72732e+88
} {abc: 3 3 (-4.72732e+88) :xyz}
do_test printf-2.7.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 -4.72732e+88
} {abc: 3 3 (-4.727e+88) :xyz}
do_test printf-2.7.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 -4.72732e+88
} {abc: 3 3 (-4.73e+88) :xyz}
do_test printf-2.7.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 9.87991e+143
} {abc: (9.880e+143) :xyz}
do_test printf-2.7.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 9.87991e+143
} {abc: (9.88e+143) :xyz}
do_test printf-2.7.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 9.87991e+143
} {abc: 3 3 (9.87991e+143) :xyz}
do_test printf-2.7.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 9.87991e+143
} {abc: 3 3 (9.87991e+143) :xyz}
do_test printf-2.7.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 9.87991e+143
} {abc: 3 3 (9.87991e+143) :xyz}
do_test printf-2.7.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 9.87991e+143
} {abc: 3 3 (9.880e+143) :xyz}
do_test printf-2.7.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 9.87991e+143
} {abc: 3 3 (9.88e+143) :xyz}
do_test printf-2.7.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 -6.287291e-9
} {abc: (-0.000) :xyz}
do_test printf-2.7.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 -6.287291e-9
} {abc: (-6.287e-09) :xyz}
do_test printf-2.7.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 -6.287291e-9
} {abc: (-6.29e-09) :xyz}
do_test printf-2.7.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-6.28729e-09) :xyz}
do_test printf-2.7.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-6.28729e-09) :xyz}
do_test printf-2.7.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-6.28729e-09) :xyz}
do_test printf-2.7.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-0.000) :xyz}
do_test printf-2.7.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-6.287e-09) :xyz}
do_test printf-2.7.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 -6.287291e-9
} {abc: 3 3 (-6.29e-09) :xyz}
do_test printf-2.7.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 3 3.38826392e-110
} {abc: (0.000) :xyz}
do_test printf-2.7.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 3 3.38826392e-110
} {abc: (3.388e-110) :xyz}
do_test printf-2.7.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 3 3.38826392e-110
} {abc: (3.39e-110) :xyz}
do_test printf-2.7.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (3.38826e-110) :xyz}
do_test printf-2.7.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (3.38826e-110) :xyz}
do_test printf-2.7.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (3.38826e-110) :xyz}
do_test printf-2.7.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.3f) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (0.000) :xyz}
do_test printf-2.7.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.3e) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (3.388e-110) :xyz}
do_test printf-2.7.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.3g) :xyz} 3 3 3.38826392e-110
} {abc: 3 3 (3.39e-110) :xyz}
do_test printf-2.8.1.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 0.001
} {abc: (0.00) :xyz}
do_test printf-2.8.1.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 0.001
} {abc: (1.00e-03) :xyz}
do_test printf-2.8.1.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 0.001
} {abc: (0.001) :xyz}
do_test printf-2.8.1.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 0.001
} {abc: 3 2 (0.001) :xyz}
do_test printf-2.8.1.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 0.001
} {abc: 3 2 (0.00100000) :xyz}
do_test printf-2.8.1.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 0.001
} {abc: 3 2 (000000.001) :xyz}
do_test printf-2.8.1.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 0.001
} {abc: 3 2 (0.00) :xyz}
do_test printf-2.8.1.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 0.001
} {abc: 3 2 (1.00e-03) :xyz}
do_test printf-2.8.1.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 0.001
} {abc: 3 2 (0.001) :xyz}
do_test printf-2.8.2.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 1.0e-20
} {abc: (0.00) :xyz}
do_test printf-2.8.2.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 1.0e-20
} {abc: (1.00e-20) :xyz}
do_test printf-2.8.2.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 1.0e-20
} {abc: (1e-20) :xyz}
do_test printf-2.8.2.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 1.0e-20
} {abc: 3 2 (1e-20) :xyz}
do_test printf-2.8.2.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 1.0e-20
} {abc: 3 2 (1.00000e-20) :xyz}
do_test printf-2.8.2.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 1.0e-20
} {abc: 3 2 (000001e-20) :xyz}
do_test printf-2.8.2.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 1.0e-20
} {abc: 3 2 (0.00) :xyz}
do_test printf-2.8.2.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 1.0e-20
} {abc: 3 2 (1.00e-20) :xyz}
do_test printf-2.8.2.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 1.0e-20
} {abc: 3 2 (1e-20) :xyz}
do_test printf-2.8.3.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 1.0
} {abc: (1.00) :xyz}
do_test printf-2.8.3.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 1.0
} {abc: (1.00e+00) :xyz}
do_test printf-2.8.3.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 1.0
} {abc: (  1) :xyz}
do_test printf-2.8.3.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 1.0
} {abc: 3 2 (1) :xyz}
do_test printf-2.8.3.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 1.0
} {abc: 3 2 (1.00000) :xyz}
do_test printf-2.8.3.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 1.0
} {abc: 3 2 (0000000001) :xyz}
do_test printf-2.8.3.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 1.0
} {abc: 3 2 (1.00) :xyz}
do_test printf-2.8.3.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 1.0
} {abc: 3 2 (1.00e+00) :xyz}
do_test printf-2.8.3.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 1.0
} {abc: 3 2 (  1) :xyz}
do_test printf-2.8.4.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 0.0
} {abc: (0.00) :xyz}
do_test printf-2.8.4.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 0.0
} {abc: (0.00e+00) :xyz}
do_test printf-2.8.4.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 0.0
} {abc: (  0) :xyz}
do_test printf-2.8.4.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 0.0
} {abc: 3 2 (0) :xyz}
do_test printf-2.8.4.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 0.0
} {abc: 3 2 (0.00000) :xyz}
do_test printf-2.8.4.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 0.0
} {abc: 3 2 (0000000000) :xyz}
do_test printf-2.8.4.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 0.0
} {abc: 3 2 (0.00) :xyz}
do_test printf-2.8.4.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 0.0
} {abc: 3 2 (0.00e+00) :xyz}
do_test printf-2.8.4.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 0.0
} {abc: 3 2 (  0) :xyz}
do_test printf-2.8.5.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 100.0
} {abc: (100.00) :xyz}
do_test printf-2.8.5.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 100.0
} {abc: (1.00e+02) :xyz}
do_test printf-2.8.5.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 100.0
} {abc: (1e+02) :xyz}
do_test printf-2.8.5.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 100.0
} {abc: 3 2 (100) :xyz}
do_test printf-2.8.5.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 100.0
} {abc: 3 2 (100.000) :xyz}
do_test printf-2.8.5.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 100.0
} {abc: 3 2 (0000000100) :xyz}
do_test printf-2.8.5.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 100.0
} {abc: 3 2 (100.00) :xyz}
do_test printf-2.8.5.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 100.0
} {abc: 3 2 (1.00e+02) :xyz}
do_test printf-2.8.5.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 100.0
} {abc: 3 2 (1e+02) :xyz}
do_test printf-2.8.6.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 9.99999
} {abc: (10.00) :xyz}
do_test printf-2.8.6.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 9.99999
} {abc: (1.00e+01) :xyz}
do_test printf-2.8.6.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 9.99999
} {abc: ( 10) :xyz}
do_test printf-2.8.6.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 9.99999
} {abc: 3 2 (9.99999) :xyz}
do_test printf-2.8.6.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 9.99999
} {abc: 3 2 (9.99999) :xyz}
do_test printf-2.8.6.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 9.99999
} {abc: 3 2 (0009.99999) :xyz}
do_test printf-2.8.6.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 9.99999
} {abc: 3 2 (10.00) :xyz}
do_test printf-2.8.6.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 9.99999
} {abc: 3 2 (1.00e+01) :xyz}
do_test printf-2.8.6.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 9.99999
} {abc: 3 2 ( 10) :xyz}
do_test printf-2.8.7.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 -0.00543
} {abc: (-0.01) :xyz}
do_test printf-2.8.7.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 -0.00543
} {abc: (-5.43e-03) :xyz}
do_test printf-2.8.7.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 -0.00543
} {abc: (-0.0054) :xyz}
do_test printf-2.8.7.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 -0.00543
} {abc: 3 2 (-0.00543) :xyz}
do_test printf-2.8.7.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 -0.00543
} {abc: 3 2 (-0.00543000) :xyz}
do_test printf-2.8.7.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 -0.00543
} {abc: 3 2 (-000.00543) :xyz}
do_test printf-2.8.7.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 -0.00543
} {abc: 3 2 (-0.01) :xyz}
do_test printf-2.8.7.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 -0.00543
} {abc: 3 2 (-5.43e-03) :xyz}
do_test printf-2.8.7.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 -0.00543
} {abc: 3 2 (-0.0054) :xyz}
do_test printf-2.8.8.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 -1.0
} {abc: (-1.00) :xyz}
do_test printf-2.8.8.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 -1.0
} {abc: (-1.00e+00) :xyz}
do_test printf-2.8.8.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 -1.0
} {abc: ( -1) :xyz}
do_test printf-2.8.8.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 -1.0
} {abc: 3 2 (-1) :xyz}
do_test printf-2.8.8.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 -1.0
} {abc: 3 2 (-1.00000) :xyz}
do_test printf-2.8.8.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 -1.0
} {abc: 3 2 (-000000001) :xyz}
do_test printf-2.8.8.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 -1.0
} {abc: 3 2 (-1.00) :xyz}
do_test printf-2.8.8.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 -1.0
} {abc: 3 2 (-1.00e+00) :xyz}
do_test printf-2.8.8.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 -1.0
} {abc: 3 2 ( -1) :xyz}
do_test printf-2.8.9.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 -99.99999
} {abc: (-100.00) :xyz}
do_test printf-2.8.9.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 -99.99999
} {abc: (-1.00e+02) :xyz}
do_test printf-2.8.9.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 -99.99999
} {abc: (-1e+02) :xyz}
do_test printf-2.8.9.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 -99.99999
} {abc: 3 2 (-100) :xyz}
do_test printf-2.8.9.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 -99.99999
} {abc: 3 2 (-100.000) :xyz}
do_test printf-2.8.9.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 -99.99999
} {abc: 3 2 (-000000100) :xyz}
do_test printf-2.8.9.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 -99.99999
} {abc: 3 2 (-100.00) :xyz}
do_test printf-2.8.9.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 -99.99999
} {abc: 3 2 (-1.00e+02) :xyz}
do_test printf-2.8.9.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 -99.99999
} {abc: 3 2 (-1e+02) :xyz}
do_test printf-2.8.10.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 3.14e+9
} {abc: (3140000000.00) :xyz}
do_test printf-2.8.10.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 3.14e+9
} {abc: (3.14e+09) :xyz}
do_test printf-2.8.10.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 3.14e+9
} {abc: (3.1e+09) :xyz}
do_test printf-2.8.10.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 3.14e+9
} {abc: 3 2 (3.14e+09) :xyz}
do_test printf-2.8.10.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 3.14e+9
} {abc: 3 2 (3.14000e+09) :xyz}
do_test printf-2.8.10.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 3.14e+9
} {abc: 3 2 (003.14e+09) :xyz}
do_test printf-2.8.10.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 3.14e+9
} {abc: 3 2 (3140000000.00) :xyz}
do_test printf-2.8.10.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 3.14e+9
} {abc: 3 2 (3.14e+09) :xyz}
do_test printf-2.8.10.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 3.14e+9
} {abc: 3 2 (3.1e+09) :xyz}
do_test printf-2.8.11.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 -4.72732e+88
} {abc: (-4.73e+88) :xyz}
do_test printf-2.8.11.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 -4.72732e+88
} {abc: (-4.7e+88) :xyz}
do_test printf-2.8.11.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 -4.72732e+88
} {abc: 3 2 (-4.72732e+88) :xyz}
do_test printf-2.8.11.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 -4.72732e+88
} {abc: 3 2 (-4.72732e+88) :xyz}
do_test printf-2.8.11.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 -4.72732e+88
} {abc: 3 2 (-4.72732e+88) :xyz}
do_test printf-2.8.11.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 -4.72732e+88
} {abc: 3 2 (-4.73e+88) :xyz}
do_test printf-2.8.11.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 -4.72732e+88
} {abc: 3 2 (-4.7e+88) :xyz}
do_test printf-2.8.12.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 9.87991e+143
} {abc: (9.88e+143) :xyz}
do_test printf-2.8.12.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 9.87991e+143
} {abc: (9.9e+143) :xyz}
do_test printf-2.8.12.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 9.87991e+143
} {abc: 3 2 (9.87991e+143) :xyz}
do_test printf-2.8.12.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 9.87991e+143
} {abc: 3 2 (9.87991e+143) :xyz}
do_test printf-2.8.12.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 9.87991e+143
} {abc: 3 2 (9.87991e+143) :xyz}
do_test printf-2.8.12.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 9.87991e+143
} {abc: 3 2 (9.88e+143) :xyz}
do_test printf-2.8.12.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 9.87991e+143
} {abc: 3 2 (9.9e+143) :xyz}
do_test printf-2.8.13.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 -6.287291e-9
} {abc: (-0.00) :xyz}
do_test printf-2.8.13.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 -6.287291e-9
} {abc: (-6.29e-09) :xyz}
do_test printf-2.8.13.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 -6.287291e-9
} {abc: (-6.3e-09) :xyz}
do_test printf-2.8.13.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-6.28729e-09) :xyz}
do_test printf-2.8.13.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-6.28729e-09) :xyz}
do_test printf-2.8.13.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-6.28729e-09) :xyz}
do_test printf-2.8.13.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-0.00) :xyz}
do_test printf-2.8.13.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-6.29e-09) :xyz}
do_test printf-2.8.13.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 -6.287291e-9
} {abc: 3 2 (-6.3e-09) :xyz}
do_test printf-2.8.14.1 {
  sqlite3_mprintf_double {abc: (%*.*f) :xyz} 3 2 3.38826392e-110
} {abc: (0.00) :xyz}
do_test printf-2.8.14.2 {
  sqlite3_mprintf_double {abc: (%*.*e) :xyz} 3 2 3.38826392e-110
} {abc: (3.39e-110) :xyz}
do_test printf-2.8.14.3 {
  sqlite3_mprintf_double {abc: (%*.*g) :xyz} 3 2 3.38826392e-110
} {abc: (3.4e-110) :xyz}
do_test printf-2.8.14.4 {
  sqlite3_mprintf_double {abc: %d %d (%g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (3.38826e-110) :xyz}
do_test printf-2.8.14.5 {
  sqlite3_mprintf_double {abc: %d %d (%#g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (3.38826e-110) :xyz}
do_test printf-2.8.14.6 {
  sqlite3_mprintf_double {abc: %d %d (%010g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (3.38826e-110) :xyz}
do_test printf-2.8.14.7 {
  sqlite3_mprintf_double {abc: %d %d (%3.2f) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (0.00) :xyz}
do_test printf-2.8.14.8 {
  sqlite3_mprintf_double {abc: %d %d (%3.2e) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (3.39e-110) :xyz}
do_test printf-2.8.14.9 {
  sqlite3_mprintf_double {abc: %d %d (%3.2g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 (3.4e-110) :xyz}
do_test printf-2.8.15.1 {
  sqlite3_mprintf_double {abc: (% *.*f) :xyz} 3 2 3.38826392e-110
} {abc: ( 0.00) :xyz}
do_test printf-2.8.15.2 {
  sqlite3_mprintf_double {abc: (% *.*e) :xyz} 3 2 3.38826392e-110
} {abc: ( 3.39e-110) :xyz}
do_test printf-2.8.15.3 {
  sqlite3_mprintf_double {abc: (% *.*g) :xyz} 3 2 3.38826392e-110
} {abc: ( 3.4e-110) :xyz}
do_test printf-2.8.15.4 {
  sqlite3_mprintf_double {abc: %d %d (% g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 3.38826e-110) :xyz}
do_test printf-2.8.15.5 {
  sqlite3_mprintf_double {abc: %d %d (% #g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 3.38826e-110) :xyz}
do_test printf-2.8.15.6 {
  sqlite3_mprintf_double {abc: %d %d (%0 10g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 3.38826e-110) :xyz}
do_test printf-2.8.15.7 {
  sqlite3_mprintf_double {abc: %d %d (% 3.2f) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 0.00) :xyz}
do_test printf-2.8.15.8 {
  sqlite3_mprintf_double {abc: %d %d (% 3.2e) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 3.39e-110) :xyz}
do_test printf-2.8.15.9 {
  sqlite3_mprintf_double {abc: %d %d (% 3.2g) :xyz} 3 2 3.38826392e-110
} {abc: 3 2 ( 3.4e-110) :xyz}

do_test printf-2.9.1 {
  sqlite3_mprintf_double {abc: %d %d (%5.0g) :xyz} 0 0 1.234
} {abc: 0 0 (    1) :xyz}
do_test printf-2.9.2 {
  sqlite3_mprintf_double {abc: %d %d (%+5.0g) :xyz} 0 0 1.234
} {abc: 0 0 (   +1) :xyz}
do_test printf-2.9.3 {
  sqlite3_mprintf_double {abc: %d %d (%+-5.0g) :xyz} 0 0 1.234
} {abc: 0 0 (+1   ) :xyz}

do_test printf-2.10.1 {
  sqlite3_mprintf_double {abc: %d %d (%-010.5f) :xyz} 0 0 1.234
} {abc: 0 0 (1.23400   ) :xyz}
do_test printf-2.10.2 {
  sqlite3_mprintf_double {abc: %d %d (%010.5f) :xyz} 0 0 1.234
} {abc: 0 0 (0001.23400) :xyz}
do_test printf-2.10.3 {
  sqlite3_mprintf_double {abc: %d %d (%+010.5f) :xyz} 0 0 1.234
} {abc: 0 0 (+001.23400) :xyz}

do_test printf-3.1 {
  sqlite3_mprintf_str {A String: (%*.*s)} 10 10 {This is the string}
} [format {A String: (%*.*s)} 10 10 {This is the string}]
do_test printf-3.2 {
  sqlite3_mprintf_str {A String: (%*.*s)} 10 5 {This is the string}
} [format {A String: (%*.*s)} 10 5 {This is the string}]
do_test printf-3.3 {
  sqlite3_mprintf_str {A String: (%*.*s)} -10 5 {This is the string}
} [format {A String: (%*.*s)} -10 5 {This is the string}]
do_test printf-3.4 {
  sqlite3_mprintf_str {%d %d A String: (%s)} 1 2 {This is the string}
} [format {%d %d A String: (%s)} 1 2 {This is the string}]
do_test printf-3.5 {
  sqlite3_mprintf_str {%d %d A String: (%30s)} 1 2 {This is the string}
} [format {%d %d A String: (%30s)} 1 2 {This is the string}]
do_test printf-3.6 {
  sqlite3_mprintf_str {%d %d A String: (%-30s)} 1 2 {This is the string}
} [format {%d %d A String: (%-30s)} 1 2 {This is the string}]
do_test printf-3.7 {
  sqlite3_mprintf_str {%d A String: (%*s)} 1 2147483647 {This is the string}
} []
do_test printf-3.8 {
  sqlite3_mprintf_str {%d A String: (%*s)} 1 -2147483648 {This is the string}
} {1 A String: (This is the string)}
do_test printf-3.9 {
  sqlite3_mprintf_str {%d A String: (%.*s)} 1 -2147483648 {This is the string}
} {1 A String: (This is the string)}
do_test snprintf-3.11 {
  sqlite3_snprintf_str 2 {x%d %d %s} 10 10 {This is the string}
} {x}
do_test snprintf-3.12 {
  sqlite3_snprintf_str 3 {x%d %d %s} 10 10 {This is the string}
} {x1}
do_test snprintf-3.13 {
  sqlite3_snprintf_str 4 {x%d %d %s} 10 10 {This is the string}
} {x10}
do_test snprintf-3.14 {
  sqlite3_snprintf_str 5 {x%d %d %s} 10 10 {This is the string}
} {x10 }
do_test snprintf-3.15 {
  sqlite3_snprintf_str 6 {x%d %d %s} 10 10 {This is the string}
} {x10 1}
do_test snprintf-3.16 {
  sqlite3_snprintf_str 7 {x%d %d %s} 10 10 {This is the string}
} {x10 10}
do_test snprintf-3.17 {
  sqlite3_snprintf_str 8 {x%d %d %s} 10 10 {This is the string}
} {x10 10 }
do_test snprintf-3.18 {
  sqlite3_snprintf_str 9 {x%d %d %s} 10 10 {This is the string}
} {x10 10 T}
do_test snprintf-3.19 {
  sqlite3_snprintf_str 100 {x%d %d %s} 10 10 {This is the string}
} {x10 10 This is the string}

do_test printf-4.1 {
  sqlite3_mprintf_str {%d %d A quoted string: '%q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''all'}
do_test printf-4.2 {
  sqlite3_mprintf_str {%d %d A NULL pointer in %%q: '%q'} 1 2
} {1 2 A NULL pointer in %q: '(NULL)'}
do_test printf-4.3 {
  sqlite3_mprintf_str {%d %d A quoted string: %Q} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''all'}
do_test printf-4.4 {
  sqlite3_mprintf_str {%d %d A NULL pointer in %%Q: %Q} 1 2
} {1 2 A NULL pointer in %Q: NULL}
do_test printf-4.5 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.10q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''all'}
do_test printf-4.6 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.9q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''all'}
do_test printf-4.7 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.8q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''all'}
do_test printf-4.8 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.7q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''al'}
do_test printf-4.9 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.6q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y''a'}
do_test printf-4.10 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.5q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y'''}
do_test printf-4.11 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.4q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi Y'}
do_test printf-4.12 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.3q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi '}
do_test printf-4.13 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.2q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'Hi'}
do_test printf-4.14 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.1q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: 'H'}
do_test printf-4.15 {
  sqlite3_mprintf_str {%d %d A quoted string: '%.0q'} 1 2 {Hi Y'all}
} {1 2 A quoted string: ''}
do_test printf-4.16 {
  sqlite3_mprintf_str {%d A quoted string: '%.*q'} 1 6 {Hi Y'all}
} {1 A quoted string: 'Hi Y''a'}


do_test printf-5.1 {
  set x [sqlite3_mprintf_str {%d %d %100000s} 0 0 {Hello}]
  string length $x
} {100004}
do_test printf-5.2 {
  sqlite3_mprintf_str {%d %d (%-10.10s) %} -9 -10 {HelloHelloHello}
} {-9 -10 (HelloHello) %}

do_test printf-6.1 {
  sqlite3_mprintf_z_test , one two three four five six
} {,one,two,three,four,five,six}


do_test printf-7.1 {
  sqlite3_mprintf_scaled {A double: %g} 1.0e307 1.0
} {A double: 1e+307}
do_test printf-7.2 {
  sqlite3_mprintf_scaled {A double: %g} 1.0e307 10.0
} {A double: 1e+308}
do_test printf-7.3 {
  sqlite3_mprintf_scaled {A double: %g} 1.0e307 100.0
} {A double: Inf}
do_test printf-7.4 {
  sqlite3_mprintf_scaled {A double: %g} -1.0e307 100.0
} {A double: -Inf}
do_test printf-7.5 {
  sqlite3_mprintf_scaled {A double: %+g} 1.0e307 100.0
} {A double: +Inf}

do_test printf-8.1 {
  sqlite3_mprintf_int {%u %u %u} 0x7fffffff 0x80000000 0xffffffff
} {2147483647 2147483648 4294967295}
do_test printf-8.2 {
  sqlite3_mprintf_long {%lu %lu %lu} 0x7fffffff 0x80000000 0xffffffff
} {2147483647 2147483648 4294967295}
do_test printf-8.3 {
  sqlite3_mprintf_int64 {%llu %llu %llu} 2147483647 2147483648 4294967296
} {2147483647 2147483648 4294967296}
do_test printf-8.4 {
  sqlite3_mprintf_int64 {%lld %lld %lld} 2147483647 2147483648 4294967296
} {2147483647 2147483648 4294967296}
do_test printf-8.5 {
  sqlite3_mprintf_int64 {%llx %llx %llx} 2147483647 2147483648 4294967296
} {7fffffff 80000000 100000000}
do_test printf-8.6 {
  sqlite3_mprintf_int64 {%llx %llo %lld} -1 -1 -1
} {ffffffffffffffff 1777777777777777777777 -1}
do_test printf-8.7 {
  sqlite3_mprintf_int64 {%llx %llx %llx} +2147483647 +2147483648 +4294967296
} {7fffffff 80000000 100000000}

do_test printf-9.1 {
  sqlite3_mprintf_int {%*.*c} 4 4 65
} {AAAA}
do_test printf-9.2 {
  sqlite3_mprintf_int {%*.*c} -4 1 66
} {B   }
do_test printf-9.3 {
  sqlite3_mprintf_int {%*.*c} 4 1 67
} {   C}
do_test printf-9.4 {
  sqlite3_mprintf_int {%d %d %c} 4 1 67
} {4 1 C}
set ten {          }
set fifty $ten$ten$ten$ten$ten
do_test printf-9.5 {
  sqlite3_mprintf_int {%d %*c} 1 -201 67
} "1 C$fifty$fifty$fifty$fifty"
do_test printf-9.6 {
  sqlite3_mprintf_int {hi%12345.12346yhello} 0 0 0
} {hi}

# Ticket #812
#
do_test printf-10.1 {
  sqlite3_mprintf_stronly %s {}
} {}

# Ticket #831
#
do_test printf-10.2 {
  sqlite3_mprintf_stronly %q {}
} {}

# Ticket #1340:  Test for loss of precision on large positive exponents
#
do_test printf-10.3 {
  sqlite3_mprintf_double {%d %d %f} 1 1 1e300
} {1 1 1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000.000000}

# The non-standard '!' flag on a 'g' conversion forces a decimal point
# and at least one digit on either side of the decimal point.
#
do_test printf-11.1 {
  sqlite3_mprintf_double {%d %d %!g} 1 1 1
} {1 1 1.0}
do_test printf-11.2 {
  sqlite3_mprintf_double {%d %d %!g} 1 1 123
} {1 1 123.0}
do_test printf-11.3 {
  sqlite3_mprintf_double {%d %d %!g} 1 1 12.3
} {1 1 12.3}
do_test printf-11.4 {
  sqlite3_mprintf_double {%d %d %!g} 1 1 0.123
} {1 1 0.123}
do_test printf-11.5 {
  sqlite3_mprintf_double {%d %d %!.15g} 1 1 1
} {1 1 1.0}
do_test printf-11.6 {
  sqlite3_mprintf_double {%d %d %!.15g} 1 1 1e10
} {1 1 10000000000.0}
do_test printf-11.7 {
  sqlite3_mprintf_double {%d %d %!.15g} 1 1 1e300
} {1 1 1.0e+300}

# Additional tests for coverage
#
do_test printf-12.1 {
  sqlite3_mprintf_double {%d %d %.2000g} 1 1 1.0
} {1 1 1}

# Floating point boundary cases
#
do_test printf-13.1 {
  sqlite3_mprintf_hexdouble %.20f 4024000000000000
} {10.00000000000000000000}
do_test printf-13.2 {
  sqlite3_mprintf_hexdouble %.20f 4197d78400000000
} {100000000.00000000000000000000}
do_test printf-13.3 {
  sqlite3_mprintf_hexdouble %.20f 4693b8b5b5056e17
} {100000000000000000000000000000000.00000000000000000000}
do_test printf-13.4 {
  sqlite3_mprintf_hexdouble %.20f 7ff0000000000000
} {Inf}
do_test printf-13.5 {
  sqlite3_mprintf_hexdouble %.20f fff0000000000000
} {-Inf}
do_test printf-13.6 {
  sqlite3_mprintf_hexdouble %.20f fff8000000000000
} {NaN}
do_test printf-13.7 {
  sqlite3_mprintf_hexdouble %2147483648.10000f 4693b8b5b5056e17
} {/100000000000000000000000000000000.00/}

do_test printf-14.1 {
  sqlite3_mprintf_str {abc-%y-123} 0 0 {not used}
} {abc-}
do_test printf-14.2 {
  sqlite3_mprintf_n_test {xyzzy}
} 5
do_test printf-14.3 {
  sqlite3_mprintf_str {abc-%T-123} 0 0 {not used}
} {abc-}
do_test printf-14.4 {
  sqlite3_mprintf_str {abc-%#} 0 0 {not used}
} {abc-}
do_test printf-14.5 {
  sqlite3_mprintf_str {abc-%*.*s-xyz} 10 -10 {a_very_long_string}
} {abc-a_very_lon-xyz}
do_test printf-14.6 {
  sqlite3_mprintf_str {abc-%5.10/} 0 0 {not used}
} {abc-}
do_test printf-14.7 {
  sqlite3_mprintf_str {abc-%05.5d} 123 0 {not used}
} {abc-00123}
do_test printf-14.8 {
  sqlite3_mprintf_str {abc-%05.5d} 1234567 0 {not used}
} {abc-1234567}

for {set i 2} {$i<200} {incr i} {
  set res [string repeat { } [expr {$i-1}]]x
  do_test printf-14.90.$i "
    sqlite3_mprintf_str {%*.*s} $i 500 x
  " $res
}

do_test printf-15.1 {
  sqlite3_snprintf_int 5 {12345} 0
} {1234}
do_test printf-15.2 {
  sqlite3_snprintf_int 5 {} 0
} {}
do_test printf-15.3 {
  sqlite3_snprintf_int 0 {} 0
} {abcdefghijklmnopqrstuvwxyz}

# Now test malloc() failure within a sqlite3_mprintf():
#
ifcapable memdebug {
  foreach var {a b c d} {
    set $var [string repeat $var 400]
  }
  set str1 "[string repeat A 360]%d%d%s"
  set str2 [string repeat B 5000]
  set zSuccess "[string repeat A 360]11[string repeat B 5000]"
  foreach ::iRepeat {0 1} {
    set nTestNum 1
    while {1} {
      sqlite3_memdebug_fail $nTestNum -repeat $::iRepeat
      set z [sqlite3_mprintf_str $str1 1 1 $str2]
      set nFail [sqlite3_memdebug_fail -1 -benign nBenign]
      do_test printf-malloc-$::iRepeat.$nTestNum {
        expr {($nFail>0 && $z eq "") || ($nFail==$nBenign && $z eq $zSuccess)}
      } {1}
      if {$nFail == 0} break
      incr nTestNum
    }
  }
}

finish_test