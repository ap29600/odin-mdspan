; ModuleID = 'odin_package'
source_filename = "odin_package"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%runtime.Default_Temp_Allocator = type { %runtime.Arena }
%runtime.Arena = type { %runtime.Allocator, %runtime.Memory_Block*, i64, i64, i64, i64 }
%runtime.Allocator = type { i8*, i8* }
%runtime.Memory_Block = type { %runtime.Memory_Block*, %runtime.Allocator, i8*, i64, i64 }
%runtime.Source_Code_Location = type { %..string, i32, i32, %..string }
%..string = type { i8*, i64 }
%runtime.Context = type { %runtime.Allocator, %runtime.Allocator, i8*, %runtime.Logger, i8*, i64, i8* }
%runtime.Logger = type { i8*, i8*, i64, i16, [6 x i8] }
%__gnu_h2f_ieee.fp32-1 = type { i32 }

@runtime.args__ = internal unnamed_addr global { i8**, i64 } zeroinitializer
@runtime.global_default_temp_allocator_data = internal thread_local global %runtime.Default_Temp_Allocator zeroinitializer
@"csbs$0" = private unnamed_addr constant [37 x i8] c"0123456789abcdefghijklmnopqrstuvwxyz\00", align 1
@"csbs$2" = private unnamed_addr constant [69 x i8] c"/home/andrea/sources/odin/core/runtime/default_allocators_arena.odin\00", align 1
@"csbs$3" = private unnamed_addr constant [19 x i8] c"memory_block_alloc\00", align 1
@"ggv$0" = private unnamed_addr constant %runtime.Source_Code_Location { %..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 45, i32 2, %..string { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @"csbs$3", i64 0, i64 0), i64 18 } }
@"ggv$1" = private unnamed_addr constant %runtime.Source_Code_Location { %..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 46, i32 2, %..string { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @"csbs$3", i64 0, i64 0), i64 18 } }
@"csbs$4" = private unnamed_addr constant [27 x i8] c"non-power of two alignment\00", align 1
@"csbs$5" = private unnamed_addr constant [24 x i8] c" Invalid slice indices \00", align 1
@"csbs$6" = private unnamed_addr constant [2 x i8] c":\00", align 1
@"csbs$7" = private unnamed_addr constant [22 x i8] c" is out of range 0..<\00", align 1
@"csbs$8" = private unnamed_addr constant [2 x i8] c" \00", align 1
@"csbs$9" = private unnamed_addr constant [3 x i8] c": \00", align 1
@"csbs$b" = private unnamed_addr constant [72 x i8] c"/home/andrea/sources/odin/core/runtime/default_temporary_allocator.odin\00", align 1
@"csbs$c" = private unnamed_addr constant [31 x i8] c"default_temp_allocator_destroy\00", align 1
@"ggv$2" = private unnamed_addr constant %runtime.Source_Code_Location { %..string { i8* getelementptr inbounds ([72 x i8], [72 x i8]* @"csbs$b", i64 0, i64 0), i64 71 }, i32 33, i32 4, %..string { i8* getelementptr inbounds ([31 x i8], [31 x i8]* @"csbs$c", i64 0, i64 0), i64 30 } }
@"csbs$d" = private unnamed_addr constant [55 x i8] c"/home/andrea/sources/odin/core/runtime/entry_unix.odin\00", align 1
@"csbs$14" = private unnamed_addr constant [42 x i8] c"/home/andrea/sources/odin/core/os/os.odin\00", align 1
@"csbs$15" = private unnamed_addr constant [18 x i8] c"runtime assertion\00", align 1

; Function Attrs: nounwind
define internal fastcc void @"__$startup_type_info"() unnamed_addr #0 {
decls:
  ret void
}

; Function Attrs: nounwind
define void @"__$startup_runtime"(i8* noalias nocapture nonnull %__.context_ptr) local_unnamed_addr #0 {
decls:
  call fastcc void @"__$startup_type_info"()
  ret void
}

define void @"__$cleanup_runtime"(i8* noalias nocapture nonnull %__.context_ptr) local_unnamed_addr {
decls:
  call fastcc void @runtime._destroy_temp_allocator_fini-3363(i8* %__.context_ptr)
  ret void
}

define internal fastcc void @runtime._destroy_temp_allocator_fini-3363(i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  call fastcc void @runtime.default_temp_allocator_destroy(i8* %__.context_ptr)
  ret void
}

define internal fastcc { i64, i64 } @runtime.memory_block_alloc({ i64, i64 } %0, i64 %1, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %2, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  %3 = alloca %runtime.Allocator, align 8
  %4 = alloca { { i8*, i64 }, i8 }, align 8
  %5 = alloca %runtime.Source_Code_Location, align 8
  %6 = alloca %runtime.Allocator, align 8
  %7 = alloca { { i8*, i64 }, i8 }, align 8
  %8 = alloca { %runtime.Memory_Block*, i8 }, align 8
  %9 = alloca { i8*, i64 }, align 8
  %10 = alloca { %runtime.Memory_Block*, i8 }, align 8
  %11 = bitcast %runtime.Allocator* %6 to { i64, i64 }*
  store { i64, i64 } %0, { i64, i64 }* %11, align 8
  %12 = load %runtime.Allocator, %runtime.Allocator* %6, align 8
  %13 = add i64 %1, 48
  %14 = bitcast { { i8*, i64 }, i8 }* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %14, i8 0, i64 24, i1 false)
  call void @llvm.experimental.noalias.scope.decl(metadata !0)
  call void @llvm.experimental.noalias.scope.decl(metadata !3)
  %15 = bitcast %runtime.Source_Code_Location* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* %15)
  %16 = bitcast %runtime.Allocator* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %16)
  %17 = bitcast { { i8*, i64 }, i8 }* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %17)
  %18 = bitcast %runtime.Source_Code_Location* %5 to i8*
  %19 = bitcast %runtime.Source_Code_Location* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %18, i8* align 1 %19, i64 40, i1 false)
  %20 = bitcast %runtime.Allocator* %3 to { i64, i64 }*
  store { i64, i64 } %0, { i64, i64 }* %20, align 8, !noalias !5
  %21 = icmp eq i64 %13, 0
  br i1 %21, label %if.then.i, label %cmp.or.i

cmp.or.i:                                         ; preds = %decls
  %22 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %3, i32 0, i32 0
  %23 = load i8*, i8** %22, align 8, !noalias !5
  %24 = icmp eq i8* %23, null
  br i1 %24, label %if.then.i, label %if.done.i

if.then.i:                                        ; preds = %cmp.or.i, %decls
  %25 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 0
  %26 = bitcast { i8*, i64 }* %25 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %26, i8 0, i64 17, i1 false), !alias.scope !0, !noalias !3
  br label %runtime.mem_alloc.exit

if.done.i:                                        ; preds = %cmp.or.i
  %27 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %3, i32 0, i32 1
  %28 = load i8*, i8** %27, align 8, !noalias !5
  %29 = bitcast { { i8*, i64 }, i8 }* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %29, i8 0, i64 24, i1 false), !noalias !5
  %30 = bitcast i8* %23 to void ({ { i8*, i64 }, i8 }*, i8*, i8, i64, i64, i8*, i64, %runtime.Source_Code_Location*, i8*)*
  call void %30({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %4, i8* %28, i8 0, i64 %13, i64 16, i8* null, i64 0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %5, i8* %__.context_ptr) #12, !noalias !0
  %31 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %4, i32 0, i32 0
  %32 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %4, i32 0, i32 1
  %33 = load i8, i8* %32, align 1, !noalias !5
  %34 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 0
  %35 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 1
  %36 = bitcast { i8*, i64 }* %34 to i8*
  %37 = bitcast { i8*, i64 }* %31 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %36, i8* align 8 %37, i64 16, i1 false), !noalias !3
  store i8 %33, i8* %35, align 1, !alias.scope !0, !noalias !3
  br label %runtime.mem_alloc.exit

runtime.mem_alloc.exit:                           ; preds = %if.then.i, %if.done.i
  %38 = bitcast %runtime.Source_Code_Location* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 40, i8* %38)
  %39 = bitcast %runtime.Allocator* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %39)
  %40 = bitcast { { i8*, i64 }, i8 }* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %40)
  %41 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 0
  %42 = load { i8*, i64 }, { i8*, i64 }* %41, align 8
  %43 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 1
  %44 = load i8, i8* %43, align 1
  %45 = icmp eq i8 %44, 0
  br i1 %45, label %or_return.continue, label %or_return.return

or_return.return:                                 ; preds = %runtime.mem_alloc.exit
  %46 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %8, i32 0, i32 0
  %47 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %8, i32 0, i32 1
  store %runtime.Memory_Block* null, %runtime.Memory_Block** %46, align 8
  store i8 %44, i8* %47, align 1
  %48 = bitcast { %runtime.Memory_Block*, i8 }* %8 to { i64, i64 }*
  %49 = load { i64, i64 }, { i64, i64 }* %48, align 8
  br label %UnifiedReturnBlock

or_return.continue:                               ; preds = %runtime.mem_alloc.exit
  store { i8*, i64 } %42, { i8*, i64 }* %9, align 8
  %50 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %9, i32 0, i32 0
  %51 = load i8*, i8** %50, align 8
  %52 = bitcast i8* %51 to %runtime.Memory_Block*
  %53 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %9, i32 0, i32 1
  %54 = load i64, i64* %53, align 8
  %55 = getelementptr i8, i8* %51, i64 %54
  %56 = ptrtoint i8* %55 to i64
  %57 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %52, i32 0, i32 1
  store %runtime.Allocator %12, %runtime.Allocator* %57, align 8
  %58 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %52, i32 0, i32 2
  %59 = ptrtoint %runtime.Memory_Block* %52 to i64
  %60 = add i64 %59, 48
  %61 = inttoptr i64 %60 to i8*
  store i8* %61, i8** %58, align 8
  %62 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %52, i32 0, i32 4
  %63 = sub i64 %56, %60
  store i64 %63, i64* %62, align 8
  %64 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %52, i32 0, i32 3
  %65 = load i64, i64* %64, align 8
  %66 = icmp eq i64 %65, 0
  call fastcc void @runtime.assert(i1 zeroext %66, %..string zeroinitializer, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) @"ggv$0", i8* %__.context_ptr)
  %67 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %52, i32 0, i32 0
  %68 = load %runtime.Memory_Block*, %runtime.Memory_Block** %67, align 8
  %69 = icmp eq %runtime.Memory_Block* %68, null
  call fastcc void @runtime.assert(i1 zeroext %69, %..string zeroinitializer, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) @"ggv$1", i8* %__.context_ptr)
  %70 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %10, i32 0, i32 0
  %71 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %10, i32 0, i32 1
  store %runtime.Memory_Block* %52, %runtime.Memory_Block** %70, align 8
  store i8 0, i8* %71, align 1
  %72 = bitcast { %runtime.Memory_Block*, i8 }* %10 to { i64, i64 }*
  %73 = load { i64, i64 }, { i64, i64 }* %72, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %or_return.continue, %or_return.return
  %UnifiedRetVal = phi { i64, i64 } [ %49, %or_return.return ], [ %73, %or_return.continue ]
  ret { i64, i64 } %UnifiedRetVal
}

define internal fastcc void @runtime.memory_block_dealloc(%runtime.Memory_Block* %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %1, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  %2 = alloca %runtime.Allocator, align 8
  %3 = alloca { { i8*, i64 }, i8 }, align 8
  %4 = alloca %runtime.Source_Code_Location, align 8
  %5 = alloca %runtime.Allocator, align 8
  %6 = icmp ne %runtime.Memory_Block* %0, null
  br i1 %6, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %7 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 1
  %8 = bitcast %runtime.Allocator* %5 to i8*
  %9 = bitcast %runtime.Allocator* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %8, i8* align 8 %9, i64 16, i1 false)
  %10 = bitcast %runtime.Memory_Block* %0 to i8*
  %11 = bitcast %runtime.Allocator* %5 to { i64, i64 }*
  %12 = load { i64, i64 }, { i64, i64 }* %11, align 8
  call void @llvm.experimental.noalias.scope.decl(metadata !6)
  %13 = bitcast %runtime.Source_Code_Location* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 40, i8* %13)
  %14 = bitcast %runtime.Allocator* %2 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %14)
  %15 = bitcast { { i8*, i64 }, i8 }* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 24, i8* %15)
  %16 = bitcast %runtime.Source_Code_Location* %4 to i8*
  %17 = bitcast %runtime.Source_Code_Location* %1 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %16, i8* align 1 %17, i64 40, i1 false)
  %18 = bitcast %runtime.Allocator* %2 to { i64, i64 }*
  store { i64, i64 } %12, { i64, i64 }* %18, align 8, !noalias !6
  %19 = icmp eq i8* %10, null
  br i1 %19, label %runtime.mem_free.exit, label %cmp.or.i

cmp.or.i:                                         ; preds = %if.then
  %20 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %2, i32 0, i32 0
  %21 = load i8*, i8** %20, align 8, !noalias !6
  %22 = icmp eq i8* %21, null
  br i1 %22, label %runtime.mem_free.exit, label %if.done.i

if.done.i:                                        ; preds = %cmp.or.i
  %23 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %2, i32 0, i32 1
  %24 = load i8*, i8** %23, align 8, !noalias !6
  %25 = bitcast { { i8*, i64 }, i8 }* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %25, i8 0, i64 24, i1 false), !noalias !6
  %26 = bitcast i8* %21 to void ({ { i8*, i64 }, i8 }*, i8*, i8, i64, i64, i8*, i64, %runtime.Source_Code_Location*, i8*)*
  call void %26({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %3, i8* %24, i8 1, i64 0, i64 0, i8* %10, i64 0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %4, i8* %__.context_ptr) #12
  %27 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %3, i32 0, i32 1
  %28 = load i8, i8* %27, align 1, !noalias !6
  br label %runtime.mem_free.exit

runtime.mem_free.exit:                            ; preds = %if.then, %cmp.or.i, %if.done.i
  %UnifiedRetVal.i = phi i8 [ %28, %if.done.i ], [ 0, %cmp.or.i ], [ 0, %if.then ]
  %29 = bitcast %runtime.Source_Code_Location* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 40, i8* %29)
  %30 = bitcast %runtime.Allocator* %2 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %30)
  %31 = bitcast { { i8*, i64 }, i8 }* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 24, i8* %31)
  br label %if.done

if.done:                                          ; preds = %runtime.mem_free.exit, %decls
  ret void
}

define internal fastcc void @runtime.alloc_from_memory_block({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, %runtime.Memory_Block* %0, i64 %1, i64 %2) unnamed_addr {
decls:
  %3 = alloca { i64, i8 }, align 8
  %4 = alloca { i64, i8 }, align 8
  %5 = alloca { i8*, i64 }, align 8
  %6 = alloca { i64, i8 }, align 8
  %7 = alloca { i64, i8 }, align 8
  %8 = alloca { i8*, i64 }, align 8
  %9 = bitcast { i8*, i64 }* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 16, i1 false)
  %10 = icmp eq %runtime.Memory_Block* %0, null
  br i1 %10, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  call void @llvm.memset.p0i8.i64(i8* align 8 %9, i8 0, i64 16, i1 false)
  %11 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %12 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %13 = bitcast { i8*, i64 }* %11 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %13, i8 0, i64 16, i1 false)
  store i8 1, i8* %12, align 1
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %decls
  %14 = call fastcc i64 @runtime.alloc_from_memory_block.calc_alignment_offset-0(%runtime.Memory_Block* %0, i64 %2)
  %15 = bitcast { i64, i8 }* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %15)
  %16 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %1, i64 %14)
  %17 = extractvalue { i64, i1 } %16, 0
  %18 = extractvalue { i64, i1 } %16, 1
  %19 = zext i1 %18 to i8
  %20 = icmp eq i8 %19, 0
  %21 = zext i1 %20 to i8
  %22 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %4, i32 0, i32 0
  %23 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %4, i32 0, i32 1
  store i64 %17, i64* %22, align 8
  store i8 %21, i8* %23, align 1
  %24 = bitcast { i64, i8 }* %4 to { i64, i64 }*
  %25 = load { i64, i64 }, { i64, i64 }* %24, align 8
  %26 = bitcast { i64, i8 }* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %26)
  %27 = bitcast { i64, i8 }* %6 to { i64, i64 }*
  store { i64, i64 } %25, { i64, i64 }* %27, align 8
  %28 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %6, i32 0, i32 0
  %29 = load i64, i64* %28, align 8
  %30 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %6, i32 0, i32 1
  %31 = load i8, i8* %30, align 1
  %32 = trunc i8 %31 to i1
  br i1 %32, label %if.init, label %if.then1

if.then1:                                         ; preds = %if.done
  %33 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %34 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %35 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %33, { i8*, i64 }* %34, align 8
  store i8 1, i8* %35, align 1
  br label %UnifiedReturnBlock

if.init:                                          ; preds = %if.done
  %36 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 3
  %37 = load i64, i64* %36, align 8
  %38 = bitcast { i64, i8 }* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %38)
  %39 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %37, i64 %29)
  %40 = extractvalue { i64, i1 } %39, 0
  %41 = extractvalue { i64, i1 } %39, 1
  %42 = zext i1 %41 to i8
  %43 = icmp eq i8 %42, 0
  %44 = zext i1 %43 to i8
  %45 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %3, i32 0, i32 0
  %46 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %3, i32 0, i32 1
  store i64 %40, i64* %45, align 8
  store i8 %44, i8* %46, align 1
  %47 = bitcast { i64, i8 }* %3 to { i64, i64 }*
  %48 = load { i64, i64 }, { i64, i64 }* %47, align 8
  %49 = bitcast { i64, i8 }* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %49)
  %50 = bitcast { i64, i8 }* %7 to { i64, i64 }*
  store { i64, i64 } %48, { i64, i64 }* %50, align 8
  %51 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %7, i32 0, i32 0
  %52 = load i64, i64* %51, align 8
  %53 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %7, i32 0, i32 1
  %54 = load i8, i8* %53, align 1
  %55 = trunc i8 %54 to i1
  br i1 %55, label %cmp.or, label %if.then3

