install.packages(c('rzmq','repr','IRkernel','IRdisplay'),
                 repos=c('http://irkernel.github.io',
                         'http://cran.rstudio.com'))
IRkernel::installspec()
