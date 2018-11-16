suppressMessages(require(ggplot2))
suppressMessages(require(tidyr))

args <- commandArgs(trailingOnly=TRUE)
resourcedir <- "output"
pdfdir <- "pdf"
dir.create(pdfdir, showWarnings=FALSE)

for (lang in c("ja", "en")) {

    raw <- read.csv(paste(resourcedir, "/", "mean-", lang, ".csv", sep=""),
                    header=FALSE, sep=",")
    df <- data.frame(raw)
    colnames(df) <- c("Noun", "Verb", "Metric", "Mean")

    for (metric in c("comprehensibility", "metaphoricity", "novelty")) {

        filtered <- dplyr::filter(df, Metric == metric) %>%
                    dplyr::filter(Noun != "札束") %>%
                    dplyr::select(Noun, Verb, Mean)

        if (metric == "comprehensibility") {
            titlelabel <- "理解可能性"
            x <- read.csv(paste(resourcedir, "/",
                                "nouns-sorted-by-comprehensibility-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
            y <- read.csv(paste(resourcedir, "/",
                                "verbs-sorted-by-comprehensibility-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
        }
        if (metric == "metaphoricity") {
            titlelabel <- "メタファー性"
            x <- read.csv(paste(resourcedir, "/",
                                "nouns-sorted-by-metaphoricity-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
            y <- read.csv(paste(resourcedir, "/",
                                "verbs-sorted-by-metaphoricity-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
        }
        if (metric == "novelty") {
            titlelabel <- "新規性"
            x <- read.csv(paste(resourcedir, "/",
                                "nouns-sorted-by-comprehensibility-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
            y <- read.csv(paste(resourcedir, "/",
                                "verbs-sorted-by-comprehensibility-", lang, ".csv", sep=""),
                          header=FALSE, sep=",")$V1
        }

        if (lang == "ja") {
            xlabel <- "名詞"
            ylabel <- "動詞"
            guidetitle <- "得点"
            xhjust <- 0.5
            pdfheight <- 7
            pdfwidth <- 7
            font <- "Hiragino Kaku Gothic ProN W3"
        }
        if (lang == "en") {
            titlelabel <- paste(toupper(substr(metric, 1, 1)),
                                substr(metric, 2, nchar(metric)), sep="")
            xlabel <- "Noun"
            ylabel <- "Verbal phrase"
            guidetitle <- "Score"
            xhjust <- 0
            pdfheight <- 8
            pdfwidth <- 10.5
            font <- "HelveticaNeueLT Std"
        }


        g <- ggplot(filtered, aes(x=Noun, y=Verb, fill=Mean)) +
            geom_tile() +
            scale_x_discrete(limits=x) +
            scale_y_discrete(limits=rev(y)) +
            labs(title=titlelabel) +
            xlab(xlabel) +
            ylab(ylabel) +
            scale_fill_gradient2(low="#2c7bb6",
                                 mid="#ffffbf",
                                 high="#d7191c",
                                 midpoint=2,
                                 limit=c(0, 4),
                                 guide=guide_colourbar(title=guidetitle)) +
            theme(axis.text.x=element_text(size=10, colour="black", angle=90,
                                           hjust=xhjust, vjust=0.5),
                  axis.text.y=element_text(size=10, colour="black", hjust=0),
                  legend.position="right",
                  plot.title=element_text(hjust=0.5))

        cairo_pdf(paste(pdfdir, "/", metric, "-", lang, ".pdf", sep=""),
                  width=pdfwidth,
                  height=pdfheight,
                  family=font)
        plot(g)
        dev.off()
    }
}
