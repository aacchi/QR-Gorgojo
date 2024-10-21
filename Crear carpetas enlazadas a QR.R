library(qrencoder)
library(googledrive)
library(qrcode)


# Variables principales
bloques <- 1:4  # Bloques 1 a 4
variedades <- c(paste0("V", 1:6), "SB-NA", "SB-A")  # 6 variedades + 2 adicionales
trampas <- c("TN", "TS", "TE", "TO", "TC1", "TC2")  # 6 trampas por parcela

# Enlace base de Google Drive
enlace_base <- "https://drive.google.com/drive/u/0/folders/"

# Define la carpeta raíz en Drive (reemplaza por tu carpeta principal)
carpeta_raiz <- as_id("1TdTl__GaQjIB4rCI3hWvJXssF2sLhnfx")

# Crear estructura de carpetas en Google Drive
for (b in bloques) {
  for (v in variedades) {
    for (t in trampas) {
      nombre_carpeta <- paste0("B", b, "-", v, "-", t)
      drive_mkdir(name = nombre_carpeta, path = carpeta_raiz)
    }
  }
}

################################# Para crear el código QR
###### Por verificar: la salida de los archivos .jpg: el problema es que Windows distuingue el "/" como código

# Generar QR para cada combinación de bloque, variedad y trampa
for (b in bloques) {
  for (v in variedades) {
    for (t in trampas) {
      
      # Crear el nombre de la carpeta (código)
      nombre_carpeta <- paste0("B", b, "-", v, "-", t)
      
      # Obtener el ID de la carpeta en Google Drive
      carpeta_id <- drive_get(nombre_carpeta)$id
      
      # Crear el enlace completo hacia la carpeta
      enlace_completo <- paste0(enlace_base, carpeta_id)
      
      # Generar el código QR y guardarlo como PNG
      png(paste0(nombre_carpeta, ".png"), width = 300, height = 300)
      qrcode::qr_code(enlace_completo, plotQRcode = TRUE)  # Generar el QR
      title(main = nombre_carpeta, cex.main = 1.5)  # Agregar el título encima
      dev.off()
    }
  }
}
##########################################
