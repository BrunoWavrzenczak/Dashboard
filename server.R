server <- function(input, output, session) {
  filteredData <- reactive({
    req(input$best_position)
    filtered_players <- players[players$Melhor.Posição == input$best_position, ]
    top_players <- filtered_players[order(-filtered_players$Pontuação.Geral), ][1:10, ]
    return(top_players)
  })

  top10Data <- reactive({
    req(input$variable)
    top10 <- players[order(-players[[input$variable]]), ][1:10, ]
    top10[, c("Nome", input$variable), drop = FALSE]
  })

  compareData <- reactive({
    req(input$player1, input$player2)
    player1_data <- players[players$Nome == input$player1, ]
    player2_data <- players[players$Nome == input$player2, ]
    rbind(player1_data, player2_data)
  })

  output$topPlayersTable <- DT::renderDataTable({
    filteredData()
  }, options = list(scrollX = TRUE))

  output$top10table <- DT::renderDataTable({
    top10Data()
  })

  output$compareTable <- DT::renderDataTable({
    compareData()
  }, options = list(scrollX = TRUE))

  output$positionTable <- renderTable({
    posicoes
  })

  output$footPlot <- renderPlot({
    ggplot(players, aes(x = Pé.Dominante, fill = Pé.Dominante)) +
      geom_bar() +
      labs(x = "Pé Dominante", y = "Contagem") +
      theme_minimal() +
      scale_fill_brewer(palette = "Set1")
  })

  output$birthPlot <- renderPlot({
    ggplot(players, aes(x = as.Date(Data.de.Nascimento, "%Y-%m-%d"))) +
      geom_histogram(binwidth = 365.25, fill = "blue", color = "white") +
      labs(x = "Data de Nascimento", y = "Contagem") +
      theme_minimal()
  })

  output$nationalityPlot <- renderPlot({
    nationality_count <- as.data.frame(table(players$Nacionalidade))
    nationality_count <- nationality_count[nationality_count$Freq > 200, ]
    ggplot(nationality_count, aes(x = Var1, y = Freq)) +
      geom_bar(stat = "identity", fill = "purple", color = "white") +
      labs(x = "Nacionalidade", y = "Contagem") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 12))
  })

  output$heightPlot <- renderPlot({
    ggplot(players, aes(x = Altura)) +
      geom_histogram(binwidth = 1, fill = "darkgreen", color = "white") +
      labs(x = "Altura (cm)", y = "Contagem") +
      theme_minimal()
  })
}
