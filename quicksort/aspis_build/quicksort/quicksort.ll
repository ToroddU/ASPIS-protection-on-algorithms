; ModuleID = 'quicksort.c'
source_filename = "quicksort.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [17 x i8] c"Before sorting:\0A\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.4 = private unnamed_addr constant [16 x i8] c"After sorting:\0A\00", align 1
@.str.5 = private unnamed_addr constant [53 x i8] c"[ERROR] Array not sorted: arr[%zu]=%d > arr[%zu]=%d\0A\00", align 1
@.str.6 = private unnamed_addr constant [38 x i8] c"[SUCCESS] Array is correctly sorted!\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @runQuicksort(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %7 = load i64, ptr %4, align 8
  %8 = icmp eq i64 %7, 0
  br i1 %8, label %9, label %10

9:                                                ; preds = %2
  br label %64

10:                                               ; preds = %2
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  store i64 0, ptr %5, align 8
  br label %12

12:                                               ; preds = %29, %10
  %13 = load i64, ptr %5, align 8
  %14 = load i64, ptr %4, align 8
  %15 = icmp ult i64 %13, %14
  br i1 %15, label %16, label %32

16:                                               ; preds = %12
  %17 = load ptr, ptr %3, align 8
  %18 = load i64, ptr %5, align 8
  %19 = getelementptr inbounds i32, ptr %17, i64 %18
  %20 = load i32, ptr %19, align 4
  %21 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %20)
  %22 = load i64, ptr %5, align 8
  %23 = add i64 %22, 1
  %24 = urem i64 %23, 10
  %25 = icmp eq i64 %24, 0
  br i1 %25, label %26, label %28

26:                                               ; preds = %16
  %27 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %28

28:                                               ; preds = %26, %16
  br label %29

29:                                               ; preds = %28
  %30 = load i64, ptr %5, align 8
  %31 = add i64 %30, 1
  store i64 %31, ptr %5, align 8
  br label %12, !llvm.loop !6

32:                                               ; preds = %12
  %33 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %34 = load ptr, ptr %3, align 8
  %35 = load i64, ptr %4, align 8
  %36 = sub i64 %35, 1
  %37 = trunc i64 %36 to i32
  call void @quicksort(ptr noundef %34, i32 noundef 0, i32 noundef %37)
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i64 0, ptr %6, align 8
  br label %39

39:                                               ; preds = %56, %32
  %40 = load i64, ptr %6, align 8
  %41 = load i64, ptr %4, align 8
  %42 = icmp ult i64 %40, %41
  br i1 %42, label %43, label %59

43:                                               ; preds = %39
  %44 = load ptr, ptr %3, align 8
  %45 = load i64, ptr %6, align 8
  %46 = getelementptr inbounds i32, ptr %44, i64 %45
  %47 = load i32, ptr %46, align 4
  %48 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %47)
  %49 = load i64, ptr %6, align 8
  %50 = add i64 %49, 1
  %51 = urem i64 %50, 10
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %53, label %55

53:                                               ; preds = %43
  %54 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  br label %55

55:                                               ; preds = %53, %43
  br label %56

56:                                               ; preds = %55
  %57 = load i64, ptr %6, align 8
  %58 = add i64 %57, 1
  store i64 %58, ptr %6, align 8
  br label %39, !llvm.loop !8

59:                                               ; preds = %39
  %60 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %61 = load ptr, ptr %3, align 8
  %62 = load i64, ptr %4, align 8
  %63 = call i32 @checkIfSorted(ptr noundef %61, i64 noundef %62)
  br label %64

