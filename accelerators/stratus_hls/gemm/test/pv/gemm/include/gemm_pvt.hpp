#include "double_matrix_t.h"

void gemm_pvt(
	int l_n,
	float* layer_node,
	float* layer_bias,
	bool relu,
	float*w,
	int wr,
	int wc,
	int ws,
	float* out,
	float* gold);
