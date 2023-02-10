Exploring social status and envisioning potential for change in
Switzerland using Open Government Data from the Swiss Federal Office of
Statistics (BFS)
================
Philipp Baumann
Invalid Date

- <a href="#overview" id="toc-overview"><span
  class="toc-section-number">1</span> Overview</a>
  - <a href="#social-welfare" id="toc-social-welfare"><span
    class="toc-section-number">1.1</span> Social welfare</a>

``` {r}
#| echo: false
#| include: false
if (!require("reticulate")) install.packages("reticulate")
library("reticulate")
```

# Overview

The Swiss Federal Office of Statistics (BFS) provides a [PxWeb
Application Programming Interface
(API)](https://www.scb.se/en/services/open-data-api/api-for-the-statistical-database/).
[PxWeb](https://www.scb.se/pxweb) provides the foundation for doing web
requests to fetch data behind the BFS database in Switzerland over a web
interface. It aims to disseminate statistical data cubes and is
developed openly by Statistics Sweden.
[Here](https://www.scb.se/en/services/statistical-programs-for-px-files/px-web/pxweb-examples/)
is a nice oerview of organizations worldwide that use the PxWeb
framework for publishing and providing data.

Perhaps because both R and Python are lingua franca for statistics and
broader realms of data science, there is not surprisingly high-level
interfaces to provide barrier-free access to non-developers.

Here we focus on using
[{PxWeb}](https://cran.r-project.org/web/packages/pxweb/vignettes/pxweb.html)
together with [{BFS}](https://felixluginbuhl.com/BFS/) to access data
designated data from the BFS in Switzerland. Both packages are on CRAN
and under active development.

## Social welfare
