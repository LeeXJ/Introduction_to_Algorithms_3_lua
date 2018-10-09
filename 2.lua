-- 插入排序
local A = {2, 1, 4, 3, 5, 6};

for j=2,#A do
	local key = A[j];
	local i = j-1;
	while i > 0 and A[i] > key do
		A[i+1] = A[i];
		i = i-1;
	end
	A[i+1]=key;
end

for i=1,#A do
	print(A[i]);
end