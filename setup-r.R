renv::restore(rebuild = TRUE)

c(
  targeted = packageVersion("targeted") |> as.character(),
  lava = packageVersion("lava") |> as.character()
)
