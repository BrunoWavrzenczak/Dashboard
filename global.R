library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)


players <- read.csv("players_1.csv")

# Remova a coluna 'X' se existir
players <- players[, !(names(players) %in% c("X", "Unnamed: 0"))]

# Crie um dataframe para as posições e suas traduções
posicoes <- data.frame(
  Posição = c("CAM", "CB", "CDM", "CF", "CM", "GK", "LB", "LM", "LW", "LWB", "RB", "RM", "RW", "RWB", "ST"),
  Significado = c("Meia Ofensivo Central", "Zagueiro Central", "Volante", "Centroavante",
                  "Meia Central", "Goleiro", "Lateral Esquerdo", "Meia Esquerdo",
                  "Ponta Esquerda", "Ala Esquerdo", "Lateral Direito", "Meia Direito",
                  "Ponta Direita", "Ala Direito", "Atacante")
)
