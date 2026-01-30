; ModuleID = 'minimax.c'
source_filename = "minimax.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Node = type { i32, i32 }

@.str = private unnamed_addr constant [63 x i8] c"Array too small for minimax tree (needs at least 16 elements)\0A\00", align 1
@.str.1 = private unnamed_addr constant [36 x i8] c"=== Minimax Adversarial Search ===\0A\00", align 1
@.str.2 = private unnamed_addr constant [60 x i8] c"Tree structure: 4 levels deep, binary choices at each node\0A\00", align 1
@.str.3 = private unnamed_addr constant [52 x i8] c"Players: MAX (root, depth 0,2) vs MIN (depth 1,3)\0A\0A\00", align 1
@.str.4 = private unnamed_addr constant [19 x i8] c"Leaf node values:\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d \00", align 1
@.str.6 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.7 = private unnamed_addr constant [3 x i8] c"\0A\0A\00", align 1
@.str.8 = private unnamed_addr constant [31 x i8] c"Minimax evaluation result: %d\0A\00", align 1
@.str.9 = private unnamed_addr constant [44 x i8] c"(This is the best value MAX can guarantee)\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local void @runMinimax(ptr noundef %0, i64 noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca i64, align 8
  %5 = alloca i32, align 4
  %6 = alloca [16 x %struct.Node], align 16
  %7 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store i64 %1, ptr %4, align 8
  %8 = load i64, ptr %4, align 8
  %9 = icmp ult i64 %8, 16
  br i1 %9, label %10, label %12

10:                                               ; preds = %2
  %11 = call i32 (ptr, ...) @printf(ptr noundef @.str)
  br label %46

12:                                               ; preds = %2
  %13 = call i32 (ptr, ...) @printf(ptr noundef @.str.1)
  %14 = call i32 (ptr, ...) @printf(ptr noundef @.str.2)
  %15 = call i32 (ptr, ...) @printf(ptr noundef @.str.3)
  %16 = call i32 (ptr, ...) @printf(ptr noundef @.str.4)
  store i32 0, ptr %5, align 4
  br label %17

17:                                               ; preds = %34, %12
  %18 = load i32, ptr %5, align 4
  %19 = icmp slt i32 %18, 16
  br i1 %19, label %20, label %37

20:                                               ; preds = %17
  %21 = load ptr, ptr %3, align 8
  %22 = load i32, ptr %5, align 4
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds i32, ptr %21, i64 %23
  %25 = load i32, ptr %24, align 4
  %26 = call i32 (ptr, ...) @printf(ptr noundef @.str.5, i32 noundef %25)
  %27 = load i32, ptr %5, align 4
  %28 = add nsw i32 %27, 1
  %29 = srem i32 %28, 8
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %33

31:                                               ; preds = %20
  %32 = call i32 (ptr, ...) @printf(ptr noundef @.str.6)
  br label %33

33:                                               ; preds = %31, %20
  br label %34

34:                                               ; preds = %33
  %35 = load i32, ptr %5, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, ptr %5, align 4
  br label %17, !llvm.loop !6

37:                                               ; preds = %17
  %38 = call i32 (ptr, ...) @printf(ptr noundef @.str.7)
  %39 = getelementptr inbounds [16 x %struct.Node], ptr %6, i64 0, i64 0
  %40 = load ptr, ptr %3, align 8
  call void @generateLeaves(ptr noundef %39, ptr noundef %40)
  %41 = getelementptr inbounds [16 x %struct.Node], ptr %6, i64 0, i64 0
  %42 = call i32 @minimax(ptr noundef %41, i32 noundef 0, i32 noundef 0, i32 noundef 1)
  store i32 %42, ptr %7, align 4
  %43 = load i32, ptr %7, align 4
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str.8, i32 noundef %43)
  %45 = call i32 (ptr, ...) @printf(ptr noundef @.str.9)
  br label %46

46:                                               ; preds = %37, %10
  ret void
}

declare i32 @printf(ptr noundef, ...) #1

; Function Attrs: noinline nounwind uwtable
define internal void @generateLeaves(ptr noundef %0, ptr noundef %1) #0 {
  %3 = alloca ptr, align 8
  %4 = alloca ptr, align 8
  %5 = alloca i32, align 4
  store ptr %0, ptr %3, align 8
  store ptr %1, ptr %4, align 8
  store i32 0, ptr %5, align 4
  br label %6

6:                                                ; preds = %25, %2
  %7 = load i32, ptr %5, align 4
  %8 = icmp slt i32 %7, 16
  br i1 %8, label %9, label %28

9:                                                ; preds = %6
  %10 = load ptr, ptr %4, align 8
  %11 = load i32, ptr %5, align 4
  %12 = sext i32 %11 to i64
  %13 = getelementptr inbounds i32, ptr %10, i64 %12
  %14 = load i32, ptr %13, align 4
  %15 = load ptr, ptr %3, align 8
  %16 = load i32, ptr %5, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds %struct.Node, ptr %15, i64 %17
  %19 = getelementptr inbounds %struct.Node, ptr %18, i32 0, i32 0
  store i32 %14, ptr %19, align 4
  %20 = load ptr, ptr %3, align 8
  %21 = load i32, ptr %5, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.Node, ptr %20, i64 %22
  %24 = getelementptr inbounds %struct.Node, ptr %23, i32 0, i32 1
  store i32 1, ptr %24, align 4
  br label %25

