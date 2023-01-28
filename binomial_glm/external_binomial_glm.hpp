#include <stan/model/model_header.hpp>
#include <ostream>
#include "stan/math/prim/fun/exp.hpp"

namespace binomial_glm_model_namespace {
template <typename T0__, stan::require_stan_scalar_t<T0__>* = nullptr>
stan::promote_args_t<T0__>
custom_inv_logit(const T0__& value, std::ostream* pstream__)
{
	stan::math::exp_fun exponent_function;

	if (value > 0) {
		return 1.0 / (1.0 + exponent_function.fun(-value));
	}
	else {
		T0__ e = exponent_function.fun(value);
		return e / (1.0 + e);
	}
}
}