cmp.or:                                           ; preds = %if.init
  %56 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 4
  %57 = load i64, i64* %56, align 8
  %58 = icmp ugt i64 %52, %57
  br i1 %58, label %if.then3, label %if.done4

if.then3:                                         ; preds = %cmp.or, %if.init
  %59 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %60 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %61 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %59, { i8*, i64 }* %60, align 8
  store i8 1, i8* %61, align 1
  br label %UnifiedReturnBlock

if.done4:                                         ; preds = %cmp.or
  %62 = load i64, i64* %36, align 8
  %63 = add i64 %62, %14
  %64 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 2
  %65 = load i8*, i8** %64, align 8
  %66 = getelementptr i8, i8* %65, i64 %63
  call fastcc void @runtime.multi_pointer_slice_expr_error(%..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 83, i32 49, i64 %1)
  %67 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %8, i32 0, i32 0
  %68 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %8, i32 0, i32 1
  store i8* %66, i8** %67, align 8
  store i64 %1, i64* %68, align 8
  %69 = bitcast { i8*, i64 }* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %9, i8* align 8 %69, i64 16, i1 false)
  %70 = load i64, i64* %36, align 8
  %71 = add i64 %70, %29
  store i64 %71, i64* %36, align 8
  %72 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %73 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %74 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %72, { i8*, i64 }* %73, align 8
  store i8 0, i8* %74, align 1
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done4, %if.then3, %if.then1, %if.then
  ret void
}

define internal fastcc void @runtime.arena_alloc({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, %runtime.Arena* %0, i64 %1, i64 %2, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %3, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  %4 = alloca { i64, i8 }, align 8
  %5 = alloca { i8*, i64 }, align 8
  %6 = alloca { i64, i8 }, align 8
  %7 = alloca %runtime.Allocator, align 8
  %8 = alloca { %runtime.Memory_Block*, i8 }, align 8
  %9 = alloca { { i8*, i64 }, i8 }, align 8
  %10 = bitcast { i8*, i64 }* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 16, i1 false)
  %11 = sub i64 %2, 1
  %12 = and i64 %2, %11
  %13 = icmp eq i64 %12, 0
  call fastcc void @runtime.assert(i1 zeroext %13, %..string { i8* getelementptr inbounds ([27 x i8], [27 x i8]* @"csbs$4", i64 0, i64 0), i64 26 }, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %3, i8* %__.context_ptr)
  %14 = icmp eq i64 %1, 0
  br i1 %14, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %15 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %16 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %17 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %15, { i8*, i64 }* %16, align 8
  store i8 0, i8* %17, align 1
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %decls
  %18 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 1
  %19 = load %runtime.Memory_Block*, %runtime.Memory_Block** %18, align 8
  %20 = icmp eq %runtime.Memory_Block* %19, null
  br i1 %20, label %if.then1, label %cmp.or

cmp.or:                                           ; preds = %if.done
  %21 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %19, i32 0, i32 3
  %22 = load i64, i64* %21, align 8
  %23 = bitcast { i64, i8 }* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %23)
  %24 = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %22, i64 %1)
  %25 = extractvalue { i64, i1 } %24, 0
  %26 = extractvalue { i64, i1 } %24, 1
  %27 = zext i1 %26 to i8
  %28 = icmp eq i8 %27, 0
  %29 = zext i1 %28 to i8
  %30 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %4, i32 0, i32 0
  %31 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %4, i32 0, i32 1
  store i64 %25, i64* %30, align 8
  store i8 %29, i8* %31, align 1
  %32 = bitcast { i64, i8 }* %4 to { i64, i64 }*
  %33 = load { i64, i64 }, { i64, i64 }* %32, align 8
  %34 = bitcast { i64, i8 }* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %34)
  %35 = bitcast { i64, i8 }* %6 to { i64, i64 }*
  store { i64, i64 } %33, { i64, i64 }* %35, align 8
  %36 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %6, i32 0, i32 0
  %37 = load i64, i64* %36, align 8
  %38 = getelementptr inbounds { i64, i8 }, { i64, i8 }* %6, i32 0, i32 1
  %39 = load i8, i8* %38, align 1
  %40 = trunc i8 %39 to i1
  %. = select i1 %40, i64 %37, i64 0
  %41 = load %runtime.Memory_Block*, %runtime.Memory_Block** %18, align 8
  %42 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %41, i32 0, i32 4
  %43 = load i64, i64* %42, align 8
  %44 = icmp ugt i64 %., %43
  br i1 %44, label %if.then1, label %if.done6

if.then1:                                         ; preds = %cmp.or, %if.done
  %45 = call fastcc i64 @runtime.arena_alloc.align_forward_uint-0(i64 %1, i64 %2)
  %46 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 4
  %47 = load i64, i64* %46, align 8
  %48 = icmp eq i64 %47, 0
  br i1 %48, label %if.then2, label %if.done3

if.then2:                                         ; preds = %if.then1
  store i64 4194304, i64* %46, align 8
  br label %if.done3

if.done3:                                         ; preds = %if.then2, %if.then1
  %49 = load i64, i64* %46, align 8
  %50 = icmp ugt i64 %45, %49
  %51 = select i1 %50, i64 %45, i64 %49
  %52 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 0
  %53 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %52, i32 0, i32 0
  %54 = load i8*, i8** %53, align 8
  %55 = icmp eq i8* %54, null
  br i1 %55, label %if.then4, label %if.done5

if.then4:                                         ; preds = %if.done3
  %56 = call fastcc { i64, i64 } @runtime.default_allocator()
  %57 = bitcast %runtime.Allocator* %7 to { i64, i64 }*
  store { i64, i64 } %56, { i64, i64 }* %57, align 8
  %58 = bitcast %runtime.Allocator* %52 to i8*
  %59 = bitcast %runtime.Allocator* %7 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %58, i8* align 8 %59, i64 16, i1 false)
  br label %if.done5

if.done5:                                         ; preds = %if.then4, %if.done3
  %60 = bitcast %runtime.Allocator* %52 to { i64, i64 }*
  %61 = load { i64, i64 }, { i64, i64 }* %60, align 8
  %62 = call fastcc { i64, i64 } @runtime.memory_block_alloc({ i64, i64 } %61, i64 %51, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %3, i8* %__.context_ptr)
  %63 = bitcast { %runtime.Memory_Block*, i8 }* %8 to { i64, i64 }*
  store { i64, i64 } %62, { i64, i64 }* %63, align 8
  %64 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %8, i32 0, i32 0
  %65 = load %runtime.Memory_Block*, %runtime.Memory_Block** %64, align 8
  %66 = getelementptr inbounds { %runtime.Memory_Block*, i8 }, { %runtime.Memory_Block*, i8 }* %8, i32 0, i32 1
  %67 = load i8, i8* %66, align 1
  %68 = icmp eq i8 %67, 0
  br i1 %68, label %or_return.continue, label %or_return.return

or_return.return:                                 ; preds = %if.done5
  %69 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %70 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %71 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %69, { i8*, i64 }* %70, align 8
  store i8 %67, i8* %71, align 1
  br label %UnifiedReturnBlock

or_return.continue:                               ; preds = %if.done5
  %72 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %65, i32 0, i32 0
  %73 = load %runtime.Memory_Block*, %runtime.Memory_Block** %18, align 8
  store %runtime.Memory_Block* %73, %runtime.Memory_Block** %72, align 8
  store %runtime.Memory_Block* %65, %runtime.Memory_Block** %18, align 8
  %74 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 3
  %75 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %65, i32 0, i32 4
  %76 = load i64, i64* %75, align 8
  %77 = load i64, i64* %74, align 8
  %78 = add i64 %77, %76
  store i64 %78, i64* %74, align 8
  br label %if.done6

if.done6:                                         ; preds = %or_return.continue, %cmp.or
  %.0 = phi i64 [ %45, %or_return.continue ], [ %1, %cmp.or ]
  %79 = load %runtime.Memory_Block*, %runtime.Memory_Block** %18, align 8
  %80 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %79, i32 0, i32 3
  %81 = load i64, i64* %80, align 8
  %82 = bitcast { { i8*, i64 }, i8 }* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %82, i8 0, i64 24, i1 false)
  call fastcc void @runtime.alloc_from_memory_block({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %9, %runtime.Memory_Block* %79, i64 %.0, i64 %2)
  %83 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 0
  %84 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 1
  %85 = load i8, i8* %84, align 1
  %86 = bitcast { i8*, i64 }* %83 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %10, i8* align 8 %86, i64 16, i1 false)
  %87 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 2
  %88 = load %runtime.Memory_Block*, %runtime.Memory_Block** %18, align 8
  %89 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %88, i32 0, i32 3
  %90 = load i64, i64* %89, align 8
  %91 = sub i64 %90, %81
  %92 = load i64, i64* %87, align 8
  %93 = add i64 %92, %91
  store i64 %93, i64* %87, align 8
  %94 = load { i8*, i64 }, { i8*, i64 }* %5, align 8
  %95 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %96 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %94, { i8*, i64 }* %95, align 8
  store i8 %85, i8* %96, align 1
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done6, %or_return.return, %if.then
  ret void
}

define internal fastcc void @runtime.arena_free_last_memory_block(%runtime.Arena* %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %1, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  %2 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 1
  %3 = load %runtime.Memory_Block*, %runtime.Memory_Block** %2, align 8
  %4 = icmp ne %runtime.Memory_Block* %3, null
  br i1 %4, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %5 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %3, i32 0, i32 0
  %6 = load %runtime.Memory_Block*, %runtime.Memory_Block** %5, align 8
  store %runtime.Memory_Block* %6, %runtime.Memory_Block** %2, align 8
  %7 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 3
  %8 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %3, i32 0, i32 4
  %9 = load i64, i64* %8, align 8
  %10 = load i64, i64* %7, align 8
  %11 = sub i64 %10, %9
  store i64 %11, i64* %7, align 8
  call fastcc void @runtime.memory_block_dealloc(%runtime.Memory_Block* %3, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %1, i8* %__.context_ptr)
  br label %if.done

if.done:                                          ; preds = %if.then, %decls
  ret void
}

define internal fastcc void @runtime.arena_free_all(%runtime.Arena* %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %1, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  br label %for.loop

for.loop:                                         ; preds = %for.body, %decls
  %2 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 1
  %3 = load %runtime.Memory_Block*, %runtime.Memory_Block** %2, align 8
  %4 = icmp ne %runtime.Memory_Block* %3, null
  br i1 %4, label %cmp.and, label %for.done

cmp.and:                                          ; preds = %for.loop
  %5 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %3, i32 0, i32 0
  %6 = load %runtime.Memory_Block*, %runtime.Memory_Block** %5, align 8
  %7 = icmp ne %runtime.Memory_Block* %6, null
  br i1 %7, label %for.body, label %for.done

for.body:                                         ; preds = %cmp.and
  call fastcc void @runtime.arena_free_last_memory_block(%runtime.Arena* %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %1, i8* %__.context_ptr)
  br label %for.loop

for.done:                                         ; preds = %cmp.and, %for.loop
  %8 = load %runtime.Memory_Block*, %runtime.Memory_Block** %2, align 8
  %9 = icmp ne %runtime.Memory_Block* %8, null
  br i1 %9, label %if.then, label %if.done

if.then:                                          ; preds = %for.done
  %10 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %8, i32 0, i32 2
  %11 = load i8*, i8** %10, align 8
  %12 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %8, i32 0, i32 3
  %13 = load i64, i64* %12, align 8
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 %13, i1 false)
  %14 = load %runtime.Memory_Block*, %runtime.Memory_Block** %2, align 8
  %15 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %14, i32 0, i32 3
  store i64 0, i64* %15, align 8
  br label %if.done

if.done:                                          ; preds = %if.then, %for.done
  %16 = getelementptr inbounds %runtime.Arena, %runtime.Arena* %0, i32 0, i32 2
  store i64 0, i64* %16, align 8
  ret void
}

define internal fastcc void @runtime.arena_destroy(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %0, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  br label %for.loop

for.loop:                                         ; preds = %for.body, %decls
  %1 = load %runtime.Memory_Block*, %runtime.Memory_Block** getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 1), align 8
  %2 = icmp ne %runtime.Memory_Block* %1, null
  br i1 %2, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %3 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %1, i32 0, i32 0
  %4 = load %runtime.Memory_Block*, %runtime.Memory_Block** %3, align 8
  store %runtime.Memory_Block* %4, %runtime.Memory_Block** getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 1), align 8
  %5 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %1, i32 0, i32 4
  %6 = load i64, i64* %5, align 8
  %7 = load i64, i64* getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 3), align 8
  %8 = sub i64 %7, %6
  store i64 %8, i64* getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 3), align 8
  call fastcc void @runtime.memory_block_dealloc(%runtime.Memory_Block* %1, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %0, i8* %__.context_ptr)
  br label %for.loop

for.done:                                         ; preds = %for.loop
  store i64 0, i64* getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 2), align 8
  store i64 0, i64* getelementptr inbounds (%runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data, i32 0, i32 0, i32 3), align 8
  ret void
}

define internal fastcc void @runtime.arena_allocator_proc({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, i8* %0, i8 %1, i64 %2, i64 %3, i8* %4, i64 %5, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %6, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  %7 = alloca { i8*, i64 }, align 8
  %8 = alloca { { i8*, i64 }, i8 }, align 8
  %9 = alloca { { i8*, i64 }, i8 }, align 8
  %10 = alloca { i8*, i64 }, align 8
  %11 = alloca { i8*, i64 }, align 8
  %12 = alloca { { i8*, i64 }, i8 }, align 8
  %13 = alloca { i8*, i64 }, align 8
  %14 = alloca { i8*, i64 }, align 8
  %15 = bitcast { i8*, i64 }* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %15, i8 0, i64 16, i1 false)
  %16 = bitcast i8* %0 to %runtime.Arena*
  switch i8 %1, label %switch.done15 [
    i8 0, label %switch.case.body
    i8 6, label %switch.case.body
    i8 1, label %switch.case.body1
    i8 2, label %switch.case.body2
    i8 3, label %switch.case.body3
    i8 4, label %switch.case.body11
    i8 5, label %switch.case.body14
  ]

switch.case.body:                                 ; preds = %decls, %decls
  %17 = bitcast { { i8*, i64 }, i8 }* %8 to i8*
  call void @llvm.memset.p0i8.i64(i8* %17, i8 0, i64 24, i1 false)
  call fastcc void @runtime.arena_alloc({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %8, %runtime.Arena* %16, i64 %2, i64 %3, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %6, i8* %__.context_ptr)
  %18 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 0
  %19 = load { i8*, i64 }, { i8*, i64 }* %18, align 8
  %20 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 1
  %21 = load i8, i8* %20, align 1
  store { i8*, i64 } %19, { i8*, i64 }* %7, align 8
  %22 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %23 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %19, { i8*, i64 }* %22, align 8
  store i8 %21, i8* %23, align 1
  br label %UnifiedReturnBlock

switch.case.body1:                                ; preds = %decls
  br label %switch.done15

switch.case.body2:                                ; preds = %decls
  call fastcc void @runtime.arena_free_all(%runtime.Arena* %16, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %6, i8* %__.context_ptr)
  br label %switch.done15

switch.case.body3:                                ; preds = %decls
  %24 = icmp eq i8* %4, null
  br i1 %24, label %switch.case.body4, label %switch.case.next

switch.case.next:                                 ; preds = %switch.case.body3
  %25 = icmp eq i64 %2, %5
  br i1 %25, label %switch.case.body6, label %switch.case.next5

switch.case.body4:                                ; preds = %switch.case.body3
  %26 = bitcast { { i8*, i64 }, i8 }* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %26, i8 0, i64 24, i1 false)
  call fastcc void @runtime.arena_alloc({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %9, %runtime.Arena* %16, i64 %2, i64 %3, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %6, i8* %__.context_ptr)
  %27 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 0
  %28 = load { i8*, i64 }, { i8*, i64 }* %27, align 8
  %29 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 1
  %30 = load i8, i8* %29, align 1
  store { i8*, i64 } %28, { i8*, i64 }* %7, align 8
  %31 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %32 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %28, { i8*, i64 }* %31, align 8
  store i8 %30, i8* %32, align 1
  br label %UnifiedReturnBlock

switch.case.next5:                                ; preds = %switch.case.next
  %33 = icmp eq i64 %2, 0
  br i1 %33, label %switch.case.body8, label %switch.case.next7

switch.case.body6:                                ; preds = %switch.case.next
  call fastcc void @runtime.multi_pointer_slice_expr_error(%..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 206, i32 19, i64 %2)
  %34 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %10, i32 0, i32 0
  %35 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %10, i32 0, i32 1
  store i8* %4, i8** %34, align 8
  store i64 %2, i64* %35, align 8
  %36 = bitcast { i8*, i64 }* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %15, i8* align 8 %36, i64 16, i1 false)
  %37 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %38 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %39 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %37, { i8*, i64 }* %38, align 8
  store i8 0, i8* %39, align 1
  br label %UnifiedReturnBlock

switch.case.next7:                                ; preds = %switch.case.next5
  %40 = ptrtoint i8* %4 to i64
  %41 = sub i64 %3, 1
  %42 = and i64 %40, %41
  %43 = icmp eq i64 %42, 0
  %44 = icmp ult i64 %2, %5
  %45 = zext i1 %44 to i8
  %46 = select i1 %43, i8 %45, i8 0
  %47 = icmp eq i8 1, %46
  br i1 %47, label %switch.case.body10, label %switch.done

switch.case.body8:                                ; preds = %switch.case.next5
  %48 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %49 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %50 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %48, { i8*, i64 }* %49, align 8
  store i8 4, i8* %50, align 1
  br label %UnifiedReturnBlock

switch.case.body10:                               ; preds = %switch.case.next7
  call fastcc void @runtime.multi_pointer_slice_expr_error(%..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 213, i32 19, i64 %2)
  %51 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %11, i32 0, i32 0
  %52 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %11, i32 0, i32 1
  store i8* %4, i8** %51, align 8
  store i64 %2, i64* %52, align 8
  %53 = bitcast { i8*, i64 }* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %15, i8* align 8 %53, i64 16, i1 false)
  %54 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %55 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %56 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %54, { i8*, i64 }* %55, align 8
  store i8 0, i8* %56, align 1
  br label %UnifiedReturnBlock

