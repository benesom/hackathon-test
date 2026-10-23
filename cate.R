library(targeted)
library(lava)

set.seed(40)
sim1 <- function(n=1000, ...) {
  w1 <- rnorm(n)
  w2 <- rnorm(n)
  ## a <- rbinom(n, 1, plogis(-1 + w1))
  a <- rbinom(n, 1, 0.3)
  y <- cos(w1) + w1*a + 0.2*w2^2 + a + rnorm(n)
  data.frame(y, a, w1, w2)
}

n <- 200
d <- sim1(n)


theta0_anova <- with(d, mean(y[a==0]))
theta1_anova <- with(d, mean(y[a==1]))

ic0_anova <- with(d, (a == 0) * (y - theta0_anova) / mean(a == 0))
ic1_anova <- with(d, (a == 1) * (y - theta1_anova) / mean(a == 1))

est0 <- estimate(coef = theta0_anova, IC = ic0_anova, labels = "E[Y(0)]", id = T)
est1 <- estimate(coef = theta1_anova, IC = ic1_anova, labels = "E[Y(1)]", id = T)

c(
  est0, est1, psi = est1 - est0
)

est_ancova <- estimate(coef = c(theta0 = theta0_anova, theta1 = theta1_anova), IC = cbind(ic0_anova, ic1_anova))
est_ancova

estimate(est_ancova, \(p) p[2] - p[1])

fit_ancova <- glm(y ~ a + w1, data = d)
pi1 <- mean(d$a)
pi0 <- 1 - pi1
w_bar <- mean(d$w1)
w0_bar <- with(d, sum(w1[a == 0])) / (pi0 * n)
w1_bar <- with(d, sum(w1[a == 1])) / (pi1 * n)
beta_hat <- coef(fit_ancova)[3]
theta0_ancova <- theta0_anova - beta_hat * (w0_bar - w_bar)
theta1_ancova <- theta1_anova - beta_hat * (w1_bar - w_bar)
theta1_ancova - theta0_ancova - coef(fit_ancova)[2]

alpha0 <- with(d, mean(y[a == 0]) - beta_hat * mean(w1[a == 0]))
alpha1 <- with(d, mean(y[a == 1]) - beta_hat * mean(w1[a == 1]))
alpha1 - alpha0 - coef(fit_ancova)[2]


ic0 <- with(d,
  (a == 0) * (y - theta0_ancova - beta_hat * (w1 - w_bar)) / pi0
)
ic1 <- with(d,
(a == 1) * (y - theta1_ancova - beta_hat * (w1 - w_bar)) / pi1
)
ic_ancova <- ic1 - ic0

est_ancova <- estimate(coef = theta1_ancova - theta0_ancova, IC = ic_ancova)


est <- cate(
  response.model = learner_glm(formula(fit_ancova)),
  ## response.model = learner_glm(y ~ a),
  treatment.model = a ~ 1,
  data = d,
  second.order = T
)
est

((n - 1)  * var(IC(est)[, 3]) / (n ** 2))
vcov(est)

((n - 1)  * var(ic_ancova) / (n ** 2))

((n - 1)  * var(IC(estimate(fit_ancova, keep = "a"))) / (n ** 2))


mean(ic_ancova - IC(est)[, 3] )
mean(ic_ancova - )
