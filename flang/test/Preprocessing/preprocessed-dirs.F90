! RUN: %flang_fc1 -E %s 2>&1 | FileCheck %s
!CHECK: subroutine r4(x) Z real :: x Z !$acc routine Z print *, x Z end
#define SUB(s, t) subroutine s(x) Z\
  t :: x Z\
  !$acc routine Z\
  print *, x Z\
  end subroutine s
SUB(r4, real)
