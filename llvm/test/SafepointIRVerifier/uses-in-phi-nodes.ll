; RUN: opt -safepoint-ir-verifier-print-only -verify-safepoint-ir -S %s 2>&1 | FileCheck %s

define ptr addrspace(1) @test.not.ok.0(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.not.ok.0
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0)
  br label %merge

 right:
  br label %merge

 merge:
; CHECK: Illegal use of unrelocated value found!
; CHECK-NEXT: Def:   %val = phi ptr addrspace(1) [ %arg, %left ], [ %arg, %right ]
; CHECK-NEXT: Use:   ret ptr addrspace(1) %val
  %val = phi ptr addrspace(1) [ %arg, %left ], [ %arg, %right ]
  ret ptr addrspace(1) %val
}

define ptr addrspace(1) @test.not.ok.1(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.not.ok.1
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0)
  br label %merge

 right:
  br label %merge

 merge:
; CHECK: Illegal use of unrelocated value found!
; CHECK-NEXT: Def:   %val = phi ptr addrspace(1) [ %arg, %left ], [ null, %right ]
; CHECK-NEXT: Use:   ret ptr addrspace(1) %val
  %val = phi ptr addrspace(1) [ %arg, %left ], [ null, %right ]
  ret ptr addrspace(1) %val
}

define ptr addrspace(1) @test.ok.0(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK: No illegal uses found by SafepointIRVerifier in: test.ok.0
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0)
  br label %merge

 right:
  br label %merge

 merge:
  %val = phi ptr addrspace(1) [ null, %left ], [ null, %right]
  ret ptr addrspace(1) %val
}

define ptr addrspace(1) @test.ok.1(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK: No illegal uses found by SafepointIRVerifier in: test.ok.1
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  call void @not_statepoint()
  br label %merge

 right:
  br label %merge

 merge:
  %val = phi ptr addrspace(1) [ %arg, %left ], [ %arg, %right]
  ret ptr addrspace(1) %val
}

; It should be allowed to compare poisoned ptr with null.
define void @test.poisoned.cmp.ok(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.poisoned.cmp.ok
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg)]
  %arg.relocated = call ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token, i32 0, i32 0) ; arg, arg
  br label %merge

 right:
  %safepoint_token2 = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg)]
  br label %merge

 merge:
; CHECK: No illegal uses found by SafepointIRVerifier in: test.poisoned.cmp.ok
  %val.poisoned = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg, %right ]
  %c = icmp eq ptr addrspace(1) %val.poisoned, null
  ret void
}

; It is illegal to compare poisoned ptr and relocated.
define void @test.poisoned.cmp.fail.0(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.poisoned.cmp.fail.0
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg)]
  %arg.relocated = call ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token, i32 0, i32 0) ; arg, arg
  br label %merge

 right:
  %safepoint_token2 = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg), "deopt"(i32 -1, i32 0, i32 0, i32 0)]
  %arg.relocated2 = call ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token2, i32 0, i32 0) ; arg, arg
  br label %merge

 merge:
; CHECK: Illegal use of unrelocated value found!
; CHECK-NEXT: Def:   %val.poisoned = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg, %right ]
; CHECK-NEXT: Use:   %c = icmp eq ptr addrspace(1) %val.poisoned, %val
  %val.poisoned = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg, %right ]
  %val = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg.relocated2, %right ]
  %c = icmp eq ptr addrspace(1) %val.poisoned, %val
  ret void
}

; It is illegal to compare poisoned ptr and unrelocated.
define void @test.poisoned.cmp.fail.1(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.poisoned.cmp.fail.1
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg)]
  %arg.relocated = call ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token, i32 0, i32 0) ; arg, arg
  br label %merge

 right:
  %safepoint_token2 = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0) ["gc-live"(ptr addrspace(1) %arg), "deopt"(i32 -1, i32 0, i32 0, i32 0)]
  %arg.relocated2 = call ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token %safepoint_token2, i32 0, i32 0) ; arg, arg
  br label %merge

 merge:
; CHECK: Illegal use of unrelocated value found!
; CHECK-NEXT: Def:   %val.poisoned = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg, %right ]
; CHECK-NEXT: Use:   %c = icmp eq ptr addrspace(1) %val.poisoned, %arg
  %val.poisoned = phi ptr addrspace(1) [ %arg.relocated, %left ], [ %arg, %right ]
  %c = icmp eq ptr addrspace(1) %val.poisoned, %arg
  ret void
}

; It should be allowed to compare unrelocated phi with unrelocated value.
define void @test.unrelocated-phi.cmp.ok(ptr addrspace(1) %arg, i1 %new_arg) gc "statepoint-example" {
; CHECK-LABEL: Verifying gc pointers in function: test.unrelocated-phi.cmp.ok
 bci_0:
  br i1 %new_arg, label %left, label %right

 left:
  %safepoint_token = call token (i64, i32, ptr, i32, i32, ...) @llvm.experimental.gc.statepoint.p0(i64 0, i32 0, ptr elementtype(void ()) undef, i32 0, i32 0, i32 0, i32 0)
  br label %merge

 right:
  br label %merge

 merge:
; CHECK: No illegal uses found by SafepointIRVerifier in: test.unrelocated-phi.cmp.ok
  %val.unrelocated = phi ptr addrspace(1) [ %arg, %left ], [ null, %right ]
  %c = icmp eq ptr addrspace(1) %val.unrelocated, %arg
  ret void
}

declare token @llvm.experimental.gc.statepoint.p0(i64, i32, ptr, i32, i32, ...)
declare ptr addrspace(1) @llvm.experimental.gc.relocate.p1(token, i32, i32)
declare void @not_statepoint()
