functions {
    real custom_inv_logit(real value);
}

data {
    int<lower=1> N;                     // #obs
    int<lower=1> p;                     // #params
    int<lower=1> n[N];                  // #trials
    int<lower=0> y[N];                  // #successes
    matrix<lower=0, upper=1> [N,p] X;   // X matrix
    real bkprior[2];                    // bk (k>0) prior mean and sd
}

parameters {
    vector[p] b;
}

model {
    vector[N] output;

    output = X * b;
    for (i in 1:N) {
        // [y | beta]
        y[i] ~ binomial(n[i], custom_inv_logit(output[i]));
    }

    // [beta] = [b0] * prod_k [bk] (k>1)
    b[2:11] ~ normal(bkprior[1], bkprior[2]);

    // [b0 flat improper implied]
}
