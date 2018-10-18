-- 2.2插入排序
function INSERTION_SORT(A)
	if nil == A then
		return nil;
	end
	for j=2,#A do
		local key = A[j];
		local i = j-1;
		while i > 0 and A[i] > key do
			A[i+1] = A[i];
			i = i-1;
		end
		A[i+1]=key;
	end
	return A;
end

-- 测试
-- local A = {2, 1, 4, 3, 5, 6};
-- for i=1,#A do
-- 	print(A[i])
-- end

-- 6.1 堆排序
function PARENT(i)
	return math.floor(i/2);
end

function LEFT(i)
	return 2*i;
end

function RIGHT(i)
	return 2*i+1;
end

function MAX_HEAPIFY(A, i)
	local l = LEFT(i);
	local r = RIGHT(i);
	local largest = i;
	if l <= A.heap_size and A[l] > A[i] then
		largest = l;
	end
	if r <= A.heap_size and A[r] > A[largest] then
		largest = r;
	end
	if largest ~= i then
		A[i], A[largest] = A[largest], A[i];
		MAX_HEAPIFY(A, largest);
	end
end

function BUILD_MAX_HEAP(A)
	A.heap_size = #A;
	for i=(#A/2), 1, -1 do
		MAX_HEAPIFY(A, i);
	end
end

function HEAPSORT(A)
	BUILD_MAX_HEAP(A);
	for i=#A, 2, -1 do
		A[1], A[i] = A[i], A[1];
		A.heap_size = A.heap_size-1;
		MAX_HEAPIFY(A, 1);
	end

	for i=1,#A do
		print(A[i])
	end
end

-- 测试
-- HEAPSORT({4,1,3,2,16,9,10,14,8,7})
-- HEAPSORT({16,14,10,8,7,9,3,2,4,1})

-- 6.5 最大优先级队列
function HEAP_MAXMUM(A)
	return A[1];
end

function HEAP_EXTRACT_MAX(A)
	if A.heap_size < 1 then
		print("error heap underflow");
		return;
	end
	local max = A[1];
	A[1] = A[A.heap_size];
	A.heap_size = A.heap_size-1;
	MAX_HEAPIFY(A, 1);
	return max;
end

function HEAP_INCREASE_KEY(A, i, key)
	if key < A[i] then
		print("error new key is smaller than curren key");
		return;
	end
	A[i] = key;
	while i > 1 and A[PARENT(i)] < A[i] do
		A[i], A[PARENT(i)] = A[PARENT(i)], A[i];
		i = PARENT(i);
	end
end

function MAX_HEAP_INSERT(A, key)
	A.heap_size = A.heap_size or 0;
	A.heap_size = A.heap_size + 1;
	A[A.heap_size] = -math.huge;
	HEAP_INCREASE_KEY(A, A.heap_size, key);
end

-- 最大优先级队列测试
-- A = {};
-- MAX_HEAP_INSERT(A, 16);
-- MAX_HEAP_INSERT(A, 14);
-- MAX_HEAP_INSERT(A, 10);
-- MAX_HEAP_INSERT(A, 8);
-- MAX_HEAP_INSERT(A, 7);
-- MAX_HEAP_INSERT(A, 9);
-- MAX_HEAP_INSERT(A, 3);
-- MAX_HEAP_INSERT(A, 2);
-- MAX_HEAP_INSERT(A, 4);
-- MAX_HEAP_INSERT(A, 1);
-- MAX_HEAP_INSERT(A, 15);
-- 也可以通过BUILD_MAX_HEAP实现

-- for i=1,#A do
-- 	print(A[i])
-- end

-- print(HEAP_MAXMUM(A))
-- HEAP_EXTRACT_MAX(A)
-- HEAP_EXTRACT_MAX(A)
-- print(HEAP_MAXMUM(A))

-- 7.1 快速排序
function QUICKSORT(A, p, r)
	if p < r then
		local q = PARTITION(A, p, r);
		QUICKSORT(A, p, q-1);
		QUICKSORT(A, q+1, r);
	end
end

function PARTITION(A, p, r)
	local x = A[r];
	local i = p-1;
	for j=p, r-1 do
		if A[j] <= x then
			i = i+1;
			A[i], A[j] = A[j], A[i];
		end
	end
	A[i+1], A[r] = A[r], A[i+1];
	return i+1;
end
-- 测试
-- local A = {2,8,7,1,3,5,6,4};
-- QUICKSORT(A, 1, #A);

-- for i=1,#A do
-- 	print(A[i]);
-- end

-- 7.3 快速排序随机化版本
function RANDOMIZED_QUICKSORT(A, p, r)
	if p < r then
		local q = RANDOMIZED_PARTITION(A, p, r);
		RANDOMIZED_QUICKSORT(A, p, q-1);
		RANDOMIZED_QUICKSORT(A, q+1, r);
	end
end

function RANDOMIZED_PARTITION(A, p, r)
	math.randomseed(os.time());
	local i = math.random(p, r);
	A[r], A[i] = A[i], A[r];
	return PARTITION(A, p, r);
end

-- 测试
-- local A = {2,8,7,1,3,5,6,4};
-- RANDOMIZED_QUICKSORT(A, 1, #A);

-- for i=1,#A do
-- 	print(A[i]);
-- end

-- 7_1 Hoare 快速排序
function HOARE_QUICKSORT(A, p, r)
	if p < r then
		local q = HOARE_PARTITION(A, p, r);
		-- 注意这里和普通的快速算法有区别
		HOARE_QUICKSORT(A, p, q);
		HOARE_QUICKSORT(A, q+1, r);
	end
end

function HOARE_PARTITION(A, p, r)
	local x = A[p];
	local i = p-1;
	local j = r+1;
	while true do
		repeat
			j = j-1;
		until A[j] <= x

		repeat
			i = i+1;
		until A[i] >= x

		if i < j then
			A[i], A[j] = A[j], A[i];
		else
			return j;
		end
	end
end

-- 测试
-- local A = {2,8,7,1,3,5,6,4};
-- HOARE_QUICKSORT(A, 1, #A);

-- for i=1,#A do
-- 	print(A[i]);
-- end

-- 7_3 STOOGE快速排序
function STOOGE_SORT(A, i, j)
	if A[i] > A[j] then
		A[i], A[j] = A[j], A[i];
	end
	if i+1 >= j then
		return;
	end
	local  k = math.floor((j-i+1)/3);
	STOOGE_SORT(A, i, j-k);
	STOOGE_SORT(A, i+k, j);
	STOOGE_SORT(A, i, j-k);
end

-- 测试
-- local A = {2,8,7,1,3,5,6,4};
-- STOOGE_SORT(A, 1, #A);
-- for i=1,#A do
-- 	print(A[i]);
-- end

-- 8.2计数排序
function COUNTING_SORT(A, B, k)
	local C = {};
	for i=0,k do
		C[i] = 0;
	end
	for j=1,#A do
		C[A[j]] = C[A[j]]+1;
	end
	for i=1,k do
		C[i] = C[i]+C[i-1];
	end
	for j=#A,1,-1 do
		B[C[A[j]]] = A[j];
		C[A[j]] = C[A[j]]-1;
	end
end

-- 测试
-- local A = {2,5,3,0,2,3,0,3};
-- local B = {};

-- COUNTING_SORT(A, B, #A);
-- for i=1,#B do
-- 	print(B[i]);
-- end

-- 8.4 桶排序
function BUCKET_SORT(A)
	local n = #A;
	local B = {};
	for i=1,n do
		local key = math.floor(A[i]/n);
		if B[key] == nil then
			B[key] = {};
		end
		B[key][#B[key]+1] = A[i];
	end
	for i=0,n-1 do
		B[i] = INSERTION_SORT(B[i]);
	end
	local C = {};
	for i=0,n-1 do
		if B[i] ~= nil then
			for j=1,#B[i] do
				C[#C+1] = B[i][j];
			end
		end
	end 
	return C;
end

-- 测试
-- local A = {78,17,39,26,72,94,21,12,23,68};
-- local B = BUCKET_SORT(A);
-- for i=1,#B do
-- 	print(B[i]);
-- end

-- 9.1 最小值
function MINIMUN(A)
	local min = A[1];
	for i=2,#A do
		if min > A[i] then
			min = A[i];
		end
	end
	return min;
end

-- 测试
-- local A = {78,17,39,26,72,94,21,12,23,68};
-- print(MINIMUN(A));

-- 9.2 随机选择算法(返回数组[p,r]中第i小的元素)
function RANDOMIZED_SELECT(A,p,r,i)
	if p == r then
		return A[p];
	end
	local q = RANDOMIZED_PARTITION(A,p,r);
	local k = q-p+1;
	if i == k then
		return A[q];
	elseif i < k then
		return RANDOMIZED_SELECT(A,p,q-1,i);
	else
		return RANDOMIZED_SELECT(A,q+1,r,i-k);
	end
end

-- 测试
-- local A = {78,17,39,26,72,94,21,12,23,68};
-- print(RANDOMIZED_SELECT(A,1,10,3));

-- 10.1 栈和队列
function STACK_EMPTY(S)
	if S.top == nil or S.top == 0 then
		return true;
	else
		return false;
	end
end

function PUSH(S,x)
	if nil == S.top then
		S.top = 0;
	end
	S.top = S.top+1;
	S[S.top] = x;
end

function POP(S)
	if STACK_EMPTY(S) then 
		return nil;
	else
		S.top = S.top-1;
		return S[S.top+1];
	end
end

function ENQUEUE(Q,x)
	
end