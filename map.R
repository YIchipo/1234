library(ggplot2)
library(maptools)
coor = read.csv('D:\\R\\beta\\xlsx\\coor.csv')
y = readShapePoly('D:\\中国gis\\gadm36_CHN_shp\\gadm36_CHN_2.shp')

y1 = subset(y,y$NAME_1=='Guangdong')
y1$NAME_2  #按照这个顺序输入你的数据
y2 = subset(y,y$NAME_1=='Guangxi')
y2$NAME_2
gddat=fortify(y1)
gddat = transform(gddat, id = iconv(id, from = 'GBK'), group = iconv(group, from =  'GBK'))

gxdat=fortify(y2)
gxdat = transform(gxdat, id = iconv(id, from = 'GBK'), group = iconv(group, from =  'GBK'))
names(gddat)[1:2]=c('x','y')
names(gxdat)[1:2]=c('x','y')
dx = rbind.data.frame(gddat,gxdat)
sub_gddat = data.frame(id = unique(sort(gddat$id)))

sub_gxdat = data.frame(id = unique(sort(gxdat$id)))
sub_dx = rbind.data.frame(sub_gddat,sub_gxdat)
sub_dx$income=rep(0,35)
gdmap = ggplot(dx) + geom_map(aes(map_id = id),color = "black",fill=NA,map = dx) +
   expand_limits(dx) 
  
gdmap + scale_y_continuous(name = 'Latitude') + scale_x_continuous(name = 'Longitude')
temp=coordinates(y1)
temp=as.data.frame(temp)
temp$name=c('潮州','东莞','佛山','广州','河源','惠州','江门','揭阳','茂名','梅州','清远 ','汕头','汕尾','韶关','深圳','阳江','云浮','湛江','肇庆','中山','珠海')
gdmap + geom_point(aes(x = Longitude,y = Latitude),color='red', family = "GB1", data = coor) +
  geom_text(aes(x = textx,y = texty,label = site), hjust = 0.5,family = "GB1", data = coor) 
#ggplot(gddat,aes(x=x,y=y,fill=NA)) + 
# geom_polygon() + 
 # geom_path(color='grey40') + 
 # scale_fill_manual(values = colors())
#gdmap = ggplot(sub_gddat) +geom_map(aes(map_id = id,fill = income), color = "black",  map = gddat) +
  #scale_fill_gradient(high = "white",low = "white")  +expand_limits(gddat)+geom_point(x=c(110.12,123),y=c(22.16,25),fill=NA)+
  #annotate("text",x=c(110.12,123),y=22.16,label="杭州市")
#print(gdmap)
#p <- ggplot(mtcars, aes(x = wt, y = mpg)) + geom_point()
#p + annotate("text", x = 4, y = 25, label = "Some text")
#p + annotate("text", x = 2:5, y = 25, label = "Some text")


#ggplot(sub_gddat) +geom_map(aes(map_id = id, fill = income), color = "black",  map = gddat) +
 # scale_fill_gradient(high = NA,low = NA)  +expand_limits(gddat) 

#ggplot(sub_dx,aes(x=x,y=y,fill=NA,group=id)) + 
  #geom_polygon() + 
  #geom_path(color='grey40') + 
  #scale_fill_manual(values = colors(),guide=FALSE)

#ggplot(sub_dx) +geom_map(aes(map_id = id,fill='income'),color = "black",map = dx) + scale_fill_gradient(high = 'white',low = 'white') + 
  #expand_limits(dx)
