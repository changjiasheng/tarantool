#!/usr/bin/env ./tcltestrunner.lua

# 2010 July 16
#
# The author disclaims copyright to this source code.  In place of
# a legal notice, here is a blessing:
#
#    May you do good and not evil.
#    May you find forgiveness for yourself and forgive others.
#    May you share freely, never taking more than you give.
#
#***********************************************************************
#
# This file implements tests to verify that the "testable statements" in 
# the lang_expr.html document are correct.
#

set testdir [file dirname $argv0]
source $testdir/tester.tcl
source $testdir/malloc_common.tcl

ifcapable !compound {
  finish_test
  return
}

proc do_expr_test {tn expr type value} {
  uplevel do_execsql_test $tn [list "SELECT typeof($expr), $expr"] [
    list [list $type $value]
  ]
}

proc do_qexpr_test {tn expr value} {
  uplevel do_execsql_test $tn [list "SELECT quote($expr)"] [list $value]
}

# Set up three global variables:
#
#   ::opname         An array mapping from SQL operator to an easy to parse
#                    name. The names are used as part of test case names.
#
#   ::opprec         An array mapping from SQL operator to a numeric
#                    precedence value. Operators that group more tightly
#                    have lower numeric precedences.
#
#   ::oplist         A list of all SQL operators supported by SQLite.
#
foreach {op opn} {
      ||   cat     *   mul       /  div       %     mod       +      add
      -    sub     <<  lshift    >> rshift    &     bitand    |      bitor
      <    less    <=  lesseq    >  more      >=    moreeq    =      eq1
      ==   eq2     <>  ne1       != ne2       IS    is        LIKE   like
      GLOB glob    AND and       OR or        MATCH match     REGEXP regexp
      {IS NOT} isnt
} {
  set ::opname($op) $opn
}
set oplist [list]
foreach {prec opl} {
  1   ||
  2   {* / %}
  3   {+ -}
  4   {<< >> & |}
  5   {< <= > >=}
  6   {= == != <> IS {IS NOT} LIKE GLOB MATCH REGEXP}
  7   AND
  8   OR
} {
  foreach op $opl { 
    set ::opprec($op) $prec 
    lappend oplist $op
  }
}


# Hook in definitions of MATCH and REGEX. The following implementations
# cause MATCH and REGEX to behave similarly to the == operator.
#
proc matchfunc {a b} { return [expr {$a==$b}] }
proc regexfunc {a b} { return [expr {$a==$b}] }
db func match  -argcount 2 matchfunc
db func regexp -argcount 2 regexfunc

#-------------------------------------------------------------------------
# Test cases e_expr-1.* attempt to verify that all binary operators listed
# in the documentation exist and that the relative precedences of the
# operators are also as the documentation suggests.
#
# EVIDENCE-OF: R-15514-65163 SQLite understands the following binary
# operators, in order from highest to lowest precedence: || * / % + -
# << >> & | < <= > >= = == != <> IS IS
# NOT IN LIKE GLOB MATCH REGEXP AND OR
#
# EVIDENCE-OF: R-38759-38789 Operators IS and IS NOT have the same
# precedence as =.
#

unset -nocomplain untested
foreach op1 $oplist {
  foreach op2 $oplist {
    set untested($op1,$op2) 1
    foreach {tn A B C} {
       1     22   45    66
       2      0    0     0
       3      0    0     1
       4      0    1     0
       5      0    1     1
       6      1    0     0
       7      1    0     1
       8      1    1     0
       9      1    1     1
      10      5    6     1
      11      1    5     6
      12      1    5     5
      13      5    5     1

      14      5    2     1
      15      1    4     1
      16     -1    0     1
      17      0    1    -1

    } {
      set testname "e_expr-1.$opname($op1).$opname($op2).$tn"

      # If $op2 groups more tightly than $op1, then the result
      # of executing $sql1 whould be the same as executing $sql3.
      # If $op1 groups more tightly, or if $op1 and $op2 have 
      # the same precedence, then executing $sql1 should return
      # the same value as $sql2.
      #
      set sql1 "SELECT $A $op1 $B $op2 $C"
      set sql2 "SELECT ($A $op1 $B) $op2 $C"
      set sql3 "SELECT $A $op1 ($B $op2 $C)"

      set a2 [db one $sql2]
      set a3 [db one $sql3]

      do_execsql_test $testname $sql1 [list [
        if {$opprec($op2) < $opprec($op1)} {set a3} {set a2}
      ]]
      if {$a2 != $a3} { unset -nocomplain untested($op1,$op2) }
    }
  }
}

foreach op {* AND OR + || & |} { unset untested($op,$op) }
unset untested(+,-)  ;#       Since    (a+b)-c == a+(b-c)
unset untested(*,<<) ;#       Since    (a*b)<<c == a*(b<<c)

do_test e_expr-1.1 { array names untested } {}

# At one point, test 1.2.2 was failing. Instead of the correct result, it
# was returning {1 1 0}. This would seem to indicate that LIKE has the
# same precedence as '<'. Which is incorrect. It has lower precedence.
#
do_execsql_test e_expr-1.2.1 { 
  SELECT 0 < 2 LIKE 1,   (0 < 2) LIKE 1,   0 < (2 LIKE 1)
} {1 1 0}
do_execsql_test e_expr-1.2.2 { 
  SELECT 0 LIKE 0 < 2,   (0 LIKE 0) < 2,   0 LIKE (0 < 2)
} {0 1 0}

# Showing that LIKE and == have the same precedence
#
do_execsql_test e_expr-1.2.3 { 
  SELECT 2 LIKE 2 == 1,   (2 LIKE 2) == 1,    2 LIKE (2 == 1)
} {1 1 0}
do_execsql_test e_expr-1.2.4 { 
  SELECT 2 == 2 LIKE 1,   (2 == 2) LIKE 1,    2 == (2 LIKE 1)
} {1 1 0}

# Showing that < groups more tightly than == (< has higher precedence). 
#
do_execsql_test e_expr-1.2.5 { 
  SELECT 0 < 2 == 1,   (0 < 2) == 1,   0 < (2 == 1)
} {1 1 0}
do_execsql_test e_expr-1.6 { 
  SELECT 0 == 0 < 2,   (0 == 0) < 2,   0 == (0 < 2)
} {0 1 0}

#-------------------------------------------------------------------------
# Check that the four unary prefix operators mentioned in the 
# documentation exist.
#
# EVIDENCE-OF: R-13958-53419 Supported unary prefix operators are these:
# - + ~ NOT
#
do_execsql_test e_expr-2.1 { SELECT -   10   } {-10}
do_execsql_test e_expr-2.2 { SELECT +   10   } {10}
do_execsql_test e_expr-2.3 { SELECT ~   10   } {-11}
do_execsql_test e_expr-2.4 { SELECT NOT 10   } {0}

#-------------------------------------------------------------------------
# Tests for the two statements made regarding the unary + operator.
#
# EVIDENCE-OF: R-53670-03373 The unary operator + is a no-op.
#
# EVIDENCE-OF: R-19480-30968 It can be applied to strings, numbers,
# blobs or NULL and it always returns a result with the same value as
# the operand.
#
foreach {tn literal type} {
  1     'helloworld'   text
  2     45             integer
  3     45.2           real
  4     45.0           real
  5     X'ABCDEF'      blob
  6     NULL           null
} {
  set sql " SELECT quote( + $literal ), typeof( + $literal) "
  do_execsql_test e_expr-3.$tn $sql [list $literal $type]
}

#-------------------------------------------------------------------------
# Check that both = and == are both acceptable as the "equals" operator.
# Similarly, either != or <> work as the not-equals operator.
#
# EVIDENCE-OF: R-03679-60639 Equals can be either = or ==.
#
# EVIDENCE-OF: R-30082-38996 The non-equals operator can be either != or
# <>.
#
foreach {tn literal different} {
  1   'helloworld'  '12345'
  2   22            23
  3   'xyz'         X'78797A'
  4   X'78797A00'   'xyz'
} {
  do_execsql_test e_expr-4.$tn "
    SELECT $literal  = $literal,   $literal == $literal,
           $literal  = $different, $literal == $different,
           $literal  = NULL,       $literal == NULL,
           $literal != $literal,   $literal <> $literal,
           $literal != $different, $literal <> $different,
           $literal != NULL,       $literal != NULL

  " {1 1 0 0 {} {} 0 0 1 1 {} {}}
}

#-------------------------------------------------------------------------
# Test the || operator.
#
# EVIDENCE-OF: R-44409-62641 The || operator is "concatenate" - it joins
# together the two strings of its operands.
#
foreach {tn a b} {
  1   'helloworld'  '12345'
  2   22            23
} {
  set as [db one "SELECT $a"]
  set bs [db one "SELECT $b"]
  
  do_execsql_test e_expr-5.$tn "SELECT $a || $b" [list "${as}${bs}"]
}

#-------------------------------------------------------------------------
# Test the % operator.
#
# EVIDENCE-OF: R-08914-63790 The operator % outputs the value of its
# left operand modulo its right operand.
#
do_execsql_test e_expr-6.1 {SELECT  72%5}  {2}
do_execsql_test e_expr-6.2 {SELECT  72%-5} {2}
do_execsql_test e_expr-6.3 {SELECT -72%-5} {-2}
do_execsql_test e_expr-6.4 {SELECT -72%5}  {-2}

#-------------------------------------------------------------------------
# Test that the results of all binary operators are either numeric or 
# NULL, except for the || operator, which may evaluate to either a text
# value or NULL.
#
# EVIDENCE-OF: R-20665-17792 The result of any binary operator is either
# a numeric value or NULL, except for the || concatenation operator
# which always evaluates to either NULL or a text value.
#
set literals {
  1 'abc'        2 'hexadecimal'       3 ''
  4 123          5 -123                6 0
  7 123.4        8 0.0                 9 -123.4
 10 X'ABCDEF'   11 X''                12 X'0000'
 13     NULL
}
foreach op $oplist {
  foreach {n1 rhs} $literals { 
  foreach {n2 lhs} $literals {

    set t [db one " SELECT typeof($lhs $op $rhs) "]
    do_test e_expr-7.$opname($op).$n1.$n2 {
      expr {
           ($op=="||" && ($t == "text" || $t == "null"))
        || ($op!="||" && ($t == "integer" || $t == "real" || $t == "null"))
      }
    } 1

  }}
}

