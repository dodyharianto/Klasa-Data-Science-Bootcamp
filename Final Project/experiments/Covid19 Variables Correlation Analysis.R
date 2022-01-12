
# COVID19 VARIABLES CORRELATION ANALYSIS

getwd()

library(dplyr)
library(ggplot2)
library(gganimate)

df <- read.csv("active cases and gdp grouped by region 1.csv")
df

# Kasus Aktif vs. PDB
kasus_aktif_pdb <- df %>%
  ggplot(aes(x = Kasus.Aktif, y = PDB, color = Wilayah)) + 
  geom_point(alpha = 0.5, size = 5) + theme_bw() + transition_time(Tahun) + 
  shadow_mark(alpha = 0.2, size = 0.5) +
  ggtitle("Hubungan PDB dan Kasus Aktif", 
          subtitle = "Tahun: {frame_time}") +
  labs(x = "Kasus Aktif", y = "PDB") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom")

animate(kasus_aktif_pdb, renderer = gifski_renderer())
cor(df$PDB, df$Kasus.Aktif, method = "pearson") %>% round(3)

# Kasus Aktif vs. Simpanan
simpanan_vs_kasus_aktif <- df %>%
  ggplot(aes(x = Simpanan, y = Kasus.Aktif, color = Wilayah)) + 
  geom_point(alpha = 0.5, size = 5) + theme_bw() + transition_time(Tahun) + 
  shadow_mark(alpha = 0.2, size = 0.5) +
  ggtitle("Hubungan Kasus Aktif dan Simpanan", 
          subtitle = "Tahun: {frame_time}") +
  labs(x = "Simpanan", y = "Kasus Aktif") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom")

animate(simpanan_vs_kasus_aktif, renderer = gifski_renderer())
animate(simpanan_vs_kasus_aktif + facet_wrap(~ Wilayah), 
        renderer = gifski_renderer())
cor(df$Kasus.Aktif, df$Simpanan, method = "pearson") %>% round(3)


# PDB vs. Kredit UMKM
pdb_vs_kredit_umkm <- df %>%
  ggplot(aes(x = Kredit.UMKM, y = PDB, color = Wilayah)) + 
  geom_point(alpha = 0.5, size = 5) + theme_bw() + transition_time(Tahun) + 
  shadow_mark(alpha = 0.2, size = 0.5) +
  ggtitle("Hubungan PDB dan Kredit UMKM", 
          subtitle = "Tahun: {frame_time}") +
  labs(x = "Kredit UMKM", y = "PDB") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom")

animate(pdb_vs_kredit_umkm, renderer = gifski_renderer())
cor(df$PDB, df$Kredit.UMKM, method = "pearson") %>% round(3)

# PDB vs. Pinjaman
pdb_vs_kredit_umkm <- df %>%
  ggplot(aes(x = Pinjaman.yang.diberikan, y = PDB, color = Wilayah)) + 
  geom_point(alpha = 0.5, size = 5) + theme_bw() + transition_time(Tahun) + 
  shadow_mark(alpha = 0.2, size = 0.5) +
  ggtitle("Hubungan PDB dan Pinjaman", 
          subtitle = "Tahun: {frame_time}") +
  labs(x = "Pinjaman", y = "PDB") + 
  theme(plot.title = element_text(hjust = 0.5, size = 20),
        plot.subtitle = element_text(hjust = 0.5),
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom")

animate(pdb_vs_kredit_umkm, renderer = gifski_renderer())
cor(df$PDB, df$Pinjaman.yang.diberikan, method = "pearson") %>% round(3)