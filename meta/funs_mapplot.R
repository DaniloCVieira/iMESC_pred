getcolhabs<-function(newcolhabs,palette,n){
  newcolhabs[[palette]](n)
}


map_discrete_variable<-function(data,get,coords,base_shape=NULL,layer_shape=NULL,main="",size=.14,cex.main=15,cex.axes=13,cex.lab=15,cex.sub=14,cex.leg=11,cex.pt=7,subtitle="",leg="", factors=NULL,showcoords=F, cex.coords=NULL, col.coords="firebrick",col.palette='matlab.like2',col.fac="firebrick",symbol=15, scalesize_size=T,scalesize_color=T, points=T, cex.fac=4, as_factor=F,bmu=F, colored_by_factor=NULL,showguides=F, limits=NULL,layer_col="gray",lighten=0.5,base_col="white",base_lighten=1,newcolhabs){
  base_shape0<-base_shape
  layer_shape0<-layer_shape
  shapes<-get_shapes(base_shape,layer_shape,coords)
  base_shape<-shapes$base_shape
  layer_shape<-shapes$layer_shape
  BS_ggplot<-layer_shape




  if(isTRUE(as_factor)){
    scalesize_size=F
    scalesize_color=T
    if(isTRUE(bmu)){
      somprev<-somC$som.model$unit.classif
      names(somprev)<-names(somC[[1]])
      colhabs<-somC$colunits
      nlevels<-nrow(somC$som.model$grid$pts)
      name.var="bmu"
    } else{
      somprev<-as.numeric(as.factor(data[,get]))
      names(somprev)<-rownames(data[get])
      nlevels<-nlevels(as.factor(somprev))
      colhabs=getcolhabs(newcolhabs,col.palette,as.vector(nlevels))
      if(is.null(leg)){name.var=get} else {name.var=leg}
    }

    prev=newy<-factor(somprev, levels=1:nlevels)
    geopoint<-cbind(coords[names(prev),],prev)
    colnames(geopoint)<-c("x","y","pop")
    colfac= getcolhabs(newcolhabs,col.fac,as.vector(nlevels))[as.factor(prev)]
  } else{
    if(!is.null(factors)){

      colfac= getcolhabs(newcolhabs,col.fac,as.vector(nlevels(as.factor(factors))))[as.factor(factors)]
    }
  }


  if(!is.null(points)){
    geopoint<-cbind(coords[rownames(data),],data[,get])
    colnames(geopoint)<-c("x","y","pop")
    if(is.null(leg)){name.var=get} else {name.var=leg}
  }



  if(is.null(points)& as_factor==F)
  {
    geopoint<-cbind(coords[rownames(data),])
    colnames(geopoint)<-c("x","y")
    name.var=""

  }



  geopoint[geopoint==0]<-NA
  geopoint<-na.omit(geopoint)
  if(isTRUE(as_factor)){  mybreaks<-1:nlevels
  } else{
    if(is.factor(geopoint$pop)){ mybreaks<-1:nlevels(geopoint$pop)}else {
      if(! any(geopoint$pop<0)){

        mybreaks<-unique(round(quantile((geopoint$pop[which(geopoint$pop>0)]),c(0.1,0.25,0.5,0.75,1)),2))} else{
          mybreaks<- unique(round(quantile((geopoint$pop),c(0.1,0.25,0.5,0.75,1)),2))
        }
    }
  }

  if(is.null(limits)){
    limits<-st_bbox(base_shape)}
  xlimits<-limits[c(1,3)]
  ylimits<-limits[c(2,4)]
  bbox<-t(cbind(xlimits,ylimits))
  if(any(mybreaks==0)){mybreaks<-mybreaks[-which(mybreaks==0)]}

  suppressWarnings(st_crs(BS_ggplot)<-"+proj=longlat +datum=WGS84 +no_defs")

  p<-ggplot(st_as_sf(to_spatial(geopoint)))
  if(!is.null(layer_shape0)){
    p<-p+geom_sf(data=st_as_sf(layer_shape), fill=lighten(layer_col,lighten), lty=1)
  }


  if(!is.null(base_shape0)){
    p<-p+geom_sf(data=base_shape, fill=lighten(base_col,base_lighten), lty=1)
  }

  if(!is.null(colored_by_factor)){

    colfactor<-colored_by_factor[,1]
    names(colfactor)<-rownames(data[get])
    nlevels_fac<-nlevels(as.factor(colfactor))
    prev_fac<-colfactor
    col_pts=getcolhabs(newcolhabs,col.palette,as.vector(nlevels_fac))


    colorFAC<-  data.frame(prev_fac=levels(colfactor),col_pts, levels=1:nlevels(colfactor))



    geopoint_fac<-cbind(geopoint,fac=prev_fac[rownames(geopoint)])
    col_pts<-col_pts[rownames(geopoint_fac)]
  } else {col_pts=getcolhabs(newcolhabs,col.palette,100)[2]}


  if(!is.null(points)){
    if(isTRUE(scalesize_size)){
      if(isTRUE(scalesize_color))
      {  p <-  p+ geom_point( data=geopoint, aes(x=x, y=y, size=pop, col=pop), pch=symbol)
      } else if(isFALSE(scalesize_color)&is.null(colored_by_factor))
      {   p <- p+geom_point( data=geopoint, aes(x=x, y=y, size=pop), pch=symbol,color=col_pts)} else if(isFALSE(scalesize_color)&!is.null(colored_by_factor)){
        p <- p+geom_point( data=geopoint_fac, aes(x=x, y=y, size=pop, col=fac), pch=symbol)+ scale_color_manual(name=leg,labels =  colorFAC$prev_fac,values =  colorFAC$col_pts,drop=F )
      }

    } else  if(isFALSE(scalesize_size))
    {
      if(isTRUE(scalesize_color)){
        p<-  p+ geom_point( data=geopoint, aes(x=x, y=y,  col=pop), pch=symbol,size=cex.pt)} else if(isFALSE((scalesize_color))){
          if(!is.null(colored_by_factor)) {
            p <- p+geom_point( data=geopoint_fac, aes(x=x, y=y, col=fac), pch=symbol,size=cex.pt)+ scale_color_manual(name=leg,labels =  colorFAC$prev_fac,values =  colorFAC$col_pts,drop=F)
          } else {
            p<-   p+geom_point( data=geopoint, aes(x=x, y=y), pch=symbol,size=cex.pt, color=col_pts[rownames(geopoint)])
          }
        }
    }
  }

  p<-p  +
    scale_size(name=name.var, range=c(0,cex.pt))

  #scale_color_viridis(name=name.var, limits= range(mybreaks)) +
  if(is.null(colored_by_factor)){
    if(isTRUE(as_factor)){p<- p +   geom_point( data=geopoint, aes(x=x, y=y), pch=symbol, color=colhabs[as.factor(prev)]) }else{p<-p+scale_color_matlab(name=name.var, palette=col.palette,newcolhabs=newcolhabs) }
  }
  if(isTRUE(showguides)){
    xcoords<-pretty(coords[,1])
    ycoords<-pretty(coords[,2])
    p<-p+geom_hline(yintercept=ycoords,color = gray(.5), linetype = "dashed", size = .15)+
      geom_vline(xintercept =xcoords,color = gray(.5), linetype = "dashed", size = .15)
  }
  p<-p+
    #guides( colour = guide_legend())+

    annotation_scale(location = "br", width_hint = 0.15) +
    annotation_north_arrow(location = "tl", which_north = "true", pad_x = unit(.1, "in"), pad_y = unit(0.1, "in"), style = north_arrow_fancy_orienteering) +
    coord_sf(xlim = c(bbox[1,]), ylim = c(bbox[2,]), expand = FALSE) +


    xlab("Longitude") +
    ylab("Latitude") +
    ggtitle(main, subtitle = subtitle) +
    theme(panel.grid.major = element_blank(),

          panel.border = element_rect(fill=NA,color="black", size=0.5, linetype="solid"),
          axis.line=element_line(),
          axis.text=element_text(size=cex.axes),
          axis.title=element_text(size=cex.lab,face="bold"),
          plot.title=element_text(size=cex.main),
          plot.subtitle=element_text(size=cex.sub),
          legend.text=element_text(size=cex.leg),
          legend.title=element_text(size=cex.leg))
  if(!is.null(factors)){

    geopoint0<-cbind(coords[rownames(data),],factors)
    colnames(geopoint0)<-c("x","y","factors")
    p<-p+  geom_text( data=geopoint0, aes(x=x, y=y, label=factors,),size=cex.fac,colour=colfac)
  }
  if(isTRUE(showcoords)){
    geopoint0<-cbind(coords[rownames(data),],data[,get])
    colnames(geopoint0)<-c("x","y","pop")
    p<-p+geom_point( data=geopoint0, aes(x=x, y=y),  size=cex.coords, pch=3, colour=col.coords)

  }
  p
}