64:                                               ; preds = %59, %9
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind uwtable
define internal void @quicksort(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %8 = load i32, ptr %5, align 4
  %9 = load i32, ptr %6, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %24

11:                                               ; preds = %3
  %12 = load ptr, ptr %4, align 8
  %13 = load i32, ptr %5, align 4
  %14 = load i32, ptr %6, align 4
  %15 = call i32 @partition(ptr noundef %12, i32 noundef %13, i32 noundef %14)
  store i32 %15, ptr %7, align 4
  %16 = load ptr, ptr %4, align 8
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %7, align 4
  %19 = sub nsw i32 %18, 1
  call void @quicksort(ptr noundef %16, i32 noundef %17, i32 noundef %19)
  %20 = load ptr, ptr %4, align 8
  %21 = load i32, ptr %7, align 4
  %22 = add nsw i32 %21, 1
  %23 = load i32, ptr %6, align 4
  call void @quicksort(ptr noundef %20, i32 noundef %22, i32 noundef %23)
  br label %24

24:                                               ; preds = %11, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @checkIfSorted(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca ptr, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  store ptr %0, ptr %4, align 8
  store i64 %1, ptr %5, align 8
  store i64 0, ptr %6, align 8
  br label %7

7:                                                ; preds = %38, %2
  %8 = load i64, ptr %6, align 8
  %9 = load i64, ptr %5, align 8
  %10 = sub i64 %9, 1
  %11 = icmp ult i64 %8, %10
  br i1 %11, label %12, label %41

12:                                               ; preds = %7
  %13 = load ptr, ptr %4, align 8
  %14 = load i64, ptr %6, align 8
  %15 = getelementptr inbounds i32, ptr %13, i64 %14
  %16 = load i32, ptr %15, align 4
  %17 = load ptr, ptr %4, align 8
  %18 = load i64, ptr %6, align 8
  %19 = add i64 %18, 1
  %20 = getelementptr inbounds i32, ptr %17, i64 %19
  %21 = load i32, ptr %20, align 4
  %22 = icmp sgt i32 %16, %21
  br i1 %22, label %23, label %37

23:                                               ; preds = %12
  %24 = load i64, ptr %6, align 8
  %25 = load ptr, ptr %4, align 8
  %26 = load i64, ptr %6, align 8
  %27 = getelementptr inbounds i32, ptr %25, i64 %26
  %28 = load i32, ptr %27, align 4
  %29 = load i64, ptr %6, align 8
  %30 = add i64 %29, 1
  %31 = load ptr, ptr %4, align 8
  %32 = load i64, ptr %6, align 8
  %33 = add i64 %32, 1
  %34 = getelementptr inbounds i32, ptr %31, i64 %33
  %35 = load i32, ptr %34, align 4
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i64 noundef %24, i32 noundef %28, i64 noundef %30, i32 noundef %35)
  store i32 0, ptr %3, align 4
  br label %43

37:                                               ; preds = %12
  br label %38

38:                                               ; preds = %37
  %39 = load i64, ptr %6, align 8
  %40 = add i64 %39, 1
  store i64 %40, ptr %6, align 8
  br label %7, !llvm.loop !9

41:                                               ; preds = %7
  %42 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  store i32 1, ptr %3, align 4
  br label %43

43:                                               ; preds = %41, %23
  %44 = load i32, ptr %3, align 4
  ret i32 %44
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @partition(ptr noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store ptr %0, ptr %4, align 8
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %10 = load ptr, ptr %4, align 8
  %11 = load i32, ptr %6, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, ptr %10, i64 %12
  %14 = load i32, ptr %13, align 4
  store i32 %14, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  %16 = sub nsw i32 %15, 1
  store i32 %16, ptr %8, align 4
  %17 = load i32, ptr %5, align 4
  store i32 %17, ptr %9, align 4
  br label %18

18:                                               ; preds = %42, %3
  %19 = load i32, ptr %9, align 4
  %20 = load i32, ptr %6, align 4
  %21 = icmp slt i32 %19, %20
  br i1 %21, label %22, label %45

22:                                               ; preds = %18
  %23 = load ptr, ptr %4, align 8
  %24 = load i32, ptr %9, align 4
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i32, ptr %23, i64 %25
  %27 = load i32, ptr %26, align 4
  %28 = load i32, ptr %7, align 4
  %29 = icmp sle i32 %27, %28
  br i1 %29, label %30, label %41

30:                                               ; preds = %22
  %31 = load i32, ptr %8, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, ptr %8, align 4
  %33 = load ptr, ptr %4, align 8
  %34 = load i32, ptr %8, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds i32, ptr %33, i64 %35
  %37 = load ptr, ptr %4, align 8
  %38 = load i32, ptr %9, align 4
  %39 = sext i32 %38 to i64
  %40 = getelementptr inbounds i32, ptr %37, i64 %39
  call void @swap(ptr noundef %36, ptr noundef %40)
  br label %41

41:                                               ; preds = %30, %22
  br label %42

42:                                               ; preds = %41
  %43 = load i32, ptr %9, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, ptr %9, align 4
  br label %18, !llvm.loop !10

45:                                               ; preds = %18
  %46 = load ptr, ptr %4, align 8
  %47 = load i32, ptr %8, align 4
  %48 = add nsw i32 %47, 1
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds i32, ptr %46, i64 %49
  %51 = load ptr, ptr %4, align 8
  %52 = load i32, ptr %6, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i32, ptr %51, i64 %53
  call void @swap(ptr noundef %50, ptr noundef %54)
  %55 = load i32, ptr %8, align 4
  %56 = add nsw i32 %55, 1
  ret i32 %56
}

; Function Attrs: noinline nounwind uwtable
define internal void @swap(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  %6 = load ptr, ptr %3, align 8
  %7 = load i32, ptr %6, align 4
  store i32 %7, ptr %5, align 4
  %8 = load ptr, ptr %4, align 8
  %9 = load i32, ptr %8, align 4
  %10 = load ptr, ptr %3, align 8
  store i32 %9, ptr %10, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load ptr, ptr %4, align 8
  store i32 %11, ptr %12, align 4
  ret void
}

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
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