switch.done:                                      ; preds = %switch.case.next7
  %57 = bitcast { { i8*, i64 }, i8 }* %12 to i8*
  call void @llvm.memset.p0i8.i64(i8* %57, i8 0, i64 24, i1 false)
  call fastcc void @runtime.arena_alloc({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %12, %runtime.Arena* %16, i64 %2, i64 %3, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %6, i8* %__.context_ptr)
  %58 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %12, i32 0, i32 0
  %59 = load { i8*, i64 }, { i8*, i64 }* %58, align 8
  %60 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %12, i32 0, i32 1
  %61 = load i8, i8* %60, align 1
  %62 = icmp eq i8 %61, 0
  br i1 %62, label %or_return.continue, label %or_return.return

or_return.return:                                 ; preds = %switch.done
  %63 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %64 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %65 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %63, { i8*, i64 }* %64, align 8
  store i8 %61, i8* %65, align 1
  br label %UnifiedReturnBlock

or_return.continue:                               ; preds = %switch.done
  store { i8*, i64 } %59, { i8*, i64 }* %13, align 8
  %66 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %13, i32 0, i32 0
  %67 = load i8*, i8** %66, align 8
  %68 = icmp eq i8* %67, null
  br i1 %68, label %if.then, label %if.done

if.then:                                          ; preds = %or_return.continue
  %69 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %70 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %71 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %69, { i8*, i64 }* %70, align 8
  store i8 0, i8* %71, align 1
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %or_return.continue
  call fastcc void @runtime.multi_pointer_slice_expr_error(%..string { i8* getelementptr inbounds ([69 x i8], [69 x i8]* @"csbs$2", i64 0, i64 0), i64 68 }, i32 221, i32 28, i64 %5)
  %72 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %14, i32 0, i32 0
  %73 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %14, i32 0, i32 1
  store i8* %4, i8** %72, align 8
  store i64 %5, i64* %73, align 8
  %74 = load { i8*, i64 }, { i8*, i64 }* %14, align 8
  call fastcc void @runtime.copy_slice-11602({ i8*, i64 } %59, { i8*, i64 } %74)
  %75 = load { i8*, i64 }, { i8*, i64 }* %13, align 8
  store { i8*, i64 } %75, { i8*, i64 }* %7, align 8
  %76 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %77 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %75, { i8*, i64 }* %76, align 8
  store i8 0, i8* %77, align 1
  br label %UnifiedReturnBlock

switch.case.body11:                               ; preds = %decls
  %78 = icmp ne i8* %4, null
  br i1 %78, label %if.then12, label %switch.done15

if.then12:                                        ; preds = %switch.case.body11
  store i8 93, i8* %4, align 1
  br label %switch.done15

switch.case.body14:                               ; preds = %decls
  br label %switch.done15

switch.done15:                                    ; preds = %switch.case.body11, %if.then12, %switch.case.body14, %switch.case.body2, %switch.case.body1, %decls
  %.0 = phi i8 [ 0, %decls ], [ 4, %switch.case.body14 ], [ 0, %switch.case.body2 ], [ 4, %switch.case.body1 ], [ 0, %if.then12 ], [ 0, %switch.case.body11 ]
  %79 = load { i8*, i64 }, { i8*, i64 }* %7, align 8
  %80 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %81 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %79, { i8*, i64 }* %80, align 8
  store i8 %.0, i8* %81, align 1
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %switch.done15, %if.done, %if.then, %or_return.return, %switch.case.body10, %switch.case.body8, %switch.case.body6, %switch.case.body4, %switch.case.body
  ret void
}

define internal fastcc void @runtime.os_write({ i8*, i64 } %0) unnamed_addr {
decls:
  %1 = alloca { i64, i64 }, align 8
  %2 = call fastcc { i64, i64 } @runtime._os_write({ i8*, i64 } %0)
  %3 = extractvalue { i64, i64 } %2, 0
  %4 = extractvalue { i64, i64 } %2, 1
  %5 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 0
  %6 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 1
  store i64 %3, i64* %5, align 8
  store i64 %4, i64* %6, align 8
  %7 = load { i64, i64 }, { i64, i64 }* %1, align 8
  ret void
}

define internal fastcc { i64, i64 } @runtime._os_write({ i8*, i64 } %0) unnamed_addr {
decls:
  %1 = alloca %runtime.Context, align 8
  %2 = alloca %runtime.Context, align 8
  %3 = alloca { i64, i32 }, align 8
  %4 = alloca { i64, i64 }, align 8
  %5 = bitcast %runtime.Context* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 96, i1 false)
  call fastcc void @runtime.__init_context-683(%runtime.Context* %1)
  %6 = bitcast %runtime.Context* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 96, i1 false)
  call fastcc void @runtime.default_context(%runtime.Context* sret(%runtime.Context*) %2)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %5, i8* align 8 %6, i64 96, i1 false)
  %7 = call fastcc { i64, i64 } @os.write({ i8*, i64 } %0)
  %8 = bitcast { i64, i32 }* %3 to { i64, i64 }*
  store { i64, i64 } %7, { i64, i64 }* %8, align 8
  %9 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 0
  %10 = load i64, i64* %9, align 8
  %11 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 1
  %12 = load i32, i32* %11, align 4
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %4, i32 0, i32 0
  %15 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %4, i32 0, i32 1
  store i64 %10, i64* %14, align 8
  store i64 %13, i64* %15, align 8
  %16 = load { i64, i64 }, { i64, i64 }* %4, align 8
  ret { i64, i64 } %16
}

; Function Attrs: noreturn nounwind
define internal fastcc void @runtime.bounds_trap() unnamed_addr #1 {
decls:
  call void @llvm.trap()
  unreachable
}

; Function Attrs: nounwind
define internal fastcc i128 @runtime.udivmod128(i128 %0, i128 %1, i128* %2) unnamed_addr #0 {
decls:
  %3 = alloca i128, align 8
  %4 = alloca [2 x i64], align 8
  %5 = alloca i128, align 8
  %6 = alloca [2 x i64], align 8
  %7 = alloca [2 x i64], align 8
  %8 = alloca [2 x i64], align 8
  %9 = alloca i128, align 8
  store i128 %0, i128* %3, align 8
  %10 = bitcast i128* %3 to [2 x i64]*
  %11 = bitcast [2 x i64]* %4 to i8*
  %12 = bitcast [2 x i64]* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %11, i8* align 8 %12, i64 16, i1 false)
  store i128 %1, i128* %5, align 8
  %13 = bitcast i128* %5 to [2 x i64]*
  %14 = bitcast [2 x i64]* %6 to i8*
  %15 = bitcast [2 x i64]* %13 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %14, i8* align 8 %15, i64 16, i1 false)
  %16 = bitcast [2 x i64]* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %16, i8 0, i64 16, i1 false)
  %17 = bitcast [2 x i64]* %8 to i8*
  call void @llvm.memset.p0i8.i64(i8* %17, i8 0, i64 16, i1 false)
  %18 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 1
  %19 = load i64, i64* %18, align 8
  %20 = icmp eq i64 %19, 0
  br i1 %20, label %if.then, label %if.done6

if.then:                                          ; preds = %decls
  %21 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 1
  %22 = load i64, i64* %21, align 8
  %23 = icmp eq i64 %22, 0
  br i1 %23, label %if.then1, label %if.done3

if.then1:                                         ; preds = %if.then
  %24 = icmp ne i128* %2, null
  br i1 %24, label %if.then2, label %if.done

if.then2:                                         ; preds = %if.then1
  %25 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %26 = load i64, i64* %25, align 8
  %27 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 0
  %28 = load i64, i64* %27, align 8
  %29 = urem i64 %26, %28
  %30 = zext i64 %29 to i128
  store i128 %30, i128* %2, align 8
  br label %if.done

if.done:                                          ; preds = %if.then2, %if.then1
  %31 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %32 = load i64, i64* %31, align 8
  %33 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 0
  %34 = load i64, i64* %33, align 8
  %35 = udiv i64 %32, %34
  %36 = zext i64 %35 to i128
  br label %UnifiedReturnBlock

if.done3:                                         ; preds = %if.then
  %37 = icmp ne i128* %2, null
  br i1 %37, label %if.then4, label %UnifiedReturnBlock

if.then4:                                         ; preds = %if.done3
  %38 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %39 = load i64, i64* %38, align 8
  %40 = zext i64 %39 to i128
  store i128 %40, i128* %2, align 8
  br label %UnifiedReturnBlock

if.done6:                                         ; preds = %decls
  %41 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 0
  %42 = load i64, i64* %41, align 8
  %43 = icmp eq i64 %42, 0
  br i1 %43, label %if.then7, label %if.else

if.then7:                                         ; preds = %if.done6
  %44 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 1
  %45 = load i64, i64* %44, align 8
  %46 = icmp eq i64 %45, 0
  br i1 %46, label %if.then8, label %if.done11

if.then8:                                         ; preds = %if.then7
  %47 = icmp ne i128* %2, null
  br i1 %47, label %if.then9, label %if.done10

if.then9:                                         ; preds = %if.then8
  %48 = urem i64 %19, 0
  %49 = zext i64 %48 to i128
  store i128 %49, i128* %2, align 8
  br label %if.done10

if.done10:                                        ; preds = %if.then9, %if.then8
  %50 = load i64, i64* %18, align 8
  %51 = load i64, i64* %41, align 8
  %52 = udiv i64 %50, %51
  %53 = zext i64 %52 to i128
  br label %UnifiedReturnBlock

if.done11:                                        ; preds = %if.then7
  %54 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %55 = load i64, i64* %54, align 8
  %56 = icmp eq i64 %55, 0
  br i1 %56, label %if.then12, label %if.done15

if.then12:                                        ; preds = %if.done11
  %57 = icmp ne i128* %2, null
  br i1 %57, label %if.then13, label %if.done14

if.then13:                                        ; preds = %if.then12
  %58 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  %59 = urem i64 %19, %45
  store i64 %59, i64* %58, align 8
  %60 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  store i64 0, i64* %60, align 8
  %61 = bitcast [2 x i64]* %8 to i128*
  %62 = load i128, i128* %61, align 8
  store i128 %62, i128* %2, align 8
  br label %if.done14

if.done14:                                        ; preds = %if.then13, %if.then12
  %63 = load i64, i64* %18, align 8
  %64 = load i64, i64* %44, align 8
  %65 = udiv i64 %63, %64
  %66 = zext i64 %65 to i128
  br label %UnifiedReturnBlock

if.done15:                                        ; preds = %if.done11
  %67 = sub i64 %45, 1
  %68 = and i64 %45, %67
  %69 = icmp eq i64 %68, 0
  br i1 %69, label %if.then16, label %if.done19

if.then16:                                        ; preds = %if.done15
  %70 = icmp ne i128* %2, null
  br i1 %70, label %if.then17, label %if.done18

if.then17:                                        ; preds = %if.then16
  %71 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  store i64 %55, i64* %71, align 8
  %72 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  %73 = load i64, i64* %18, align 8
  %74 = load i64, i64* %44, align 8
  %75 = sub i64 %74, 1
  %76 = and i64 %73, %75
  store i64 %76, i64* %72, align 8
  %77 = bitcast [2 x i64]* %8 to i128*
  %78 = load i128, i128* %77, align 8
  store i128 %78, i128* %2, align 8
  br label %if.done18

if.done18:                                        ; preds = %if.then17, %if.then16
  %79 = load i64, i64* %18, align 8
  %80 = load i64, i64* %44, align 8
  %81 = call i64 @llvm.cttz.i64(i64 %80, i1 false)
  %82 = icmp ult i64 %81, 64
  %83 = lshr i64 %79, %81
  %84 = select i1 %82, i64 %83, i64 0
  %85 = zext i64 %84 to i128
  br label %UnifiedReturnBlock

if.done19:                                        ; preds = %if.done15
  %86 = call i64 @llvm.ctlz.i64(i64 %45, i1 false)
  %87 = trunc i64 %86 to i32
  %88 = call i64 @llvm.ctlz.i64(i64 %19, i1 false)
  %89 = trunc i64 %88 to i32
  %90 = sub i32 %87, %89
  %91 = icmp ugt i32 %90, 62
  br i1 %91, label %if.then20, label %if.done23

if.then20:                                        ; preds = %if.done19
  %92 = icmp ne i128* %2, null
  br i1 %92, label %if.then21, label %UnifiedReturnBlock

if.then21:                                        ; preds = %if.then20
  store i128 %0, i128* %2, align 8
  br label %UnifiedReturnBlock

if.done23:                                        ; preds = %if.done19
  %93 = add i32 %90, 1
  %94 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  store i64 0, i64* %94, align 8
  %95 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %96 = load i64, i64* %54, align 8
  %97 = sub i32 64, %93
  %98 = zext i32 %97 to i64
  %99 = shl i64 %96, %98
  %100 = select i1 true, i64 %99, i64 0
  store i64 %100, i64* %95, align 8
  %101 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  %102 = load i64, i64* %18, align 8
  %103 = zext i32 %93 to i64
  %104 = lshr i64 %102, %103
  %105 = select i1 true, i64 %104, i64 0
  store i64 %105, i64* %101, align 8
  %106 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  %107 = load i64, i64* %18, align 8
  %108 = shl i64 %107, %98
  %109 = select i1 true, i64 %108, i64 0
  %110 = load i64, i64* %54, align 8
  %111 = lshr i64 %110, %103
  %112 = select i1 true, i64 %111, i64 0
  %113 = or i64 %109, %112
  store i64 %113, i64* %106, align 8
  br label %if.done42

if.else:                                          ; preds = %if.done6
  %114 = getelementptr [2 x i64], [2 x i64]* %6, i64 0, i64 1
  %115 = load i64, i64* %114, align 8
  %116 = icmp eq i64 %115, 0
  br i1 %116, label %if.then24, label %if.else33

if.then24:                                        ; preds = %if.else
  %117 = sub i64 %42, 1
  %118 = and i64 %42, %117
  %119 = icmp eq i64 %118, 0
  br i1 %119, label %if.then25, label %if.done30

if.then25:                                        ; preds = %if.then24
  %120 = icmp ne i128* %2, null
  br i1 %120, label %if.then26, label %if.done27

if.then26:                                        ; preds = %if.then25
  %121 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %122 = load i64, i64* %121, align 8
  %123 = and i64 %122, %117
  %124 = zext i64 %123 to i128
  store i128 %124, i128* %2, align 8
  br label %if.done27

if.done27:                                        ; preds = %if.then26, %if.then25
  %125 = load i64, i64* %41, align 8
  %126 = icmp eq i64 %125, 1
  br i1 %126, label %UnifiedReturnBlock, label %if.done29

if.done29:                                        ; preds = %if.done27
  %127 = call i64 @llvm.cttz.i64(i64 %125, i1 false)
  %128 = trunc i64 %127 to i32
  %129 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %130 = load i64, i64* %18, align 8
  %131 = zext i32 %128 to i64
  %132 = icmp ult i64 %131, 64
  %133 = lshr i64 %130, %131
  %134 = select i1 %132, i64 %133, i64 0
  store i64 %134, i64* %129, align 8
  %135 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  %136 = load i64, i64* %18, align 8
  %137 = sub i32 64, %128
  %138 = zext i32 %137 to i64
  %139 = icmp ult i64 %138, 64
  %140 = shl i64 %136, %138
  %141 = select i1 %139, i64 %140, i64 0
  %142 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %143 = load i64, i64* %142, align 8
  %144 = lshr i64 %143, %131
  %145 = select i1 %132, i64 %144, i64 0
  %146 = or i64 %141, %145
  store i64 %146, i64* %135, align 8
  %147 = bitcast [2 x i64]* %7 to i128*
  %148 = load i128, i128* %147, align 8
  br label %UnifiedReturnBlock

if.done30:                                        ; preds = %if.then24
  %149 = call i64 @llvm.ctlz.i64(i64 %42, i1 false)
  %150 = trunc i64 %149 to i32
  %151 = add i32 65, %150
  %152 = call i64 @llvm.ctlz.i64(i64 %19, i1 false)
  %153 = trunc i64 %152 to i32
  %154 = sub i32 %151, %153
  %155 = icmp eq i32 %154, 64
  br i1 %155, label %switch.case.body, label %switch.case.next

