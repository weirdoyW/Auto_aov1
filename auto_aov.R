auto_aov <- function(y,x,method = c("none", "bonferroni", "sidak",
                                    "holm", "hs", "hochberg", "bh",
                                    "by"),
                     p.adj=c("none","holm","hommel","hochberg",
                             "bonferroni", "BH", "BY", "fdr")){
  sht <- shapiro.test(resid(lm(y~x)))
  datf <- matrix(ncol = length(y))
  for (i in 1:length(y)) {
    datf[i] <- as.logical(y[i]>0)
  }
  if (length(datf[datf==T])==length(y)){
    if (sht$p.value > 0.05){
      bart <- bartlett.test(y~x)
      if (bart$p.value > 0.05){
        test0 <- aov(y~x)
        sutest0 <- summary(test0)
        print(sutest0)
        lm0 <- summary(lm(y~x))
        mse <- lm0$r.squared
        df <- lm0$df[2]
        multest0 <- LSD.test(y,x,MSerror = mse,DFerror = df,p.adj = p.adj)
        multest0
      }else{
        y0 <- log(y)
        bart <- bartlett.test(y0~x)
        if(bart$p.value > 0.05){
          test0 <- aov(y0~x)
          sutest0 <- summary(test0)
          print(sutest0)
          lm0 <- summary(lm(y0~x))
          mse <- lm0$r.squared
          df <- lm0$df[2]
          multest0 <- LSD.test(y0,x,MSerror = mse,DFerror = df,p.adj = p.adj)
          multest0
        }else{
          f1 <- kruskal.test(y~x)
          print(summary(f1))
          DB <- dunnTest(y~x,method = method)
          cld <- cldList(P.adj~Comparison,
                         data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                         threshold = 0.05 )
          cld
        }
      }
    }else{
      y0 <- log(y)
      sht <- shapiro.test(resid(lm(y0~x)))
      if (sht$p.value > 0.05){
        bart <- bartlett.test(y0~x)
        if (bart$p.value > 0.05){
          test0 <- aov(y0~x)
          sutest0 <- summary(test0)
          print(sutest0)
          lm0 <- summary(lm(y0~x))
          mse <- lm0$r.squared
          df <- lm0$df[2]
          multest0 <- LSD.test(y,x,MSerror = mse,DFerror = df,p.adj = p.adj)
          multest0
        }else{
          f1 <- kruskal.test(y~x)
          print(summary(f1))
          DB <- dunnTest(y~x,method = method)
          cld <- cldList(P.adj~Comparison,
                         data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                         threshold = 0.05 )
          cld
        }
      }else{
        f1 <- kruskal.test(y~x)
        print(summary(f1))
        DB <- dunnTest(y~x,method = method)
        cld <- cldList(P.adj~Comparison,
                       data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                       threshold = 0.05 )
        cld
      }
    }
  }else{
    f1 <- kruskal.test(y~x)
    print(summary(f1))
    DB <- dunnTest(y~x,method = method)
    cld <- cldList(P.adj~Comparison,
                   data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                   #?????ݽ???????
                   threshold = 0.05 )
    cld
  }
}




auto_aov0 <- function(y,x,method = c("none", "bonferroni", "sidak",
                                     "holm", "hs", "hochberg", "bh",
                                     "by"),
                      p.adj=c("none","holm","hommel","hochberg",
                              "bonferroni", "BH", "BY", "fdr")){
  sht <- shapiro.test(resid(lm(y~x)))
  if (sht$p.value > 0.05){
    bart <- bartlett.test(y~x)
    if (bart$p.value > 0.05){
      test0 <- aov(y~x)
      sutest0 <- summary(test0)
      print(sutest0)
      lm0 <- summary(lm(y~x))
      mse <- lm0$r.squared
      df <- lm0$df[2]
      multest0 <- LSD.test(y,x,MSerror = mse,DFerror = df,p.adj = p.adj)
      multest0
    }else{
      f1 <- kruskal.test(y~x)
      print(summary(f1))
      DB <- dunnTest(y~x,method = method)
      cld <- cldList(P.adj~Comparison,
                     data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                     threshold = 0.05 )
      cld
    }
  }else{
    f1 <- kruskal.test(y~x)
    print(summary(f1))
    DB <- dunnTest(y~x,method = method)
    cld <- cldList(P.adj~Comparison,
                   data = DB$res[order(DB$res$Z,decreasing = TRUE),],
                   threshold = 0.05 )
    cld
  }
}


auto_aov9 <- function(y,x,logif=F,method = c("none", "bonferroni", "sidak",
                                             "holm", "hs", "hochberg", "bh",
                                             "by"),
                      p.adj=c("none","holm","hommel","hochberg",
                              "bonferroni", "BH", "BY", "fdr")){
  library(FSA);library(agricolae);library(rcompanion)
  if(logif==F){
    auto_aov0(y,x,method = method,
              p.adj=p.adj)
  }else{
    auto_aov(y,x,method = method,
             p.adj=p.adj)
  }
}
