library(shiny)


shinyUI(fluidPage(
    
    navbarPage(h2("Storm Data Analysis"),
        tabPanel("Documentation",
            titlePanel("Background and How to Use This Application"),
            
            fluidRow(
                column(8,
                    p(h3("Background")),
                            p("This application involves exploring the U.S. National Oceanic and Atmospheric
                            Administration's (NOAA) storm database. This database tracks characteristics
                            of major storms and weather events in the United States from 1950 to 2011, 
                            including when and where they occur, as well as estimates of any fatalities, 
                            injuries, and property damage. Note that this analysis application does not
                            include any locational data and looks at the United States as a single entity
                            over that time period"),
                            p("The events in the database start in the year 1950 and end in November 2011. 
                            In the earlier years of the database there are generally fewer events recorded, 
                            most likely due to a lack of good records. More recent years should be considered 
                            more complete. Note that due to this fact, there is substantial difference in the
                            amount of data collected before and after 1993"),  
                            p("The data for this assignment come in the form of a comma-separated-value file 
                            compressed via the bzip2 algorithm to reduce its size. In addition, there is also 
                            some documentation of the database available. Here you will find how some of the 
                            variables are constructed/defined."),
                            p(a("National Weather Service Storm Data Documentation",  
                            href= "https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2Fpd01016005curr.pdf",
                            target= "_blank")),
                            p(a("National Climatic Data Center Storm Events FAQ", 
                            href= "https://d396qusza40orc.cloudfront.net/repdata%2Fpeer2_doc%2FNCDC%20Storm%20Events-FAQ%20Page.pdf",
                            target= "_blank"))
                       ),
               column(4,
                      img(src='Lighthouse.PNG', align = "right", width=300, height= 400)
                      ) 
            ),
            mainPanel(
                column(12,
                p(h3("How to Use this Application")),
                p("Click on the Application tab at the top of the page in order to access the Storm Data 
                Analysis application. The application has an input selection box in the left panel which
                states - Choose the type of analysis to display - This selection enables a user to choose 
                which type of data is presented - either the aggregated number of - Human Fatalities and 
                Injuries - or the aggregated amount of total - Economic and Crop Damage - over the selected 
                period in the input slider box below."),
                p("The input slider box which is located just below the input selector box and is named - 
                Years of interest; - enables a user to specify
                which period  of time to aggregate the data over. Once a selection is made the application
                recalculates the respective total amounts and displays them in a vertical bar chart at the 
                top of the page and in a data table just below the graph. Both sliders in the input slider 
                box can be adjusted so that any range of data in the period from 1950 through 2011 will be 
                displayed in both the graphs and the data table."),
                p(h3("Data")),
                p("The data displayed in this application has been pre-processed into 12 categories in order
                to simplify the analysis. The preposssed data is then input into this application in aggregated
                yearly totals from 1950 through 2011 for each of the respective strom categories and event types.
                The data calculations conducted in the pre-processing are detailed in a Knitr Markdown document
                at the following link:"),
                p(a("Analysis of Health and Economic Consequences Due to Severe Weather Events",
                href= "http://rpubs.com/skewdlogix/278567", target= "_blank"))
                
                 )

            )
        ),
    
        tabPanel("Application",
            sidebarLayout(
                sidebarPanel(
                    helpText("Examine various time periods from 1950 to 2011 from the US National
                             and Atmospheric Administration's (NOAA) storm database to determine
                             the costs that are associated with extreme weather events both 
                             from a human and an economic perspective."),
                    
                    selectInput("var", 
                                label = "Choose the type of analysis to display",
                                choices = c("Human Fatalities and Injuries", "Economic and Crop Damage"),
                                selected = "Human Fatalities and Injuries"),
                    
                    sliderInput("range", 
                                label = "Years of interest:",
                                min = 1950, max = 2011, value = c(1993, 2011),
                                sep= "")
                    ),
                
                mainPanel(
                    conditionalPanel(
                          
                            condition = "input.var == 'Economic and Crop Damage' &&
                            input['var'] != 'Human Fatalities and Injuries'",
                                plotOutput("chart2"),
                                br(),
                                tableOutput("table2")),
                    conditionalPanel(   
                            condition = "input.var == 'Human Fatalities and Injuries' &&
                            input['var'] != 'Economic and Crop Damage'",
                                plotOutput("chart1"),
                                br(),
                                tableOutput("table1"))
                )
            )
        )
        )
    ))