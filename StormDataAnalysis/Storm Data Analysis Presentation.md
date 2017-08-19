Storm Data Application
========================================================
author: skewdlogix
date:   August 15, 2017
autosize: true
<div align="center">
<img src="Lighthouse.PNG" width=800 height=600>
</div>

Extreme Storm Event Human Costs
========================================================





The National Oceanic and Atmospheric Administration's (NOAA) storm database contains data on storm events from 1950 to 2011. During that period of time the total number of deaths due to storm events were


```r
filter(stormhealth, outcomes == "FATALITIES") %>% summarise(totalamount= comma(round(sum(totalamount)),0))
```

```
  totalamount
1      14,836
```

while the total number of injuries due to storm events were


```r
filter(stormhealth, outcomes == "INJURIES") %>% summarise(totalamount= comma(round(sum(totalamount)),0))
```

```
  totalamount
1     139,452
```

Extreme Storm Event Property Costs
========================================================
During the same time period the total amount of property damage was


```r
filter(stormdamage, outcomes == "PROPDMG") %>% summarise(totalamount= paste0("$",comma(round(sum(totalamount)),0)))
```

```
       totalamount
1 $423,706,156,042
```

and the total amount of crop damage was


```r
filter(stormdamage, outcomes == "CROPDMG") %>% summarise(totalamount= paste0("$",comma(round(sum(totalamount)),0)))
```

```
      totalamount
1 $24,085,729,473
```

Types of Storm Events
========================================================

The various storm events can be broken down in 12 distinct categories.

![plot of chunk unnamed-chunk-7](Storm Data Analysis Presentation-figure/unnamed-chunk-7-1.png)

Storm Data Analyzer Application
========================================================

The Storm Data Analyzer can easily show the total number of fatalities and injuries or the total amount of property and crop damage for any specified span of years simply by adjusting the Years of interest slider control and choosing the appropriate drop down selection.

This dynamic application caculates the correct total for both human and property costs on the fly as soon as the slider controls are adjusted.

Save yourself a lot of time in needlessly calculating these varibles by using this dynamic application and at the same time output the results in a colourful graph as shown on the previous page. 

Location: <a href="https://skewdlogix.shinyapps.io/stormdataanalysis/", target= "_blank">Storm Data Analysis Application</a>

Source Code: <a href="https://github.com/skewdlogix/DevelopingDataProducts/tree/gh-pages/StormDataAnalysis", target= "_blank">Github</a>