#-------------------------------------------------------------------------
# Test the IS and IS NOT operators.
#
# EVIDENCE-OF: R-24731-45773 The IS and IS NOT operators work like = and
# != except when one or both of the operands are NULL.
#
# EVIDENCE-OF: R-06325-15315 In this case, if both operands are NULL,
# then the IS operator evaluates to 1 (true) and the IS NOT operator
# evaluates to 0 (false).
#
# EVIDENCE-OF: R-19812-36779 If one operand is NULL and the other is
# not, then the IS operator evaluates to 0 (false) and the IS NOT
# operator is 1 (true).
#
# EVIDENCE-OF: R-61975-13410 It is not possible for an IS or IS NOT
# expression to evaluate to NULL.
#
do_execsql_test e_expr-8.1.1  { SELECT NULL IS     NULL } {1}
do_execsql_test e_expr-8.1.2  { SELECT 'ab' IS     NULL } {0}
do_execsql_test e_expr-8.1.3  { SELECT NULL IS     'ab' } {0}
do_execsql_test e_expr-8.1.4  { SELECT 'ab' IS     'ab' } {1}
do_execsql_test e_expr-8.1.5  { SELECT NULL ==     NULL } {{}}
do_execsql_test e_expr-8.1.6  { SELECT 'ab' ==     NULL } {{}}
do_execsql_test e_expr-8.1.7  { SELECT NULL ==     'ab' } {{}}
do_execsql_test e_expr-8.1.8  { SELECT 'ab' ==     'ab' } {1}
do_execsql_test e_expr-8.1.9  { SELECT NULL IS NOT NULL } {0}
do_execsql_test e_expr-8.1.10 { SELECT 'ab' IS NOT NULL } {1}
do_execsql_test e_expr-8.1.11 { SELECT NULL IS NOT 'ab' } {1}
do_execsql_test e_expr-8.1.12 { SELECT 'ab' IS NOT 'ab' } {0}
do_execsql_test e_expr-8.1.13 { SELECT NULL !=     NULL } {{}}
do_execsql_test e_expr-8.1.14 { SELECT 'ab' !=     NULL } {{}}
do_execsql_test e_expr-8.1.15 { SELECT NULL !=     'ab' } {{}}
do_execsql_test e_expr-8.1.16 { SELECT 'ab' !=     'ab' } {0}

foreach {n1 rhs} $literals { 
  foreach {n2 lhs} $literals {
    if {$rhs!="NULL" && $lhs!="NULL"} {
      set eq [execsql "SELECT $lhs = $rhs, $lhs != $rhs"]
    } else {
      set eq [list [expr {$lhs=="NULL" && $rhs=="NULL"}] \
                   [expr {$lhs!="NULL" || $rhs!="NULL"}]
      ]
    }
    set test e_expr-8.2.$n1.$n2
    do_execsql_test $test.1 "SELECT $lhs IS $rhs, $lhs IS NOT $rhs" $eq
    do_execsql_test $test.2 "
      SELECT ($lhs IS $rhs) IS NULL, ($lhs IS NOT $rhs) IS NULL
    " {0 0}
  }
}

#-------------------------------------------------------------------------
# Run some tests on the COLLATE "unary postfix operator".
#
# This collation sequence reverses both arguments before using 
# [string compare] to compare them. For example, when comparing the
# strings 'one' and 'four', return the result of:
#   
#   string compare eno ruof
#
proc reverse_str {zStr} {
  set out ""
  foreach c [split $zStr {}] { set out "${c}${out}" }
  set out
}
proc reverse_collate {zLeft zRight} {
  string compare [reverse_str $zLeft] [reverse_str $zRight]
}
db collate reverse reverse_collate

# EVIDENCE-OF: R-59577-33471 The COLLATE operator is a unary postfix
# operator that assigns a collating sequence to an expression.
#
# EVIDENCE-OF: R-36231-30731 The COLLATE operator has a higher
# precedence (binds more tightly) than any binary operator and any unary
# prefix operator except "~".
#
do_execsql_test e_expr-9.1 { SELECT  'abcd' < 'bbbb'    COLLATE reverse } 0
do_execsql_test e_expr-9.2 { SELECT ('abcd' < 'bbbb')   COLLATE reverse } 1
do_execsql_test e_expr-9.3 { SELECT  'abcd' <= 'bbbb'   COLLATE reverse } 0
do_execsql_test e_expr-9.4 { SELECT ('abcd' <= 'bbbb')  COLLATE reverse } 1

do_execsql_test e_expr-9.5 { SELECT  'abcd' > 'bbbb'    COLLATE reverse } 1
do_execsql_test e_expr-9.6 { SELECT ('abcd' > 'bbbb')   COLLATE reverse } 0
do_execsql_test e_expr-9.7 { SELECT  'abcd' >= 'bbbb'   COLLATE reverse } 1
do_execsql_test e_expr-9.8 { SELECT ('abcd' >= 'bbbb')  COLLATE reverse } 0

do_execsql_test e_expr-9.10 { SELECT  'abcd' =  'ABCD'  COLLATE nocase } 1
do_execsql_test e_expr-9.11 { SELECT ('abcd' =  'ABCD') COLLATE nocase } 0
do_execsql_test e_expr-9.12 { SELECT  'abcd' == 'ABCD'  COLLATE nocase } 1
do_execsql_test e_expr-9.13 { SELECT ('abcd' == 'ABCD') COLLATE nocase } 0
do_execsql_test e_expr-9.14 { SELECT  'abcd' IS 'ABCD'  COLLATE nocase } 1
do_execsql_test e_expr-9.15 { SELECT ('abcd' IS 'ABCD') COLLATE nocase } 0

do_execsql_test e_expr-9.16 { SELECT  'abcd' != 'ABCD'      COLLATE nocase } 0
do_execsql_test e_expr-9.17 { SELECT ('abcd' != 'ABCD')     COLLATE nocase } 1
do_execsql_test e_expr-9.18 { SELECT  'abcd' <> 'ABCD'      COLLATE nocase } 0
do_execsql_test e_expr-9.19 { SELECT ('abcd' <> 'ABCD')     COLLATE nocase } 1
do_execsql_test e_expr-9.20 { SELECT  'abcd' IS NOT 'ABCD'  COLLATE nocase } 0
do_execsql_test e_expr-9.21 { SELECT ('abcd' IS NOT 'ABCD') COLLATE nocase } 1

do_execsql_test e_expr-9.22 { 
  SELECT 'bbb' BETWEEN 'AAA' AND 'CCC' COLLATE nocase 
} 1
do_execsql_test e_expr-9.23 { 
  SELECT ('bbb' BETWEEN 'AAA' AND 'CCC') COLLATE nocase 
} 0

# # EVIDENCE-OF: R-58731-25439 The collating sequence set by the COLLATE
# # operator overrides the collating sequence determined by the COLLATE
# # clause in a table column definition.
# #
# do_execsql_test e_expr-9.24 { 
#   CREATE TABLE t24(a COLLATE NOCASE, b);
#   INSERT INTO t24 VALUES('aaa', 1);
#   INSERT INTO t24 VALUES('bbb', 2);
#   INSERT INTO t24 VALUES('ccc', 3);
# } {}
# do_execsql_test e_expr-9.25 { SELECT 'BBB' = a FROM t24 } {0 1 0}
# do_execsql_test e_expr-9.25 { SELECT a = 'BBB' FROM t24 } {0 1 0}
# do_execsql_test e_expr-9.25 { SELECT 'BBB' = a COLLATE binary FROM t24 } {0 0 0}
# do_execsql_test e_expr-9.25 { SELECT a COLLATE binary = 'BBB' FROM t24 } {0 0 0}

#-------------------------------------------------------------------------
# Test statements related to literal values.
#
# EVIDENCE-OF: R-31536-32008 Literal values may be integers, floating
# point numbers, strings, BLOBs, or NULLs.
#
do_execsql_test e_expr-10.1.1 { SELECT typeof(5)       } {integer}
do_execsql_test e_expr-10.1.2 { SELECT typeof(5.1)     } {real}
do_execsql_test e_expr-10.1.3 { SELECT typeof('5.1')   } {text}
do_execsql_test e_expr-10.1.4 { SELECT typeof(X'ABCD') } {blob}
do_execsql_test e_expr-10.1.5 { SELECT typeof(NULL)    } {null}

# "Scientific notation is supported for point literal values."
#
do_execsql_test e_expr-10.2.1 { SELECT typeof(3.4e-02)    } {real}
do_execsql_test e_expr-10.2.2 { SELECT typeof(3e+5)       } {real}
do_execsql_test e_expr-10.2.3 { SELECT 3.4e-02            } {0.034}
do_execsql_test e_expr-10.2.4 { SELECT 3e+4               } {30000.0}

