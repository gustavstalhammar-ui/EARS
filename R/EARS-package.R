#' EARS: Event-Adjusted Rank Sum Test
#'
#' The Event-Adjusted Rank Sum (EARS) test provides a non-parametric approach
#' to comparing survival distributions between groups without relying on
#' the proportional hazards assumption. It adjusts each event time by the
#' proportion of events in its group and then applies a Kruskal–Wallis test
#' with a censoring-based penalty.
#'
#' Reference:
#' Stålhammar G. (2025). "Introducing the Event-Adjusted Rank Sum (EARS) Test:
#' A Simple Approach to Survival Analysis Independent of Proportional Hazards."
#' *BioMed Research International.*
#'
#' @section Intended use and disclaimer:
#' This software is provided “as is,” without warranties of any kind. It is
#' intended for research and educational purposes only and must not be used
#' for clinical decision-making. Users are responsible for validating all
#' assumptions, methods, and results. See LICENSE and DISCLAIMER.md for details.
#'
#' @docType package
#' @name EARS
NULL
