; RUN: opt < %s -instcombine -S | FileCheck %s
@a = common global [60 x i8] zeroinitializer, align 1 ; <[60 x i8]*>
@.str = private constant [8 x i8] c"abcdefg\00"   ; <[8 x i8]*>

define i32 @foo() nounwind {
; CHECK: @foo
; CHECK-NEXT: ret i32 60
  %1 = call i32 @llvm.objectsize.i32(i8* getelementptr inbounds ([60 x i8]* @a, i32 0, i32 0), i1 false)
  ret i32 %1
}

define i8* @bar() nounwind {
; CHECK: @bar
entry:
  %retval = alloca i8*
  %0 = call i32 @llvm.objectsize.i32(i8* getelementptr inbounds ([60 x i8]* @a, i32 0, i32 0), i1 false)
  %cmp = icmp ne i32 %0, -1
; CHECK: br i1 true
  br i1 %cmp, label %cond.true, label %cond.false

cond.true:
  %1 = load i8** %retval;
  ret i8* %1;

cond.false:
  %2 = load i8** %retval;
  ret i8* %2;
}

@window = external global [0 x i8]

define i1 @baz() nounwind {
; CHECK: @baz
; CHECK-NEXT: llvm.objectsize.i32
  %1 = tail call i32 @llvm.objectsize.i32(i8* getelementptr inbounds ([0 x i8]* @window, i32 0, i32 0), i1 false)
  %2 = icmp eq i32 %1, -1
  ret i1 %2
}


declare i32 @llvm.objectsize.i32(i8*, i1) nounwind readonly