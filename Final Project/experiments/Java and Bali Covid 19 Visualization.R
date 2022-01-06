
library(dplyr)
library(ggplot2)
library(gganimate)

getwd()

# Import and View Data
df <- read.csv("jawa_and_bali_df.csv")
df
glimpse(df)

# Simpanan vs Pinjaman yang Diberikan (2019 - 2021)
plot <- df %>%
  ggplot(aes(x = Simpanan, y = Pinjaman.yang.diberikan, 
             color = Provinsi, size = Kredit.UMKM)) + 
  geom_point(alpha = 0.8) + theme_bw() + 
  ggtitle('Pinjaman yang Diberikan vs. Simpanan') + 
  labs(y = 'Pinjaman yang Diberikan') + 
  transition_time(Tahun) + 
  shadow_mark(alpha = 0.3, size = 0.5) +
  ggtitle("Hubungan Pinjaman dan Simpanan", subtitle = "Tahun: {frame_time}")

animate(plot, renderer = gifski_renderer())
anim_save("pinjaman vs simpanan.gif", plot)

# Simpanan vs Kasus Aktif (2019 - 2021)
simpanan_vs_kasus_aktif <- df %>%
  ggplot(aes(x = Simpanan, y = Kasus.Aktif, 
             color = Provinsi, size = Kredit.UMKM)) + 
  geom_point(alpha = 0.8) + theme_bw() +
  labs(y = 'Kasus Aktif') + transition_time(Tahun) + 
  shadow_mark(alpha = 0.3, size = 0.5) +
  ggtitle("Hubungan Kasus Aktif dan Simpanan", 
          subtitle = "Tahun: {frame_time}")

animate(simpanan_vs_kasus_aktif, renderer = gifski_renderer())
anim_save("kasus aktif vs simpanan.gif", simpanan_vs_kasus_aktif)

# Pinjaman vs. Kasus Aktif (2019 - 2021)
pinjaman_vs_kasus_aktif <- df %>%
  ggplot(aes(x = Pinjaman.yang.diberikan, y = Kasus.Aktif, 
             color = Provinsi, size = Kredit.UMKM)) + 
  geom_point(alpha = 0.8) + theme_bw() +
  labs(x = "Pinjaman yang Diberikan", y = 'Kasus Aktif') +
  transition_time(Tahun) + shadow_mark(alpha = 0.3, size = 0.5) +
  ggtitle("Hubungan Kasus Aktif dan Pinjaman yang Diberikan", 
          subtitle = "Tahun: {frame_time}")

animate(pinjaman_vs_kasus_aktif, renderer = gifski_renderer())


# Kasus Aktif (2019 - 2021)
kasus_aktif <- df %>%
  ggplot(aes(x = Tahun, y = Kasus.Aktif, color = Provinsi)) + geom_line() +
  transition_reveal(Tahun) + shadow_mark(alpha = 0.3, size = 0.5) +
  ggtitle("Kasus Aktif")

animate(kasus_aktif, renderer = gifski_renderer())

