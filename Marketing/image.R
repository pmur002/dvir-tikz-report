
## Image to add to the blog front page

## Based on R <-> TikZ image in report
## (but with better arrows)

library(dvir)

png("dvir.png", width=200, height=100, bg="white")
grid.newpage()
grid.tikzpicture("
\\path (0, 0) node[circle,minimum size=.5in,fill=blue!10,draw,thick] (x) {{\\sffamily R}} 
       (3, 0) node[circle,minimum size=.5in,fill=blue!10,draw,thick] (y) {Ti{\\it k}Z!};
\\draw[decorate, decoration={zigzag, post=curveto, post length=5mm}] (x) .. controls (1, 1) and (2, 1) .. (y);
\\draw[decorate, decoration={zigzag, post=curveto, post length=5mm}] (y) .. controls (2, -1) and (1, -1) .. (x);
",
    preamble=tikzpicturePreamble(packages=c("decorations.pathmorphing",
                                            "arrows.meta")))
## Draw R logo over text "R" ?
Rgrob <- grid.get("text", grep=TRUE)
library(png)
logo <- readPNG("Rlogo.png")
downViewport(Rgrob$vp)
grid.raster(logo,
            x=Rgrob$x + 0.5*stringWidth("R"),
            y=Rgrob$y + 0.5*stringHeight("R"),
            height=unit(7, "mm"),
            hjust=.55)
upViewport(0)
grid.remove("text", grep=TRUE)
## Draw better arrows ?
library(gridGeometry)
library(vwline)
edges <- grid.get("polyline", grep=TRUE, global=TRUE)
curveArrow <- function(i) {
    pts <- grobCoords(edges[[i]], closed=FALSE)
    segs <- trim(pts,
             from=unit(c(1, -3), c("npc", "mm")),
             to=unit(c(-4, -5), c("mm", "mm")))
    arrow1 <- offsetXsplineGrob(segs[[1]]$x, segs[[1]]$y, default.units="in",
                                shape=1,
                                w=widthSpline(unit(c(2, 0), "mm")))
    arrow2 <- offsetXsplineGrob(segs[[2]]$x, segs[[2]]$y, default.units="in",
                                shape=1,
                                w=widthSpline(unit(c(4, 0), "mm")))
    arrow <- polyclipGrob(arrow1, arrow2, "minus",
                          gp=gpar(fill="black"))
    grid.draw(arrow)
}
curveArrow(1)
curveArrow(2)
dev.off()
