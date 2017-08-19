
library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)
library(scales)

stormhealth <- readRDS("data/stormhealth.rds")
stormdamage <- readRDS("data/stormdamage.rds")

shinyServer(
    function(input, output) {
       
        
        output$chart1 <- renderPlot({
            # now we need to subset using parameters supplied by Shiny tool
            # re-order factors in stormdamage for ggplot such that facet is first order and then
            # totalamount in decreasing level
            health <- filter(stormhealth, (yr >= input$range[1] & yr <= input$range[2])) %>% group_by(EVTYPE, outcomes) %>% 
                summarise(totalamount= sum(totalamount, na.rm = TRUE)) %>% ungroup() %>% arrange(outcomes, -totalamount) %>% 
                mutate(order= row_number())
            
            # plot separate facets for outcomes with factors for EVTYPE plotted in decreasing order
            # of relative amount - use logged data so charts will look better
            g <- ggplot(health, aes(x=order, y=log10(totalamount + 1), fill=EVTYPE))
            g <- g + geom_bar(stat= "identity") +
                facet_grid(facets= .~ outcomes, scales= "free", space= "free") +
                scale_x_continuous(breaks= health$order, labels= health$EVTYPE) +
                ggtitle("Total Fatalities and Injuries Due to Severe Weather Events in the USA") +
                ylab("Total Number of Fatalities and Injuries (log10)") +
                xlab("Type of Severe Weather Event") +
                theme(axis.text.x = element_text(angle = 45, hjust = 1))
            print(g)
            
        })
        
        output$table1 <- renderTable({
            health <- filter(stormhealth, (yr >= input$range[1] & yr <= input$range[2])) %>% group_by(EVTYPE, outcomes) %>% 
                summarise(totalamount= sum(totalamount, na.rm = TRUE)) %>% ungroup() %>% arrange(outcomes, -totalamount) %>% 
                mutate(order= row_number())
            # print data frame with regular data for easier observation
            health$totalamount <- comma(health$totalamount)
            health[,c(1,2,3)]
        })          

        output$chart2 <- renderPlot({
            # now we need to subset using parameters supplied by Shiny tool
            # re-order factors in stormdamage for ggplot such that facet is first order and then
            # totalamount in decreasing level
            damage <- filter(stormdamage, (yr >= input$range[1] & yr <= input$range[2])) %>% group_by(EVTYPE, outcomes) %>% 
                summarise(totalamount= sum(totalamount, na.rm = TRUE)) %>% ungroup() %>% arrange(outcomes, -totalamount) %>% 
                mutate(order= row_number())
            
            # plot separate facets for outcomes with factors for EVTYPE plotted in decreasing order
            # of relative amount - use logged data so charts will look better
            g <- ggplot(damage, aes(x=order, y=log10(totalamount + 1), fill=EVTYPE))
            g <- g + geom_bar(stat= "identity") +
                facet_grid(facets= .~ outcomes, scales= "free", space= "free") +
                scale_x_continuous(breaks= damage$order, labels= damage$EVTYPE) +
                ggtitle("Total Property and Crop Damage Due to Severe Weather Events in the USA") +
                ylab("Total Amount of Property and Crop Damage (log10)") +
                xlab("Type of Severe Weather Event") +
                theme(axis.text.x = element_text(angle = 45, hjust = 1))
            print(g)
            
        })
        #outputOptions(output, "chart2", suspendWhenHidden = FALSE)  
        
        output$table2 <- renderTable({
            damage <- filter(stormdamage, (yr >= input$range[1] & yr <= input$range[2])) %>% group_by(EVTYPE, outcomes) %>% 
                summarise(totalamount= sum(totalamount, na.rm = TRUE)) %>% ungroup() %>% arrange(outcomes, -totalamount) %>% 
                mutate(order= row_number())
            # print data frame with regular data for easier observation
            damage$totalamount <- comma(round(damage$totalamount,digits=0))
            damage$totalamount <- paste0("$",damage$totalamount)
            damage[,c(1,2,3)]
            
        })          
        #outputOptions(output, "table2", suspendWhenHidden = FALSE)  
    }
)