switch.case.next:                                 ; preds = %if.done30
  %156 = icmp ult i32 %154, 64
  br i1 %156, label %switch.case.body32, label %switch.default.body

switch.case.body:                                 ; preds = %if.done30
  %157 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  store i64 0, i64* %157, align 8
  %158 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %159 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %160 = load i64, i64* %159, align 8
  store i64 %160, i64* %158, align 8
  %161 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  store i64 0, i64* %161, align 8
  %162 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  %163 = load i64, i64* %18, align 8
  store i64 %163, i64* %162, align 8
  br label %if.done42

switch.case.body32:                               ; preds = %switch.case.next
  %164 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  store i64 0, i64* %164, align 8
  %165 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %166 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %167 = load i64, i64* %166, align 8
  %168 = sub i32 64, %154
  %169 = zext i32 %168 to i64
  %170 = icmp ult i64 %169, 64
  %171 = shl i64 %167, %169
  %172 = select i1 %170, i64 %171, i64 0
  store i64 %172, i64* %165, align 8
  %173 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  %174 = load i64, i64* %18, align 8
  %175 = zext i32 %154 to i64
  %176 = lshr i64 %174, %175
  %177 = select i1 true, i64 %176, i64 0
  store i64 %177, i64* %173, align 8
  %178 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  %179 = load i64, i64* %18, align 8
  %180 = shl i64 %179, %169
  %181 = select i1 %170, i64 %180, i64 0
  %182 = load i64, i64* %166, align 8
  %183 = lshr i64 %182, %175
  %184 = select i1 true, i64 %183, i64 0
  %185 = or i64 %181, %184
  store i64 %185, i64* %178, align 8
  br label %if.done42

switch.default.body:                              ; preds = %switch.case.next
  %186 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  %187 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %188 = load i64, i64* %187, align 8
  %189 = sub i32 128, %154
  %190 = zext i32 %189 to i64
  %191 = icmp ult i64 %190, 64
  %192 = shl i64 %188, %190
  %193 = select i1 %191, i64 %192, i64 0
  store i64 %193, i64* %186, align 8
  %194 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %195 = load i64, i64* %18, align 8
  %196 = shl i64 %195, %190
  %197 = select i1 %191, i64 %196, i64 0
  %198 = load i64, i64* %187, align 8
  %199 = sub i32 %154, 64
  %200 = zext i32 %199 to i64
  %201 = icmp ult i64 %200, 64
  %202 = lshr i64 %198, %200
  %203 = select i1 %201, i64 %202, i64 0
  %204 = or i64 %197, %203
  store i64 %204, i64* %194, align 8
  %205 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  store i64 0, i64* %205, align 8
  %206 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  %207 = load i64, i64* %18, align 8
  %208 = lshr i64 %207, %200
  %209 = select i1 %201, i64 %208, i64 0
  store i64 %209, i64* %206, align 8
  br label %if.done42

if.else33:                                        ; preds = %if.else
  %210 = call i64 @llvm.ctlz.i64(i64 %115, i1 false)
  %211 = trunc i64 %210 to i32
  %212 = call i64 @llvm.ctlz.i64(i64 %19, i1 false)
  %213 = trunc i64 %212 to i32
  %214 = sub i32 %211, %213
  %215 = icmp ugt i32 %214, 63
  br i1 %215, label %if.then34, label %if.done37

if.then34:                                        ; preds = %if.else33
  %216 = icmp ne i128* %2, null
  br i1 %216, label %if.then35, label %UnifiedReturnBlock

if.then35:                                        ; preds = %if.then34
  store i128 %0, i128* %2, align 8
  br label %UnifiedReturnBlock

if.done37:                                        ; preds = %if.else33
  %217 = add i32 %214, 1
  %218 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  store i64 0, i64* %218, align 8
  %219 = icmp eq i32 %217, 64
  br i1 %219, label %if.then38, label %if.else39

if.then38:                                        ; preds = %if.done37
  %220 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %221 = load i64, i64* %220, align 8
  %222 = load i64, i64* %18, align 8
  br label %if.done40

if.else39:                                        ; preds = %if.done37
  %223 = load i64, i64* %18, align 8
  %224 = zext i32 %217 to i64
  %225 = lshr i64 %223, %224
  %226 = select i1 true, i64 %225, i64 0
  %227 = sub i32 64, %217
  %228 = zext i32 %227 to i64
  %229 = shl i64 %223, %228
  %230 = select i1 true, i64 %229, i64 0
  %231 = getelementptr [2 x i64], [2 x i64]* %4, i64 0, i64 0
  %232 = load i64, i64* %231, align 8
  %233 = lshr i64 %232, %224
  %234 = select i1 true, i64 %233, i64 0
  %235 = or i64 %230, %234
  %236 = shl i64 %232, %228
  %237 = select i1 true, i64 %236, i64 0
  br label %if.done40

if.done40:                                        ; preds = %if.else39, %if.then38
  %.sink47 = phi i64 [ %221, %if.then38 ], [ %237, %if.else39 ]
  %.sink46 = phi i64 [ 0, %if.then38 ], [ %226, %if.else39 ]
  %.sink = phi i64 [ %222, %if.then38 ], [ %235, %if.else39 ]
  %238 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  store i64 %.sink47, i64* %238, align 8
  %239 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  store i64 %.sink46, i64* %239, align 8
  %240 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  store i64 %.sink, i64* %240, align 8
  br label %if.done42

if.done42:                                        ; preds = %if.done40, %switch.default.body, %switch.case.body32, %switch.case.body, %if.done23
  %.1 = phi i32 [ %93, %if.done23 ], [ %217, %if.done40 ], [ %154, %switch.default.body ], [ %154, %switch.case.body32 ], [ 64, %switch.case.body ]
  store i128 0, i128* %9, align 8
  br label %for.loop

for.loop:                                         ; preds = %for.body, %if.done42
  %.2 = phi i32 [ %.1, %if.done42 ], [ %276, %for.body ]
  %.0 = phi i32 [ 0, %if.done42 ], [ %271, %for.body ]
  %241 = icmp ugt i32 %.2, 0
  br i1 %241, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %242 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 1
  %243 = load i64, i64* %242, align 8
  %244 = shl i64 %243, 1
  %245 = getelementptr [2 x i64], [2 x i64]* %8, i64 0, i64 0
  %246 = load i64, i64* %245, align 8
  %247 = lshr i64 %246, 63
  %248 = or i64 %244, %247
  store i64 %248, i64* %242, align 8
  %249 = load i64, i64* %245, align 8
  %250 = shl i64 %249, 1
  %251 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 1
  %252 = load i64, i64* %251, align 8
  %253 = lshr i64 %252, 63
  %254 = or i64 %250, %253
  store i64 %254, i64* %245, align 8
  %255 = load i64, i64* %251, align 8
  %256 = shl i64 %255, 1
  %257 = getelementptr [2 x i64], [2 x i64]* %7, i64 0, i64 0
  %258 = load i64, i64* %257, align 8
  %259 = lshr i64 %258, 63
  %260 = or i64 %256, %259
  store i64 %260, i64* %251, align 8
  %261 = load i64, i64* %257, align 8
  %262 = shl i64 %261, 1
  %263 = zext i32 %.0 to i64
  %264 = or i64 %262, %263
  store i64 %264, i64* %257, align 8
  %265 = bitcast [2 x i64]* %8 to i128*
  %266 = load i128, i128* %265, align 8
  %267 = sub i128 %1, %266
  %268 = sub i128 %267, 1
  %269 = ashr i128 %268, 127
  %270 = and i128 %269, 1
  %271 = trunc i128 %270 to i32
  %272 = and i128 %1, %269
  %273 = sub i128 %266, %272
  store i128 %273, i128* %9, align 8
  %274 = bitcast i128* %9 to [2 x i64]*
  %275 = bitcast [2 x i64]* %274 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %17, i8* align 8 %275, i64 16, i1 false)
  %276 = sub i32 %.2, 1
  br label %for.loop

for.done:                                         ; preds = %for.loop
  %277 = bitcast [2 x i64]* %7 to i128*
  %278 = load i128, i128* %277, align 8
  %279 = shl i128 %278, 1
  %280 = zext i32 %.0 to i128
  %281 = or i128 %279, %280
  %282 = icmp ne i128* %2, null
  br i1 %282, label %if.then43, label %UnifiedReturnBlock

if.then43:                                        ; preds = %for.done
  %283 = load i128, i128* %9, align 8
  store i128 %283, i128* %2, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %for.done, %if.then43, %if.then34, %if.then35, %if.done27, %if.then20, %if.then21, %if.done3, %if.then4, %if.done29, %if.done18, %if.done14, %if.done10, %if.done
  %UnifiedRetVal = phi i128 [ %36, %if.done ], [ %53, %if.done10 ], [ %66, %if.done14 ], [ %85, %if.done18 ], [ %148, %if.done29 ], [ 0, %if.then4 ], [ 0, %if.done3 ], [ 0, %if.then21 ], [ 0, %if.then20 ], [ %0, %if.done27 ], [ 0, %if.then35 ], [ 0, %if.then34 ], [ %281, %if.then43 ], [ %281, %for.done ]
  ret i128 %UnifiedRetVal
}

define internal fastcc void @runtime.print_string(%..string %0) unnamed_addr {
decls:
  %1 = alloca %..string, align 8
  store %..string %0, %..string* %1, align 8
  %2 = bitcast %..string* %1 to { i8*, i64 }*
  %3 = load { i8*, i64 }, { i8*, i64 }* %2, align 8
  call fastcc void @runtime.os_write({ i8*, i64 } %3)
  %4 = extractvalue { i64, i64 } undef, 0
  ret void
}

; Function Attrs: noreturn
define internal fastcc void @runtime.slice_handle_error(i64 %0, i64 %1, i64 %2) unnamed_addr #2 {
decls:
  %3 = alloca %runtime.Source_Code_Location, align 8
  %4 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %3, i32 0, i32 0
  %5 = bitcast %runtime.Source_Code_Location* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 40, i1 false)
  store %..string { i8* getelementptr inbounds ([42 x i8], [42 x i8]* @"csbs$14", i64 0, i64 0), i64 41 }, %..string* %4, align 8
  %6 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %3, i32 0, i32 1
  store i32 222, i32* %6, align 4
  %7 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %3, i32 0, i32 2
  store i32 41, i32* %7, align 4
  call fastcc void @runtime.print_caller_location(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %3)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([24 x i8], [24 x i8]* @"csbs$5", i64 0, i64 0), i64 23 })
  call fastcc void @runtime.print_i64(i64 %0)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @"csbs$6", i64 0, i64 0), i64 1 })
  call fastcc void @runtime.print_i64(i64 %1)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([22 x i8], [22 x i8]* @"csbs$7", i64 0, i64 0), i64 21 })
  call fastcc void @runtime.print_i64(i64 %2)
  call fastcc void @runtime.print_byte(i8 10)
  call fastcc void @runtime.bounds_trap()
  unreachable
}

; Function Attrs: noreturn
define internal fastcc void @runtime.multi_pointer_slice_handle_error(%..string %0, i32 %1, i32 %2, i64 %3) unnamed_addr #2 {
decls:
  %4 = alloca %runtime.Source_Code_Location, align 8
  %5 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %4, i32 0, i32 0
  %6 = bitcast %runtime.Source_Code_Location* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 40, i1 false)
  store %..string %0, %..string* %5, align 8
  %7 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %4, i32 0, i32 1
  store i32 %1, i32* %7, align 4
  %8 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %4, i32 0, i32 2
  store i32 %2, i32* %8, align 4
  call fastcc void @runtime.print_caller_location(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %4)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([24 x i8], [24 x i8]* @"csbs$5", i64 0, i64 0), i64 23 })
  call fastcc void @runtime.print_i64(i64 0)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @"csbs$6", i64 0, i64 0), i64 1 })
  call fastcc void @runtime.print_i64(i64 %3)
  call fastcc void @runtime.print_byte(i8 10)
  call fastcc void @runtime.bounds_trap()
  unreachable
}

define internal fastcc void @runtime.print_byte(i8 %0) unnamed_addr {
decls:
  %1 = alloca { i8*, i64 }, align 8
  %2 = alloca [1 x i8], align 16
  %3 = alloca { i8*, i64 }, align 8
  %4 = bitcast { i8*, i64 }* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 16, i1 false)
  %5 = bitcast [1 x i8]* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 1 %5, i8 0, i64 1, i1 false)
  %6 = getelementptr inbounds [1 x i8], [1 x i8]* %2, i64 0, i64 0
  %7 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %3, i32 0, i32 0
  store i8* %6, i8** %7, align 8
  %8 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %3, i32 0, i32 1
  store i64 1, i64* %8, align 8
  %9 = load { i8*, i64 }, { i8*, i64 }* %3, align 8
  %10 = load i8*, i8** %7, align 8
  store i8 %0, i8* %10, align 1
  %11 = extractvalue { i8*, i64 } %9, 1
  %12 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %1, i32 0, i32 0
  store i8* %10, i8** %12, align 8
  %13 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %1, i32 0, i32 1
  store i64 %11, i64* %13, align 8
  %14 = load { i8*, i64 }, { i8*, i64 }* %1, align 8
  call fastcc void @runtime.os_write({ i8*, i64 } %14)
  %15 = extractvalue { i64, i64 } undef, 0
  ret void
}

define internal fastcc void @runtime.multi_pointer_slice_expr_error(%..string %0, i32 %1, i32 %2, i64 %3) unnamed_addr {
decls:
  %4 = icmp sle i64 0, %3
  br i1 %4, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  ret void

if.done:                                          ; preds = %decls
  call fastcc void @runtime.multi_pointer_slice_handle_error(%..string %0, i32 %1, i32 %2, i64 %3)
  unreachable
}

; Function Attrs: nounwind
define dllexport i64 @foo(i64* %0, i64 %1, i8* noalias nocapture nonnull %__.context_ptr) local_unnamed_addr #0 {
decls:
  %2 = alloca i64, align 8
  store i64 0, i64* %2, align 8
  call fastcc void @mdspan.reduce_add_helper_leading-11592(i64* %0, i64* %2, i64 %1)
  %3 = load i64, i64* %2, align 8
  ret i64 %3
}

define internal fastcc void @runtime.slice_expr_error_lo_hi(i64 %0, i64 %1, i64 %2) unnamed_addr {
decls:
  %3 = icmp sle i64 0, %0
  %4 = icmp sle i64 %0, %2
  %or.cond = select i1 %3, i1 %4, i1 false
  %5 = icmp sle i64 %0, %1
  %or.cond1 = select i1 %or.cond, i1 %5, i1 false
  %6 = icmp sle i64 %1, %2
  %or.cond2 = select i1 %or.cond1, i1 %6, i1 false
  br i1 %or.cond2, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  ret void

if.done:                                          ; preds = %decls
  call fastcc void @runtime.slice_handle_error(i64 %0, i64 %1, i64 %2)
  unreachable
}

define internal fastcc void @runtime.print_u64(i64 %0) unnamed_addr {
decls:
  %1 = alloca [129 x i8], align 1
  %2 = alloca { i8*, i64 }, align 8
  %3 = bitcast [129 x i8]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 129, i1 false)
  br label %for.loop

for.loop:                                         ; preds = %for.body, %decls
  %.01 = phi i64 [ 129, %decls ], [ %5, %for.body ]
  %.0 = phi i64 [ %0, %decls ], [ %10, %for.body ]
  %4 = icmp uge i64 %.0, 10
  br i1 %4, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %5 = sub i64 %.01, 1
  %6 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 %5
  %7 = urem i64 %.0, 10
  %8 = getelementptr i8, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @"csbs$0", i64 0, i64 0), i64 %7
  %9 = load i8, i8* %8, align 1
  store i8 %9, i8* %6, align 1
  %10 = udiv i64 %.0, 10
  br label %for.loop

for.done:                                         ; preds = %for.loop
  %11 = sub i64 %.01, 1
  %12 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 %11
  %13 = urem i64 %.0, 10
  %14 = getelementptr i8, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @"csbs$0", i64 0, i64 0), i64 %13
  %15 = load i8, i8* %14, align 1
  store i8 %15, i8* %12, align 1
  %16 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 0
  %17 = getelementptr i8, i8* %16, i64 %11
  %18 = sub i64 129, %11
  %19 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %2, i32 0, i32 0
  store i8* %17, i8** %19, align 8
  %20 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %2, i32 0, i32 1
  store i64 %18, i64* %20, align 8
  %21 = load { i8*, i64 }, { i8*, i64 }* %2, align 8
  call fastcc void @runtime.os_write({ i8*, i64 } %21)
  ret void
}

define internal fastcc void @runtime.print_i64(i64 %0) unnamed_addr {
decls:
  %1 = alloca [129 x i8], align 1
  %2 = alloca { i8*, i64 }, align 8
  %3 = icmp slt i64 %0, 0
  %4 = sub i64 0, %0
  %5 = select i1 %3, i64 %4, i64 %0
  %6 = bitcast [129 x i8]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 129, i1 false)
  br label %for.loop

for.loop:                                         ; preds = %for.body, %decls
  %.01 = phi i64 [ %5, %decls ], [ %13, %for.body ]
  %.0 = phi i64 [ 129, %decls ], [ %8, %for.body ]
  %7 = icmp sge i64 %.01, 10
  br i1 %7, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %8 = sub i64 %.0, 1
  %9 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 %8
  %10 = srem i64 %.01, 10
  %11 = getelementptr i8, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @"csbs$0", i64 0, i64 0), i64 %10
  %12 = load i8, i8* %11, align 1
  store i8 %12, i8* %9, align 1
  %13 = sdiv i64 %.01, 10
  br label %for.loop

