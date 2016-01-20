library(devtools)
install_github('armstrtw/rzmq')

install.packages(c('repr', 'IRkernel', 'IRdisplay'),
                 repos=c('http://irkernel.github.io',
                         'http://cran.rstudio.com'))

IRkernel::installspec()
