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

-- 7_1 Hoare 全速排序
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