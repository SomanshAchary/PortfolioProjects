# Load required packages
install.packages("ggplot2")
library(ggplot2)

# Function to read CSV and view data
load_and_view_data <- function() {
  data <- read.csv(file.choose())
  View(data)
  return(data)
}

# Compare stats from 2000-2010
strp <- load_and_view_data()

ggplot(strp, aes(Year, Runs, col = Name)) +
  geom_point(size = 5) +
  geom_line()

ggplot(strp, aes(Year, X50s, col = Name)) +
  geom_point(size = 5) +
  geom_line()

ggplot(strp, aes(Year, X100s, col = Name)) +
  geom_point(size = 5) +
  geom_line()

# Compare performance Home vs Away
ha <- load_and_view_data()

ha <- data.frame(
  Name = c("R.Ponting", "R.Ponting", "R.Ponting", "S.Tendulkar", "S.Tendulkar", "S.Tendulkar"),
  Stadium = c("Home", "Away", "Neutral", "Home", "Away", "Neutral"),
  Runs = c(13117, 10632, 3734, 14192, 13780, 6385)
)

ggplot(ha, aes(x = Stadium, y = Runs, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of Runs scored by R.Ponting and S.Tendulkar by stadium",
       x = "Stadium", y = "Runs", fill = "Player")

ggplot(ha, aes(x = Stadium, y = X100s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of 100 scored by R.Ponting and S.Tendulkar by stadium",
       x = "Stadium", y = "X100s", fill = "Player")

ggplot(ha, aes(x = Stadium, y = X50s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of 50 scored by R.Ponting and S.Tendulkar by stadium",
       x = "Stadium", y = "X50s", fill = "Player")

# Compare vs Major teams of their career
mt <- load_and_view_data()

ggplot(mt, aes(x = Team, y = Runs, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of Runs scored by R.Ponting and S.Tendulkar Versus Major Teams",
       x = "Team", y = "Runs", fill = "Player")

ggplot(mt, aes(x = Team, y = X100s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of 100s scored by R.Ponting and S.Tendulkar Versus Major Teams",
       x = "Team", y = "X100s", fill = "Player")

ggplot(mt, aes(x = Team, y = X50s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Number of 50s scored by R.Ponting and S.Tendulkar Versus Major Teams",
       x = "Team", y = "X50s", fill = "Player")

# Comparison b/w them on the basis of the major trophies they played (Runs,100s,50s)
MT <- load_and_view_data()

ggplot(MT, aes(x = Tournament, y = Runs, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of Runs scored by R.Ponting and S.Tendulkar in Major Tournament",
       x = "Tournament", y = "Runs", fill = "Player")

ggplot(MT, aes(x = Tournament, y = X100s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of 100s scored by R.Ponting and S.Tendulkar in Major Tournament",
       x = "Tournament", y = "Number of 100s", fill = "Player")

ggplot(MT, aes(x = Tournament, y = X50s, fill = Name)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Comparison of 50s scored by R.Ponting and S.Tendulkar in Major Tournament",
       x = "Tournament", y = "Number of 50s", fill = "Player")
