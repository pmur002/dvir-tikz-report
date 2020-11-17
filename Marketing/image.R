
## Image to add to the blog front page

## Based on R <-> TikZ image in report
## (but with better arrows)

library(dvir)

png("dvir.png", width=200, height=100)
grid.newpage()
grid.tikzpicture("
\\path (0, 0) node[circle,minimum size=.5in,fill=blue!20,draw,thick] (x) {\\sffamily{R}} 
       (3, 0) node[circle,minimum size=.5in,fill=blue!20,draw,thick] (y) {Ti{\\it k}Z!};
\\draw[-{Stealth[length=4mm]}, decorate, decoration={zigzag, post=curveto, post length=5mm}] (x) .. controls (1, 1) and (2, 1) .. (y);
\\draw[-{Stealth[length=4mm]}, decorate, decoration={zigzag, post=curveto, post length=5mm}] (y) .. controls (2, -1) and (1, -1) .. (x);
",
    preamble=tikzpicturePreamble(packages=c("decorations.pathmorphing",
                                            "arrows.meta")))
dev.off()