for.done:                                         ; preds = %for.loop
  %14 = sub i64 %.0, 1
  %15 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 %14
  %16 = srem i64 %.01, 10
  %17 = getelementptr i8, i8* getelementptr inbounds ([37 x i8], [37 x i8]* @"csbs$0", i64 0, i64 0), i64 %16
  %18 = load i8, i8* %17, align 1
  store i8 %18, i8* %15, align 1
  br i1 %3, label %if.then, label %if.done

if.then:                                          ; preds = %for.done
  %19 = sub i64 %14, 1
  %20 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 %19
  store i8 45, i8* %20, align 1
  br label %if.done

if.done:                                          ; preds = %if.then, %for.done
  %.1 = phi i64 [ %19, %if.then ], [ %14, %for.done ]
  %21 = getelementptr [129 x i8], [129 x i8]* %1, i64 0, i64 0
  %22 = getelementptr i8, i8* %21, i64 %.1
  %23 = sub i64 129, %.1
  %24 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %2, i32 0, i32 0
  store i8* %22, i8** %24, align 8
  %25 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %2, i32 0, i32 1
  store i64 %23, i64* %25, align 8
  %26 = load { i8*, i64 }, { i8*, i64 }* %2, align 8
  call fastcc void @runtime.os_write({ i8*, i64 } %26)
  ret void
}

define internal fastcc void @runtime.print_caller_location(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %0) unnamed_addr {
decls:
  %1 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %0, i32 0, i32 0
  %2 = load %..string, %..string* %1, align 8
  call fastcc void @runtime.print_string(%..string %2)
  call fastcc void @runtime.print_byte(i8 40)
  %3 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %0, i32 0, i32 1
  %4 = load i32, i32* %3, align 4
  %5 = sext i32 %4 to i64
  call fastcc void @runtime.print_u64(i64 %5)
  call fastcc void @runtime.print_byte(i8 58)
  %6 = getelementptr inbounds %runtime.Source_Code_Location, %runtime.Source_Code_Location* %0, i32 0, i32 2
  %7 = load i32, i32* %6, align 4
  %8 = sext i32 %7 to i64
  call fastcc void @runtime.print_u64(i64 %8)
  call fastcc void @runtime.print_byte(i8 41)
  ret void
}

; Function Attrs: nounwind
define internal void @runtime.default_logger_proc(i8* %0, i64 %1, %..string %2, i16 %3, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %4, i8* noalias nocapture nonnull %__.context_ptr) #0 {
decls:
  ret void
}

; Function Attrs: nounwind
define internal fastcc void @runtime.default_context(%runtime.Context* noalias sret(%runtime.Context) %agg.result) unnamed_addr #0 {
decls:
  %0 = alloca %runtime.Context, align 8
  %1 = bitcast %runtime.Context* %0 to i8*
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 96, i1 false)
  call fastcc void @runtime.__init_context-683(%runtime.Context* %0)
  %2 = bitcast %runtime.Context* %agg.result to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %1, i64 96, i1 false)
  ret void
}

; Function Attrs: nounwind
define internal fastcc void @runtime.__init_context-683(%runtime.Context* %0) unnamed_addr #0 {
decls:
  %1 = icmp eq %runtime.Context* %0, null
  br i1 %1, label %UnifiedReturnBlock, label %if.done

if.done:                                          ; preds = %decls
  %2 = getelementptr inbounds %runtime.Context, %runtime.Context* %0, i32 0, i32 0
  %3 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %2, i32 0, i32 0
  store i8* bitcast (void ({ { i8*, i64 }, i8 }*, i8*, i8, i64, i64, i8*, i64, %runtime.Source_Code_Location*, i8*)* @os.heap_allocator_proc to i8*), i8** %3, align 8
  %4 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %2, i32 0, i32 1
  store i8* null, i8** %4, align 8
  %5 = getelementptr inbounds %runtime.Context, %runtime.Context* %0, i32 0, i32 1
  %6 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %5, i32 0, i32 0
  store i8* bitcast (void ({ { i8*, i64 }, i8 }*, i8*, i8, i64, i64, i8*, i64, %runtime.Source_Code_Location*, i8*)* @runtime.default_temp_allocator_proc to i8*), i8** %6, align 8
  %7 = getelementptr inbounds %runtime.Allocator, %runtime.Allocator* %5, i32 0, i32 1
  store i8* bitcast (%runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data to i8*), i8** %7, align 8
  %8 = getelementptr inbounds %runtime.Context, %runtime.Context* %0, i32 0, i32 2
  store i8* bitcast (void (%..string, %..string, %runtime.Source_Code_Location*, i8*)* @runtime.default_assertion_failure_proc to i8*), i8** %8, align 8
  %9 = getelementptr inbounds %runtime.Context, %runtime.Context* %0, i32 0, i32 3
  %10 = getelementptr inbounds %runtime.Logger, %runtime.Logger* %9, i32 0, i32 0
  store i8* bitcast (void (i8*, i64, %..string, i16, %runtime.Source_Code_Location*, i8*)* @runtime.default_logger_proc to i8*), i8** %10, align 8
  %11 = getelementptr inbounds %runtime.Logger, %runtime.Logger* %9, i32 0, i32 1
  store i8* null, i8** %11, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %decls, %if.done
  ret void
}

; Function Attrs: noreturn
define internal void @runtime.default_assertion_failure_proc(%..string %0, %..string %1, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %2, i8* noalias nocapture nonnull %__.context_ptr) #2 {
decls:
  call fastcc void @runtime.print_caller_location(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %2)
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([2 x i8], [2 x i8]* @"csbs$8", i64 0, i64 0), i64 1 })
  call fastcc void @runtime.print_string(%..string %0)
  %3 = extractvalue %..string %1, 1
  %4 = icmp sgt i64 %3, 0
  br i1 %4, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  call fastcc void @runtime.print_string(%..string { i8* getelementptr inbounds ([3 x i8], [3 x i8]* @"csbs$9", i64 0, i64 0), i64 2 })
  call fastcc void @runtime.print_string(%..string %1)
  br label %if.done

if.done:                                          ; preds = %if.then, %decls
  call fastcc void @runtime.print_byte(i8 10)
  call void @llvm.trap()
  unreachable
}

define internal void @os.heap_allocator_proc({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, i8* %0, i8 %1, i64 %2, i64 %3, i8* %4, i64 %5, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %6, i8* noalias nocapture nonnull %__.context_ptr) {
decls:
  %7 = alloca { { i8*, i64 }, i8 }, align 8
  %8 = alloca { { i8*, i64 }, i8 }, align 8
  %9 = alloca { { i8*, i64 }, i8 }, align 8
  switch i8 %1, label %switch.done [
    i8 0, label %switch.case.body
    i8 6, label %switch.case.body
    i8 1, label %switch.case.body1
    i8 2, label %switch.case.body2
    i8 3, label %switch.case.body3
    i8 4, label %switch.case.body4
    i8 5, label %switch.case.body7
  ]

switch.case.body:                                 ; preds = %decls, %decls
  %10 = icmp eq i8 %1, 0
  %11 = bitcast { { i8*, i64 }, i8 }* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 24, i1 false)
  call fastcc void @os.heap_allocator_proc.aligned_alloc-0({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %7, i64 %2, i64 %3, i8* null, i1 zeroext %10)
  %12 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 0
  %13 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %7, i32 0, i32 1
  %14 = load i8, i8* %13, align 1
  %15 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %16 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %17 = bitcast { i8*, i64 }* %15 to i8*
  %18 = bitcast { i8*, i64 }* %12 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %17, i8* align 8 %18, i64 16, i1 false)
  store i8 %14, i8* %16, align 1
  br label %UnifiedReturnBlock

switch.case.body1:                                ; preds = %decls
  call fastcc void @os.heap_allocator_proc.aligned_free-1(i8* %4)
  br label %switch.done

switch.case.body2:                                ; preds = %decls
  %19 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %20 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %21 = bitcast { i8*, i64 }* %19 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %21, i8 0, i64 16, i1 false)
  store i8 4, i8* %20, align 1
  br label %UnifiedReturnBlock

switch.case.body3:                                ; preds = %decls
  %22 = icmp eq i8* %4, null
  br i1 %22, label %if.then, label %if.done

if.then:                                          ; preds = %switch.case.body3
  %23 = bitcast { { i8*, i64 }, i8 }* %8 to i8*
  call void @llvm.memset.p0i8.i64(i8* %23, i8 0, i64 24, i1 false)
  call fastcc void @os.heap_allocator_proc.aligned_alloc-0({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %8, i64 %2, i64 %3, i8* null, i1 zeroext true)
  %24 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 0
  %25 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 1
  %26 = load i8, i8* %25, align 1
  %27 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %28 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %29 = bitcast { i8*, i64 }* %27 to i8*
  %30 = bitcast { i8*, i64 }* %24 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %29, i8* align 8 %30, i64 16, i1 false)
  store i8 %26, i8* %28, align 1
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %switch.case.body3
  %31 = bitcast { { i8*, i64 }, i8 }* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %31, i8 0, i64 24, i1 false)
  call fastcc void @os.heap_allocator_proc.aligned_resize-2({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %9, i8* %4, i64 %5, i64 %2, i64 %3)
  %32 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 0
  %33 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %9, i32 0, i32 1
  %34 = load i8, i8* %33, align 1
  %35 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %36 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %37 = bitcast { i8*, i64 }* %35 to i8*
  %38 = bitcast { i8*, i64 }* %32 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %37, i8* align 8 %38, i64 16, i1 false)
  store i8 %34, i8* %36, align 1
  br label %UnifiedReturnBlock

switch.case.body4:                                ; preds = %decls
  %39 = icmp ne i8* %4, null
  br i1 %39, label %if.then5, label %if.done6

if.then5:                                         ; preds = %switch.case.body4
  store i8 91, i8* %4, align 1
  br label %if.done6

if.done6:                                         ; preds = %if.then5, %switch.case.body4
  %40 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %41 = bitcast { i8*, i64 }* %40 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %41, i8 0, i64 17, i1 false)
  br label %UnifiedReturnBlock

switch.case.body7:                                ; preds = %decls
  %42 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %43 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %44 = bitcast { i8*, i64 }* %42 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %44, i8 0, i64 16, i1 false)
  store i8 4, i8* %43, align 1
  br label %UnifiedReturnBlock

switch.done:                                      ; preds = %switch.case.body1, %decls
  %45 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %46 = bitcast { i8*, i64 }* %45 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %46, i8 0, i64 17, i1 false)
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %switch.done, %switch.case.body7, %if.done6, %if.done, %if.then, %switch.case.body2, %switch.case.body
  ret void
}

; Function Attrs: nounwind
define internal fastcc { i64, i64 } @os.heap_allocator() unnamed_addr #0 {
decls:
  %0 = alloca { i64, i64 }, align 8
  %1 = bitcast { i64, i64 }* %0 to %runtime.Allocator*
  store %runtime.Allocator { i8* bitcast (void ({ { i8*, i64 }, i8 }*, i8*, i8, i64, i64, i8*, i64, %runtime.Source_Code_Location*, i8*)* @os.heap_allocator_proc to i8*), i8* null }, %runtime.Allocator* %1, align 8
  %2 = load { i64, i64 }, { i64, i64 }* %0, align 8
  ret { i64, i64 } %2
}

; Function Attrs: nounwind
define dllexport i64 @bar(i64* %0, i64 %1, i8* noalias nocapture nonnull %__.context_ptr) local_unnamed_addr #0 {
decls:
  %2 = alloca i64, align 8
  store i64 0, i64* %2, align 8
  call fastcc void @mdspan.reduce_add_helper_trailing-13906(i64* %0, i64* %2, i64 %1)
  %3 = load i64, i64* %2, align 8
  ret i64 %3
}

; Function Attrs: nounwind
define internal fastcc void @mdspan.main() unnamed_addr #0 {
decls:
  ret void
}

; Function Attrs: nounwind
define internal fastcc void @mem.zero(i8* %0, i64 %1) unnamed_addr #0 {
decls:
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 %1, i1 false)
  ret void
}

; Function Attrs: nounwind
define dso_local i16 @__truncsfhf2(float %0) local_unnamed_addr #0 {
decls:
  %1 = alloca { i32 }, align 4
  %2 = alloca i64, align 8
  %3 = bitcast { i32 }* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 4, i1 false)
  %4 = bitcast { i32 }* %1 to float*
  store float %0, float* %4, align 4
  %5 = bitcast { i32 }* %1 to i32*
  %6 = load i32, i32* %5, align 4
  %7 = ashr i32 %6, 16
  %8 = and i32 %7, 32768
  %9 = ashr i32 %6, 23
  %10 = and i32 %9, 255
  %11 = sub i32 %10, 112
  %12 = and i32 %6, 8388607
  %13 = icmp sle i32 %11, 0
  br i1 %13, label %if.then, label %if.else

if.then:                                          ; preds = %decls
  %14 = icmp slt i32 %11, -10
  br i1 %14, label %if.then1, label %if.done

if.then1:                                         ; preds = %if.then
  %15 = trunc i32 %8 to i16
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %if.then
  %16 = or i32 %12, 8388608
  %17 = sub i32 1, %11
  %18 = ashr i32 %16, %17
  %19 = select i1 true, i32 %18, i32 0
  %20 = and i32 %19, 4096
  %21 = icmp ne i32 %20, 0
  %22 = add i32 %19, 8192
  %spec.select = select i1 %21, i32 %22, i32 %19
  %23 = ashr i32 %spec.select, 13
  %24 = or i32 %8, %23
  %25 = trunc i32 %24 to i16
  br label %UnifiedReturnBlock

if.else:                                          ; preds = %decls
  %26 = icmp eq i32 %11, 143
  br i1 %26, label %if.then4, label %if.else8

if.then4:                                         ; preds = %if.else
  %27 = icmp eq i32 %12, 0
  br i1 %27, label %if.then5, label %if.else6

if.then5:                                         ; preds = %if.then4
  %28 = or i32 %8, 31744
  %29 = trunc i32 %28 to i16
  br label %UnifiedReturnBlock

if.else6:                                         ; preds = %if.then4
  %30 = ashr i32 %12, 13
  %31 = or i32 %8, 31744
  %32 = or i32 %31, %30
  %33 = icmp eq i32 %30, 0
  %34 = zext i1 %33 to i32
  %35 = or i32 %32, %34
  %36 = trunc i32 %35 to i16
  br label %UnifiedReturnBlock

if.else8:                                         ; preds = %if.else
  %37 = and i32 %12, 4096
  %38 = icmp ne i32 %37, 0
  br i1 %38, label %if.then9, label %if.done12

if.then9:                                         ; preds = %if.else8
  %39 = add i32 %12, 8192
  %40 = and i32 %39, 8388608
  %41 = icmp ne i32 %40, 0
  %42 = add i32 %11, 1
  %spec.select20 = select i1 %41, i32 %42, i32 %11
  %spec.select21 = select i1 %41, i32 0, i32 %39
  br label %if.done12

if.done12:                                        ; preds = %if.then9, %if.else8
  %.119 = phi i32 [ %spec.select20, %if.then9 ], [ %11, %if.else8 ]
  %.2 = phi i32 [ %spec.select21, %if.then9 ], [ %12, %if.else8 ]
  %43 = icmp sgt i32 %.119, 30
  br i1 %43, label %if.then13, label %if.done14

if.then13:                                        ; preds = %if.done12
  store i64 1000000000000, i64* %2, align 8
  br label %for.loop

for.loop:                                         ; preds = %for.body, %if.then13
  %.0 = phi i64 [ 0, %if.then13 ], [ %47, %for.body ]
  %44 = icmp slt i64 %.0, 10
  br i1 %44, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %45 = load volatile i64, i64* %2, align 8
  %46 = mul i64 %45, %45
  store volatile i64 %46, i64* %2, align 8
  %47 = add i64 %.0, 1
  br label %for.loop

for.done:                                         ; preds = %for.loop
  %48 = or i32 %8, 31744
  %49 = trunc i32 %48 to i16
  br label %UnifiedReturnBlock

if.done14:                                        ; preds = %if.done12
  %50 = shl i32 %.119, 10
  %51 = or i32 %8, %50
  %52 = ashr i32 %.2, 13
  %53 = or i32 %51, %52
  %54 = trunc i32 %53 to i16
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done14, %for.done, %if.else6, %if.then5, %if.done, %if.then1
  %UnifiedRetVal = phi i16 [ %15, %if.then1 ], [ %25, %if.done ], [ %29, %if.then5 ], [ %36, %if.else6 ], [ %49, %for.done ], [ %54, %if.done14 ]
  ret i16 %UnifiedRetVal
}

; Function Attrs: nounwind
define dso_local i16 @__truncdfhf2(double %0) local_unnamed_addr #0 {
decls:
  %1 = fptrunc double %0 to float
  %2 = call i16 @__truncsfhf2(float %1)
  ret i16 %2
}

