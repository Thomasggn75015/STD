library(tidyverse)
library("ggpubr")

prostate <- read.table("~/Documents/Documents ISEP/A1/2e semestre/Sciences et traitement des données/IF1103/prostate.txt", header = TRUE)
attach(prostate)
summary(psa) #Calcule les statistiques descriptives de la variable psa
cor(prostate) #Matrice de corrélation montrant notamment la corrélation des différentes variables avec la variable psa
#ggplot(prostate) + geom_point(aes(x = vol, y=psa)) #Les points de ce graphique sont très rapprochés, on prend le logarithme des variables pour un graphique plus visuel
prostate[,-3] <- log(prostate[,-3]) #Fonction permettant d'appliquer un logarithme sur toutes les colonnes excepté l'âge
colnames(prostate) <- paste('l', colnames(prostate), sep='') #Modifie le nom des variables à 'lvariable'
attach(prostate)
aplot <- ggplot(prostate) + geom_point(aes(x = lvol, y=lpsa), color = 'blue') + geom_point(aes(x=lbh, y=lpsa), color='yellow') + geom_point(aes(x=lpc, y=lpsa), color='black') #Représentation graphique des logarithmes des variables
bplot <- ggplot(prostate) + geom_point(aes(x=lwht, y=lpsa), color='green')
cplot <- ggplot(prostate) + geom_point(aes(x=lage, y=lpsa), color='red')
figure <- ggarrange(aplot, bplot, cplot, labels=c("lvol, lbh, lpc", "lwht", "lage"), ncol=2, nrow=2)
figure

