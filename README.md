# EARS: Event-Adjusted Rank Sum Test for Survival Analysis

The **Event-Adjusted Rank Sum (EARS) test** is a non-parametric statistical method for comparing survival distributions between groups **without relying on the proportional hazards assumption**.  
It adjusts each event time by the proportion of events in its group and then applies a Kruskal-Wallis test to the adjusted survival times.  
This provides a simple and robust approach to time-to-event data analysis even when survival curves cross or hazards vary over time.

EARS is described in:

> Stålhammar G. *Introducing the Event-Adjusted Rank Sum (EARS) Test: A Simple Approach to Survival Analysis Independent of Proportional Hazards.*  
> **BioMed Research International**, 2025.

---

## 🧠 Key features
- Non-parametric test independent of proportional hazards  
- Works with two or more groups  
- Adjusts for censoring by penalizing the resulting *P*-value  
- Implemented in R for straightforward use  
- Validated through extensive simulation and clinical datasets  

---

## ⚙️ Installation

You can install the EARS package directly from GitHub using **devtools**:

```r
# install.packages("devtools")
devtools::install_github("gustavstalhammar-ui/EARS")