; Function Attrs: nounwind
define dso_local float @__gnu_h2f_ieee(i16 %0) local_unnamed_addr #0 {
decls:
  %1 = alloca %__gnu_h2f_ieee.fp32-1, align 4
  %2 = alloca %__gnu_h2f_ieee.fp32-1, align 4
  %3 = alloca %__gnu_h2f_ieee.fp32-1, align 4
  %4 = bitcast %__gnu_h2f_ieee.fp32-1* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 4, i1 false)
  %5 = bitcast %__gnu_h2f_ieee.fp32-1* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 4, i1 false)
  %6 = bitcast %__gnu_h2f_ieee.fp32-1* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 4, i1 false)
  %7 = bitcast %__gnu_h2f_ieee.fp32-1* %2 to i32*
  store i32 2004877312, i32* %7, align 4
  %8 = bitcast %__gnu_h2f_ieee.fp32-1* %3 to i32*
  store i32 1199570944, i32* %8, align 4
  %9 = bitcast %__gnu_h2f_ieee.fp32-1* %1 to i32*
  %10 = and i16 %0, 32767
  %11 = zext i16 %10 to i32
  %12 = shl i32 %11, 13
  store i32 %12, i32* %9, align 4
  %13 = bitcast %__gnu_h2f_ieee.fp32-1* %1 to float*
  %14 = bitcast %__gnu_h2f_ieee.fp32-1* %2 to float*
  %15 = load float, float* %14, align 4
  %16 = load float, float* %13, align 4
  %17 = fmul float %16, %15
  store float %17, float* %13, align 4
  %18 = bitcast %__gnu_h2f_ieee.fp32-1* %3 to float*
  %19 = load float, float* %18, align 4
  %20 = fcmp oge float %17, %19
  br i1 %20, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %21 = load i32, i32* %9, align 4
  %22 = or i32 %21, 2139095040
  store i32 %22, i32* %9, align 4
  br label %if.done

if.done:                                          ; preds = %if.then, %decls
  %23 = and i16 %0, -32768
  %24 = zext i16 %23 to i32
  %25 = shl i32 %24, 16
  %26 = load i32, i32* %9, align 4
  %27 = or i32 %26, %25
  store i32 %27, i32* %9, align 4
  %28 = load float, float* %13, align 4
  ret float %28
}

; Function Attrs: nounwind
define dso_local i16 @__gnu_f2h_ieee(float %0) local_unnamed_addr #0 {
decls:
  %1 = call i16 @__truncsfhf2(float %0)
  ret i16 %1
}

; Function Attrs: nounwind
define dso_local float @__extendhfsf2(i16 %0) local_unnamed_addr #0 {
decls:
  %1 = call float @__gnu_h2f_ieee(i16 %0)
  ret float %1
}

; Function Attrs: nounwind
define dso_local double @__floattidf(i128 %0) local_unnamed_addr #0 {
decls:
  %1 = alloca [2 x i32], align 4
  %2 = icmp eq i128 %0, 0
  br i1 %2, label %UnifiedReturnBlock, label %if.done

if.done:                                          ; preds = %decls
  %3 = ashr i128 %0, 127
  %4 = xor i128 %0, %3
  %5 = sub i128 %4, %3
  %6 = call i128 @llvm.ctlz.i128(i128 %5, i1 false)
  %7 = sub i128 128, %6
  %8 = sub i128 %7, 1
  %9 = trunc i128 %8 to i32
  %10 = icmp sgt i128 %7, 53
  br i1 %10, label %if.then1, label %if.else

if.then1:                                         ; preds = %if.done
  switch i128 %7, label %switch.default.body [
    i128 54, label %switch.case.body
    i128 55, label %switch.done
  ]

switch.case.body:                                 ; preds = %if.then1
  %11 = shl i128 %5, 1
  br label %switch.done

switch.default.body:                              ; preds = %if.then1
  %12 = sub i128 %7, 55
  %13 = icmp ult i128 %12, 128
  %14 = lshr i128 %5, %12
  %15 = select i1 %13, i128 %14, i128 0
  %16 = sub i128 183, %7
  %17 = icmp ult i128 %16, 128
  %18 = lshr i128 -1, %16
  %19 = select i1 %17, i128 %18, i128 0
  %20 = and i128 %5, %19
  %21 = icmp ne i128 %20, 0
  %22 = zext i1 %21 to i128
  %23 = or i128 %15, %22
  br label %switch.done

switch.done:                                      ; preds = %if.then1, %switch.default.body, %switch.case.body
  %.06 = phi i128 [ %23, %switch.default.body ], [ %11, %switch.case.body ], [ %5, %if.then1 ]
  %24 = and i128 %.06, 4
  %25 = icmp ne i128 %24, 0
  %26 = zext i1 %25 to i128
  %27 = or i128 %.06, %26
  %28 = add i128 %27, 1
  %29 = ashr i128 %28, 2
  %30 = and i128 %29, 9007199254740992
  %31 = icmp ne i128 %30, 0
  %32 = ashr i128 %29, 1
  %33 = add i32 %9, 1
  %.17 = select i1 %31, i128 %32, i128 %29
  %.0 = select i1 %31, i32 %33, i32 %9
  br label %if.done5

if.else:                                          ; preds = %if.done
  %34 = sub i128 53, %7
  %35 = and i128 %34, 127
  %36 = shl i128 %5, %35
  br label %if.done5

if.done5:                                         ; preds = %if.else, %switch.done
  %.2 = phi i128 [ %.17, %switch.done ], [ %36, %if.else ]
  %.1 = phi i32 [ %.0, %switch.done ], [ %9, %if.else ]
  %37 = bitcast [2 x i32]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %37, i8 0, i64 8, i1 false)
  %38 = getelementptr [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %39 = trunc i128 %3 to i32
  %40 = and i32 %39, -2147483648
  %41 = add i32 %.1, 1023
  %42 = shl i32 %41, 20
  %43 = or i32 %40, %42
  %44 = trunc i128 %.2 to i64
  %45 = lshr i64 %44, 32
  %46 = and i64 %45, 1048575
  %47 = trunc i64 %46 to i32
  %48 = or i32 %43, %47
  store i32 %48, i32* %38, align 4
  %49 = getelementptr [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %50 = trunc i128 %.2 to i32
  store i32 %50, i32* %49, align 4
  %51 = bitcast [2 x i32]* %1 to double*
  %52 = load double, double* %51, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %decls, %if.done5
  %UnifiedRetVal = phi double [ %52, %if.done5 ], [ 0.000000e+00, %decls ]
  ret double %UnifiedRetVal
}

; Function Attrs: nounwind
define dso_local double @__floattidf_unsigned(i128 %0) local_unnamed_addr #0 {
decls:
  %1 = alloca [2 x i32], align 4
  %2 = icmp eq i128 %0, 0
  br i1 %2, label %UnifiedReturnBlock, label %if.done

if.done:                                          ; preds = %decls
  %3 = call i128 @llvm.ctlz.i128(i128 %0, i1 false)
  %4 = sub i128 128, %3
  %5 = sub i128 %4, 1
  %6 = trunc i128 %5 to i32
  %7 = icmp ugt i128 %4, 53
  br i1 %7, label %if.then1, label %if.else

if.then1:                                         ; preds = %if.done
  switch i128 %4, label %switch.default.body [
    i128 54, label %switch.case.body
    i128 55, label %switch.done
  ]

switch.case.body:                                 ; preds = %if.then1
  %8 = shl i128 %0, 1
  br label %switch.done

switch.default.body:                              ; preds = %if.then1
  %9 = sub i128 %4, 55
  %10 = icmp ult i128 %9, 128
  %11 = lshr i128 %0, %9
  %12 = select i1 %10, i128 %11, i128 0
  %13 = sub i128 183, %4
  %14 = icmp ult i128 %13, 128
  %15 = lshr i128 -1, %13
  %16 = select i1 %14, i128 %15, i128 0
  %17 = and i128 %0, %16
  %18 = icmp ne i128 %17, 0
  %19 = zext i1 %18 to i128
  %20 = or i128 %12, %19
  br label %switch.done

switch.done:                                      ; preds = %if.then1, %switch.default.body, %switch.case.body
  %.06 = phi i128 [ %20, %switch.default.body ], [ %8, %switch.case.body ], [ %0, %if.then1 ]
  %21 = and i128 %.06, 4
  %22 = icmp ne i128 %21, 0
  %23 = zext i1 %22 to i128
  %24 = or i128 %.06, %23
  %25 = add i128 %24, 1
  %26 = lshr i128 %25, 2
  %27 = and i128 %26, 9007199254740992
  %28 = icmp ne i128 %27, 0
  %29 = lshr i128 %26, 1
  %30 = add i32 %6, 1
  %.17 = select i1 %28, i128 %29, i128 %26
  %.0 = select i1 %28, i32 %30, i32 %6
  br label %if.done5

if.else:                                          ; preds = %if.done
  %31 = sub i128 53, %4
  %32 = shl i128 %0, %31
  %33 = select i1 true, i128 %32, i128 0
  br label %if.done5

if.done5:                                         ; preds = %if.else, %switch.done
  %.2 = phi i128 [ %.17, %switch.done ], [ %33, %if.else ]
  %.1 = phi i32 [ %.0, %switch.done ], [ %6, %if.else ]
  %34 = bitcast [2 x i32]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %34, i8 0, i64 8, i1 false)
  %35 = getelementptr [2 x i32], [2 x i32]* %1, i64 0, i64 1
  %36 = add i32 %.1, 1023
  %37 = shl i32 %36, 20
  %38 = trunc i128 %.2 to i64
  %39 = lshr i64 %38, 32
  %40 = and i64 %39, 1048575
  %41 = trunc i64 %40 to i32
  %42 = or i32 %37, %41
  store i32 %42, i32* %35, align 4
  %43 = getelementptr [2 x i32], [2 x i32]* %1, i64 0, i64 0
  %44 = trunc i128 %.2 to i32
  store i32 %44, i32* %43, align 4
  %45 = bitcast [2 x i32]* %1 to double*
  %46 = load double, double* %45, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %decls, %if.done5
  %UnifiedRetVal = phi double [ %46, %if.done5 ], [ 0.000000e+00, %decls ]
  ret double %UnifiedRetVal
}

; Function Attrs: noinline nounwind
define dso_local i128 @__fixunsdfti(double %0) local_unnamed_addr #3 {
decls:
  %1 = fptoui double %0 to i64
  %2 = zext i64 %1 to i128
  ret i128 %2
}

; Function Attrs: noinline nounwind
define dso_local i128 @__fixunsdfdi(double %0) local_unnamed_addr #3 {
decls:
  %1 = fptosi double %0 to i64
  %2 = sext i64 %1 to i128
  ret i128 %2
}

; Function Attrs: nounwind
define dso_local i128 @__umodti3(i128 %0, i128 %1) local_unnamed_addr #0 {
decls:
  %2 = alloca i128, align 8
  store i128 undef, i128* %2, align 8
  %3 = call fastcc i128 @runtime.udivmod128(i128 %0, i128 %1, i128* %2)
  %4 = load i128, i128* %2, align 8
  ret i128 %4
}

; Function Attrs: nounwind
define dso_local i128 @__udivmodti4(i128 %0, i128 %1, i128* %2) local_unnamed_addr #0 {
decls:
  %3 = call fastcc i128 @runtime.udivmod128(i128 %0, i128 %1, i128* %2)
  ret i128 %3
}

; Function Attrs: nounwind
define dso_local i128 @__udivti3(i128 %0, i128 %1) local_unnamed_addr #0 {
decls:
  %2 = call i128 @__udivmodti4(i128 %0, i128 %1, i128* null)
  ret i128 %2
}

; Function Attrs: nounwind
define dso_local i128 @__modti3(i128 %0, i128 %1) local_unnamed_addr #0 {
decls:
  %2 = alloca i128, align 8
  %3 = ashr i128 %0, 127
  %4 = ashr i128 %1, 127
  %5 = xor i128 %0, %3
  %6 = sub i128 %5, %3
  %7 = xor i128 %1, %4
  %8 = sub i128 %7, %4
  store i128 undef, i128* %2, align 8
  %9 = call fastcc i128 @runtime.udivmod128(i128 %6, i128 %8, i128* %2)
  %10 = load i128, i128* %2, align 8
  %11 = xor i128 %10, %3
  %12 = sub i128 %11, %3
  ret i128 %12
}

; Function Attrs: nounwind
define dso_local i128 @__divmodti4(i128 %0, i128 %1, i128* %2) local_unnamed_addr #0 {
decls:
  %3 = call fastcc i128 @runtime.udivmod128(i128 %0, i128 %1, i128* %2)
  ret i128 %3
}

; Function Attrs: nounwind
define dso_local i128 @__divti3(i128 %0, i128 %1) local_unnamed_addr #0 {
decls:
  %2 = call i128 @__udivmodti4(i128 %0, i128 %1, i128* null)
  ret i128 %2
}

; Function Attrs: nounwind
define dso_local i128 @__fixdfti(i64 %0, i8* noalias nocapture nonnull %__.context_ptr) local_unnamed_addr #0 {
decls:
  %1 = and i64 %0, 9223372036854775807
  %2 = and i64 %0, -9223372036854775808
  %3 = icmp ne i64 %2, 0
  %4 = select i1 %3, i128 -1, i128 1
  %5 = lshr i64 %1, 52
  %6 = sub i64 %5, 1023
  %7 = and i64 %1, 4503599627370495
  %8 = or i64 %7, 4503599627370496
  %9 = icmp uge i64 %6, 128
  br i1 %9, label %if.then3, label %if.done7

if.then3:                                         ; preds = %decls
  %10 = icmp eq i128 %4, 1
  %. = select i1 %10, i128 170141183460469231731687303715884105727, i128 -170141183460469231731687303715884105728
  br label %UnifiedReturnBlock

if.done7:                                         ; preds = %decls
  %11 = icmp ult i64 %6, 52
  br i1 %11, label %if.then8, label %if.else9

if.then8:                                         ; preds = %if.done7
  %12 = sub i64 52, %6
  %13 = lshr i64 %8, %12
  %14 = select i1 true, i64 %13, i64 0
  %15 = zext i64 %14 to i128
  %16 = mul i128 %4, %15
  br label %UnifiedReturnBlock

if.else9:                                         ; preds = %if.done7
  %17 = zext i64 %8 to i128
  %18 = sub i64 %6, 52
  %19 = zext i64 %18 to i128
  %20 = shl i128 %17, %19
  %21 = select i1 true, i128 %20, i128 0
  %22 = mul i128 %4, %21
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.else9, %if.then8, %if.then3
  %UnifiedRetVal = phi i128 [ %., %if.then3 ], [ %16, %if.then8 ], [ %22, %if.else9 ]
  ret i128 %UnifiedRetVal
}

define internal fastcc void @runtime.assert(i1 zeroext %0, %..string %1, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %2, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  br i1 %0, label %if.done, label %if.then

if.then:                                          ; preds = %decls
  call fastcc void @runtime.assert.internal-0(%..string %1, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %2, i8* %__.context_ptr)
  unreachable

if.done:                                          ; preds = %decls
  ret void
}

define internal fastcc i64 @unix.sys_write(i8* %0, i64 %1) unnamed_addr {
decls:
  %2 = ptrtoint i8* %0 to i64
  %3 = call i64 asm sideeffect "syscall", "={rax},{rax},{rdi},{rsi},{rdx},~{rcx},~{r11},~{memory}"(i64 1, i64 2, i64 %2, i64 %1)
  ret i64 %3
}

declare i8* @malloc(i64) local_unnamed_addr

declare i8* @calloc(i64, i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

declare i8* @realloc(i8*, i64) local_unnamed_addr

; Function Attrs: nounwind
define internal fastcc i32 @os._get_errno-2026(i64 %0) unnamed_addr #0 {
decls:
  %1 = icmp sgt i64 %0, -4096
  %2 = sub i64 0, %0
  %3 = trunc i64 %2 to i32
  %UnifiedRetVal = select i1 %1, i32 %3, i32 0
  ret i32 %UnifiedRetVal
}

define internal fastcc { i64, i64 } @os.write({ i8*, i64 } %0) unnamed_addr {
decls:
  %1 = alloca { i64, i32 }, align 8
  %2 = alloca { i64, i32 }, align 8
  %3 = alloca { i64, i32 }, align 8
  %4 = extractvalue { i8*, i64 } %0, 1
  %5 = icmp eq i64 %4, 0
  br i1 %5, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %6 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %1, i32 0, i32 0
  %7 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %1, i32 0, i32 1
  store i64 0, i64* %6, align 8
  store i32 0, i32* %7, align 4
  %8 = bitcast { i64, i32 }* %1 to { i64, i64 }*
  %9 = load { i64, i64 }, { i64, i64 }* %8, align 8
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %decls
  %10 = extractvalue { i8*, i64 } %0, 0
  %11 = call fastcc i64 @unix.sys_write(i8* %10, i64 %4)
  %12 = icmp slt i64 %11, 0
  br i1 %12, label %if.then1, label %if.done2

if.then1:                                         ; preds = %if.done
  %13 = call fastcc i32 @os._get_errno-2026(i64 %11)
  %14 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %2, i32 0, i32 0
  %15 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %2, i32 0, i32 1
  store i64 -1, i64* %14, align 8
  store i32 %13, i32* %15, align 4
  %16 = bitcast { i64, i32 }* %2 to { i64, i64 }*
  %17 = load { i64, i64 }, { i64, i64 }* %16, align 8
  br label %UnifiedReturnBlock

if.done2:                                         ; preds = %if.done
  %18 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 0
  %19 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 1
  store i64 %11, i64* %18, align 8
  store i32 0, i32* %19, align 4
  %20 = bitcast { i64, i32 }* %3 to { i64, i64 }*
  %21 = load { i64, i64 }, { i64, i64 }* %20, align 8
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done2, %if.then1, %if.then
  %UnifiedRetVal = phi { i64, i64 } [ %9, %if.then ], [ %17, %if.then1 ], [ %21, %if.done2 ]
  ret { i64, i64 } %UnifiedRetVal
}

