library(targeted)
library(lava)

print(sessionInfo())

set.seed(42)
sim1 <- function(n=1000, ...) {
  w1 <- rnorm(n)
  w2 <- rnorm(n)
  a <- rbinom(n, 1, plogis(-1 + w1))
  ## a <- rbinom(n, 1, 0.3)
  y <- cos(w1) + w2*a + 0.2*w2^2 + a + rnorm(n)
  data.frame(y, a, w1, w2)
}

d <- sim1(5000)


fit <- glm(y ~ a + w1 + w2, data = d)
## fit <- glm(y ~ a, data = d)

est <- cate(
  response.model = learner_glm(y ~ a + w1 + w2),
  ## response.model = learner_glm(y ~ a),
  treatment.model = a ~ 1,
  data = d,
  second.order = T
)
est
