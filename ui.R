ui <- dashboardPage(
  skin = 'red',
  dashboardHeader(title = "Jogadores FIFA"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Posições", tabName = "dashboard", icon = icon("futbol")),
      menuItem("Top10", tabName = "top10", icon = icon("trophy")),
      menuItem("Compare Jogadores", tabName = "compare", icon = icon("balance-scale")),
      menuItem("Curiosidades", tabName = "curiosities", icon = icon("lightbulb"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(width = 12,
                    selectInput("best_position", "Melhores jogadores da posição:",
                                choices = c("CAM", "CB", "CDM", "CF", "CM", "GK",
                                            "LB", "LM", "LW", "LWB", "RB", "RM",
                                            "RW", "RWB", "ST"))
                ),
                box(width = 12,
                    DT::dataTableOutput("topPlayersTable")
                ),
                box(title = "Legenda", width = 2,
                    tableOutput("positionTable")
                )
              )
      ),
      tabItem(tabName = "top10",
              fluidRow(
                box(width = 6,
                    selectInput("variable", "Selecione a variável:",
                                choices = colnames(players)[sapply(players, is.numeric)])
                )
              ),
              fluidRow(
                box(width = 6,
                    DT::dataTableOutput("top10table")
                )
              )
      ),
      tabItem(tabName = "compare",
              fluidRow(
                box(width = 6,
                    selectizeInput("player1", "Selecione o primeiro jogador:",
                                   choices = players$Nome, options = list(maxOptions = 1000))
                ),
                box(width = 6,
                    selectizeInput("player2", "Selecione o segundo jogador:",
                                   choices = players$Nome, options = list(maxOptions = 1000))
                )
              ),
              fluidRow(
                box(width = 12,
                    DT::dataTableOutput("compareTable")
                )
              )
      ),
      tabItem(tabName = "curiosities",
              fluidRow(
                box(title = "Pé Dominante", width = 6,
                    plotOutput("footPlot")
                ),
                box(title = "Data de Nascimento", width = 6,
                    plotOutput("birthPlot")
                )
              ),
              fluidRow(
                box(title = "Nacionalidade", width = 6,
                    plotOutput("nationalityPlot")
                ),
                box(title = "Altura", width = 6,
                    plotOutput("heightPlot")
                )
              )
      )
    )
  )
)