25:                                               ; preds = %9
  %26 = load i32, ptr %5, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, ptr %5, align 4
  br label %6, !llvm.loop !8

28:                                               ; preds = %6
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal i32 @minimax(ptr noundef %0, i32 noundef %1, i32 noundef %2, i32 noundef %3) #0 {
  %5 = alloca i32, align 4
  %6 = alloca ptr, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  store ptr %0, ptr %6, align 8
  store i32 %1, ptr %7, align 4
  store i32 %2, ptr %8, align 4
  store i32 %3, ptr %9, align 4
  %17 = load i32, ptr %8, align 4
  %18 = icmp eq i32 %17, 4
  br i1 %18, label %19, label %27

19:                                               ; preds = %4
  %20 = load ptr, ptr %6, align 8
  %21 = load i32, ptr %7, align 4
  %22 = sext i32 %21 to i64
  %23 = getelementptr inbounds %struct.Node, ptr %20, i64 %22
  %24 = getelementptr inbounds %struct.Node, ptr %23, i32 0, i32 0
  %25 = load i32, ptr %24, align 4
  store i32 %25, ptr %10, align 4
  %26 = load i32, ptr %10, align 4
  store i32 %26, ptr %5, align 4
  br label %78

27:                                               ; preds = %4
  %28 = load i32, ptr %9, align 4
  %29 = icmp ne i32 %28, 0
  br i1 %29, label %30, label %54

30:                                               ; preds = %27
  %31 = load ptr, ptr %6, align 8
  %32 = load i32, ptr %7, align 4
  %33 = mul nsw i32 %32, 2
  %34 = load i32, ptr %8, align 4
  %35 = add nsw i32 %34, 1
  %36 = call i32 @minimax(ptr noundef %31, i32 noundef %33, i32 noundef %35, i32 noundef 0)
  store i32 %36, ptr %11, align 4
  %37 = load ptr, ptr %6, align 8
  %38 = load i32, ptr %7, align 4
  %39 = mul nsw i32 %38, 2
  %40 = add nsw i32 %39, 1
  %41 = load i32, ptr %8, align 4
  %42 = add nsw i32 %41, 1
  %43 = call i32 @minimax(ptr noundef %37, i32 noundef %40, i32 noundef %42, i32 noundef 0)
  store i32 %43, ptr %12, align 4
  %44 = load i32, ptr %11, align 4
  %45 = load i32, ptr %12, align 4
  %46 = icmp sgt i32 %44, %45
  br i1 %46, label %47, label %49

47:                                               ; preds = %30
  %48 = load i32, ptr %11, align 4
  br label %51

49:                                               ; preds = %30
  %50 = load i32, ptr %12, align 4
  br label %51

51:                                               ; preds = %49, %47
  %52 = phi i32 [ %48, %47 ], [ %50, %49 ]
  store i32 %52, ptr %13, align 4
  %53 = load i32, ptr %13, align 4
  store i32 %53, ptr %5, align 4
  br label %78

54:                                               ; preds = %27
  %55 = load ptr, ptr %6, align 8
  %56 = load i32, ptr %7, align 4
  %57 = mul nsw i32 %56, 2
  %58 = load i32, ptr %8, align 4
  %59 = add nsw i32 %58, 1
  %60 = call i32 @minimax(ptr noundef %55, i32 noundef %57, i32 noundef %59, i32 noundef 1)
  store i32 %60, ptr %14, align 4
  %61 = load ptr, ptr %6, align 8
  %62 = load i32, ptr %7, align 4
  %63 = mul nsw i32 %62, 2
  %64 = add nsw i32 %63, 1
  %65 = load i32, ptr %8, align 4
  %66 = add nsw i32 %65, 1
  %67 = call i32 @minimax(ptr noundef %61, i32 noundef %64, i32 noundef %66, i32 noundef 1)
  store i32 %67, ptr %15, align 4
  %68 = load i32, ptr %14, align 4
  %69 = load i32, ptr %15, align 4
  %70 = icmp slt i32 %68, %69
  br i1 %70, label %71, label %73

71:                                               ; preds = %54
  %72 = load i32, ptr %14, align 4
  br label %75

73:                                               ; preds = %54
  %74 = load i32, ptr %15, align 4
  br label %75

75:                                               ; preds = %73, %71
  %76 = phi i32 [ %72, %71 ], [ %74, %73 ]
  store i32 %76, ptr %16, align 4
  %77 = load i32, ptr %16, align 4
  store i32 %77, ptr %5, align 4
  br label %78

78:                                               ; preds = %75, %51, %19
  %79 = load i32, ptr %5, align 4
  ret i32 %79
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
