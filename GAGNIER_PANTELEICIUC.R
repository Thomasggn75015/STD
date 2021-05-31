#Graphes
library(tidyverse)
library("ggpubr")
#PCA
library("FactoMineR")
library("factoextra")

prostate <- read.table("prostate.txt", header = TRUE)
attach(prostate)

summary(psa) #Calcule les statistiques descriptives de la variable psa
cor(prostate) #Matrice de corrélation montrant notamment la corrélation des différentes variables avec la variable psa

#Les points de ce graphique sont très rapprochés
#On prend le logarithme des variables pour un graphique plus visuel
#ggplot(prostate) + geom_point(aes(x = vol, y=psa)

prostate[,-3] <- log(prostate[,-3]) #Fonction permettant d'appliquer un logarithme sur toutes les colonnes excepté l'âge
colnames(prostate) <- paste('l', colnames(prostate), sep='') #Modifie le nom des variables à 'lvariable'

#Représentation graphique des logarithmes des variables
aplot <- ggplot(prostate) + geom_point(aes(x = lvol, y=lpsa), color = 'blue') + geom_point(aes(x=lbh, y=lpsa), color='yellow') + geom_point(aes(x=lpc, y=lpsa), color='black')
bplot <- ggplot(prostate) + geom_point(aes(x=lwht, y=lpsa), color='green')
cplot <- ggplot(prostate) + geom_point(aes(x=lage, y=lpsa), color='red')
figure <- ggarrange(aplot, bplot, cplot, labels=c("lvol, lbh, lpc", "lwht", "lage"), ncol=2, nrow=2)
figure

#Calcul de la variance logarithmique
var(prostate)

#Calcul de l'Analyse en Composante Principale
PCA(prostate, scale.unit=TRUE, ncp=6, graph=TRUE)
#On affiche les vecteurs propres (1e colonne du résultat)
#Ainsi que le pourcentage de variance (2e colonne du résultat) 
#Ainsi que le pourcentage cumulé de variance (3e colonne du résultat)
PCA$eig
