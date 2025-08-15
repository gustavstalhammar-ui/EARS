#' EVENT-ADJUSTED RANK SUM (EARS) TEST
#'
#' Computes adjusted survival times by dividing each event time by the proportion
#' of events in its group, then compares distributions across groups with a
#' Kruskal–Wallis test and adjusts the P value for censoring.
#'
#' @param data   A data.frame containing your data.
#' @param group  Name of the grouping variable (character).
#' @param time   Name of the survival-time variable (character).
#' @param event  Name of the event indicator (character; 1=event, 0=censored).
#' @return A list with components:
#'   \describe{
#'     \item{statistic}{Kruskal–Wallis chi-squared statistic}
#'     \item{p.value}{Censoring-adjusted P value (≤ 1)}
#'     \item{method}{Description of the test performed}
#'     \item{data}{Data.frame of adjusted times (only events)} 
#'   }
#' @examples
#' df <- data.frame(
#'   Group = rep(c("A","B"), each=5),
#'   Time  = c(5,6,7,8,9,3,4,10,12,15),
#'   Event = c(1,1,0,1,0,1,0,1,0,1)
#' )
#' ears_test(df, "Group", "Time", "Event")
#' @export
ears_test <- function(data, group, time, event) {
  if (!is.data.frame(data)) stop("`data` must be a data.frame.")
  cols <- names(data)
  
  
# helper: show numbered list, then readline once
ask_for <- function(arg) {
  cols <- names(data)
  cat("\n*** SELECT COLUMN FOR '", toupper(arg), "' ***\n\n", sep = "")
  for (i in seq_along(cols)) {
    cat(sprintf(" %2d: %s\n", i, cols[i]))
  }
  prompt <- sprintf("Enter number (1–%d) for '%s' or 0 to cancel: ", length(cols), arg)
  repeat {
    ans <- readline(prompt)
    num <- suppressWarnings(as.integer(ans))
    if (!is.na(num) && num >= 0 && num <= length(cols)) {
      if (num == 0) stop("No column selected for '", arg, "'. Aborting.")
      return(cols[num])
    }
    cat("  → Invalid input. Please enter an integer between 1 and", length(cols), "or 0.\n")
  }
}


  
  # if any arg is missing from your data, force a menu
  if (!group %in% cols) group <- ask_for("group")
  if (!time  %in% cols) time  <- ask_for("time")
  if (!event %in% cols) event <- ask_for("event")
  
  grp <- as.factor(data[[group]])
  t   <- data[[time]]
  evt <- data[[event]]
  
  if (!is.numeric(t))        stop("Column '", time, "' must be numeric.")
  if (!all(evt %in% c(0,1))) stop("Column '", event, "' must be coded 0/1.")
  
  prop <- tapply(evt, grp, mean)
  if (any(prop == 0)) stop("Each group must have at least one event.")
  
  adj  <- ifelse(evt == 1, t / prop[as.character(grp)], NA)
  adjf <- data.frame(group = grp, adj_time = adj)
  adjf <- adjf[!is.na(adjf$adj_time), , drop = FALSE]
  
  kw <- stats::kruskal.test(adj_time ~ group, data = adjf)
  
  censor_rate <- mean(evt == 0)
  p_adj       <- kw$p.value / (1 - censor_rate)
  
  res <- list(
    statistic = kw$statistic,
    p.value   = min(p_adj, 1),
    method    = "Event-Adjusted Rank Sum (EARS) test with censoring-adjusted P value",
    data      = adjf
  )
    class(res) <- "ears_test"
  # automatically show the results in the console
  print(res)
  invisible(res)

}

#' @export
print.ears_test <- function(x, ...) {
  cat(x$method, "\n")
  cat("Kruskal–Wallis chi-squared =", round(unname(x$statistic), 3), "\n")
  cat("Adjusted P value =", signif(x$p.value, 3), "\n")
}
