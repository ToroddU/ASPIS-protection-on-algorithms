; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@arr = dso_local global [100 x i32] [i32 92, i32 45, i32 23, i32 67, i32 12, i32 89, i32 34, i32 78, i32 56, i32 90, i32 15, i32 73, i32 38, i32 61, i32 27, i32 84, i32 19, i32 51, i32 76, i32 41, i32 58, i32 9, i32 63, i32 30, i32 47, i32 82, i32 25, i32 68, i32 36, i32 74, i32 13, i32 86, i32 44, i32 29, i32 59, i32 7, i32 65, i32 38, i32 53, i32 91, i32 18, i32 72, i32 42, i32 81, i32 26, i32 55, i32 39, i32 70, i32 11, i32 64, i32 37, i32 79, i32 14, i32 60, i32 46, i32 85, i32 21, i32 69, i32 33, i32 87, i32 16, i32 50, i32 77, i32 24, i32 62, i32 40, i32 75, i32 20, i32 57, i32 35, i32 66, i32 48, i32 83, i32 28, i32 54, i32 17, i32 100, i32 31, i32 43, i32 98, i32 19, i32 73, i32 37, i32 52, i32 32, i32 80, i32 49, i32 61, i32 22, i32 71, i32 10, i32 88, i32 39, i32 65, i32 18, i32 58, i32 27, i32 76, i32 44, i32 99], align 16

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, ptr %1, align 4
  store i32 100, ptr %2, align 4
  call void @runQuicksort(ptr noundef @arr, i64 noundef 100)
  ret i32 0
}

declare void @runQuicksort(ptr noundef, i64 noundef) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 16.0.6 (++20231112100510+7cbf1a259152-1~exp1~20231112100554.106)"}
