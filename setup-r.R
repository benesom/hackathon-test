renv::restore(rebuild = TRUE) # force rebuild to avoid picking up
# outdated dependencies

c(
  targeted = packageVersion("targeted") |> as.character(),
  lava = packageVersion("lava") |> as.character()
)
