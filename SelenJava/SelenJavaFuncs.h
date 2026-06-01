typedef enum{
	Byte,
	Word,
	Number,
	Long,
	Function,
	Table,
	Pointer
}Type;
typedef struct{
	char* VarKey;
	Type VarType;
	void* VarPointer;
}Field;
typedef struct{
	void* Array;
	void* ArrayType;
	Field* HashPointer;
	int Access;
}Table;
typedef struct HeapInfo{
	char* Heap;
	char* Alloced;
}HeapInfo_t;

HeapInfo_t* HeapPath = (HeapInfo_t*)Heap;

int isAlloced(int arg1){
	return (((HeapPath->Alloced + (arg1/8)) >> (arg1%8)) & 0x80) << 8;
}

int isAlloceds(int arg1, int arg2){
	count = 0;
	for(;;){
		if(isAlloced(arg1 + count)){
			return 1;
		}
		else if(arg1 + count == arg2){
			return 0;
			/**/
		}
		count++;
	}
}

int doAlloc(int arg1){
	int temp = 0x80 << (arg1%8);
	HeapPath->Alloced = HeapPath->Alloced | temp;
	return 0;
}

int doUnloc(int arg1){
	char temp = 0x80 << (arg1%8);
	char temp1 = 0xFF ^ temp
	HeapPath->Alloced = HeapPath->Alloced & temp1;
	return 0;
}

void* alloc(int arg1){
	int size = arg1 + 8
	int current = 0;
	int count = 0;
	while(1){
		if(current == MAX){
			return NULL;
		}
		if(isAlloced){
			if(isAlloceds(current, size)){
				doAllocs(current, size);
				break;
			}
			else{
				current++;
				break;
			}
		}
	}
	while(1){
		if(current == MAX){
			return NULL;
		}
		if(isAlloced){
			if(isAlloced(current+size)){
				if(count == size){
					doAllocs(current, size);
					break;
				}
				else{
					count++;
					continue;
				}
			}
			else{
				current++;
				count = 0;
				continue;
			}
		}
	}
	(long)(*(HeapPath->Heap + current)) = arg1;
	return HeapPath->Heap + current + 8;
}