define internal fastcc i8* @os.heap_alloc(i64 %0, i1 zeroext %1) unnamed_addr {
decls:
  %2 = icmp sle i64 %0, 0
  br i1 %2, label %UnifiedReturnBlock, label %if.done

if.done:                                          ; preds = %decls
  br i1 %1, label %if.then1, label %if.else

if.then1:                                         ; preds = %if.done
  %3 = call i8* @calloc(i64 1, i64 %0)
  br label %UnifiedReturnBlock

if.else:                                          ; preds = %if.done
  %4 = call i8* @malloc(i64 %0)
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %decls, %if.else, %if.then1
  %UnifiedRetVal = phi i8* [ %3, %if.then1 ], [ %4, %if.else ], [ null, %decls ]
  ret i8* %UnifiedRetVal
}

define internal fastcc i8* @os.heap_resize(i8* %0, i64 %1) unnamed_addr {
decls:
  %2 = call i8* @realloc(i8* %0, i64 %1)
  ret i8* %2
}

define internal fastcc void @os.heap_free(i8* %0) unnamed_addr {
decls:
  call void @free(i8* %0)
  ret void
}

; Function Attrs: nounwind
define internal fastcc { i64, i64 } @runtime.default_allocator() unnamed_addr #0 {
decls:
  %0 = alloca %runtime.Allocator, align 8
  %1 = call fastcc { i64, i64 } @os.heap_allocator()
  %2 = bitcast %runtime.Allocator* %0 to { i64, i64 }*
  store { i64, i64 } %1, { i64, i64 }* %2, align 8
  ret { i64, i64 } %1
}

define internal fastcc void @runtime.default_temp_allocator_destroy(i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr {
decls:
  call fastcc void @runtime.arena_destroy(%runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) @"ggv$2", i8* %__.context_ptr)
  call void @llvm.memset.p0i8.i64(i8* bitcast (%runtime.Default_Temp_Allocator* @runtime.global_default_temp_allocator_data to i8*), i8 0, i64 56, i1 false)
  ret void
}

define internal void @runtime.default_temp_allocator_proc({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, i8* %0, i8 %1, i64 %2, i64 %3, i8* %4, i64 %5, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %6, i8* noalias nocapture nonnull %__.context_ptr) {
decls:
  %7 = alloca { i8*, i64 }, align 8
  %8 = alloca { { i8*, i64 }, i8 }, align 8
  %9 = bitcast { i8*, i64 }* %7 to i8*
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 16, i1 false)
  %10 = bitcast i8* %0 to %runtime.Default_Temp_Allocator*
  %11 = getelementptr inbounds %runtime.Default_Temp_Allocator, %runtime.Default_Temp_Allocator* %10, i32 0, i32 0
  %12 = bitcast %runtime.Arena* %11 to i8*
  %13 = bitcast { { i8*, i64 }, i8 }* %8 to i8*
  call void @llvm.memset.p0i8.i64(i8* %13, i8 0, i64 24, i1 false)
  call fastcc void @runtime.arena_allocator_proc({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %8, i8* %12, i8 %1, i64 %2, i64 %3, i8* %4, i64 %5, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %6, i8* %__.context_ptr)
  %14 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 0
  %15 = load { i8*, i64 }, { i8*, i64 }* %14, align 8
  %16 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %8, i32 0, i32 1
  %17 = load i8, i8* %16, align 1
  store { i8*, i64 } %15, { i8*, i64 }* %7, align 8
  %18 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %19 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %15, { i8*, i64 }* %18, align 8
  store i8 %17, i8* %19, align 1
  ret void
}

define dso_local i32 @main(i32 %0, i8** %1) local_unnamed_addr {
decls:
  %2 = alloca { i8**, i64 }, align 8
  %3 = alloca %runtime.Context, align 8
  %4 = alloca %runtime.Context, align 8
  %5 = sext i32 %0 to i64
  call fastcc void @runtime.multi_pointer_slice_expr_error(%..string { i8* getelementptr inbounds ([55 x i8], [55 x i8]* @"csbs$d", i64 0, i64 0), i64 54 }, i32 26, i32 16, i64 %5)
  %6 = getelementptr inbounds { i8**, i64 }, { i8**, i64 }* %2, i32 0, i32 0
  %7 = getelementptr inbounds { i8**, i64 }, { i8**, i64 }* %2, i32 0, i32 1
  store i8** %1, i8*** %6, align 8
  store i64 %5, i64* %7, align 8
  %8 = bitcast { i8**, i64 }* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 bitcast ({ i8**, i64 }* @runtime.args__ to i8*), i8* align 8 %8, i64 16, i1 false)
  %9 = bitcast %runtime.Context* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 96, i1 false)
  call fastcc void @runtime.__init_context-683(%runtime.Context* %3)
  %10 = bitcast %runtime.Context* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 96, i1 false)
  call fastcc void @runtime.default_context(%runtime.Context* sret(%runtime.Context*) %4)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %9, i8* align 8 %10, i64 96, i1 false)
  call void @"__$startup_runtime"(i8* undef) #13
  call fastcc void @mdspan.main()
  call void @"__$cleanup_runtime"(i8* %9) #13
  ret i32 0
}

; Function Attrs: nounwind
define internal fastcc void @mdspan.reduce_add_helper_leading-11592(i64* %0, i64* %1, i64 %2) unnamed_addr #0 {
decls:
  %3 = alloca <8 x i64>, align 64
  %4 = alloca <8 x i64>, align 64
  %5 = alloca <8 x i64>, align 32
  %6 = alloca [8 x i64], align 8
  %7 = alloca <8 x i64>, align 64
  %8 = alloca <8 x i64>, align 32
  %9 = alloca [8 x i64], align 8
  %10 = alloca [8 x i64], align 8
  %11 = alloca <8 x i64>, align 32
  %12 = mul i64 1, %2
  %13 = getelementptr i64, i64* %1, i64 %12
  %14 = icmp sge i64 %2, 8
  br i1 %14, label %if.then, label %for.interval.loop28

if.then:                                          ; preds = %decls
  %15 = srem i64 %2, 8
  %16 = icmp eq i64 %15, 0
  br i1 %16, label %if.then1, label %if.done38

if.then1:                                         ; preds = %if.then
  %17 = sdiv i64 %2, 8
  %18 = ptrtoint i64* %1 to i64
  %19 = urem i64 %18, 64
  %20 = icmp ne i64 %19, 0
  br i1 %20, label %if.then2, label %if.done

if.then2:                                         ; preds = %if.then1
  %21 = udiv i64 %19, 8
  %22 = sub i64 8, %21
  %23 = getelementptr i64, i64* %13, i64 -8
  br label %for.interval.loop

for.interval.loop:                                ; preds = %for.interval.body, %if.then2
  %.056 = phi i64 [ 0, %if.then2 ], [ %28, %for.interval.body ]
  %.055 = phi i64 [ 0, %if.then2 ], [ %27, %for.interval.body ]
  %.049 = phi <8 x i64> [ zeroinitializer, %if.then2 ], [ %26, %for.interval.body ]
  %24 = icmp ult i64 %.055, %21
  br i1 %24, label %for.interval.body, label %for.interval.loop3

for.interval.body:                                ; preds = %for.interval.loop
  %foo = getelementptr i64, i64* %23, i64 %.055
  %25 = load i64, i64* %foo, align 8
  %26 = insertelement <8 x i64> %.049, i64 %25, i64 %.055
  %27 = add i64 %.055, 1
  %28 = add i64 %.056, 1
  br label %for.interval.loop

for.interval.loop3:                               ; preds = %for.interval.loop, %for.interval.body4
  %.057 = phi i64 [ %33, %for.interval.body4 ], [ 0, %for.interval.loop ]
  %.054 = phi i64 [ %34, %for.interval.body4 ], [ 0, %for.interval.loop ]
  %.150 = phi <8 x i64> [ %32, %for.interval.body4 ], [ %.049, %for.interval.loop ]
  %29 = icmp ult i64 %.057, %22
  br i1 %29, label %for.interval.body4, label %for.interval.done7

for.interval.body4:                               ; preds = %for.interval.loop3
  %30 = add i64 %.057, %21
  %foo5 = getelementptr i64, i64* %1, i64 %.057
  %31 = load i64, i64* %foo5, align 8
  %32 = insertelement <8 x i64> %.150, i64 %31, i64 %30
  %33 = add i64 %.057, 1
  %34 = add i64 %.054, 1
  br label %for.interval.loop3

for.interval.done7:                               ; preds = %for.interval.loop3
  %35 = ptrtoint i64* %1 to i64
  %36 = and i64 %35, -64
  %37 = inttoptr i64 %36 to i64*
  %38 = getelementptr i64, i64* %37, i64 %2
  %39 = bitcast i64* %38 to <8 x i64>*
  %40 = ptrtoint i64* %13 to i64
  %41 = and i64 %40, -64
  %42 = inttoptr i64 %41 to i64*
  %43 = bitcast i64* %42 to <8 x i64>*
  br label %for.loop

for.loop:                                         ; preds = %for.body, %for.interval.done7
  %.053 = phi <8 x i64>* [ %39, %for.interval.done7 ], [ %47, %for.body ]
  %.2 = phi <8 x i64> [ %.150, %for.interval.done7 ], [ %46, %for.body ]
  %44 = icmp slt <8 x i64>* %.053, %43
  br i1 %44, label %for.body, label %for.done

for.body:                                         ; preds = %for.loop
  %45 = load <8 x i64>, <8 x i64>* %.053, align 64
  %46 = add <8 x i64> %.2, %45
  %47 = getelementptr <8 x i64>, <8 x i64>* %.053, i64 %17
  br label %for.loop

for.done:                                         ; preds = %for.loop
  store <8 x i64> %.2, <8 x i64>* %8, align 64
  %48 = bitcast [8 x i64]* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %48, i8 0, i64 64, i1 false)
  call void @llvm.experimental.noalias.scope.decl(metadata !9)
  %49 = bitcast <8 x i64>* %3 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* %49)
  %50 = bitcast <8 x i64>* %3 to i8*
  %51 = bitcast <8 x i64>* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %50, i8* align 1 %51, i64 64, i1 false)
  %52 = bitcast <8 x i64>* %3 to [8 x i64]*
  %53 = bitcast [8 x i64]* %9 to i8*
  %54 = bitcast [8 x i64]* %52 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %53, i8* %54, i64 64, i1 false)
  %55 = bitcast <8 x i64>* %3 to i8*
  call void @llvm.lifetime.end.p0i8(i64 64, i8* %55)
  %56 = bitcast [8 x i64]* %10 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %56, i8* align 8 %48, i64 64, i1 false)
  br label %for.interval.loop9

for.interval.loop9:                               ; preds = %for.interval.body10, %for.done
  %.052 = phi i64 [ 0, %for.done ], [ %61, %for.interval.body10 ]
  %.051 = phi i64 [ 0, %for.done ], [ %62, %for.interval.body10 ]
  %57 = icmp ult i64 %.052, %22
  br i1 %57, label %for.interval.body10, label %for.interval.loop14

for.interval.body10:                              ; preds = %for.interval.loop9
  %foo11 = getelementptr i64, i64* %0, i64 %.052
  %58 = add i64 %21, %.052
  %59 = getelementptr [8 x i64], [8 x i64]* %10, i64 0, i64 %58
  %60 = load i64, i64* %59, align 8
  store i64 %60, i64* %foo11, align 8
  %61 = add i64 %.052, 1
  %62 = add i64 %.051, 1
  br label %for.interval.loop9

for.interval.loop14:                              ; preds = %for.interval.loop9, %for.interval.body15
  %.048 = phi i64 [ %68, %for.interval.body15 ], [ 0, %for.interval.loop9 ]
  %.047 = phi i64 [ %69, %for.interval.body15 ], [ 0, %for.interval.loop9 ]
  %63 = icmp ult i64 %.048, %21
  br i1 %63, label %for.interval.body15, label %for.interval.done18

for.interval.body15:                              ; preds = %for.interval.loop14
  %64 = sub i64 %2, %21
  %65 = add i64 %64, %.048
  %foo16 = getelementptr i64, i64* %0, i64 %65
  %66 = getelementptr [8 x i64], [8 x i64]* %10, i64 0, i64 %.048
  %67 = load i64, i64* %66, align 8
  store i64 %67, i64* %foo16, align 8
  %68 = add i64 %.048, 1
  %69 = add i64 %.047, 1
  br label %for.interval.loop14

for.interval.done18:                              ; preds = %for.interval.loop14
  %70 = getelementptr i64, i64* %1, i64 %22
  %71 = getelementptr i64, i64* %0, i64 %22
  br label %if.done

if.done:                                          ; preds = %for.interval.done18, %if.then1
  %.045 = phi i64* [ %71, %for.interval.done18 ], [ %0, %if.then1 ]
  %.042 = phi i64* [ %70, %for.interval.done18 ], [ %1, %if.then1 ]
  %72 = getelementptr i64, i64* %.042, i64 %2
  %73 = bitcast i64* %72 to <8 x i64>*
  %74 = ptrtoint <8 x i64>* %73 to i64
  %75 = and i64 %74, -64
  %76 = inttoptr i64 %75 to <8 x i64>*
  %77 = bitcast i64* %.042 to <8 x i64>*
  %78 = ptrtoint i64* %13 to i64
  %79 = and i64 %78, -64
  %80 = inttoptr i64 %79 to i64*
  %81 = bitcast i64* %80 to <8 x i64>*
  br label %for.loop19

for.loop19:                                       ; preds = %for.done24, %if.done
  %.046 = phi <8 x i64>* [ %77, %if.done ], [ %106, %for.done24 ]
  %.1 = phi i64* [ %.045, %if.done ], [ %107, %for.done24 ]
  %82 = icmp slt <8 x i64>* %.046, %76
  br i1 %82, label %for.loop21, label %if.done38

for.loop21:                                       ; preds = %for.loop19, %for.body22
  %.044 = phi <8 x i64> [ %85, %for.body22 ], [ zeroinitializer, %for.loop19 ]
  %.043 = phi <8 x i64>* [ %86, %for.body22 ], [ %.046, %for.loop19 ]
  %83 = icmp slt <8 x i64>* %.043, %81
  br i1 %83, label %for.body22, label %for.done24

for.body22:                                       ; preds = %for.loop21
  %84 = load <8 x i64>, <8 x i64>* %.043, align 64
  %85 = add <8 x i64> %.044, %84
  %86 = getelementptr <8 x i64>, <8 x i64>* %.043, i64 %17
  br label %for.loop21

for.done24:                                       ; preds = %for.loop21
  store <8 x i64> %.044, <8 x i64>* %11, align 64
  %87 = bitcast <8 x i64>* %7 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* %87)
  %88 = bitcast <8 x i64>* %5 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* %88)
  %89 = bitcast [8 x i64]* %6 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* %89)
  %90 = bitcast <8 x i64>* %7 to i8*
  %91 = bitcast <8 x i64>* %11 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %90, i8* align 1 %91, i64 64, i1 false)
  %92 = bitcast i64* %.1 to [8 x i64]*
  %93 = load <8 x i64>, <8 x i64>* %7, align 64
  store <8 x i64> %93, <8 x i64>* %5, align 64
  %94 = bitcast [8 x i64]* %6 to i8*
  call void @llvm.memset.p0i8.i64(i8* %94, i8 0, i64 64, i1 false)
  call void @llvm.experimental.noalias.scope.decl(metadata !12)
  %95 = bitcast <8 x i64>* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 64, i8* %95)
  %96 = bitcast <8 x i64>* %4 to i8*
  %97 = bitcast <8 x i64>* %5 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 1 %96, i8* align 1 %97, i64 64, i1 false)
  %98 = bitcast <8 x i64>* %4 to [8 x i64]*
  %99 = bitcast [8 x i64]* %6 to i8*
  %100 = bitcast [8 x i64]* %98 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %99, i8* %100, i64 64, i1 false)
  %101 = bitcast <8 x i64>* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 64, i8* %101)
  %102 = bitcast [8 x i64]* %92 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %102, i8* align 8 %94, i64 64, i1 false)
  %103 = bitcast <8 x i64>* %7 to i8*
  call void @llvm.lifetime.end.p0i8(i64 64, i8* %103)
  %104 = bitcast <8 x i64>* %5 to i8*
  call void @llvm.lifetime.end.p0i8(i64 64, i8* %104)
  %105 = bitcast [8 x i64]* %6 to i8*
  call void @llvm.lifetime.end.p0i8(i64 64, i8* %105)
  %106 = getelementptr <8 x i64>, <8 x i64>* %.046, i64 1
  %107 = getelementptr i64, i64* %.1, i64 8
  br label %for.loop19

for.interval.loop28:                              ; preds = %decls, %for.interval.post36
  %.041 = phi i64 [ %117, %for.interval.post36 ], [ 0, %decls ]
  %.040 = phi i64 [ %118, %for.interval.post36 ], [ 0, %decls ]
  %108 = icmp slt i64 %.041, 1
  br i1 %108, label %for.interval.loop30, label %if.done38

for.interval.loop30:                              ; preds = %for.interval.loop28, %for.interval.body31
  %.039 = phi i64 [ %115, %for.interval.body31 ], [ 0, %for.interval.loop28 ]
  %.0 = phi i64 [ %116, %for.interval.body31 ], [ 0, %for.interval.loop28 ]
  %109 = icmp slt i64 %.039, %2
  br i1 %109, label %for.interval.body31, label %for.interval.post36

