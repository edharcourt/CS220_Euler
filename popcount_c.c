int popcount_c(unsigned long long x) {
	int sum = 0;
	while (x != 0) {
		sum = sum + (x & 1);
		x = x >> 1;
	}
	return sum;
}
