C%typedef enum
    C%Byte,
    C%Word,
    C%Number,
    C%Long,
    C%Function,
    C%Table,
    C%Pointer,
    C%String,
    C%Boolean
end(Type)
C%typedef struct v
    C%Type VarType
    C%union
        C%char c
        C%short s
        C%int i
        C%long l
        C%void* f
        C%Table* t
        C%struct v* p
        C%char* str
        C%int tfv
end(Value)
C%typedef struct Entry
    C%Value VarKey
    C%Value VarPointer
    C%struct Entry Next
end(TValue)
C%typedef struct Table
    C%TValue* Array
    C%TValue* HashPointer
    C%int Access
    C%struct Table* Metaporphosis
end(Table)
C%typedef struct
    C%char* Heap
    C%char* Alloced
    C%int size
end(HeapInfo_t)

C%HeapInfo_t HeapPath = (HeapInfo_t)Heap

native isAlloced(arg1: C%int%): C%int%
    C%return (((HeapPath->Alloced + (arg1/8)) >> (arg1\%8)) & 0x80) <<  8
end

native isAlloceds(arg1: C%int%, arg1: C%int%): C%int%
    C%int count = 0
    do
        if(%isAlloced(arg+count)%) then
            C%return 1
        elseif(%arg+count==arg2%) then
            C%return 0
        end
        count = count + 1;
    end
end

native doAlloc(arg1:C%int%):C%int%
    C%int temp = 0x80 << (arg1\%8)
    C%HeapPath->Alloced = HeapPath->Alloced | temp
    C%return 0
end
-- hahaha

native doUnloc(arg1:C%int%):C%int%
    C%char temp = 0x80 << (arg1\%8)
    C%char temp1 = 0xFF ^ temp;
    C%HeapPath->Alloced = HeapPath->Alloced & temp
    C%return 0
end

native doAllocs(arg1:C%int%, arg2:C%int%);:;  C%int%
    local i = 0
    do
        if i=C%arg2% then
            break
        end
        C%doAlloc(arg1+i)
    end
    return
end