for.interval.body31:                              ; preds = %for.interval.loop30
  %foo32 = getelementptr i64, i64* %0, i64 %.039
  %110 = mul i64 %.041, %2
  %111 = add i64 %110, %.039
  %foo33 = getelementptr i64, i64* %1, i64 %111
  %112 = load i64, i64* %foo33, align 8
  %113 = load i64, i64* %foo32, align 8
  %114 = add i64 %113, %112
  store i64 %114, i64* %foo32, align 8
  %115 = add i64 %.039, 1
  %116 = add i64 %.0, 1
  br label %for.interval.loop30

for.interval.post36:                              ; preds = %for.interval.loop30
  %117 = add i64 %.041, 1
  %118 = add i64 %.040, 1
  br label %for.interval.loop28

if.done38:                                        ; preds = %for.interval.loop28, %for.loop19, %if.then
  ret void
}

; Function Attrs: nounwind
define internal fastcc void @runtime.copy_slice-11602({ i8*, i64 } %0, { i8*, i64 } %1) unnamed_addr #0 {
decls:
  %2 = extractvalue { i8*, i64 } %0, 1
  %3 = extractvalue { i8*, i64 } %1, 1
  %4 = icmp slt i64 %2, %3
  %5 = select i1 %4, i64 %2, i64 %3
  %6 = icmp sgt i64 0, %5
  %7 = select i1 %6, i64 0, i64 %5
  %8 = icmp sgt i64 %7, 0
  br i1 %8, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %9 = extractvalue { i8*, i64 } %0, 0
  %10 = extractvalue { i8*, i64 } %1, 0
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %9, i8* %10, i64 %7, i1 false)
  br label %if.done

if.done:                                          ; preds = %if.then, %decls
  ret void
}

; Function Attrs: nounwind
define internal fastcc void @mdspan.reduce_add_helper_trailing-13906(i64* %0, i64* %1, i64 %2) unnamed_addr #0 {
decls:
  %3 = getelementptr i64, i64* %0, i64 1
  %4 = icmp sge i64 %2, 16
  br i1 %4, label %for.loop, label %for.loop18

for.loop:                                         ; preds = %decls, %for.post16
  %.030 = phi i64* [ %.2, %for.post16 ], [ %1, %decls ]
  %.029 = phi i64* [ %32, %for.post16 ], [ %0, %decls ]
  %5 = icmp slt i64* %.029, %3
  br i1 %5, label %for.body, label %if.done

for.body:                                         ; preds = %for.loop
  %6 = getelementptr i64, i64* %.030, i64 %2
  br label %for.loop1

for.loop1:                                        ; preds = %for.body2, %for.body
  %.131 = phi i64* [ %.030, %for.body ], [ %13, %for.body2 ]
  %7 = ptrtoint i64* %.131 to i64
  %8 = urem i64 %7, 64
  %9 = icmp ne i64 %8, 0
  br i1 %9, label %for.body2, label %for.done

for.body2:                                        ; preds = %for.loop1
  %10 = load i64, i64* %.131, align 8
  %11 = load i64, i64* %.029, align 8
  %12 = add i64 %11, %10
  store i64 %12, i64* %.029, align 8
  %13 = getelementptr i64, i64* %.131, i64 1
  br label %for.loop1

for.done:                                         ; preds = %for.loop1
  %14 = ptrtoint i64* %6 to i64
  %15 = and i64 %14, -64
  %16 = inttoptr i64 %15 to i64*
  %17 = bitcast i64* %16 to <8 x i64>*
  %18 = bitcast i64* %.131 to <8 x i64>*
  br label %for.loop4

for.loop4:                                        ; preds = %for.body5, %for.done
  %.028 = phi <8 x i64> [ zeroinitializer, %for.done ], [ %21, %for.body5 ]
  %.0 = phi <8 x i64>* [ %18, %for.done ], [ %22, %for.body5 ]
  %19 = icmp slt <8 x i64>* %.0, %17
  br i1 %19, label %for.body5, label %for.done8

for.body5:                                        ; preds = %for.loop4
  %20 = load <8 x i64>, <8 x i64>* %.0, align 64
  %21 = add <8 x i64> %.028, %20
  %22 = getelementptr <8 x i64>, <8 x i64>* %.0, i64 1
  br label %for.loop4

for.done8:                                        ; preds = %for.loop4
  %23 = bitcast <8 x i64>* %.0 to i64*
  %24 = call i64 @llvm.vector.reduce.add.v8i64(<8 x i64> %.028)
  %25 = load i64, i64* %.029, align 8
  %26 = add i64 %25, %24
  store i64 %26, i64* %.029, align 8
  br label %for.loop10

for.loop10:                                       ; preds = %for.body11, %for.done8
  %.2 = phi i64* [ %23, %for.done8 ], [ %31, %for.body11 ]
  %27 = icmp slt i64* %.2, %6
  br i1 %27, label %for.body11, label %for.post16

for.body11:                                       ; preds = %for.loop10
  %28 = load i64, i64* %.2, align 8
  %29 = load i64, i64* %.029, align 8
  %30 = add i64 %29, %28
  store i64 %30, i64* %.029, align 8
  %31 = getelementptr i64, i64* %.2, i64 1
  br label %for.loop10

for.post16:                                       ; preds = %for.loop10
  %32 = getelementptr i64, i64* %.029, i64 1
  br label %for.loop

for.loop18:                                       ; preds = %decls, %for.post26
  %.3 = phi i64* [ %.4, %for.post26 ], [ %1, %decls ]
  %.1 = phi i64* [ %40, %for.post26 ], [ %0, %decls ]
  %33 = icmp slt i64* %.1, %3
  br i1 %33, label %for.body19, label %if.done

for.body19:                                       ; preds = %for.loop18
  %34 = getelementptr i64, i64* %.3, i64 %2
  br label %for.loop20

for.loop20:                                       ; preds = %for.body21, %for.body19
  %.4 = phi i64* [ %.3, %for.body19 ], [ %39, %for.body21 ]
  %35 = icmp slt i64* %.4, %34
  br i1 %35, label %for.body21, label %for.post26

for.body21:                                       ; preds = %for.loop20
  %36 = load i64, i64* %.4, align 8
  %37 = load i64, i64* %.1, align 8
  %38 = add i64 %37, %36
  store i64 %38, i64* %.1, align 8
  %39 = getelementptr i64, i64* %.4, i64 1
  br label %for.loop20

for.post26:                                       ; preds = %for.loop20
  %40 = getelementptr i64, i64* %.1, i64 1
  br label %for.loop18

if.done:                                          ; preds = %for.loop18, %for.loop
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #4

; Function Attrs: argmemonly nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nounwind
define internal fastcc i64 @runtime.alloc_from_memory_block.calc_alignment_offset-0(%runtime.Memory_Block* %0, i64 %1) unnamed_addr #0 {
decls:
  %2 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 3
  %3 = load i64, i64* %2, align 8
  %4 = getelementptr inbounds %runtime.Memory_Block, %runtime.Memory_Block* %0, i32 0, i32 2
  %5 = load i8*, i8** %4, align 8
  %6 = getelementptr i8, i8* %5, i64 %3
  %7 = ptrtoint i8* %6 to i64
  %8 = sub i64 %1, 1
  %9 = and i64 %7, %8
  %10 = icmp ne i64 %9, 0
  %11 = sub i64 %1, %9
  %.0 = select i1 %10, i64 %11, i64 0
  ret i64 %.0
}

; Function Attrs: nounwind
define internal fastcc i64 @runtime.arena_alloc.align_forward_uint-0(i64 %0, i64 %1) unnamed_addr #0 {
decls:
  %2 = sub i64 %1, 1
  %3 = and i64 %0, %2
  %4 = icmp ne i64 %3, 0
  %5 = sub i64 %1, %3
  %6 = add i64 %0, %5
  %.0 = select i1 %4, i64 %6, i64 %0
  ret i64 %.0
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1 immarg) #6

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #7

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.cttz.i64(i64, i1 immarg) #4

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i64 @llvm.ctlz.i64(i64, i1 immarg) #4

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #6

define internal fastcc void @os.heap_allocator_proc.aligned_alloc-0({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, i64 %0, i64 %1, i8* %2, i1 zeroext %3) unnamed_addr {
decls:
  %4 = alloca { i8*, i64 }, align 8
  %5 = icmp sgt i64 %1, 8
  %6 = select i1 %5, i64 %1, i64 8
  %7 = add i64 %0, %6
  %8 = sub i64 %7, 1
  %9 = icmp ne i8* %2, null
  br i1 %9, label %if.then, label %if.else

if.then:                                          ; preds = %decls
  %10 = bitcast i8* %2 to i8**
  %11 = getelementptr i8*, i8** %10, i64 -1
  %12 = load i8*, i8** %11, align 8
  %13 = add i64 %8, 8
  %14 = call fastcc i8* @os.heap_resize(i8* %12, i64 %13)
  br label %if.done

if.else:                                          ; preds = %decls
  %15 = add i64 %8, 8
  %16 = call fastcc i8* @os.heap_alloc(i64 %15, i1 zeroext %3)
  br label %if.done

if.done:                                          ; preds = %if.else, %if.then
  %.0 = phi i8* [ %14, %if.then ], [ %16, %if.else ]
  %17 = getelementptr i8, i8* %.0, i64 8
  %18 = ptrtoint i8* %17 to i64
  %19 = sub i64 %18, 1
  %20 = add i64 %19, %6
  %21 = sub i64 0, %6
  %22 = and i64 %20, %21
  %23 = sub i64 %22, %18
  %24 = add i64 %0, %23
  %25 = icmp sgt i64 %24, %8
  br i1 %25, label %if.then1, label %if.done2

if.then1:                                         ; preds = %if.done
  %26 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %27 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  %28 = bitcast { i8*, i64 }* %26 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %28, i8 0, i64 16, i1 false)
  store i8 1, i8* %27, align 1
  br label %UnifiedReturnBlock

if.done2:                                         ; preds = %if.done
  %29 = inttoptr i64 %22 to i8*
  %30 = bitcast i8* %29 to i8**
  %31 = getelementptr i8*, i8** %30, i64 -1
  store i8* %.0, i8** %31, align 8
  %32 = bitcast { i8*, i64 }* %4 to i8*
  call void @llvm.lifetime.start.p0i8(i64 16, i8* %32)
  %33 = icmp sgt i64 %0, 0
  %34 = select i1 %33, i64 %0, i64 0
  %35 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %4, i32 0, i32 0
  %36 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %4, i32 0, i32 1
  store i8* %29, i8** %35, align 8
  store i64 %34, i64* %36, align 8
  %37 = load { i8*, i64 }, { i8*, i64 }* %4, align 8
  %38 = bitcast { i8*, i64 }* %4 to i8*
  call void @llvm.lifetime.end.p0i8(i64 16, i8* %38)
  %39 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %40 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %37, { i8*, i64 }* %39, align 8
  store i8 0, i8* %40, align 1
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done2, %if.then1
  ret void
}

define internal fastcc void @os.heap_allocator_proc.aligned_free-1(i8* %0) unnamed_addr {
decls:
  %1 = icmp ne i8* %0, null
  br i1 %1, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  %2 = bitcast i8* %0 to i8**
  %3 = getelementptr i8*, i8** %2, i64 -1
  %4 = load i8*, i8** %3, align 8
  call fastcc void @os.heap_free(i8* %4)
  br label %if.done

if.done:                                          ; preds = %if.then, %decls
  ret void
}

define internal fastcc void @os.heap_allocator_proc.aligned_resize-2({ { i8*, i64 }, i8 }* noalias sret({ { i8*, i64 }, i8 }) %agg.result, i8* %0, i64 %1, i64 %2, i64 %3) unnamed_addr {
decls:
  %4 = alloca { i8*, i64 }, align 8
  %5 = alloca { { i8*, i64 }, i8 }, align 8
  %6 = alloca { i8*, i64 }, align 8
  %7 = bitcast { i8*, i64 }* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 16, i1 false)
  %8 = icmp eq i8* %0, null
  br i1 %8, label %if.then, label %if.done

if.then:                                          ; preds = %decls
  call void @llvm.memset.p0i8.i64(i8* align 8 %7, i8 0, i64 16, i1 false)
  %9 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %10 = bitcast { i8*, i64 }* %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %10, i8 0, i64 17, i1 false)
  br label %UnifiedReturnBlock

if.done:                                          ; preds = %decls
  %11 = bitcast { { i8*, i64 }, i8 }* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 24, i1 false)
  call fastcc void @os.heap_allocator_proc.aligned_alloc-0({ { i8*, i64 }, i8 }* sret({ { i8*, i64 }, i8 }*) %5, i64 %2, i64 %3, i8* %0, i1 zeroext true)
  %12 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %5, i32 0, i32 0
  %13 = load { i8*, i64 }, { i8*, i64 }* %12, align 8
  %14 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %5, i32 0, i32 1
  %15 = load i8, i8* %14, align 1
  %16 = icmp eq i8 %15, 0
  br i1 %16, label %or_return.continue, label %or_return.return

or_return.return:                                 ; preds = %if.done
  %17 = load { i8*, i64 }, { i8*, i64 }* %4, align 8
  %18 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %19 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %17, { i8*, i64 }* %18, align 8
  store i8 %15, i8* %19, align 1
  br label %UnifiedReturnBlock

or_return.continue:                               ; preds = %if.done
  store { i8*, i64 } %13, { i8*, i64 }* %4, align 8
  %20 = icmp sgt i64 %2, %1
  br i1 %20, label %if.then1, label %if.done2

if.then1:                                         ; preds = %or_return.continue
  %21 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %4, i32 0, i32 1
  %22 = load i64, i64* %21, align 8
  call fastcc void @runtime.slice_expr_error_lo_hi(i64 %1, i64 %22, i64 %22)
  %23 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %4, i32 0, i32 0
  %24 = load i8*, i8** %23, align 8
  %25 = getelementptr i8, i8* %24, i64 %1
  %26 = sub i64 %22, %1
  %27 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %6, i32 0, i32 0
  store i8* %25, i8** %27, align 8
  %28 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %6, i32 0, i32 1
  store i64 %26, i64* %28, align 8
  %29 = load i8*, i8** %27, align 8
  %30 = sub i64 %2, %1
  call fastcc void @mem.zero(i8* %29, i64 %30)
  br label %if.done2

if.done2:                                         ; preds = %if.then1, %or_return.continue
  %31 = load { i8*, i64 }, { i8*, i64 }* %4, align 8
  %32 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 0
  %33 = getelementptr inbounds { { i8*, i64 }, i8 }, { { i8*, i64 }, i8 }* %agg.result, i32 0, i32 1
  store { i8*, i64 } %31, { i8*, i64 }* %32, align 8
  store i8 0, i8* %33, align 1
  br label %UnifiedReturnBlock

UnifiedReturnBlock:                               ; preds = %if.done2, %or_return.return, %if.then
  ret void
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i128 @llvm.ctlz.i128(i128, i1 immarg) #4

; Function Attrs: cold noreturn
define internal fastcc void @runtime.assert.internal-0(%..string %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) align 8 %1, i8* noalias nocapture nonnull %__.context_ptr) unnamed_addr #8 {
decls:
  %2 = bitcast i8* %__.context_ptr to %runtime.Context*
  %3 = getelementptr inbounds %runtime.Context, %runtime.Context* %2, i32 0, i32 2
  %4 = load i8*, i8** %3, align 8
  %5 = icmp eq i8* %4, null
  %.0 = select i1 %5, i8* bitcast (void (%..string, %..string, %runtime.Source_Code_Location*, i8*)* @runtime.default_assertion_failure_proc to i8*), i8* %4
  %6 = bitcast i8* %.0 to void (%..string, %..string, %runtime.Source_Code_Location*, i8*)*
  call void %6(%..string { i8* getelementptr inbounds ([18 x i8], [18 x i8]* @"csbs$15", i64 0, i64 0), i64 17 }, %..string %0, %runtime.Source_Code_Location* byval(%runtime.Source_Code_Location) %1, i8* %__.context_ptr)
  unreachable
}

; Function Attrs: nofree nosync nounwind readnone willreturn
declare i64 @llvm.vector.reduce.add.v8i64(<8 x i64>) #9

; Function Attrs: inaccessiblememonly nofree nosync nounwind willreturn
declare void @llvm.experimental.noalias.scope.decl(metadata) #10

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #11

; Function Attrs: argmemonly nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #11

attributes #0 = { nounwind }
attributes #1 = { noreturn nounwind }
attributes #2 = { noreturn }
attributes #3 = { noinline nounwind }
attributes #4 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #5 = { argmemonly nofree nounwind willreturn writeonly }
attributes #6 = { argmemonly nofree nounwind willreturn }
attributes #7 = { cold noreturn nounwind }
attributes #8 = { cold noreturn }
attributes #9 = { nofree nosync nounwind readnone willreturn }
attributes #10 = { inaccessiblememonly nofree nosync nounwind willreturn }
attributes #11 = { argmemonly nofree nosync nounwind willreturn }
attributes #12 = { alwaysinline }
attributes #13 = { noinline }

!0 = !{!1}
!1 = distinct !{!1, !2, !"runtime.mem_alloc: %agg.result"}
!2 = distinct !{!2, !"runtime.mem_alloc"}
!3 = !{!4}
!4 = distinct !{!4, !2, !"runtime.mem_alloc: %__.context_ptr"}
!5 = !{!1, !4}
!6 = !{!7}
!7 = distinct !{!7, !8, !"runtime.mem_free: %__.context_ptr"}
!8 = distinct !{!8, !"runtime.mem_free"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"simd.to_array-11699: %agg.result"}
!11 = distinct !{!11, !"simd.to_array-11699"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"simd.to_array-11699: %agg.result"}
!14 = distinct !{!14, !"simd.to_array-11699"}
