# Pacotes
library(ggplot2)
library(dplyr)

# Banco de dados
dados <- Pokemon_full #já havia subido o banco de dados pro R

# 1. Encontrar os 6 tipos mais comuns para não poluir a tela
top_tipos <- dados %>%
  count(type, sort = TRUE) %>%
  head(6) %>%
  pull(type)

# 2. Construir o gráfico
dados %>%
  filter(type %in% top_tipos) %>%
  ggplot(aes(x = attack, y = defense, color = type)) +
  geom_point(alpha = 0.7, size = 3) + # alpha adiciona transparência aos pontos
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dashed") + # Adiciona linha de tendência
  facet_wrap(~type) + # Cria um mini-gráfico para cada tipo
  labs(
    title = "Relação entre Ataque e Defesa",
    subtitle = "Focado nos 6 tipos mais comuns de Pokémon",
    x = "Ataque",
    y = "Defesa"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(size = 18, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 14, hjust = 0.5, color = "gray30"),
    axis.title = element_text(size = 14, face = "bold"),
    axis.text = element_text(size = 12, face = "plain"),
    strip.text = element_text(size = 12, face = "bold"), # Formata o título de cada faceta
    legend.position = "none" # Remove a legenda lateral
  )