# EVIDENCE-OF: R-35229-17830 A string constant is formed by enclosing
# the string in single quotes (').
#
# EVIDENCE-OF: R-07100-06606 A single quote within the string can be
# encoded by putting two single quotes in a row - as in Pascal.
#
do_execsql_test e_expr-10.3.1 { SELECT 'is not' }         {{is not}}
do_execsql_test e_expr-10.3.2 { SELECT typeof('is not') } {text}
do_execsql_test e_expr-10.3.3 { SELECT 'isn''t' }         {isn't}
do_execsql_test e_expr-10.3.4 { SELECT typeof('isn''t') } {text}

# EVIDENCE-OF: R-09593-03321 BLOB literals are string literals
# containing hexadecimal data and preceded by a single "x" or "X"
# character.
#
# EVIDENCE-OF: R-19836-11244 Example: X'53514C697465'
#
do_execsql_test e_expr-10.4.1 { SELECT typeof(X'0123456789ABCDEF') } blob
do_execsql_test e_expr-10.4.2 { SELECT typeof(x'0123456789ABCDEF') } blob
do_execsql_test e_expr-10.4.3 { SELECT typeof(X'0123456789abcdef') } blob
do_execsql_test e_expr-10.4.4 { SELECT typeof(x'0123456789abcdef') } blob
do_execsql_test e_expr-10.4.5 { SELECT typeof(X'53514C697465')     } blob

# EVIDENCE-OF: R-23914-51476 A literal value can also be the token
# "NULL".
#
do_execsql_test e_expr-10.5.1 { SELECT NULL         } {{}}
do_execsql_test e_expr-10.5.2 { SELECT typeof(NULL) } {null}

#-------------------------------------------------------------------------
# Test statements related to bound parameters
#

proc parameter_test {tn sql params result} {
  set stmt [sqlite3_prepare_v2 db $sql -1]

  foreach {number name} $params {
    set nm [sqlite3_bind_parameter_name $stmt $number]
    do_test $tn.name.$number [list set {} $nm] $name
    sqlite3_bind_int $stmt $number [expr -1 * $number]
  }

  sqlite3_step $stmt

  set res [list]
  for {set i 0} {$i < [sqlite3_column_count $stmt]} {incr i} {
    lappend res [sqlite3_column_text $stmt $i]
  }

  set rc [sqlite3_finalize $stmt]
  do_test $tn.rc [list set {} $rc] SQLITE_OK
  do_test $tn.res [list set {} $res] $result
}

# EVIDENCE-OF: R-33509-39458 A question mark followed by a number NNN
# holds a spot for the NNN-th parameter. NNN must be between 1 and
# SQLITE_MAX_VARIABLE_NUMBER.
#
set mvn $SQLITE_MAX_VARIABLE_NUMBER
parameter_test e_expr-11.1 "
  SELECT ?1, ?123, ?$SQLITE_MAX_VARIABLE_NUMBER, ?123, ?4
"   "1 ?1  123 ?123 $mvn ?$mvn 4 ?4"   "-1 -123 -$mvn -123 -4"

set errmsg "variable number must be between ?1 and ?$SQLITE_MAX_VARIABLE_NUMBER"
foreach {tn param_number} [list \
  2  0                                    \
  3  [expr $SQLITE_MAX_VARIABLE_NUMBER+1] \
  4  [expr $SQLITE_MAX_VARIABLE_NUMBER+2] \
  5  12345678903456789034567890234567890  \
  6  2147483648                           \
  7  2147483649                           \
  8  4294967296                           \
  9  4294967297                           \
  10 9223372036854775808                  \
  11 9223372036854775809                  \
  12 18446744073709551616                 \
  13 18446744073709551617                 \
] {
  do_catchsql_test e_expr-11.1.$tn "SELECT ?$param_number" [list 1 $errmsg]
}

# EVIDENCE-OF: R-33670-36097 A question mark that is not followed by a
# number creates a parameter with a number one greater than the largest
# parameter number already assigned.
#
# EVIDENCE-OF: R-42938-07030 If this means the parameter number is
# greater than SQLITE_MAX_VARIABLE_NUMBER, it is an error.
#
parameter_test e_expr-11.2.1 "SELECT ?"          {1 {}}       -1
parameter_test e_expr-11.2.2 "SELECT ?, ?"       {1 {} 2 {}}  {-1 -2}
parameter_test e_expr-11.2.3 "SELECT ?5, ?"      {5 ?5 6 {}}  {-5 -6}
parameter_test e_expr-11.2.4 "SELECT ?, ?5"      {1 {} 5 ?5}  {-1 -5}
parameter_test e_expr-11.2.5 "SELECT ?, ?456, ?" {
  1 {} 456 ?456 457 {}
}  {-1 -456 -457}
parameter_test e_expr-11.2.5 "SELECT ?, ?456, ?4, ?" {
  1 {} 456 ?456 4 ?4 457 {}
}  {-1 -456 -4 -457}
foreach {tn sql} [list                           \
  1  "SELECT ?$mvn, ?"                           \
  2  "SELECT ?[expr $mvn-5], ?, ?, ?, ?, ?, ?"   \
  3  "SELECT ?[expr $mvn], ?5, ?6, ?"            \
] {
  do_catchsql_test e_expr-11.3.$tn $sql [list 1 {too many SQL variables}]
}

# EVIDENCE-OF: R-11620-22743 A colon followed by an identifier name
# holds a spot for a named parameter with the name :AAAA.
#
# Identifiers in SQLite consist of alphanumeric, '_' and '$' characters,
# and any UTF characters with codepoints larger than 127 (non-ASCII 
# characters).
#
parameter_test e_expr-11.2.1 {SELECT :AAAA}         {1 :AAAA}       -1
parameter_test e_expr-11.2.2 {SELECT :123}          {1 :123}        -1
parameter_test e_expr-11.2.3 {SELECT :__}           {1 :__}         -1
parameter_test e_expr-11.2.4 {SELECT :_$_}          {1 :_$_}        -1
parameter_test e_expr-11.2.5 "
  SELECT :\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25
" "1 :\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25" -1
parameter_test e_expr-11.2.6 "SELECT :\u0080" "1 :\u0080" -1

# EVIDENCE-OF: R-49783-61279 An "at" sign works exactly like a colon,
# except that the name of the parameter created is @AAAA.
#
parameter_test e_expr-11.3.1 {SELECT @AAAA}         {1 @AAAA}       -1
parameter_test e_expr-11.3.2 {SELECT @123}          {1 @123}        -1
parameter_test e_expr-11.3.3 {SELECT @__}           {1 @__}         -1
parameter_test e_expr-11.3.4 {SELECT @_$_}          {1 @_$_}        -1
parameter_test e_expr-11.3.5 "
  SELECT @\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25
" "1 @\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25" -1
parameter_test e_expr-11.3.6 "SELECT @\u0080" "1 @\u0080" -1

# EVIDENCE-OF: R-62610-51329 A dollar-sign followed by an identifier
# name also holds a spot for a named parameter with the name $AAAA.
#
# EVIDENCE-OF: R-55025-21042 The identifier name in this case can
# include one or more occurrences of "::" and a suffix enclosed in
# "(...)" containing any text at all.
#
# Note: Looks like an identifier cannot consist entirely of "::" 
# characters or just a suffix. Also, the other named variable characters
# (: and @) work the same way internally. Why not just document it that way?
#
parameter_test e_expr-11.4.1 {SELECT $AAAA}         {1 $AAAA}       -1
parameter_test e_expr-11.4.2 {SELECT $123}          {1 $123}        -1
parameter_test e_expr-11.4.3 {SELECT $__}           {1 $__}         -1
parameter_test e_expr-11.4.4 {SELECT $_$_}          {1 $_$_}        -1
parameter_test e_expr-11.4.5 "
  SELECT \$\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25
" "1 \$\u0e40\u0e2d\u0e28\u0e02\u0e39\u0e40\u0e2d\u0e25" -1
parameter_test e_expr-11.4.6 "SELECT \$\u0080" "1 \$\u0080" -1

parameter_test e_expr-11.5.1 {SELECT $::::a(++--++)} {1 $::::a(++--++)} -1
parameter_test e_expr-11.5.2 {SELECT $::a()} {1 $::a()} -1
parameter_test e_expr-11.5.3 {SELECT $::1(::#$)} {1 $::1(::#$)} -1
 
# EVIDENCE-OF: R-11370-04520 Named parameters are also numbered. The
# number assigned is one greater than the largest parameter number
# already assigned.
#
# EVIDENCE-OF: R-42620-22184 If this means the parameter would be
# assigned a number greater than SQLITE_MAX_VARIABLE_NUMBER, it is an
# error.
#
parameter_test e_expr-11.6.1 "SELECT ?, @abc"    {1 {} 2 @abc} {-1 -2}
parameter_test e_expr-11.6.2 "SELECT ?123, :a1"  {123 ?123 124 :a1} {-123 -124}
parameter_test e_expr-11.6.3 {SELECT $a, ?8, ?, $b, ?2, $c} {
  1 $a 8 ?8 9 {} 10 $b 2 ?2 11 $c
} {-1 -8 -9 -10 -2 -11}
foreach {tn sql} [list                           \
  1  "SELECT ?$mvn, \$::a"                       \
  2  "SELECT ?$mvn, ?4, @a1"                     \
  3  "SELECT ?[expr $mvn-2], :bag, @123, \$x"    \
] {
  do_catchsql_test e_expr-11.7.$tn $sql [list 1 {too many SQL variables}]
}

# EVIDENCE-OF: R-14068-49671 Parameters that are not assigned values
# using sqlite3_bind() are treated as NULL.
#
do_test e_expr-11.7.1 {
  set stmt [sqlite3_prepare_v2 db { SELECT ?, :a, @b, $d } -1]
  sqlite3_step $stmt

  list [sqlite3_column_type $stmt 0] \
       [sqlite3_column_type $stmt 1] \
       [sqlite3_column_type $stmt 2] \
       [sqlite3_column_type $stmt 3] 
} {NULL NULL NULL NULL}
do_test e_expr-11.7.1 { sqlite3_finalize $stmt } SQLITE_OK

#-------------------------------------------------------------------------
# "Test" the syntax diagrams in lang_expr.html.
#
# -- syntax diagram signed-number
#
do_execsql_test e_expr-12.1.1 { SELECT 0, +0, -0 } {0 0 0}
do_execsql_test e_expr-12.1.2 { SELECT 1, +1, -1 } {1 1 -1}
do_execsql_test e_expr-12.1.3 { SELECT 2, +2, -2 } {2 2 -2}
do_execsql_test e_expr-12.1.4 { 
  SELECT 1.4, +1.4, -1.4 
} {1.4 1.4 -1.4}
do_execsql_test e_expr-12.1.5 { 
  SELECT 1.5e+5, +1.5e+5, -1.5e+5 
} {150000.0 150000.0 -150000.0}
do_execsql_test e_expr-12.1.6 { 
  SELECT 0.0001, +0.0001, -0.0001 
} {0.0001 0.0001 -0.0001}

# -- syntax diagram literal-value
#
set sqlite_current_time 1
do_execsql_test e_expr-12.2.1 {SELECT 123}               {123}
do_execsql_test e_expr-12.2.2 {SELECT 123.4e05}          {12340000.0}
do_execsql_test e_expr-12.2.3 {SELECT 'abcde'}           {abcde}
do_execsql_test e_expr-12.2.4 {SELECT X'414243'}         {ABC}
do_execsql_test e_expr-12.2.5 {SELECT NULL}              {{}}
do_execsql_test e_expr-12.2.6 {SELECT CURRENT_TIME}      {00:00:01}
do_execsql_test e_expr-12.2.7 {SELECT CURRENT_DATE}      {1970-01-01}
do_execsql_test e_expr-12.2.8 {SELECT CURRENT_TIMESTAMP} {{1970-01-01 00:00:01}}
set sqlite_current_time 0

# # -- syntax diagram expr
# #
# forcedelete test.db2
# execsql {
#   ATTACH 'test.db2' AS dbname;
#   CREATE TABLE dbname.tblname(cname);
# }

proc glob {args} {return 1}
db function glob glob
db function match glob
db function regexp glob

foreach {tn expr} {
  1 123
  2 123.4e05
  3 'abcde'
  4 X'414243'
  5 NULL
  6 CURRENT_TIME
  7 CURRENT_DATE
  8 CURRENT_TIMESTAMP

  9 ?
 10 ?123
 11 @hello
 12 :world
 13 $tcl
 14 $tcl(array)
  
  15 cname
  16 tblname.cname

  18 "+ EXPR"
  19 "- EXPR"
  20 "NOT EXPR"
  21 "~ EXPR"

  22 "EXPR1 || EXPR2"
  23 "EXPR1 * EXPR2"
  24 "EXPR1 / EXPR2"
  25 "EXPR1 % EXPR2"
  26 "EXPR1 + EXPR2"
  27 "EXPR1 - EXPR2"
  28 "EXPR1 << EXPR2"
  29 "EXPR1 >> EXPR2"
  30 "EXPR1 & EXPR2"
  31 "EXPR1 | EXPR2"
  32 "EXPR1 < EXPR2"
  33 "EXPR1 <= EXPR2"
  34 "EXPR1 > EXPR2"
  35 "EXPR1 >= EXPR2"
  36 "EXPR1 = EXPR2"
  37 "EXPR1 == EXPR2"
  38 "EXPR1 != EXPR2"
  39 "EXPR1 <> EXPR2"
  40 "EXPR1 IS EXPR2"
  41 "EXPR1 IS NOT EXPR2"
  42 "EXPR1 AND EXPR2"
  43 "EXPR1 OR EXPR2"
 
  44 "count(*)"
  45 "count(DISTINCT EXPR)"
  46 "substr(EXPR, 10, 20)"
  47 "changes()"
 
  48 "( EXPR )"
 
  49 "CAST ( EXPR AS integer )"
  50 "CAST ( EXPR AS 'abcd' )"
  51 "CAST ( EXPR AS 'ab$ $cd' )"
 
  52 "EXPR COLLATE nocase"
  53 "EXPR COLLATE binary"
 
  54 "EXPR1 LIKE EXPR2"
  55 "EXPR1 LIKE EXPR2 ESCAPE EXPR"
  56 "EXPR1 GLOB EXPR2"
  57 "EXPR1 GLOB EXPR2 ESCAPE EXPR"
  58 "EXPR1 REGEXP EXPR2"
  59 "EXPR1 REGEXP EXPR2 ESCAPE EXPR"
  60 "EXPR1 MATCH EXPR2"
  61 "EXPR1 MATCH EXPR2 ESCAPE EXPR"
  62 "EXPR1 NOT LIKE EXPR2"
  63 "EXPR1 NOT LIKE EXPR2 ESCAPE EXPR"
  64 "EXPR1 NOT GLOB EXPR2"
  65 "EXPR1 NOT GLOB EXPR2 ESCAPE EXPR"
  66 "EXPR1 NOT REGEXP EXPR2"
  67 "EXPR1 NOT REGEXP EXPR2 ESCAPE EXPR"
  68 "EXPR1 NOT MATCH EXPR2"
  69 "EXPR1 NOT MATCH EXPR2 ESCAPE EXPR"
 
  70 "EXPR ISNULL"
  71 "EXPR NOTNULL"
  72 "EXPR NOT NULL"
 
  73 "EXPR1 IS EXPR2"
  74 "EXPR1 IS NOT EXPR2"

  75 "EXPR NOT BETWEEN EXPR1 AND EXPR2"
  76 "EXPR BETWEEN EXPR1 AND EXPR2"

  77 "EXPR NOT IN (SELECT cname FROM tblname)"
  78 "EXPR NOT IN (1)"
  79 "EXPR NOT IN (1, 2, 3)"
  80 "EXPR NOT IN tblname"
  82 "EXPR IN (SELECT cname FROM tblname)"
  83 "EXPR IN (1)"
  84 "EXPR IN (1, 2, 3)"
  85 "EXPR IN tblname"

  87 "EXISTS (SELECT cname FROM tblname)"
  88 "NOT EXISTS (SELECT cname FROM tblname)"

  89 "CASE EXPR WHEN EXPR1 THEN EXPR2 ELSE EXPR END"
  90 "CASE EXPR WHEN EXPR1 THEN EXPR2 END"
  91 "CASE EXPR WHEN EXPR1 THEN EXPR2 WHEN EXPR THEN EXPR1 ELSE EXPR2 END"
  92 "CASE EXPR WHEN EXPR1 THEN EXPR2 WHEN EXPR THEN EXPR1 END"
  93 "CASE WHEN EXPR1 THEN EXPR2 ELSE EXPR END"
  94 "CASE WHEN EXPR1 THEN EXPR2 END"
  95 "CASE WHEN EXPR1 THEN EXPR2 WHEN EXPR THEN EXPR1 ELSE EXPR2 END"
  96 "CASE WHEN EXPR1 THEN EXPR2 WHEN EXPR THEN EXPR1 END"
} {

  # If the expression string being parsed contains "EXPR2", then replace
  # string "EXPR1" and "EXPR2" with arbitrary SQL expressions. If it 
  # contains "EXPR", then replace EXPR with an arbitrary SQL expression.
  # 
  set elist [list $expr]
  if {[string match *EXPR2* $expr]} {
    set elist [list]
    foreach {e1 e2} { cname "34+22" } {
      lappend elist [string map [list EXPR1 $e1 EXPR2 $e2] $expr]
    }
  } 
  if {[string match *EXPR* $expr]} {
    set elist2 [list]
    foreach el $elist {
      foreach e { cname "34+22" } {
        lappend elist2 [string map [list EXPR $e] $el]
      }
    }
    set elist $elist2
  }

  set x 0
  foreach e $elist {
    incr x
    do_test e_expr-12.3.$tn.$x { 
      set rc [catch { execsql "SELECT $e FROM tblname" } msg]
    } {0}
  }
}

# # -- syntax diagram raise-function
# #
# foreach {tn raiseexpr} {
#   1 "RAISE(IGNORE)"
#   2 "RAISE(ROLLBACK, 'error message')"
#   3 "RAISE(ABORT, 'error message')"
#   4 "RAISE(FAIL, 'error message')"
# } {
#   do_execsql_test e_expr-12.4.$tn "
#     CREATE TRIGGER dbname.tr$tn BEFORE DELETE ON tblname BEGIN
#       SELECT $raiseexpr ;
#     END;
#   " {}
# }

#-------------------------------------------------------------------------
# Test the statements related to the BETWEEN operator.
#
# EVIDENCE-OF: R-40079-54503 The BETWEEN operator is logically
# equivalent to a pair of comparisons. "x BETWEEN y AND z" is equivalent
# to "x>=y AND x<=z" except that with BETWEEN, the x expression is
# only evaluated once.
#
db func x x
proc x {} { incr ::xcount ; return [expr $::x] }
foreach {tn x expr res nEval} {
  1  10  "x() >= 5 AND x() <= 15"  1  2
  2  10  "x() BETWEEN 5 AND 15"    1  1

  3   5  "x() >= 5 AND x() <= 5"   1  2
  4   5  "x() BETWEEN 5 AND 5"     1  1
} {
  do_test e_expr-13.1.$tn {
    set ::xcount 0
    set a [execsql "SELECT $expr"]
    list $::xcount $a
  } [list $nEval $res]
}

# EVIDENCE-OF: R-05155-34454 The precedence of the BETWEEN operator is
# the same as the precedence as operators == and != and LIKE and groups
# left to right.
# 
# Therefore, BETWEEN groups more tightly than operator "AND", but less
# so than "<".
#
do_execsql_test e_expr-13.2.1  { SELECT 1 == 10 BETWEEN 0 AND 2   }  1
do_execsql_test e_expr-13.2.2  { SELECT (1 == 10) BETWEEN 0 AND 2 }  1
do_execsql_test e_expr-13.2.3  { SELECT 1 == (10 BETWEEN 0 AND 2) }  0
do_execsql_test e_expr-13.2.4  { SELECT  6 BETWEEN 4 AND 8 == 1 }    1
do_execsql_test e_expr-13.2.5  { SELECT (6 BETWEEN 4 AND 8) == 1 }   1
do_execsql_test e_expr-13.2.6  { SELECT  6 BETWEEN 4 AND (8 == 1) }  0

do_execsql_test e_expr-13.2.7  { SELECT  5 BETWEEN 0 AND 0  != 1 }   1
do_execsql_test e_expr-13.2.8  { SELECT (5 BETWEEN 0 AND 0) != 1 }   1
do_execsql_test e_expr-13.2.9  { SELECT  5 BETWEEN 0 AND (0 != 1) }  0
do_execsql_test e_expr-13.2.10 { SELECT  1 != 0  BETWEEN 0 AND 2  }  1
do_execsql_test e_expr-13.2.11 { SELECT (1 != 0) BETWEEN 0 AND 2  }  1
do_execsql_test e_expr-13.2.12 { SELECT  1 != (0 BETWEEN 0 AND 2) }  0

do_execsql_test e_expr-13.2.13 { SELECT 1 LIKE 10 BETWEEN 0 AND 2   }  1
do_execsql_test e_expr-13.2.14 { SELECT (1 LIKE 10) BETWEEN 0 AND 2 }  1
do_execsql_test e_expr-13.2.15 { SELECT 1 LIKE (10 BETWEEN 0 AND 2) }  0
do_execsql_test e_expr-13.2.16 { SELECT  6 BETWEEN 4 AND 8 LIKE 1   }  1
do_execsql_test e_expr-13.2.17 { SELECT (6 BETWEEN 4 AND 8) LIKE 1  }  1
do_execsql_test e_expr-13.2.18 { SELECT  6 BETWEEN 4 AND (8 LIKE 1) }  0

do_execsql_test e_expr-13.2.19 { SELECT 0 AND 0 BETWEEN 0 AND 1   } 0
do_execsql_test e_expr-13.2.20 { SELECT 0 AND (0 BETWEEN 0 AND 1) } 0
do_execsql_test e_expr-13.2.21 { SELECT (0 AND 0) BETWEEN 0 AND 1 } 1
do_execsql_test e_expr-13.2.22 { SELECT 0 BETWEEN -1 AND 1 AND 0   } 0
do_execsql_test e_expr-13.2.23 { SELECT (0 BETWEEN -1 AND 1) AND 0 } 0
do_execsql_test e_expr-13.2.24 { SELECT 0 BETWEEN -1 AND (1 AND 0) } 1

do_execsql_test e_expr-13.2.25 { SELECT 2 < 3 BETWEEN 0 AND 1   } 1
do_execsql_test e_expr-13.2.26 { SELECT (2 < 3) BETWEEN 0 AND 1 } 1
do_execsql_test e_expr-13.2.27 { SELECT 2 < (3 BETWEEN 0 AND 1) } 0
do_execsql_test e_expr-13.2.28 { SELECT 2 BETWEEN 1 AND 2 < 3    } 0
do_execsql_test e_expr-13.2.29 { SELECT 2 BETWEEN 1 AND (2 < 3)  } 0
do_execsql_test e_expr-13.2.30 { SELECT (2 BETWEEN 1 AND 2) < 3  } 1

#-------------------------------------------------------------------------
# Test the statements related to the LIKE and GLOB operators.
#
# EVIDENCE-OF: R-16584-60189 The LIKE operator does a pattern matching
# comparison.
#
# EVIDENCE-OF: R-11295-04657 The operand to the right of the LIKE
# operator contains the pattern and the left hand operand contains the
# string to match against the pattern.
#
do_execsql_test e_expr-14.1.1 { SELECT 'abc%' LIKE 'abcde' } 0
do_execsql_test e_expr-14.1.2 { SELECT 'abcde' LIKE 'abc%' } 1

# EVIDENCE-OF: R-55406-38524 A percent symbol ("%") in the LIKE pattern
# matches any sequence of zero or more characters in the string.
#
do_execsql_test e_expr-14.2.1 { SELECT 'abde'    LIKE 'ab%de' } 1
do_execsql_test e_expr-14.2.2 { SELECT 'abXde'   LIKE 'ab%de' } 1
do_execsql_test e_expr-14.2.3 { SELECT 'abABCde' LIKE 'ab%de' } 1

# EVIDENCE-OF: R-30433-25443 An underscore ("_") in the LIKE pattern
# matches any single character in the string.
#
do_execsql_test e_expr-14.3.1 { SELECT 'abde'    LIKE 'ab_de' } 0
do_execsql_test e_expr-14.3.2 { SELECT 'abXde'   LIKE 'ab_de' } 1
do_execsql_test e_expr-14.3.3 { SELECT 'abABCde' LIKE 'ab_de' } 0

# EVIDENCE-OF: R-59007-20454 Any other character matches itself or its
# lower/upper case equivalent (i.e. case-insensitive matching).
#
do_execsql_test e_expr-14.4.1 { SELECT 'abc' LIKE 'aBc' } 1
do_execsql_test e_expr-14.4.2 { SELECT 'aBc' LIKE 'aBc' } 1
do_execsql_test e_expr-14.4.3 { SELECT 'ac'  LIKE 'aBc' } 0

# EVIDENCE-OF: R-23648-58527 SQLite only understands upper/lower case
# for ASCII characters by default.
#
# EVIDENCE-OF: R-04532-11527 The LIKE operator is case sensitive by
# default for unicode characters that are beyond the ASCII range.
#
# EVIDENCE-OF: R-44381-11669 the expression
# 'a'&nbsp;LIKE&nbsp;'A' is TRUE but
# '&aelig;'&nbsp;LIKE&nbsp;'&AElig;' is FALSE.
#
#   The restriction to ASCII characters does not apply if the ICU
#   library is compiled in. When ICU is enabled SQLite does not act
#   as it does "by default".
#
do_execsql_test e_expr-14.5.1 { SELECT 'A' LIKE 'a'         } 1
ifcapable !icu {
  do_execsql_test e_expr-14.5.2 "SELECT '\u00c6' LIKE '\u00e6'" 0
}

# EVIDENCE-OF: R-56683-13731 If the optional ESCAPE clause is present,
# then the expression following the ESCAPE keyword must evaluate to a
# string consisting of a single character.
#
do_catchsql_test e_expr-14.6.1 { 
  SELECT 'A' LIKE 'a' ESCAPE '12' 
} {1 {ESCAPE expression must be a single character}}
do_catchsql_test e_expr-14.6.2 { 
  SELECT 'A' LIKE 'a' ESCAPE '' 
} {1 {ESCAPE expression must be a single character}}
do_catchsql_test e_expr-14.6.3 { SELECT 'A' LIKE 'a' ESCAPE 'x' }    {0 1}
do_catchsql_test e_expr-14.6.4 "SELECT 'A' LIKE 'a' ESCAPE '\u00e6'" {0 1}

# EVIDENCE-OF: R-02045-23762 This character may be used in the LIKE
# pattern to include literal percent or underscore characters.
#
# EVIDENCE-OF: R-13345-31830 The escape character followed by a percent
# symbol (%), underscore (_), or a second instance of the escape
# character itself matches a literal percent symbol, underscore, or a
# single escape character, respectively.
#
do_execsql_test e_expr-14.7.1  { SELECT 'abc%'  LIKE 'abcX%' ESCAPE 'X' } 1
do_execsql_test e_expr-14.7.2  { SELECT 'abc5'  LIKE 'abcX%' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.3  { SELECT 'abc'   LIKE 'abcX%' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.4  { SELECT 'abcX%' LIKE 'abcX%' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.5  { SELECT 'abc%%' LIKE 'abcX%' ESCAPE 'X' } 0

do_execsql_test e_expr-14.7.6  { SELECT 'abc_'  LIKE 'abcX_' ESCAPE 'X' } 1
do_execsql_test e_expr-14.7.7  { SELECT 'abc5'  LIKE 'abcX_' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.8  { SELECT 'abc'   LIKE 'abcX_' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.9  { SELECT 'abcX_' LIKE 'abcX_' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.10 { SELECT 'abc__' LIKE 'abcX_' ESCAPE 'X' } 0

do_execsql_test e_expr-14.7.11 { SELECT 'abcX'  LIKE 'abcXX' ESCAPE 'X' } 1
do_execsql_test e_expr-14.7.12 { SELECT 'abc5'  LIKE 'abcXX' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.13 { SELECT 'abc'   LIKE 'abcXX' ESCAPE 'X' } 0
do_execsql_test e_expr-14.7.14 { SELECT 'abcXX' LIKE 'abcXX' ESCAPE 'X' } 0

# EVIDENCE-OF: R-51359-17496 The infix LIKE operator is implemented by
# calling the application-defined SQL functions like(Y,X) or like(Y,X,Z).
#
proc likefunc {args} {
  eval lappend ::likeargs $args
  return 1
}
db func like -argcount 2 likefunc
db func like -argcount 3 likefunc
set ::likeargs [list]
do_execsql_test e_expr-15.1.1 { SELECT 'abc' LIKE 'def' } 1
do_test         e_expr-15.1.2 { set likeargs } {def abc}
set ::likeargs [list]
do_execsql_test e_expr-15.1.3 { SELECT 'abc' LIKE 'def' ESCAPE 'X' } 1
do_test         e_expr-15.1.4 { set likeargs } {def abc X}
db close
sqlite3 db test.db

# EVIDENCE-OF: R-22868-25880 The LIKE operator can be made case
# sensitive using the case_sensitive_like pragma.
#
do_execsql_test e_expr-16.1.1 { SELECT 'abcxyz' LIKE 'ABC%' } 1
do_execsql_test e_expr-16.1.2 { PRAGMA case_sensitive_like = 1 } {}
do_execsql_test e_expr-16.1.3 { SELECT 'abcxyz' LIKE 'ABC%' } 0
do_execsql_test e_expr-16.1.4 { SELECT 'ABCxyz' LIKE 'ABC%' } 1
do_execsql_test e_expr-16.1.5 { PRAGMA case_sensitive_like = 0 } {}
do_execsql_test e_expr-16.1.6 { SELECT 'abcxyz' LIKE 'ABC%' } 1
do_execsql_test e_expr-16.1.7 { SELECT 'ABCxyz' LIKE 'ABC%' } 1

# EVIDENCE-OF: R-52087-12043 The GLOB operator is similar to LIKE but
# uses the Unix file globbing syntax for its wildcards.
#
# EVIDENCE-OF: R-09813-17279 Also, GLOB is case sensitive, unlike LIKE.
#
do_execsql_test e_expr-17.1.1 { SELECT 'abcxyz' GLOB 'abc%' } 0
do_execsql_test e_expr-17.1.2 { SELECT 'abcxyz' GLOB 'abc*' } 1
do_execsql_test e_expr-17.1.3 { SELECT 'abcxyz' GLOB 'abc___' } 0
do_execsql_test e_expr-17.1.4 { SELECT 'abcxyz' GLOB 'abc???' } 1

do_execsql_test e_expr-17.1.5 { SELECT 'abcxyz' GLOB 'abc*' } 1
do_execsql_test e_expr-17.1.6 { SELECT 'ABCxyz' GLOB 'abc*' } 0
do_execsql_test e_expr-17.1.7 { SELECT 'abcxyz' GLOB 'ABC*' } 0

# EVIDENCE-OF: R-39616-20555 Both GLOB and LIKE may be preceded by the
# NOT keyword to invert the sense of the test.
#
do_execsql_test e_expr-17.2.1 { SELECT 'abcxyz' NOT GLOB 'ABC*' } 1
do_execsql_test e_expr-17.2.2 { SELECT 'abcxyz' NOT GLOB 'abc*' } 0
do_execsql_test e_expr-17.2.3 { SELECT 'abcxyz' NOT LIKE 'ABC%' } 0
do_execsql_test e_expr-17.2.4 { SELECT 'abcxyz' NOT LIKE 'abc%' } 0
do_execsql_test e_expr-17.2.5 { SELECT 'abdxyz' NOT LIKE 'abc%' } 1

db nullvalue null
do_execsql_test e_expr-17.2.6 { SELECT 'abcxyz' NOT GLOB NULL } null
do_execsql_test e_expr-17.2.7 { SELECT 'abcxyz' NOT LIKE NULL } null
do_execsql_test e_expr-17.2.8 { SELECT NULL NOT GLOB 'abc*' } null
do_execsql_test e_expr-17.2.9 { SELECT NULL NOT LIKE 'ABC%' } null
db nullvalue {}

# EVIDENCE-OF: R-39414-35489 The infix GLOB operator is implemented by
# calling the function glob(Y,X) and can be modified by overriding that
# function.
proc globfunc {args} {
  eval lappend ::globargs $args
  return 1
}
db func glob -argcount 2 globfunc
set ::globargs [list]
do_execsql_test e_expr-17.3.1 { SELECT 'abc' GLOB 'def' } 1
do_test         e_expr-17.3.2 { set globargs } {def abc}
set ::globargs [list]
do_execsql_test e_expr-17.3.3 { SELECT 'X' NOT GLOB 'Y' } 0
do_test         e_expr-17.3.4 { set globargs } {Y X}
sqlite3 db test.db

# EVIDENCE-OF: R-41650-20872 No regexp() user function is defined by
# default and so use of the REGEXP operator will normally result in an
# error message.
#
#   There is a regexp function if ICU is enabled though.
#
ifcapable !icu {
  do_catchsql_test e_expr-18.1.1 { 
    SELECT regexp('abc', 'def') 
  } {1 {no such function: regexp}}
  do_catchsql_test e_expr-18.1.2 { 
    SELECT 'abc' REGEXP 'def'
  } {1 {no such function: REGEXP}}
}

# EVIDENCE-OF: R-33693-50180 The REGEXP operator is a special syntax for
# the regexp() user function.
#
# EVIDENCE-OF: R-65524-61849 If an application-defined SQL function
# named "regexp" is added at run-time, then the "X REGEXP Y" operator
# will be implemented as a call to "regexp(Y,X)".
#
proc regexpfunc {args} {
  eval lappend ::regexpargs $args
  return 1
}
db func regexp -argcount 2 regexpfunc
set ::regexpargs [list]
do_execsql_test e_expr-18.2.1 { SELECT 'abc' REGEXP 'def' } 1
do_test         e_expr-18.2.2 { set regexpargs } {def abc}
set ::regexpargs [list]
do_execsql_test e_expr-18.2.3 { SELECT 'X' NOT REGEXP 'Y' } 0
do_test         e_expr-18.2.4 { set regexpargs } {Y X}
sqlite3 db test.db

# EVIDENCE-OF: R-42037-37826 The default match() function implementation
# raises an exception and is not really useful for anything.
#
do_catchsql_test e_expr-19.1.1 { 
  SELECT 'abc' MATCH 'def' 
} {1 {unable to use function MATCH in the requested context}}
do_catchsql_test e_expr-19.1.2 { 
  SELECT match('abc', 'def')
} {1 {unable to use function MATCH in the requested context}}

# EVIDENCE-OF: R-37916-47407 The MATCH operator is a special syntax for
# the match() application-defined function.
#
# EVIDENCE-OF: R-06021-09373 But extensions can override the match()
# function with more helpful logic.
#
proc matchfunc {args} {
  eval lappend ::matchargs $args
  return 1
}
db func match -argcount 2 matchfunc
set ::matchargs [list]
do_execsql_test e_expr-19.2.1 { SELECT 'abc' MATCH 'def' } 1
do_test         e_expr-19.2.2 { set matchargs } {def abc}
set ::matchargs [list]
do_execsql_test e_expr-19.2.3 { SELECT 'X' NOT MATCH 'Y' } 0
do_test         e_expr-19.2.4 { set matchargs } {Y X}
sqlite3 db test.db

#-------------------------------------------------------------------------
# Test cases for the testable statements related to the CASE expression.
#
# EVIDENCE-OF: R-15199-61389 There are two basic forms of the CASE
# expression: those with a base expression and those without.
#
do_execsql_test e_expr-20.1 {
  SELECT CASE WHEN 1 THEN 'true' WHEN 0 THEN 'false' ELSE 'else' END;
} {true}
do_execsql_test e_expr-20.2 {
  SELECT CASE 0 WHEN 1 THEN 'true' WHEN 0 THEN 'false' ELSE 'else' END;
} {false}

proc var {nm} {
  lappend ::varlist $nm
  return [set "::$nm"]
}
db func var var

# EVIDENCE-OF: R-30638-59954 In a CASE without a base expression, each
# WHEN expression is evaluated and the result treated as a boolean,
# starting with the leftmost and continuing to the right.
#
foreach {a b c} {0 0 0} break
set varlist [list]
do_execsql_test e_expr-21.1.1 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C' END
} {{}}
do_test e_expr-21.1.2 { set varlist } {a b c}
set varlist [list]
do_execsql_test e_expr-21.1.3 {
  SELECT CASE WHEN var('c') THEN 'C' 
              WHEN var('b') THEN 'B' 
              WHEN var('a') THEN 'A' 
              ELSE 'no result'
  END
} {{no result}}
do_test e_expr-21.1.4 { set varlist } {c b a}

# EVIDENCE-OF: R-39009-25596 The result of the CASE expression is the
# evaluation of the THEN expression that corresponds to the first WHEN
# expression that evaluates to true.
#
foreach {a b c} {0 1 0} break
do_execsql_test e_expr-21.2.1 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C' 
              ELSE 'no result'
  END
} {B}
foreach {a b c} {0 1 1} break
do_execsql_test e_expr-21.2.2 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C'
              ELSE 'no result'
  END
} {B}
foreach {a b c} {0 0 1} break
do_execsql_test e_expr-21.2.3 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C'
              ELSE 'no result'
  END
} {C}

# EVIDENCE-OF: R-24227-04807 Or, if none of the WHEN expressions
# evaluate to true, the result of evaluating the ELSE expression, if
# any.
#
foreach {a b c} {0 0 0} break
do_execsql_test e_expr-21.3.1 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C'
              ELSE 'no result'
  END
} {{no result}}

# EVIDENCE-OF: R-14168-07579 If there is no ELSE expression and none of
# the WHEN expressions are true, then the overall result is NULL.
#
db nullvalue null
do_execsql_test e_expr-21.3.2 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C'
  END
} {null}
db nullvalue {}

# EVIDENCE-OF: R-13943-13592 A NULL result is considered untrue when
# evaluating WHEN terms.
#
do_execsql_test e_expr-21.4.1 {
  SELECT CASE WHEN NULL THEN 'A' WHEN 1 THEN 'B' END
} {B}
do_execsql_test e_expr-21.4.2 {
  SELECT CASE WHEN 0 THEN 'A' WHEN NULL THEN 'B' ELSE 'C' END
} {C}

# EVIDENCE-OF: R-38620-19499 In a CASE with a base expression, the base
# expression is evaluated just once and the result is compared against
# the evaluation of each WHEN expression from left to right.
#
# Note: This test case tests the "evaluated just once" part of the above
# statement. Tests associated with the next two statements test that the
# comparisons take place.
#
foreach {a b c} [list [expr 3] [expr 4] [expr 5]] break
set ::varlist [list]
do_execsql_test e_expr-22.1.1 {
  SELECT CASE var('a') WHEN 1 THEN 'A' WHEN 2 THEN 'B' WHEN 3 THEN 'C' END
} {C}
do_test e_expr-22.1.2 { set ::varlist } {a}

# EVIDENCE-OF: R-07667-49537 The result of the CASE expression is the
# evaluation of the THEN expression that corresponds to the first WHEN
# expression for which the comparison is true.
#
do_execsql_test e_expr-22.2.1 {
  SELECT CASE 23 WHEN 1 THEN 'A' WHEN 23 THEN 'B' WHEN 23 THEN 'C' END
} {B}
do_execsql_test e_expr-22.2.2 {
  SELECT CASE 1 WHEN 1 THEN 'A' WHEN 23 THEN 'B' WHEN 23 THEN 'C' END
} {A}

# EVIDENCE-OF: R-47543-32145 Or, if none of the WHEN expressions
# evaluate to a value equal to the base expression, the result of
# evaluating the ELSE expression, if any.
#
do_execsql_test e_expr-22.3.1 {
  SELECT CASE 24 WHEN 1 THEN 'A' WHEN 23 THEN 'B' WHEN 23 THEN 'C' ELSE 'D' END
} {D}

# EVIDENCE-OF: R-54721-48557 If there is no ELSE expression and none of
# the WHEN expressions produce a result equal to the base expression,
# the overall result is NULL.
#
do_execsql_test e_expr-22.4.1 {
  SELECT CASE 24 WHEN 1 THEN 'A' WHEN 23 THEN 'B' WHEN 23 THEN 'C' END
} {{}}
db nullvalue null
do_execsql_test e_expr-22.4.2 {
  SELECT CASE 24 WHEN 1 THEN 'A' WHEN 23 THEN 'B' WHEN 23 THEN 'C' END
} {null}
db nullvalue {}

# # EVIDENCE-OF: R-11479-62774 When comparing a base expression against a
# # WHEN expression, the same collating sequence, affinity, and
# # NULL-handling rules apply as if the base expression and WHEN
# # expression are respectively the left- and right-hand operands of an =
# # operator.
# #
# proc rev {str} {
#   set ret ""
#   set chars [split $str]
#   for {set i [expr [llength $chars]-1]} {$i>=0} {incr i -1} {
#     append ret [lindex $chars $i]
#   }
#   set ret
# }
# proc reverse {lhs rhs} {
#   string compare [rev $lhs] [rev $rhs]
# }
# db collate reverse reverse
# do_execsql_test e_expr-23.1.1 {
#   CREATE TABLE t1(
#     a TEXT     COLLATE NOCASE,
#     b          COLLATE REVERSE,
#     c INTEGER,
#     d BLOB
#   );
#   INSERT INTO t1 VALUES('abc', 'cba', 55, 34.5);
# } {}
# do_execsql_test e_expr-23.1.2 {
#   SELECT CASE a WHEN 'xyz' THEN 'A' WHEN 'AbC' THEN 'B' END FROM t1
# } {B}
# do_execsql_test e_expr-23.1.3 {
#   SELECT CASE 'AbC' WHEN 'abc' THEN 'A' WHEN a THEN 'B' END FROM t1
# } {B}
# do_execsql_test e_expr-23.1.4 {
#   SELECT CASE a WHEN b THEN 'A' ELSE 'B' END FROM t1
# } {B}
# do_execsql_test e_expr-23.1.5 {
#   SELECT CASE b WHEN a THEN 'A' ELSE 'B' END FROM t1
# } {B}
# do_execsql_test e_expr-23.1.6 {
#   SELECT CASE 55 WHEN '55' THEN 'A' ELSE 'B' END
# } {B}
# do_execsql_test e_expr-23.1.7 {
#   SELECT CASE c WHEN '55' THEN 'A' ELSE 'B' END FROM t1
# } {A}
# do_execsql_test e_expr-23.1.8 {
#   SELECT CASE '34.5' WHEN d THEN 'A' ELSE 'B' END FROM t1
# } {B}
# do_execsql_test e_expr-23.1.9 {
#   SELECT CASE NULL WHEN NULL THEN 'A' ELSE 'B' END
# } {B}

# EVIDENCE-OF: R-37304-39405 If the base expression is NULL then the
# result of the CASE is always the result of evaluating the ELSE
# expression if it exists, or NULL if it does not.
#
do_execsql_test e_expr-24.1.1 {
  SELECT CASE NULL WHEN 'abc' THEN 'A' WHEN 'def' THEN 'B' END;
} {{}}
do_execsql_test e_expr-24.1.2 {
  SELECT CASE NULL WHEN 'abc' THEN 'A' WHEN 'def' THEN 'B' ELSE 'C' END;
} {C}

# EVIDENCE-OF: R-56280-17369 Both forms of the CASE expression use lazy,
# or short-circuit, evaluation.
#
set varlist [list]
foreach {a b c} {0 1 0} break
do_execsql_test e_expr-25.1.1 {
  SELECT CASE WHEN var('a') THEN 'A' 
              WHEN var('b') THEN 'B' 
              WHEN var('c') THEN 'C' 
  END
} {B}
do_test e_expr-25.1.2 { set ::varlist } {a b}
set varlist [list]
do_execsql_test e_expr-25.1.3 {
  SELECT CASE '0' WHEN var('a') THEN 'A' 
                  WHEN var('b') THEN 'B' 
                  WHEN var('c') THEN 'C' 
  END
} {A}
do_test e_expr-25.1.4 { set ::varlist } {a}

# EVIDENCE-OF: R-34773-62253 The only difference between the following
# two CASE expressions is that the x expression is evaluated exactly
# once in the first example but might be evaluated multiple times in the
# second: CASE x WHEN w1 THEN r1 WHEN w2 THEN r2 ELSE r3 END CASE WHEN
# x=w1 THEN r1 WHEN x=w2 THEN r2 ELSE r3 END
#
proc ceval {x} {
  incr ::evalcount
  return $x
}
db func ceval ceval
set ::evalcount 0

do_execsql_test e_expr-26.1.1 {
  CREATE TABLE t2(x PRIMARY KEY, w1, r1, w2, r2, r3);
  INSERT INTO t2 VALUES(1, 1, 'R1', 2, 'R2', 'R3');
  INSERT INTO t2 VALUES(2, 1, 'R1', 2, 'R2', 'R3');
  INSERT INTO t2 VALUES(3, 1, 'R1', 2, 'R2', 'R3');
} {}
do_execsql_test e_expr-26.1.2 {
  SELECT CASE x WHEN w1 THEN r1 WHEN w2 THEN r2 ELSE r3 END FROM t2
} {R1 R2 R3}
do_execsql_test e_expr-26.1.3 {
  SELECT CASE WHEN x=w1 THEN r1 WHEN x=w2 THEN r2 ELSE r3 END FROM t2
} {R1 R2 R3}

do_execsql_test e_expr-26.1.4 {
  SELECT CASE ceval(x) WHEN w1 THEN r1 WHEN w2 THEN r2 ELSE r3 END FROM t2
} {R1 R2 R3}
do_test e_expr-26.1.5 { set ::evalcount } {3}
set ::evalcount 0
do_execsql_test e_expr-26.1.6 {
  SELECT CASE 
    WHEN ceval(x)=w1 THEN r1 
    WHEN ceval(x)=w2 THEN r2 
    ELSE r3 END 
  FROM t2
} {R1 R2 R3}
do_test e_expr-26.1.6 { set ::evalcount } {5}


#-------------------------------------------------------------------------
# Test statements related to CAST expressions.
#
# EVIDENCE-OF: R-20854-17109 A CAST conversion is similar to the
# conversion that takes place when a column affinity is applied to a
# value except that with the CAST operator the conversion always takes
# place even if the conversion lossy and irreversible, whereas column
# affinity only changes the data type of a value if the change is
# lossless and reversible.
#
do_execsql_test e_expr-27.1.1 {
  CREATE TABLE t3(a TEXT PRIMARY KEY, b REAL, c INTEGER);
  INSERT INTO t3 VALUES(X'555655', '1.23abc', 4.5);
  SELECT typeof(a), a, typeof(b), b, typeof(c), c FROM t3;
} {blob UVU text 1.23abc real 4.5}
do_execsql_test e_expr-27.1.2 {
  SELECT 
    typeof(CAST(X'555655' as TEXT)), CAST(X'555655' as TEXT),
    typeof(CAST('1.23abc' as REAL)), CAST('1.23abc' as REAL),
    typeof(CAST(4.5 as INTEGER)), CAST(4.5 as INTEGER)
} {text UVU real 1.23 integer 4}

# EVIDENCE-OF: R-32434-09092 If the value of expr is NULL, then the
# result of the CAST expression is also NULL.
#
do_expr_test e_expr-27.2.1 { CAST(NULL AS integer) } null {}
do_expr_test e_expr-27.2.2 { CAST(NULL AS text) }    null {}
do_expr_test e_expr-27.2.3 { CAST(NULL AS blob) }    null {}
do_expr_test e_expr-27.2.4 { CAST(NULL AS number) }  null {}

# EVIDENCE-OF: R-43522-35548 Casting a value to a type-name with no
# affinity causes the value to be converted into a BLOB.
#
do_expr_test e_expr-27.3.1 { CAST('abc' AS blob)       } blob abc
do_expr_test e_expr-27.3.2 { CAST('def' AS shobblob_x) } blob def
do_expr_test e_expr-27.3.3 { CAST('ghi' AS abbLOb10)   } blob ghi

# EVIDENCE-OF: R-22956-37754 Casting to a BLOB consists of first casting
# the value to TEXT in the encoding of the database connection, then
# interpreting the resulting byte sequence as a BLOB instead of as TEXT.
#
do_qexpr_test e_expr-27.4.1 { CAST('ghi' AS blob) } X'676869'
do_qexpr_test e_expr-27.4.2 { CAST(456 AS blob) }   X'343536'
do_qexpr_test e_expr-27.4.3 { CAST(1.78 AS blob) }  X'312E3738'
rename db db2
sqlite3 db :memory:
ifcapable {utf16} {
db eval { PRAGMA encoding = 'utf-16le' }
do_qexpr_test e_expr-27.4.4 { CAST('ghi' AS blob) } X'670068006900'
do_qexpr_test e_expr-27.4.5 { CAST(456 AS blob) }   X'340035003600'
do_qexpr_test e_expr-27.4.6 { CAST(1.78 AS blob) }  X'31002E0037003800'
}
db close
sqlite3 db :memory:
db eval { PRAGMA encoding = 'utf-16be' }
ifcapable {utf16} {
do_qexpr_test e_expr-27.4.7 { CAST('ghi' AS blob) } X'006700680069'
do_qexpr_test e_expr-27.4.8 { CAST(456 AS blob) }   X'003400350036'
do_qexpr_test e_expr-27.4.9 { CAST(1.78 AS blob) }  X'0031002E00370038'
}
db close
rename db2 db

# EVIDENCE-OF: R-04207-37981 To cast a BLOB value to TEXT, the sequence
# of bytes that make up the BLOB is interpreted as text encoded using
# the database encoding.
#
do_expr_test e_expr-28.1.1 { CAST (X'676869' AS text) } text ghi
do_expr_test e_expr-28.1.2 { CAST (X'670068006900' AS text) } text g
rename db db2
sqlite3 db :memory:
db eval { PRAGMA encoding = 'utf-16le' }
ifcapable {utf16} {
do_expr_test e_expr-28.1.3 { CAST (X'676869' AS text) == 'ghi' } integer 0
do_expr_test e_expr-28.1.4 { CAST (X'670068006900' AS text) } text ghi
}
db close
rename db2 db

# EVIDENCE-OF: R-22235-47006 Casting an INTEGER or REAL value into TEXT
# renders the value as if via sqlite3_snprintf() except that the
# resulting TEXT uses the encoding of the database connection.
#
do_expr_test e_expr-28.2.1 { CAST (1 AS text)   }     text 1
do_expr_test e_expr-28.2.2 { CAST (45 AS text)  }     text 45
do_expr_test e_expr-28.2.3 { CAST (-45 AS text) }     text -45
do_expr_test e_expr-28.2.4 { CAST (8.8 AS text)    }  text 8.8
do_expr_test e_expr-28.2.5 { CAST (2.3e+5 AS text) }  text 230000.0
do_expr_test e_expr-28.2.6 { CAST (-2.3e-5 AS text) } text -2.3e-05
do_expr_test e_expr-28.2.7 { CAST (0.0 AS text) }     text 0.0
do_expr_test e_expr-28.2.7 { CAST (0 AS text) }       text 0

# EVIDENCE-OF: R-26346-36443 When casting a BLOB value to a REAL, the
# value is first converted to TEXT.
#
do_expr_test e_expr-29.1.1 { CAST (X'312E3233' AS REAL) } real 1.23
do_expr_test e_expr-29.1.2 { CAST (X'3233302E30' AS REAL) } real 230.0
do_expr_test e_expr-29.1.3 { CAST (X'2D392E3837' AS REAL) } real -9.87
do_expr_test e_expr-29.1.4 { CAST (X'302E30303031' AS REAL) } real 0.0001
rename db db2
sqlite3 db :memory:
ifcapable {utf16} {
db eval { PRAGMA encoding = 'utf-16le' }
do_expr_test e_expr-29.1.5 { 
    CAST (X'31002E0032003300' AS REAL) } real 1.23
do_expr_test e_expr-29.1.6 { 
    CAST (X'3200330030002E003000' AS REAL) } real 230.0
do_expr_test e_expr-29.1.7 { 
    CAST (X'2D0039002E0038003700' AS REAL) } real -9.87
do_expr_test e_expr-29.1.8 { 
    CAST (X'30002E003000300030003100' AS REAL) } real 0.0001
}
db close
rename db2 db

# EVIDENCE-OF: R-54898-34554 When casting a TEXT value to REAL, the
# longest possible prefix of the value that can be interpreted as a real
# number is extracted from the TEXT value and the remainder ignored.
#
do_expr_test e_expr-29.2.1 { CAST('1.23abcd' AS REAL) } real 1.23
do_expr_test e_expr-29.2.2 { CAST('1.45.23abcd' AS REAL) } real 1.45
do_expr_test e_expr-29.2.3 { CAST('-2.12e-01ABC' AS REAL) } real -0.212
do_expr_test e_expr-29.2.4 { CAST('1 2 3 4' AS REAL) } real 1.0

# EVIDENCE-OF: R-11321-47427 Any leading spaces in the TEXT value are
# ignored when converging from TEXT to REAL.
#
do_expr_test e_expr-29.3.1 { CAST(' 1.23abcd' AS REAL) } real 1.23
do_expr_test e_expr-29.3.2 { CAST('    1.45.23abcd' AS REAL) } real 1.45
do_expr_test e_expr-29.3.3 { CAST('   -2.12e-01ABC' AS REAL) } real -0.212
do_expr_test e_expr-29.3.4 { CAST(' 1 2 3 4' AS REAL) } real 1.0

# EVIDENCE-OF: R-22662-28218 If there is no prefix that can be
# interpreted as a real number, the result of the conversion is 0.0.
#
do_expr_test e_expr-29.4.1 { CAST('' AS REAL) } real 0.0
do_expr_test e_expr-29.4.2 { CAST('not a number' AS REAL) } real 0.0
do_expr_test e_expr-29.4.3 { CAST('XXI' AS REAL) } real 0.0

# EVIDENCE-OF: R-21829-14563 When casting a BLOB value to INTEGER, the
# value is first converted to TEXT.
#
do_expr_test e_expr-30.1.1 { CAST(X'313233' AS INTEGER) } integer 123
do_expr_test e_expr-30.1.2 { CAST(X'2D363738' AS INTEGER) } integer -678
do_expr_test e_expr-30.1.3 { 
  CAST(X'31303030303030' AS INTEGER) 
} integer 1000000
do_expr_test e_expr-30.1.4 { 
  CAST(X'2D31313235383939393036383432363234' AS INTEGER) 
} integer -1125899906842624

rename db db2
sqlite3 db :memory:
ifcapable {utf16} {
execsql { PRAGMA encoding = 'utf-16be' }
do_expr_test e_expr-30.1.5 { CAST(X'003100320033' AS INTEGER) } integer 123
do_expr_test e_expr-30.1.6 { CAST(X'002D003600370038' AS INTEGER) } integer -678
do_expr_test e_expr-30.1.7 { 
  CAST(X'0031003000300030003000300030' AS INTEGER) 
} integer 1000000
do_expr_test e_expr-30.1.8 { 
  CAST(X'002D0031003100320035003800390039003900300036003800340032003600320034' AS INTEGER) 
} integer -1125899906842624
}
db close
rename db2 db

# EVIDENCE-OF: R-47612-45842 When casting a TEXT value to INTEGER, the
# longest possible prefix of the value that can be interpreted as an
# integer number is extracted from the TEXT value and the remainder
# ignored.
#
do_expr_test e_expr-30.2.1 { CAST('123abcd' AS INT) } integer 123
do_expr_test e_expr-30.2.2 { CAST('14523abcd' AS INT) } integer 14523
do_expr_test e_expr-30.2.3 { CAST('-2.12e-01ABC' AS INT) } integer -2
do_expr_test e_expr-30.2.4 { CAST('1 2 3 4' AS INT) } integer 1

# EVIDENCE-OF: R-34400-33772 Any leading spaces in the TEXT value when
# converting from TEXT to INTEGER are ignored.
#
do_expr_test e_expr-30.3.1 { CAST('   123abcd' AS INT) } integer 123
do_expr_test e_expr-30.3.2 { CAST('  14523abcd' AS INT) } integer 14523
do_expr_test e_expr-30.3.3 { CAST(' -2.12e-01ABC' AS INT) } integer -2
do_expr_test e_expr-30.3.4 { CAST('     1 2 3 4' AS INT) } integer 1

# EVIDENCE-OF: R-43164-44276 If there is no prefix that can be
# interpreted as an integer number, the result of the conversion is 0.
#
do_expr_test e_expr-30.4.1 { CAST('' AS INTEGER) } integer 0
do_expr_test e_expr-30.4.2 { CAST('not a number' AS INTEGER) } integer 0
do_expr_test e_expr-30.4.3 { CAST('XXI' AS INTEGER) } integer 0

# EVIDENCE-OF: R-08980-53124 The CAST operator understands decimal
# integers only &mdash; conversion of hexadecimal integers stops at
# the "x" in the "0x" prefix of the hexadecimal integer string and thus
# result of the CAST is always zero.
do_expr_test e_expr-30.5.1 { CAST('0x1234' AS INTEGER) } integer 0
do_expr_test e_expr-30.5.2 { CAST('0X1234' AS INTEGER) } integer 0

# EVIDENCE-OF: R-02752-50091 A cast of a REAL value into an INTEGER
# results in the integer between the REAL value and zero that is closest
# to the REAL value.
#
do_expr_test e_expr-31.1.1 { CAST(3.14159 AS INTEGER) } integer 3
do_expr_test e_expr-31.1.2 { CAST(1.99999 AS INTEGER) } integer 1
do_expr_test e_expr-31.1.3 { CAST(-1.99999 AS INTEGER) } integer -1
do_expr_test e_expr-31.1.4 { CAST(-0.99999 AS INTEGER) } integer 0

# EVIDENCE-OF: R-51517-40824 If a REAL is greater than the greatest
# possible signed integer (+9223372036854775807) then the result is the
# greatest possible signed integer and if the REAL is less than the
# least possible signed integer (-9223372036854775808) then the result
# is the least possible signed integer.
#
do_expr_test e_expr-31.2.1 { CAST(2e+50 AS INT) } integer 9223372036854775807
do_expr_test e_expr-31.2.2 { CAST(-2e+50 AS INT) } integer -9223372036854775808
do_expr_test e_expr-31.2.3 { 
  CAST(-9223372036854775809.0 AS INT)
} integer -9223372036854775808
do_expr_test e_expr-31.2.4 { 
  CAST(9223372036854775809.0 AS INT)
} integer 9223372036854775807


# EVIDENCE-OF: R-09295-61337 Casting a TEXT or BLOB value into NUMERIC
# first does a forced conversion into REAL but then further converts the
# result into INTEGER if and only if the conversion from REAL to INTEGER
# is lossless and reversible.
#
do_expr_test e_expr-32.1.1 { CAST('45'   AS NUMERIC)  } integer 45
do_expr_test e_expr-32.1.2 { CAST('45.0' AS NUMERIC)  } integer 45
do_expr_test e_expr-32.1.3 { CAST('45.2' AS NUMERIC)  } real 45.2
do_expr_test e_expr-32.1.4 { CAST('11abc' AS NUMERIC) } integer 11
do_expr_test e_expr-32.1.5 { CAST('11.1abc' AS NUMERIC) } real 11.1

# EVIDENCE-OF: R-30347-18702 Casting a REAL or INTEGER value to NUMERIC
# is a no-op, even if a real value could be losslessly converted to an
# integer.
#
do_expr_test e_expr-32.2.1 { CAST(13.0 AS NUMERIC) } real 13.0
do_expr_test e_expr-32.2.2 { CAST(13.5 AS NUMERIC) } real 13.5

do_expr_test e_expr-32.2.3 { 
  CAST(-9223372036854775808 AS NUMERIC)
} integer -9223372036854775808
do_expr_test e_expr-32.2.4 { 
  CAST(9223372036854775807 AS NUMERIC)
} integer 9223372036854775807

# EVIDENCE-OF: R-64550-29191 Note that the result from casting any
# non-BLOB value into a BLOB and the result from casting any BLOB value
# into a non-BLOB value may be different depending on whether the
# database encoding is UTF-8, UTF-16be, or UTF-16le.
#
ifcapable {utf16} {
sqlite3 db1 :memory: ; db1 eval { PRAGMA encoding = 'utf-8' }
sqlite3 db2 :memory: ; db2 eval { PRAGMA encoding = 'utf-16le' }
sqlite3 db3 :memory: ; db3 eval { PRAGMA encoding = 'utf-16be' }
foreach {tn castexpr differs} {
  1 { CAST(123 AS BLOB)    } 1
  2 { CAST('' AS BLOB)     } 0
  3 { CAST('abcd' AS BLOB) } 1

  4 { CAST(X'abcd' AS TEXT) } 1
  5 { CAST(X'' AS TEXT)     } 0
} {
  set r1 [db1 eval "SELECT typeof($castexpr), quote($castexpr)"]
  set r2 [db2 eval "SELECT typeof($castexpr), quote($castexpr)"]
  set r3 [db3 eval "SELECT typeof($castexpr), quote($castexpr)"]

  if {$differs} {
    set res [expr {$r1!=$r2 && $r2!=$r3}]
  } else {
    set res [expr {$r1==$r2 && $r2==$r3}]
  }

  do_test e_expr-33.1.$tn {set res} 1
}
db1 close
db2 close
db3 close
}

#-------------------------------------------------------------------------
# Test statements related to the EXISTS and NOT EXISTS operators.
#
catch { db close }
forcedelete test.db
sqlite3 db test.db

do_execsql_test e_expr-34.1 {
  CREATE TABLE t1(id PRIMARY KEY, a, b);
  INSERT INTO t1 VALUES(1, 1, 2);
  INSERT INTO t1 VALUES(2, NULL, 2);
  INSERT INTO t1 VALUES(3, 1, NULL);
  INSERT INTO t1 VALUES(4, NULL, NULL);
} {}

# EVIDENCE-OF: R-25588-27181 The EXISTS operator always evaluates to one
# of the integer values 0 and 1.
#
# This statement is not tested by itself. Instead, all e_expr-34.* tests 
# following this point explicitly test that specific invocations of EXISTS
# return either integer 0 or integer 1.
#

# EVIDENCE-OF: R-58553-63740 If executing the SELECT statement specified
# as the right-hand operand of the EXISTS operator would return one or
# more rows, then the EXISTS operator evaluates to 1.
#
foreach {tn expr} {
    1 { EXISTS ( SELECT a FROM t1 ) }
    2 { EXISTS ( SELECT b FROM t1 ) }
    3 { EXISTS ( SELECT 24 ) }
    4 { EXISTS ( SELECT NULL ) }
    5 { EXISTS ( SELECT a FROM t1 WHERE a IS NULL ) }
} {
  do_expr_test e_expr-34.2.$tn $expr integer 1
}

# EVIDENCE-OF: R-19673-40972 If executing the SELECT would return no
# rows at all, then the EXISTS operator evaluates to 0.
#
foreach {tn expr} {
    1 { EXISTS ( SELECT a FROM t1 WHERE 0) }
    2 { EXISTS ( SELECT b FROM t1 WHERE a = 5) }
    3 { EXISTS ( SELECT 24 WHERE 0) }
    4 { EXISTS ( SELECT NULL WHERE 1=2) }
} {
  do_expr_test e_expr-34.3.$tn $expr integer 0
}

# EVIDENCE-OF: R-35109-49139 The number of columns in each row returned
# by the SELECT statement (if any) and the specific values returned have
# no effect on the results of the EXISTS operator.
#
foreach {tn expr res} {
    1 { EXISTS ( SELECT a,b FROM t1 ) }                          1
    2 { EXISTS ( SELECT a,b, a,b, a,b FROM t1 ) }                    1
    3 { EXISTS ( SELECT 24, 25 ) }                             1
    4 { EXISTS ( SELECT NULL, NULL, NULL ) }                   1
    5 { EXISTS ( SELECT a,b,a||b FROM t1 WHERE a IS NULL ) }   1

    6 { EXISTS ( SELECT a, a FROM t1 WHERE 0) }                0
    7 { EXISTS ( SELECT b, b, a FROM t1 WHERE a = 5) }         0
    8 { EXISTS ( SELECT 24, 46, 89 WHERE 0) }                  0
    9 { EXISTS ( SELECT NULL, NULL WHERE 1=2) }                0
} {
  do_expr_test e_expr-34.4.$tn $expr integer $res
}

# EVIDENCE-OF: R-10645-12439 In particular, rows containing NULL values
# are not handled any differently from rows without NULL values.
#
foreach {tn e1 e2} {
  1 { EXISTS (SELECT 'not null') }    { EXISTS (SELECT NULL) }
  2 { EXISTS (SELECT NULL FROM t1) }  { EXISTS (SELECT 'bread' FROM t1) }
} {
  set res [db one "SELECT $e1"]
  do_expr_test e_expr-34.5.${tn}a $e1 integer $res
  do_expr_test e_expr-34.5.${tn}b $e2 integer $res
}

#-------------------------------------------------------------------------
# Test statements related to scalar sub-queries.
#

catch { db close }
forcedelete test.db
sqlite3 db test.db
catchsql {DROP TABLE t2;}
do_test e_expr-35.0 {
  execsql {
    CREATE TABLE t2(a PRIMARY KEY, b);
    INSERT INTO t2 VALUES('one', 'two');
    INSERT INTO t2 VALUES('three', NULL);
    INSERT INTO t2 VALUES(4, 5.0);
  }
} {}

# EVIDENCE-OF: R-00980-39256 A SELECT statement enclosed in parentheses
# may appear as a scalar quantity.
#
# EVIDENCE-OF: R-56294-03966 All types of SELECT statement, including
# aggregate and compound SELECT queries (queries with keywords like
# UNION or EXCEPT) are allowed as scalar subqueries.
#
do_expr_test e_expr-35.1.1 { (SELECT 35)   } integer 35
do_expr_test e_expr-35.1.2 { (SELECT NULL) } null {}

do_expr_test e_expr-35.1.3 { (SELECT count(*) FROM t2) } integer 3
do_expr_test e_expr-35.1.4 { (SELECT 4 FROM t2) } integer 4

do_expr_test e_expr-35.1.5 { 
  (SELECT b FROM t2 UNION SELECT a+1 FROM t2)
} null {}
do_expr_test e_expr-35.1.6 { 
  (SELECT a FROM t2 UNION SELECT COALESCE(b, 55) FROM t2 ORDER BY 1)
} integer 4

# EVIDENCE-OF: R-46899-53765 A SELECT used as a scalar quantity must
# return a result set with a single column.
#
# The following block tests that errors are returned in a bunch of cases
# where a subquery returns more than one column.
#
set M {only a single result allowed for a SELECT that is part of an expression}
foreach {tn sql} {
  1     { SELECT (SELECT * FROM t2 UNION SELECT a+1, b+1 FROM t2) }
  2     { SELECT (SELECT * FROM t2 UNION SELECT a+1, b+1 FROM t2 ORDER BY 1) }
  3     { SELECT (SELECT 1, 2) }
  4     { SELECT (SELECT NULL, NULL, NULL) }
  5     { SELECT (SELECT * FROM t2) }
  6     { SELECT (SELECT * FROM (SELECT 1, 2, 3)) }
} {
  do_catchsql_test e_expr-35.2.$tn $sql [list 1 $M]
}

# EVIDENCE-OF: R-35764-28041 The result of the expression is the value
# of the only column in the first row returned by the SELECT statement.
#
# EVIDENCE-OF: R-41898-06686 If the SELECT yields more than one result
# row, all rows after the first are ignored.
#
do_execsql_test e_expr-36.3.1 {
  CREATE TABLE t4(x PRIMARY KEY, y);
  INSERT INTO t4 VALUES(1, 'one');
  INSERT INTO t4 VALUES(2, 'two');
  INSERT INTO t4 VALUES(3, 'three');
} {}

foreach {tn expr restype resval} {
    2  { ( SELECT x FROM t4 ORDER BY x )      }        integer 1
    3  { ( SELECT x FROM t4 ORDER BY y )      }        integer 1
    4  { ( SELECT x FROM t4 ORDER BY x DESC ) }        integer 3
    5  { ( SELECT x FROM t4 ORDER BY y DESC ) }        integer 2
    6  { ( SELECT y FROM t4 ORDER BY y DESC ) }        text    two

    7  { ( SELECT sum(x) FROM t4 )           }         integer 6
    8  { ( SELECT group_concat(y,'') FROM t4 ) }       text    onetwothree
    9  { ( SELECT max(x) FROM t4 WHERE y LIKE '___') } integer 2 

} {
  do_expr_test e_expr-36.3.$tn $expr $restype $resval
}

# EVIDENCE-OF: R-25492-41572 If the SELECT yields no rows, then the
# value of the expression is NULL.
#
foreach {tn expr} {
    1  { ( SELECT x FROM t4 WHERE x>3 ORDER BY x )      }
    2  { ( SELECT x FROM t4 WHERE y<'one' ORDER BY y )  }
} {
  do_expr_test e_expr-36.4.$tn $expr null {}
}

# EVIDENCE-OF: R-62477-06476 For example, the values NULL, 0.0, 0,
# 'english' and '0' are all considered to be false.
#
do_execsql_test e_expr-37.1 {
   SELECT CASE WHEN NULL THEN 'true' ELSE 'false' END;
} {false}
do_execsql_test e_expr-37.2 {
   SELECT CASE WHEN 0.0 THEN 'true' ELSE 'false' END;
} {false}
do_execsql_test e_expr-37.3 {
   SELECT CASE WHEN 0 THEN 'true' ELSE 'false' END;
} {false}
do_execsql_test e_expr-37.4 {
   SELECT CASE WHEN 'engligh' THEN 'true' ELSE 'false' END;
} {false}
do_execsql_test e_expr-37.5 {
   SELECT CASE WHEN '0' THEN 'true' ELSE 'false' END;
} {false}

# EVIDENCE-OF: R-55532-10108 Values 1, 1.0, 0.1, -0.1 and '1english' are
# considered to be true.
#
do_execsql_test e_expr-37.6 {
   SELECT CASE WHEN 1 THEN 'true' ELSE 'false' END;
} {true}
do_execsql_test e_expr-37.7 {
   SELECT CASE WHEN 1.0 THEN 'true' ELSE 'false' END;
} {true}
do_execsql_test e_expr-37.8 {
   SELECT CASE WHEN 0.1 THEN 'true' ELSE 'false' END;
} {true}
do_execsql_test e_expr-37.9 {
   SELECT CASE WHEN -0.1 THEN 'true' ELSE 'false' END;
} {true}
do_execsql_test e_expr-37.10 {
   SELECT CASE WHEN '1english' THEN 'true' ELSE 'false' END;
} {true}


finish_test