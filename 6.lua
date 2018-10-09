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