lighten <- function(color, factor = 0.5) {
  if ((factor > 1) | (factor < 0)) stop("factor needs to be within [0,1]")
  col <- col2rgb(color)
  col <- col + (255 - col)*factor
  col <- rgb(t(col), maxColorValue=255)
  col
}
to_spatial<-function(coords,  crs.info="+proj=longlat +datum=WGS84 +no_defs"){
  suppressWarnings({
    colnames(coords)[1:2]<-c("Long","Lat")
    coordinates(coords)<-~Long+Lat
    proj4string(coords) <-CRS(crs.info)
    return(coords)
  })
}
inline<-function (x) {
  tags$div(style="display:inline-block; margin: 0px", x)
}
inline2<-function (x) {
  tags$div(style="display:inline-block; margin-top: -100px", x)
}



scale_color_matlab<-function (..., alpha = 1, begin = 0, end = 1, direction = 1,discrete = FALSE, option = "D",palette=c(
  "matlab.like2",'viridis', 'plasma',"Rushmore1","FantasticFox1",'Grays',"heat",'Purples',"Blues",'Greens',"black","gray","royalblue", "firebrick","forestGreen",'goldenrod3',"white"),
  newcolhabs)
{

  if (discrete) {
    discrete_scale("colour", palette,  newcolhabs[[palette]], ...)
  } else {
    scale_color_gradientn(colours = do.call( newcolhabs[[palette]],args=list(n=256)),...)

  }
}




scale_color_2<-function (palette="viridis",newcolhabs)
{
  newcolhabs[[palette]](256)
}

