dat = readLines("102年9月.txt", encoding = "UTF-8")
head(dat)

dat = readLines("102年9月.txt", encoding = "UTF-8")

dat1 = dat[grepl("經緯度：", dat)]
dat2 = gsub('經緯度：', "", dat1)
dat3 = strsplit(dat2, '、')

lat = rep(NA, length(dat3))
lon = rep(NA, length(dat3))

for (i in 1:length(dat3)) {
  
  if (grepl('南', dat3[[i]][[1]])) {lat_sign = -1} else {lat_sign = 1}
  current_lat = strsplit(dat3[[i]][[1]], '度')
  current_lat = gsub('北緯', '', current_lat[[1]])
  current_lat = gsub('南緯', '', current_lat)
  current_lat = gsub('分', '', current_lat)
  current_lat = as.numeric(current_lat)
  
  lat[i] = (current_lat[1] + current_lat[2] / 100) * lat_sign
  
  if (grepl('西', dat3[[i]][[2]])) {lon_sign = -1} else {lon_sign = 1}
  current_lon = strsplit(dat3[[i]][[2]], '度')
  current_lon = gsub('東經', '', current_lon[[1]])
  current_lon = gsub('西經', '', current_lon)
  current_lon = gsub('分', '', current_lon)
  current_lon = as.numeric(current_lon)
  
  lon[i] = (current_lon[1] + current_lon[2] / 100) * lon_sign
  
}

library(RgoogleMaps)

lon = c(107.02, 103.3444, 112.402, 117.417, 103.37, 104.05, 98.45)
lat = c(10.13, 1.0918, -7.099, -0.164, 1.07, 4.52, 3.58)

center = c(mean(lat), mean(lon))
zoom = min(MaxZoom(range(lat), range(lon)))

MysubMap = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')
PlotOnStaticMap(MysubMap)

PlotOnStaticMap(MysubMap, lat = lat, lon = lon, pch = 19, col = '#FF000080', add = TRUE)