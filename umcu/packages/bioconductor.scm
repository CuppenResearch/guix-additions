;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2016, 2017, 2018, 2019 Roel Janssen <roel@gnu.org>
;;;
;;; This file is not officially part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (umcu packages bioconductor)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system r)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bioconductor)
  #:use-module (gnu packages bioinformatics)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages c)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cran)
  #:use-module (gnu packages image)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages graph)
  #:use-module (gnu packages haskell)
  #:use-module (gnu packages java)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages web))

(define-public r-rmisc
  (package
  (name "r-rmisc")
  (version "1.5")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "Rmisc" version))
      (sha256
        (base32
          "1ijjhfy3v91fspid77rrkc5dkcb2lav37wc3f4k5lwrn24wzy5y8"))))
  (properties `((upstream-name . "Rmisc")))
  (build-system r-build-system)
  (propagated-inputs
   `(("r-plyr" ,r-plyr)
     ("r-rcpp" ,r-rcpp)
     ("r-lattice" ,r-lattice)))
  (home-page
    "http://cran.r-project.org/web/packages/Rmisc")
  (synopsis "Rmisc: Ryan Miscellaneous")
  (description "The Rmisc library contains functions for data analysis and
utility operations.")
  (license license:gpl3)))

(define-public r-spp
  (package
    (name "r-spp")
    (version "1.16.0")
    (source (origin
              (method url-fetch)
              (uri (cran-uri "spp" version))
              (sha256
               (base32
                "08zxxgyp0h6733b08jmml7k4rhfd3mi5dda3jrzid0s184y0z29w"))))
    (properties `((upstream-name . "spp")))
    (build-system r-build-system)
    (inputs `(("zlib" ,zlib)))
    (propagated-inputs
     `(("r-bh" ,r-bh)
       ("r-catools" ,r-catools)
       ("r-rcpp" ,r-rcpp)
       ("r-rsamtools" ,r-rsamtools)))
    (home-page "https://cran.r-project.org/web/packages/spp")
    (synopsis "ChIP-Seq Processing Pipeline")
    (description "Analysis of ChIP-seq and other functional sequencing
 data [Kharchenko PV (2008) <DOI:10.1038/nbt.1508>].")
    (license license:gpl2)))

(define-public r-phantompeakqualtools
  (package
    (name "r-phantompeakqualtools")
    (version "1.2.2")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/kundajelab/phantompeakqualtools/"
                    "archive/" version ".tar.gz"))
              (sha256
               (base32
                "1l8cw6g0z8c9vlw1s0q5rmh7lzasa67i7bkz9pf7psgg9av664mk"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (delete 'build)
         (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let ((script (string-append (assoc-ref outputs "out")
                                          "/share/scripts")))
               (install-file "run_spp.R" script)))))))
    (propagated-inputs
     `(("r-catools" ,r-catools)
       ("r-snow" ,r-snow)
       ("r-snowfall" ,r-snowfall)
       ("r-bitops" ,r-bitops)
       ("r-rsamtools" ,r-rsamtools)
       ("r-spp" ,r-spp)
       ("gawk" ,gawk)
       ("samtools" ,samtools)
       ("boost" ,boost)
       ("gzip" ,gzip)))
    (home-page "https://github.com/kundajelab/phantompeakqualtools")
    (synopsis "")
    (description "")
    (license #f)))

(define-public r-txdb-dmelanogaster-ucsc-dm3-ensgene
  (package
    (name "r-txdb-dmelanogaster-ucsc-dm3-ensgene")
    (version "3.2.2")
    (source (origin
              (method url-fetch)
              ;; We cannot use bioconductor-uri here because this tarball is
              ;; located under "data/annotation/" instead of "bioc/".
              (uri (string-append "http://bioconductor.org/packages/"
                                  "release/data/annotation/src/contrib"
                                  "/TxDb.Dmelanogaster.UCSC.dm3.ensGene_"
                                  "3.2.2.tar.gz"))
              (sha256
               (base32
                "1337x23rdmiiza83ms225kri37h16q5hw1lw0m577abcgip3d7c7"))))
    (properties
     `((upstream-name . "TxDb.Hsapiens.UCSC.hg19.knownGene")))
    (build-system r-build-system)
    ;; As this package provides little more than a very large data file it
    ;; doesn't make sense to build substitutes.
    (arguments `(#:substitutable? #f))
    (propagated-inputs
     `(("r-genomicfeatures" ,r-genomicfeatures)))
    (home-page
     "http://bioconductor.org/packages/TxDb.Dmelanogaster.UCSC.dm3.ensGene/")
    (synopsis "Annotation package for Dmelanogaster in TxDb format")
    (description
     "This package provides an annotation databases generated from UCSC by
exposing these as @code{TxDb} objects.")
    (license license:artistic2.0)))

(define-public r-ecp
  (package
    (name "r-ecp")
    (version "3.1.2")
    (source (origin
              (method url-fetch)
              (uri (cran-uri "ecp" version))
              (sha256
               (base32
                "11f9p869xr0zg779i46gmflxlq4xclk9wxbab0nj2fan26pn4sfy"))))
    (properties `((upstream-name . "ecp")))
    (build-system r-build-system)
    (propagated-inputs `(("r-rcpp" ,r-rcpp)))
    (home-page "https://cran.r-project.org/web/packages/ecp")
    (synopsis
     "Non-Parametric Multiple Change-Point Analysis of Multivariate Data")
    (description
     "This package provies an implementation of various procedures for finding
multiple change-points.  Two methods make use of dynamic programming and
pruning, with no distributional assumptions other than the existence of certain
absolute moments in one method.  Hierarchical and exact search methods are
included.  All methods return the set of estimated change- points as well as
other summary information.")
    (license license:gpl2+)))

(define-public r-aneufinderdata
  (package
   (name "r-aneufinderdata")
   (version "1.18.0")
   (source (origin
            (method url-fetch)
            (uri (bioconductor-uri "AneuFinderData" version 'experiment))
            (sha256
             (base32
              "02vb3kmza5hv8bc424fdmfif608xvpdb759w8882kac8izpv29ks"))))
   (build-system r-build-system)
   (home-page "https://bioconductor.org/packages/AneuFinderData/")
   (synopsis "Data package for AneuFinder")
   (description "This package contains data used by AneuFinder.")
   (license license:artistic2.0)))

(define-public r-aneufinder
  (package
    (name "r-aneufinder")
    (version "1.18.0")
    (source (origin
              (method url-fetch)
              (uri (bioconductor-uri "AneuFinder" version))
              (sha256
               (base32
                "1j2n6i3ja63i98y1mbb8ndn6cn2a0pw97zz6al4myycnv55w49j3"))))
    (build-system r-build-system)
    (native-inputs
     `(("r-knitr" ,r-knitr)))
    (propagated-inputs
     `(("r-genomicranges" ,r-genomicranges)
       ("r-aneufinderdata" ,r-aneufinderdata)
       ("r-ecp" ,r-ecp)
       ("r-foreach" ,r-foreach)
       ("r-doparallel" ,r-doparallel)
       ("r-biocgenerics" ,r-biocgenerics)
       ("r-s4vectors" ,r-s4vectors)
       ("r-genomeinfodb" ,r-genomeinfodb)
       ("r-iranges" ,r-iranges)
       ("r-rsamtools" ,r-rsamtools)
       ("r-bamsignals" ,r-bamsignals)
       ("r-dnacopy" ,r-dnacopy)
       ("r-biostrings" ,r-biostrings)
       ("r-genomicalignments" ,r-genomicalignments)
       ("r-ggplot2" ,r-ggplot2)
       ("r-reshape2" ,r-reshape2)
       ("r-ggdendro" ,r-ggdendro)
       ("r-ggrepel" ,r-ggrepel)
       ("r-reordercluster" ,r-reordercluster)
       ("r-mclust" ,r-mclust)
       ("r-cowplot" ,r-cowplot)))
    (home-page "https://bioconductor.org/packages/AneuFinder/")
    (synopsis "Copy number variation analysis in single-cell-sequencing data")
    (description "This package implements functions for copy number variant
calling, plotting, export and analysis from whole-genome single cell
sequencing data.")
    (license license:artistic2.0)))

(define-public r-aneufinder-umcu
  (package
    (name "r-aneufinder")
    (version "1.17.99-umcu")
    (source (origin
             (method git-fetch)
             (uri (git-reference
                   (url "https://github.com/UMCUGenetics/aneufinder.git")
                   (commit "67346eb8597a6328fdf186261f88815fe881271f")))
             (sha256
              (base32
               "0dxpqibmlm01jzjl8kif1077gr20k1ssrzj8b3la41x4s1p96mgl"))))
    (build-system r-build-system)
    (native-inputs
     `(("r-knitr" ,r-knitr)))
    (propagated-inputs
     `(("r-genomicranges" ,r-genomicranges)
       ("r-aneufinderdata" ,r-aneufinderdata)
       ("r-ecp" ,r-ecp)
       ("r-foreach" ,r-foreach)
       ("r-doparallel" ,r-doparallel)
       ("r-biocgenerics" ,r-biocgenerics)
       ("r-s4vectors" ,r-s4vectors)
       ("r-genomeinfodb" ,r-genomeinfodb)
       ("r-iranges" ,r-iranges)
       ("r-rsamtools" ,r-rsamtools)
       ("r-bamsignals" ,r-bamsignals)
       ("r-dnacopy" ,r-dnacopy)
       ("r-biostrings" ,r-biostrings)
       ("r-genomicalignments" ,r-genomicalignments)
       ("r-ggplot2" ,r-ggplot2)
       ("r-reshape2" ,r-reshape2)
       ("r-ggdendro" ,r-ggdendro)
       ("r-ggrepel" ,r-ggrepel)
       ("r-reordercluster" ,r-reordercluster)
       ("r-mclust" ,r-mclust)
       ("r-cowplot" ,r-cowplot)))
    (home-page "https://bioconductor.org/packages/AneuFinder/")
    (synopsis "Copy number variation analysis in single-cell-sequencing data")
    (description "This package contains a modified version of Aneufinder that
includes the GCSC correction method.  When in doubt, use the unmodified version
instead.")
    (license license:artistic2.0)))

(define-public r-bsgenome-btaurus-ucsc-bostau8
  (package
    (name "r-bsgenome-btaurus-ucsc-bostau8")
    (version "1.4.2")
    (source (origin
              (method url-fetch)
              ;; We cannot use bioconductor-uri here because this tarball is
              ;; located under "data/annotation/" instead of "bioc/".
              (uri (string-append "http://bioconductor.org/packages/"
                                  "release/data/annotation/src/contrib"
                                  "/BSgenome.Btaurus.UCSC.bosTau8_"
                                  version ".tar.gz"))
              (sha256
               (base32
                "16wjy1aw9nvx03r7w8yh5w7sw3pn8i9nczd0n0728l6nnyqxlsz6"))))
    (properties
     `((upstream-name . "SNPlocs.Hsapiens.dbSNP144.GRCh37")))
    (build-system r-build-system)
    ;; As this package provides little more than a very large data file it
    ;; doesn't make sense to build substitutes.
    (arguments `(#:substitutable? #f))
    (propagated-inputs `(("r-bsgenome" ,r-bsgenome)))
    (home-page "http://bioconductor.org/packages/BSgenome.Btaurus.UCSC.bosTau8")
    (synopsis "Full genome sequences for Bos taurus (UCSC version bosTau8)")
    (description "This package provides the full genome sequences for Bos
taurus (UCSC version bosTau8).")
    (license license:artistic2.0)))

(define-public r-glinternet
  (package
   (name "r-glinternet")
   (version "1.0.10")
   (source
    (origin
     (method url-fetch)
     (uri (cran-uri "glinternet" version))
     (sha256
      (base32
       "15dikazmhs7md7j8p45f67h3947br18hsrjl74cjk10vazd0ihng"))))
   (build-system r-build-system)
   (home-page "http://web.stanford.edu/~hastie/Papers/glinternet_jcgs.pdf")
   (synopsis "Learning interactions via hierarchical group-lasso regularization")
   (description "Group-Lasso INTERaction-NET.  Fits linear pairwise-interaction
models that satisfy strong hierarchy: if an interaction coefficient is estimated
to be nonzero, then its two associated main effects also have nonzero estimated
coefficients.  Accommodates categorical variables (factors) with arbitrary
numbers of levels, continuous variables, and combinations thereof.  Implements
the machinery described in the paper \"Learning interactions via hierarchical
group-lasso regularization\" (JCGS 2015, Volume 24, Issue 3).
Michael Lim & Trevor Hastie (2015)")
   (license license:gpl2)))

(define-public r-rms
(package
  (name "r-rms")
  (version "5.1-2")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "rms" version))
      (sha256
        (base32
          "01wjxlqfz6l1bdsvxqq0lsbps0k86hx3ayb6fl2n2hxccvsfxkzi"))))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-ggplot2" ,r-ggplot2)
      ("r-hmisc" ,r-hmisc)
      ("r-htmltable" ,r-htmltable)
      ("r-htmltools" ,r-htmltools)
      ("r-lattice" ,r-lattice)
      ("r-multcomp" ,r-multcomp)
      ("r-nlme" ,r-nlme)
      ("r-polspline" ,r-polspline)
      ("r-quantreg" ,r-quantreg)
      ("r-rpart" ,r-rpart)
      ("r-sparsem" ,r-sparsem)
      ("r-survival" ,r-survival)))
  (native-inputs `(("gfortran" ,gfortran)))
  (home-page
    "http://biostat.mc.vanderbilt.edu/rms")
  (synopsis "Regression Modeling Strategies")
  (description
    "Regression modeling, testing, estimation, validation, graphics, prediction, and typesetting by storing enhanced model design attributes in the fit.  'rms' is a collection of functions that assist with and streamline modeling.  It also contains functions for binary and ordinal logistic regression models, ordinal models for continuous Y with a variety of distribution families, and the Buckley-James multiple regression model for right-censored responses, and implements penalized maximum likelihood estimation for logistic and ordinary linear models.  'rms' works with almost any regression model, but it was especially written to work with binary or ordinal regression models, Cox regression, accelerated failure time models, ordinary linear models,\tthe Buckley-James model, generalized least squares for serially or spatially correlated observations, generalized linear models, and quantile regression.")
  (license license:gpl2+)))

(define-public r-multcomp
(package
  (name "r-multcomp")
  (version "1.4-8")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "multcomp" version))
      (sha256
        (base32
          "0fm78g4zjc6ank316qfw977864shmy890znn4fahwc8jjdhpc252"))))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-codetools" ,r-codetools)
      ("r-mvtnorm" ,r-mvtnorm)
      ("r-sandwich" ,r-sandwich)
      ("r-survival" ,r-survival)
      ("r-th-data" ,r-th-data)))
  (home-page
    "http://cran.r-project.org/web/packages/multcomp")
  (synopsis
    "Simultaneous Inference in General Parametric Models")
  (description
    "Simultaneous tests and confidence intervals for general linear hypotheses in parametric models, including linear, generalized linear, linear mixed effects, and survival models.  The package includes demos reproducing analyzes presented in the book \"Multiple Comparisons Using R\" (Bretz, Hothorn, Westfall, 2010, CRC Press).")
  (license license:gpl2)))

(define-public r-polspline
(package
  (name "r-polspline")
  (version "1.1.13")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "polspline" version))
      (sha256
        (base32
          "08hz6wlaipjss3cfk0dvr7yy6fc7cd4hqv9finj40kkm5n262xck"))))
  (build-system r-build-system)
  (native-inputs `(("gfortran" ,gfortran)))
  (home-page
    "http://cran.r-project.org/web/packages/polspline")
  (synopsis "Polynomial Spline Routines")
  (description
    "Routines for the polynomial spline fitting routines hazard regression, hazard estimation with flexible tails, logspline, lspec, polyclass, and polymars, by C.  Kooperberg and co-authors.")
  (license license:gpl2+)))

(define-public r-th-data
(package
  (name "r-th-data")
  (version "1.0-9")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "TH.data" version))
      (sha256
        (base32
          "03xfvww0krw0fn76qmmvrj7dx4shin57qafwhkrggfg25hbqlcfq"))))
  (properties `((upstream-name . "TH.data")))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-mass" ,r-mass) ("r-survival" ,r-survival)))
  (home-page
    "http://cran.r-project.org/web/packages/TH.data")
  (synopsis "TH's Data Archive")
  (description
    "Contains data sets used in other packages Torsten Hothorn maintains.")
  (license license:gpl3)))

(define-public r-pvclust
  (package
   (name "r-pvclust")
   (version "2.0-0")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "pvclust" version))
            (sha256
             (base32
              "0hfpf257k5f1w59m0zq6sk0gaamflc3ldkw6qzbpyc4j94hiaihs"))))
   (build-system r-build-system)
   (home-page "http://www.sigmath.es.osaka-u.ac.jp/shimo-lab/prog/pvclust/")
   (synopsis "Hierarchical clustering with P-values via multiscale bootstrap resampling")
   (description "An implementation of multiscale bootstrap resampling for
assessing the uncertainty in hierarchical cluster analysis.  It provides AU
(approximately unbiased) p-value as well as BP (bootstrap probability) value
for each cluster in a dendrogram.")
   (license license:gpl2+)))

(define-public r-model4you
(package
  (name "r-model4you")
  (version "0.9-2")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "model4you" version))
      (sha256
        (base32
          "0bi69s4bxdqfkjg7ldg41a72vsvqi6ipzqhfbk5jhj7avfa990b9"))))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-formula" ,r-formula)
      ("r-ggplot2" ,r-ggplot2)
      ("r-gridextra" ,r-gridextra)
      ("r-partykit" ,r-partykit)
      ("r-sandwich" ,r-sandwich)
      ("r-survival" ,r-survival)))
  (home-page
    "http://cran.r-project.org/web/packages/model4you")
  (synopsis
    "Stratified and Personalised Models Based on Model-Based Trees and Forests")
  (description
    "Model-based trees for subgroup analyses in clinical trials and model-based forests for the estimation and prediction of personalised treatment effects (personalised models).  Currently partitioning of linear models, lm(), generalised linear models, glm(), and Weibull models, survreg(), is supported.  Advanced plotting functionality is supported for the trees and a test for parameter heterogeneity is provided for the personalised models.  For details on model-based trees for subgroup analyses see Seibold, Zeileis and Hothorn (2016) <doi:10.1515/ijb-2015-0032>; for details on model-based forests for estimation of individual treatment effects see Seibold, Zeileis and Hothorn (2017) <doi:10.1177/0962280217693034>.")
  (license #f)))

(define-public r-apeglm
  (package
    (name "r-apeglm")
    (version "1.6.0")
    (source
     (origin
       (method url-fetch)
       (uri (bioconductor-uri "apeglm" version))
       (sha256
        (base32
         "0jx1xf83rvnpnphdz3s15lvx8hchs5yg825jzn2bszm0brq6bsqv"))))
    (build-system r-build-system)
        (home-page "https://bioconductor.org/packages/apeglm/")
    (propagated-inputs
     `(("r-emdbook",r-emdbook)
        ("r-summarizedexperiment" ,r-summarizedexperiment)
        ("r-genomicranges" ,r-genomicranges)
        ("r-rcppeigen" ,r-rcppeigen)
        ("r-rcppnumerical" ,r-rcppnumerical)
        ("r-rcpp" ,r-rcpp)))
  (synopsis "Approximate posterior estimation for GLM coefficients")
    (description "apeglm provides Bayesian shrinkage estimators for effect sizes for a variety of GLM models, using approximation of the posterior for individual coefficients.")
    (license license:gpl2)))

(define-public r-rcppnumerical
  (package
    (name "r-rcppnumerical")
    (version "0.3-3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "RcppNumerical" version))
        (sha256
          (base32
            "15qwjfwx6yrh9sl2gndqfxw0b3iwnkr2nrgrccb6phpj3pdp7vsq"))))
    (properties `((upstream-name . "RcppNumerical")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-rcpp" ,r-rcpp) ("r-rcppeigen" ,r-rcppeigen)))
    (home-page
      "https://github.com/yixuan/RcppNumerical")
    (synopsis
      "'Rcpp' Integration for Numerical Computing Libraries")
    (description
      "This package provides a collection of open source libraries for numerical computing (numerical integration, optimization, etc.) and their integration with 'Rcpp'.")
    (license license:gpl2+)))

(define-public r-decipher
  (package
    (name "r-decipher")
    (version "2.12.0")
    (source (origin
              (method url-fetch)
              (uri (bioconductor-uri "DECIPHER" version))
              (sha256
               (base32
                "01wdp8jb7ywha24vzgzpmqrkk1z6iyavfbf4bva3rcsj6bkch604"))))
    (build-system r-build-system)
    (propagated-inputs
     `(("r-biostrings" ,r-biostrings)
       ("r-rsqlite" ,r-rsqlite)))
    (home-page "http://bioconductor.org/packages/DECIPHER")
    (synopsis "Tools for deciphering and managing biological sequences")
    (description "This package provides a toolset for deciphering and managing
biological sequences.")
    (license license:gpl3)))

(define-public r-boruta
  (package
  (name "r-boruta")
  (version "6.0.0")
  (source
    (origin
      (method url-fetch)
      (uri (cran-uri "Boruta" version))
      (sha256
        (base32
          "1pp8zal1vhxlzdhl20phn39m3ffhw5glyqbcgwa0w14zw2mpm6hw"))))
  (properties `((upstream-name . "Boruta")))
  (build-system r-build-system)
  (propagated-inputs `(("r-ranger" ,r-ranger)))
  (home-page "https://notabug.org/mbq/Boruta/")
  (synopsis
    "Wrapper Algorithm for All Relevant Feature Selection")
  (description "An all relevant feature selection wrapper algorithm.
It finds relevant features by comparing original attributes' importance
with importance achievable at random, estimated using their permuted
copies (shadows).")
  (license license:gpl2+)))

(define-public r-geneoverlap
  (package
  (name "r-geneoverlap")
  (version "1.20.0")
  (source (origin
            (method url-fetch)
            (uri (bioconductor-uri "GeneOverlap" version))
            (sha256
             (base32
              "0nhikxwdd0zn8iw6rlg3dmh2gkrw8v9qzfnjabjj5a5qrd9xrv7v"))))
  (build-system r-build-system)
  (propagated-inputs
   `(("r-rcolorbrewer" ,r-rcolorbrewer)
     ("r-gplots" ,r-gplots)))
  (home-page "http://bioconductor.org/packages/GeneOverlap/")
  (synopsis "Test and visualize gene overlaps")
  (description "This package can be used to test two sets of gene lists
and visualize the results.")
  (license license:gpl3)))

(define-public r-chipseeker
  (package
  (name "r-chipseeker")
  (version "1.24.0")
  (source (origin
            (method url-fetch)
            (uri (bioconductor-uri "ChIPseeker" version))
            (sha256
             (base32
              "04lvw4bglab7vrhz5frn8vvp311dhr19ff2r97l1qharh22bnyq2"))))
  (build-system r-build-system)
  (inputs
   `(("r-knitr" ,r-knitr)))
  (propagated-inputs
   `(("r-annotationdbi" ,r-annotationdbi)
     ("r-biocgenerics" ,r-biocgenerics)
     ("r-boot" ,r-boot)
     ("r-enrichplot" ,r-enrichplot)
     ("r-iranges" ,r-iranges)
     ("r-genomeinfodb" ,r-genomeinfodb)
     ("r-genomicranges" ,r-genomicranges)
     ("r-genomicfeatures" ,r-genomicfeatures)
     ("r-ggplot2" ,r-ggplot2)
     ("r-gplots" ,r-gplots)
     ("r-gridbase" ,r-gridbase)
     ("r-gtools" ,r-gtools)
     ("r-dplyr" ,r-dplyr)
     ("r-plotrix" ,r-plotrix)
     ("r-dplyr" ,r-dplyr)
     ("r-magrittr" ,r-magrittr)
     ("r-rcolorbrewer" ,r-rcolorbrewer)
     ("r-rtracklayer" ,r-rtracklayer)
     ("r-s4vectors" ,r-s4vectors)
     ("r-txdb-hsapiens-ucsc-hg19-knowngene" ,r-txdb-hsapiens-ucsc-hg19-knowngene)
     ("r-upsetr" ,r-upsetr)))
  (home-page "http://bioconductor.org/packages/ChIPseeker/")
  (synopsis "ChIPseeker for ChIP peak Annotation, Comparison, and Visualization")
  (description "This package implements functions to retrieve the nearest genes
around the peak, annotate genomic region of the peak, statstical methods for
estimate the significance of overlap among ChIP peak data sets, and incorporate
GEO database for user to compare the own dataset with those deposited in database.
The comparison can be used to infer cooperative regulation and thus can be used to
generate hypotheses.  Several visualization functions are implemented to summarize
the coverage of the peak experiment, average profile and heatmap of peaks binding
to TSS regions, genomic annotation, distance to TSS, and overlap of peaks or
genes.")
  (license license:artistic2.0)))

(define-public r-graphite
  (package
    (name "r-graphite")
    (version "1.30.0")
    (source (origin
              (method url-fetch)
              (uri (bioconductor-uri "graphite" version))
              (sha256
               (base32
                "1sp2lplwwi70spzx8hfxyk1397zp1fx752wpnb1aasz5f2hpfv03"))))
    (build-system r-build-system)
    (propagated-inputs
     `(("r-annotationdbi" ,r-annotationdbi)
       ("r-checkmate" ,r-checkmate)
       ("r-graph" ,r-graph)
       ("r-httr" ,r-httr)
       ("r-rappdirs" ,r-rappdirs)))
    (home-page "https://guangchuangyu.github.io/software/ReactomePA")
    (synopsis "GRAPH Interaction from pathway Topological Environment")
    (description "Graph objects from pathway topology derived from Biocarta,
HumanCyc, KEGG, NCI, Panther, PathBank, PharmGKB, Reactome and SMPDB
databases.")
    (license license:agpl3)))

(define-public r-qvalue-2.14.0
  (package (inherit r-qvalue)
    (name "r-qvalue")
    (version "2.16.0")
    (source (origin
              (method url-fetch)
              (uri (bioconductor-uri "qvalue" version))
              (sha256
               (base32
                "00mahhwb4n2s6nycwkdkjs2qgyyyi7hyrby3qr269krprr6q3lh5"))))))

(define-public r-spdata
  (package
   (name "r-spdata")
   (version "0.3.2")
   (source
    (origin
     (method url-fetch)
     (uri (cran-uri "spData" version))
     (sha256
      (base32
       "190msrrpn226x27pcnck4ac34f9k4xcn26cyz2apdri2nzkr6zbw"))))
   (properties `((upstream-name . "spData")))
   (build-system r-build-system)
   (home-page "https://github.com/Nowosad/spData")
   (synopsis "Datasets for Spatial Analysis")
   (description
    "Diverse spatial datasets for demonstrating, benchmarking and teaching
spatial data analysis.  It includes R data of class sf (defined by the
package 'sf'), Spatial ('sp'), and nb ('spdep').  Unlike other spatial
data packages such as 'rnaturalearth' and 'maps', it also contains data
stored in a range of file formats including GeoJSON, ESRI Shapefile and
GeoPackage.  Some of the datasets are designed to illustrate specific
analysis techniques.  cycle_hire() and cycle_hire_osm(), for example, is
designed to illustrate point pattern analysis techniques.")
   (license #f)))

(define-public r-kegggraph
  (package
   (name "r-kegggraph")
   (version "1.44.0")
   (source (origin
            (method url-fetch)
            (uri (bioconductor-uri "KEGGgraph" version))
            (sha256
             (base32
              "1vrzblywl5vp3k4vvp9wx8r3479ahvxd4773bc9nrmlbriz8yz5w"))))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-xml", r-xml)
      ("r-rcurl" ,r-rcurl)
      ("r-graph", r-graph)))
   (home-page "http://bioconductor.org/packages/KEGGgraph/")
   (synopsis "KEGGgraph: A graph approach to KEGG PATHWAY")
   (description "KEGGGraph is an interface between KEGG pathway and graph object
as well as a collection of tools to analyze, dissect and visualize these graphs.
It parses the regularly updated KGML (KEGG XML) files into graph models
maintaining all essential pathway attributes. The package offers functionalities
including parsing, graph operation, visualization and etc.")
   (license license:gpl2)))

(define-public r-pathview
  (package
   (name "r-pathview")
   (version "1.24.0")
   (source (origin
            (method url-fetch)
            (uri (bioconductor-uri "pathview" version))
            (sha256
             (base32
              "12jswp402bwmw3hnia3y0lvklfjpldc0f2893ircqx76n9cm17d9"))))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-kegggraph", r-kegggraph)
      ("r-xml", r-xml)
      ("r-rgraphviz", r-rgraphviz)
      ("r-graph", r-graph)
      ("r-png", r-png)
      ("r-annotationdbi", r-annotationdbi)
      ("r-keggrest", r-keggrest)
      ("r-org-hs-eg-db", r-org-hs-eg-db)))
   (home-page "http://bioconductor.org/packages/pathview/")
   (synopsis "Toolset for pathway-based data integration and visualization")
   (description "Pathview is a tool set for pathway based data integration
and visualization.  It maps and renders a wide variety of biological data
on relevant pathway graphs. All users need is to supply their data and
specify the target pathway. Pathview automatically downloads the pathway
graph data, parses the data file, maps user data to the pathway, and render
pathway graph with the mapped data.  In addition, Pathview also seamlessly
integrates with pathway and gene set (enrichment) analysis tools for
 large-scale and fully automated analysis.")
   (license license:gpl3)))

(define-public r-deepsnv
  (package
   (name "r-deepsnv")
   (version "1.32.0")
   (source
    (origin
     (method url-fetch)
     (uri (bioconductor-uri "deepSNV" version))
     (sha256
      (base32
       "0kanxnb3xhhxki2b447lkcivh1jc3zgjbnam3m4dkp5nbb4yag49"))))
   (properties `((upstream-name . "deepSNV")))
   (build-system r-build-system)
   (inputs
    `(("zlib" ,zlib)))
   (propagated-inputs
    `(("r-biostrings" ,r-biostrings)
      ("r-genomicranges" ,r-genomicranges)
      ("r-iranges" ,r-iranges)
      ("r-rhtslib" ,r-rhtslib)
      ("r-summarizedexperiment" ,r-summarizedexperiment)
      ("r-variantannotation" ,r-variantannotation)
      ("r-vgam" ,r-vgam)))
   (home-page
    "http://github.com/gerstung-lab/deepSNV")
   (synopsis
    "Detection of subclonal SNVs in deep sequencing data.")
   (description
    "This package provides provides quantitative variant callers for detecting subclonal mutations in ultra-deep (>=100x coverage) sequencing experiments.  The deepSNV algorithm is used for a comparative setup with a control experiment of the same loci and uses a beta-binomial model and a likelihood ratio test to discriminate sequencing errors and subclonal SNVs.  The shearwater algorithm computes a Bayes classifier based on a beta-binomial model for variant calling with multiple samples for precisely estimating model parameters - such as local error rates and dispersion - and prior knowledge, e.g.  from variation data bases such as COSMIC.")
   (license license:gpl3)))

(define-public r-structuralvariantannotation-for-hmf-pipeline
  (package
    (name "r-structuralvariantannotation")
    (version "0.0.0-d6173c3")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
	     (url "https://github.com/PapenfussLab/StructuralVariantAnnotation.git")
	     (commit "d6173c3d9dd1fa314c91092b51920925b22268c6")))
       (sha256
	(base32
	 "12s4l5f778mnncbikqva941hzr07c59gnkd633hd03q3h57hm5xg"))))
    (build-system r-build-system)
    (propagated-inputs
     `(("r-biocgenerics" ,r-biocgenerics)
       ("r-biostrings" ,r-biostrings)
       ("r-devtools" ,r-devtools)
       ("r-dplyr" ,r-dplyr)
       ("r-genomicranges" ,r-genomicranges)
       ("r-roxygen2" ,r-roxygen2)
       ("r-rtracklayer" ,r-rtracklayer)
       ("r-s4vectors" ,r-s4vectors)
       ("r-stringr" ,r-stringr)
       ("r-testthat" ,r-testthat)
       ("r-assertthat" ,r-assertthat)
       ("r-variantannotation" ,r-variantannotation)))
    (home-page "https://github.com/PapenfussLab/StructuralVariantAnnotation")
    (synopsis "R package designed to simplify structural variant analysis")
    (description
     "This package contains useful helper functions for dealing with structural
variants in VCF format.  The packages contains functions for parsing VCFs from
a number of popular callers as well as functions for dealing with breakpoints
involving two separate genomic loci encoded as GRanges objects.")
    (license license:gpl3)))

(define-public r-structuralvariantannotation
  (package
    (name "r-structuralvariantannotation")
    (version "1.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (bioconductor-uri "StructuralVariantAnnotation" version))
       (sha256
        (base32
         "1qkr6mxqyknf0sgn7k7laqmwgf27g81d80k7qikxiln8fimwj8xa"))))
    (build-system r-build-system)
    (propagated-inputs
     `(("r-biocgenerics" ,r-biocgenerics)
       ("r-biostrings" ,r-biostrings)
       ("r-dplyr" ,r-dplyr)
       ("r-genomicranges" ,r-genomicranges)
       ("r-rtracklayer" ,r-rtracklayer)
       ("r-stringr" ,r-stringr)
       ("r-testthat" ,r-testthat)
       ("r-assertthat" ,r-assertthat)
       ("r-variantannotation" ,r-variantannotation)))
    (home-page "https://bioconductor.org/packages/StructuralVariantAnnotation/")
    (synopsis "R package designed to simplify structural variant analysis")
    (description
     "This package contains useful helper functions for dealing with structural
variants in VCF format.  The packages contains functions for parsing VCFs from
a number of popular callers as well as functions for dealing with breakpoints
involving two separate genomic loci encoded as GRanges objects.")
    (license license:gpl3)))

(define-public r-mutsigextractor
  (let ((commit "18deddb70ad29211d2b35b0ce564b829f2105a13"))
    (package
      (name "r-mutsigextractor")
      (version (string-append "0-" (string-take commit 7)))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/luannnguyen/mutSigExtractor.git")
                      (commit commit)))
                (file-name (string-append name "-" version "-checkout"))
                (sha256
                 (base32
                  "0pcxk5ay68mgf17zll4r46s44y06dj8i3070ifh5bqgpq91dgkzq"))))
      (build-system r-build-system)
      (propagated-inputs
       `(("r-genomicranges" ,r-genomicranges)
         ("r-variantannotation" ,r-variantannotation)
         ("r-bsgenome" ,r-bsgenome)
         ("r-bsgenome-hsapiens-ucsc-hg19" ,r-bsgenome-hsapiens-ucsc-hg19)))
      (home-page "https://github.com/luannnguyen/mutSigExtractor")
      (synopsis "Extracts SNV, indel, and SV signatures from VCF files")
      (description "More about what it does (maybe more than one line). Use four spaces when indenting paragraphs within the Description.")
      (license license:expat))))

(define-public r-hiddenmarkov
  (package
   (name "r-hiddenmarkov")
   (version "1.8-11")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "HiddenMarkov" version))
            (sha256
             (base32
              "1yh85pdb9r90qxcl5gxslyplxzrx8knrrsl2q65l57zfkqj185ja"))))
   (properties `((upstream-name . "HiddenMarkov")))
   (build-system r-build-system)
   (native-inputs
    `(("gfortran" ,gfortran)))
   (home-page "http://cran.r-project.org/web/packages/HiddenMarkov")
   (synopsis "Hidden Markov models")
   (description "This package contains functions for the analysis of Discrete
Time Hidden Markov Models, Markov Modulated GLMs and the Markov Modulated
Poisson Process.  It includes functions for simulation, parameter estimation,
and the Viterbi algorithm. See the topic 'HiddenMarkov' for an introduction to
the package, and 'Change Log' for a list of recent changes. The algorithms are
based of those of Walter Zucchini.")
   (license license:gpl2+)))

(define-public r-depmixs4
  (package
   (name "r-depmixs4")
   (version "1.4-0")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "depmixS4" version))
            (sha256
             (base32
              "0v8hvkg7ia7c6a0x7rw5fddm06vv1n0kwjk7g0kj3g18chvpnvw2"))))
   (properties
    `((upstream-name . "depmixS4")))
   (propagated-inputs
    `(("r-nnet" ,r-nnet)
      ("r-nlme" ,r-nlme)
      ("r-mass" ,r-mass)
      ("r-rsolnp" ,r-rsolnp)))
   (build-system r-build-system)
   (home-page "http://cran.r-project.org/web/packages/depmixS4")
   (synopsis "Dependent Mixture Models")
   (description "This package fits latent (hidden) Markov models on mixed
categorical and continuous (time series) data, otherwise known as dependent
mixture models.")
   (license license:gpl2+)))

(define-public r-rnmf
  (package
   (name "r-rnmf")
   (version "0.5.0")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "rNMF" version))
            (sha256
             (base32
              "1nz6h0j5ywdh48m0swmhp34hbkycd7n13rclrxaw85qi9wc42597"))))
   (properties
    `((upstream-name . "rNMF")))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-knitr" ,r-knitr)
      ("r-nnls" ,r-nnls)))
   (home-page "https://cran.r-project.org/web/packages/rNMF")
   (synopsis "Robust Nonnegative Matrix Factorization")
   (description
    "An implementation of robust nonnegative matrix factorization (rNMF).  The
rNMF algorithm decomposes a nonnegative high dimension data matrix into the
product of two low rank nonnegative matrices, while detecting and trimming
outliers.  The main function is rnmf().  The package also includes a
visualization tool, see(), that arranges and prints vectorized images.")
   (license license:gpl2+)))

(define-public r-protgenerics-1.17.4
  (let ((commit "8bc2a4193f416f62b35c2a346242d0e0152eaad0"))
    (package
      (name "r-protgenerics")
      (version (string-append "1.17.4-" (string-take commit 9)))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
               (url "https://github.com/lgatto/ProtGenerics.git")
               (commit commit)))
         (sha256
          (base32
           "1qp7ryp6c0zc8ag469ffcsmcmkln8d99002qb282da5c1xqp9jzh"))))
      (properties `((upstream-name . "ProtGenerics")))
      (build-system r-build-system)
      (home-page "https://github.com/lgatto/ProtGenerics")
      (synopsis "S4 generic functions for proteomics infrastructure")
      (description
       "This package provides S4 generic functions needed by Bioconductor
proteomics packages.")
      (license license:artistic2.0))))

(define-public r-loomr
  (package
   (name "r-loomr")
   (version "0.2.0-beta")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/mojaveazure/loomR/archive/"
                  version ".tar.gz"))
            (sha256
             (base32
              "1grchjgiky5siifkl9hmj6v0sf7q2by62rfdj2k8s2zhmrpgb0yw"))))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-hdf5r" ,r-hdf5r)
      ("r-r6" ,r-r6)
      ("r-iterators" ,r-iterators)
      ("r-itertools" ,r-itertools)
      ("r-matrix" ,r-matrix)))
   (home-page "http://loompy.org")
   (synopsis "R interface for loom files")
   (description "This package provides an interface for the single-cell
RNAseq-oriented loom format.  Loom files are an HDF5-based format for storing
and interacting with large single-cell RNAseq datasets.  This package provides
an interface for working with loom files in a loom-specific way; we provide
routines for validating loom files, iterating with chunks through data within
the loom file, and provide a platform for other packages to build support for
loom files.")
   ;; The author specified "GPL3" without intending to release the
   ;; code under "GPL3". The actual license is probably non-free,
   ;; so use of this package is highly discouraged.
   (license #f)))

(define-public r-tree
  (package
   (name "r-tree")
   (version "1.0-40")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "tree" version))
            (sha256
             (base32
              "1rr6ws62j9h36f3nl713f8h3ndkh95mv46l055jvgmby5lw1dazz"))))
   (properties `((upstream-name . "tree")))
   (build-system r-build-system)
   (home-page "https://cran.r-project.org/web/packages/tree")
   (synopsis "Classification and Regression Trees")
   (description "Classification and regression trees.")
   (license license:gpl2+)))

(define-public r-cummerbund
  (package
   (name "r-cummerbund")
   (version "2.28.0")
   (source (origin
             (method url-fetch)
             (uri (bioconductor-uri "cummeRbund" version))
             (sha256
              (base32
               "1fjc3bcclm4gsvw4nq6cv3a1kbrldvrxbkyfb9306708si1n4dwk"))))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-biobase" ,r-biobase)
      ("r-biocgenerics" ,r-biocgenerics)
      ("r-fastcluster", r-fastcluster)
      ("r-ggplot2" ,r-ggplot2)
      ("r-gviz" ,r-gviz)
      ("r-plyr" ,r-plyr)
      ("r-reshape2" ,r-reshape2)
      ("r-rsqlite" ,r-rsqlite)
      ("r-rtracklayer" ,r-rtracklayer)
      ("r-s4vectors" ,r-s4vectors)))
   (home-page "https://bioconductor.org/packages/cummeRbund/")
   (synopsis "Analyze Cufflinks high-throughput sequencing data")
   (description "This package allows for persistent storage, access,
exploration, and manipulation of Cufflinks high-throughput sequencing
data.  In addition, provides numerous plotting functions for commonly
used visualizations.")
   (license license:artistic2.0)))

(define-public r-km-ci
  (package
    (name "r-km-ci")
    (version "0.5-2")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "km.ci" version))
        (sha256
          (base32
            "1l6kw8jppaa1802yc5pbfwwgac56nhwc9p076ivylhms4w7cdf8v"))))
    (properties `((upstream-name . "km.ci")))
    (build-system r-build-system)
    (propagated-inputs `(("r-survival" ,r-survival)))
    (home-page
      "https://cran.r-project.org/web/packages/km.ci")
    (synopsis
      "Confidence intervals for the Kaplan-Meier estimator")
    (description
      "Computes various confidence intervals for the Kaplan-Meier estimator, namely: Petos CI, Rothman CI, CI's based on Greenwoods variance, Thomas and Grunkemeier CI and the simultaneous confidence bands by Nair and Hall and Wellner.")
    (license license:gpl2+)))

(define-public r-kmsurv
  (package
    (name "r-kmsurv")
    (version "0.1-5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "KMsurv" version))
        (sha256
          (base32
            "0hi5vvk584rl70gbrr75w9hc775xmbxnaig0dd6hlpi4071pnqjm"))))
    (properties `((upstream-name . "KMsurv")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/KMsurv")
    (synopsis
      "Data sets from Klein and Moeschberger (1997), Survival Analysis")
    (description
      "Data sets and functions for Klein and Moeschberger (1997), \"Survival Analysis, Techniques for Censored and Truncated Data\", Springer.")
    (license license:gpl3+)))

(define-public r-survmisc
  (package
    (name "r-survmisc")
    (version "0.5.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "survMisc" version))
        (sha256
          (base32
            "00nvvl8gz4477ab24rd0xvfksm8msv8h021b9ld5c9cizc41n2bm"))))
    (properties `((upstream-name . "survMisc")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-data-table" ,r-data-table)
        ("r-ggplot2" ,r-ggplot2)
        ("r-gridextra" ,r-gridextra)
        ("r-km-ci" ,r-km-ci)
        ("r-kmsurv" ,r-kmsurv)
        ("r-knitr" ,r-knitr)
        ("r-survival" ,r-survival)
        ("r-xtable" ,r-xtable)
        ("r-zoo" ,r-zoo)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://cran.r-project.org/web/packages/survMisc")
    (synopsis
      "Miscellaneous Functions for Survival Data")
    (description
      "This package provides a collection of functions to help in the analysis of right-censored survival data.  These extend the methods available in package:survival.")
    (license license:gpl2)))

(define-public r-exactranktests
  (package
    (name "r-exactranktests")
    (version "0.8-31")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "exactRankTests" version))
        (sha256
          (base32
            "1154dkcid3njhamdp87qs9bnx7l8bdqkcjsds9q9f2xmizs9x8gw"))))
    (properties
      `((upstream-name . "exactRankTests")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/exactRankTests")
    (synopsis
      "Exact Distributions for Rank and Permutation Tests")
    (description
      "Computes exact conditional p-values and quantiles using an implementation of the Shift-Algorithm by Streitberg & Roehmel.")
    (license license:gpl2+)))

(define-public r-maxstat
  (package
    (name "r-maxstat")
    (version "0.7-25")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "maxstat" version))
        (sha256
          (base32
            "114z1rwxwvk05ijjhdppzm148n1h192fp0w12ky10zkrhf6kphbg"))))
    (properties `((upstream-name . "maxstat")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-exactranktests" ,r-exactranktests)
        ("r-mvtnorm" ,r-mvtnorm)))
    (home-page
      "https://cran.r-project.org/web/packages/maxstat")
    (synopsis "Maximally Selected Rank Statistics")
    (description
      "Maximally selected rank statistics with several p-value approximations.")
    (license license:gpl2+)))

(define-public r-survminer
  (package
    (name "r-survminer")
    (version "0.4.7")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "survminer" version))
        (sha256
          (base32
            "1pdj3gs4aii8gn8wf4smbwmjymbzwkjwr3kxf90dxyy6i66mqq3v"))))
    (properties `((upstream-name . "survminer")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-broom" ,r-broom)
        ("r-dplyr" ,r-dplyr)
        ("r-ggplot2" ,r-ggplot2)
        ("r-ggpubr" ,r-ggpubr)
        ("r-gridextra" ,r-gridextra)
        ("r-magrittr" ,r-magrittr)
        ("r-maxstat" ,r-maxstat)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-scales" ,r-scales)
        ("r-survival" ,r-survival)
        ("r-survmisc" ,r-survmisc)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "http://www.sthda.com/english/rpkgs/survminer/")
    (synopsis
      "Drawing Survival Curves using 'ggplot2'")
    (description
      "Contains the function 'ggsurvplot()' for drawing easily beautiful and 'ready-to-publish' survival curves with the 'number at risk' table and 'censoring count plot'.  Other functions are also available to plot adjusted curves for `Cox` model and to visually examine 'Cox' model assumptions.")
    (license license:gpl2)))

(define-public r-heatmap3
  (package
   (name "r-heatmap3")
   (version "1.1.7")
   (source
    (origin
     (method url-fetch)
     (uri (cran-uri "heatmap3" version))
     (sha256
      (base32
       "1gdjc5b4f4nf5zpfdl0ch352p3bwbcw5hkd5vlarxvb2qkf9pcxs"))))
   (properties `((upstream-name . "heatmap3")))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-fastcluster" ,r-fastcluster)))
   (native-inputs
    `(("r-knitr" ,r-knitr)))
   (home-page "https://cran.r-project.org/web/packages/heatmap3")
   (synopsis "Improved Heatmap Package")
   (description
    "An improved heatmap package.  Completely compatible with the original
R function 'heatmap', and provides more powerful and convenient features.")
   (license license:gpl2+)))

(define-public r-naniar
  (package
    (name "r-naniar")
    (version "0.5.2")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "naniar" version))
        (sha256
          (base32
            "02b4mmb69k2scbr7lq83ymv782x1kd5i1z3b2863c2c6zwgilngb"))))
    (properties `((upstream-name . "naniar")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-forcats" ,r-forcats)
        ("r-ggplot2" ,r-ggplot2)
        ("r-glue" ,r-glue)
        ("r-magrittr" ,r-magrittr)
        ("r-purrr" ,r-purrr)
        ("r-rlang" ,r-rlang)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)
        ("r-upsetr" ,r-upsetr)
        ("r-viridis" ,r-viridis)
        ("r-visdat" ,r-visdat)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/njtierney/naniar")
    (synopsis
      "Data Structures, Summaries, and Visualisations for Missing Data")
    (description
      "Missing values are ubiquitous in data and need to be explored and
handled in the initial stages of analysis. 'naniar' provides data structures
and functions that facilitate the plotting of missing values and examination
of imputations.  This allows missing data dependencies to be explored with
minimal deviation from the common work patterns of 'ggplot2' and tidy data.
The work is fully discussed at Tierney & Cook (2018) <arXiv:1809.02264>.")
    (license expat)))

(define-public r-visdat
  (package
    (name "r-visdat")
    (version "0.5.3")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "visdat" version))
        (sha256
          (base32
            "1ikqp29nncbw1xlwyb9dqqgcdk9q0bs3wxhnhnjpb11vcjv7cz2j"))))
    (properties `((upstream-name . "visdat")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-dplyr" ,r-dplyr)
        ("r-ggplot2" ,r-ggplot2)
        ("r-glue" ,r-glue)
        ("r-magrittr" ,r-magrittr)
        ("r-purrr" ,r-purrr)
        ("r-readr" ,r-readr)
        ("r-tibble" ,r-tibble)
        ("r-tidyr" ,r-tidyr)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "http://visdat.njtierney.com/")
    (synopsis "Preliminary Visualisation of Data")
    (description
      "Create preliminary exploratory data visualisations of an entire dataset
to identify problems or unexpected features using 'ggplot2'.")
    (license expat)))

(define-public r-ashr
  (package
    (name "r-ashr")
    (version "2.2-47")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "ashr" version))
        (sha256
          (base32
            "1rqb5j30ylaf1h4l66x4jxyn5inrvhc42d90qd5mgkxsq0ghdlr4"))))
    (properties `((upstream-name . "ashr")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-etrunct" ,r-etrunct)
        ("r-invgamma" ,r-invgamma)
        ("r-matrix" ,r-matrix)
        ("r-mixsqp" ,r-mixsqp)
        ("r-rcpp" ,r-rcpp)
        ("r-squarem" ,r-squarem)
        ("r-truncnorm" ,r-truncnorm)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/stephens999/ashr")
    (synopsis
      "Methods for Adaptive Shrinkage, using Empirical Bayes")
    (description
      "The R package 'ashr' implements an Empirical Bayes approach for large-scale hypothesis testing and false discovery rate (FDR) estimation based on the methods proposed in M.  Stephens, 2016, \"False discovery rates: a new deal\", <DOI:10.1093/biostatistics/kxw041>.  These methods can be applied whenever two sets of summary statistics---estimated effects and standard errors---are available, just as 'qvalue' can be applied to previously computed p-values.  Two main interfaces are provided: ash(), which is more user-friendly; and ash.workhorse(), which has more options and is geared toward advanced users.  The ash() and ash.workhorse() also provides a flexible modeling interface that can accommodate a variety of likelihoods (e.g., normal, Poisson) and mixture priors (e.g., uniform, normal).")
    (license expat)))

(define-public r-etrunct
  (package
    (name "r-etrunct")
    (version "0.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "etrunct" version))
        (sha256
          (base32
            "0ayazgyqlc8jcqr03cwfmfhm4pck6xri1r6vkgqy4arqkrrnrcqr"))))
    (properties `((upstream-name . "etrunct")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/etrunct")
    (synopsis
      "Computes Moments of Univariate Truncated t Distribution")
    (description
    "Computes moments of univariate truncated t distribution.  There is only one exported function, e_trunct(), which should be seen for details.")
    (license expat)))

(define-public r-invgamma
  (package
    (name "r-invgamma")
    (version "1.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "invgamma" version))
        (sha256
          (base32
            "12ga2y4wc9bc5zz6vimvxwgjpsx3ys3209nq63gscbw559ydxa5a"))))
    (properties `((upstream-name . "invgamma")))
    (build-system r-build-system)
    (home-page "https://github.com/dkahle/invgamma")
    (synopsis "The Inverse Gamma Distribution")
    (description
    "Light weight implementation of the standard distribution functions for the inverse gamma distribution, wrapping those for the gamma distribution in the stats package.")
    (license expat)))

(define-public r-mixsqp
  (package
    (name "r-mixsqp")
    (version "0.3-43")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "mixsqp" version))
        (sha256
          (base32
            "1qics04w0swyp216d6g8dmsph8q2kpadpacp66h2qih3521js12q"))))
    (properties `((upstream-name . "mixsqp")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-irlba" ,r-irlba)
        ("r-rcpp" ,r-rcpp)
        ("r-rcpparmadillo" ,r-rcpparmadillo)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/stephenslab/mixsqp")
    (synopsis
      "Sequential Quadratic Programming for Fast Maximum-Likelihood Estimation of Mixture Proportions")
    (description
      "This package provides an optimization method based on sequential quadratic programming (SQP) for maximum likelihood estimation of the mixture proportions in a finite mixture model where the component densities are known.  The algorithm is expected to obtain solutions that are at least as accurate as the state-of-the-art MOSEK interior-point solver (called by function \"KWDual\" in the 'REBayes' package), and they are expected to arrive at solutions more quickly when the number of samples is large and the number of mixture components is not too large.  This implements the \"mix-SQP\" algorithm, with some improvements, described in Y.  Kim, P.  Carbonetto, M.  Stephens & M.  Anitescu (2020) <DOI:10.1080/10618600.2019.1689985>.")
    (license expat)))

(define-public r-rnexml
  (package
    (name "r-rnexml")
    (version "2.4.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "RNeXML" version))
        (sha256
          (base32
            "1wsl4xq9w5bp3wk69dw57bg0qcw1vs6ajwya4p0w1r00ck5pwrib"))))
    (properties `((upstream-name . "RNeXML")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-ape" ,r-ape)
        ("r-dplyr" ,r-dplyr)
        ("r-httr" ,r-httr)
        ("r-lazyeval" ,r-lazyeval)
        ("r-plyr" ,r-plyr)
        ("r-reshape2" ,r-reshape2)
        ("r-stringi" ,r-stringi)
        ("r-stringr" ,r-stringr)
        ("r-tidyr" ,r-tidyr)
        ("r-uuid" ,r-uuid)
        ("r-xml" ,r-xml)
        ("r-xml2" ,r-xml2)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://docs.ropensci.org/RNeXML")
    (synopsis
      "Semantically Rich I/O for the 'NeXML' Format")
    (description
      "This package provides access to phyloinformatic data in 'NeXML' format.  The package should add new functionality to R such as the possibility to manipulate 'NeXML' objects in more various and refined way and compatibility with 'ape' objects.")
    (license license:bsd-3)))
 
(define-public r-rncl
  (package
    (name "r-rncl")
    (version "0.8.4")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "rncl" version))
        (sha256
          (base32
            "0ss9jqrvv7bhvl5j74cjrp8r866d9dlavrbbfscwz3mhkgfx06bb"))))
    (properties `((upstream-name . "rncl")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-progress" ,r-progress) ("r-rcpp" ,r-rcpp)))
    (home-page "https://github.com/fmichonneau/rncl")
    (synopsis
      "An Interface to the Nexus Class Library")
    (description
      "An interface to the Nexus Class Library which allows parsing of NEXUS, Newick and other phylogenetic tree file formats.  It provides elements of the file that can be used to build phylogenetic objects such as ape's 'phylo' or phylobase's 'phylo4(d)'.  This functionality is demonstrated with 'read_newick_phylo()' and 'read_nexus_phylo()'.")
    (license license:bsd-2)))
 
(define-public r-phylobase
  (package
    (name "r-phylobase")
    (version "0.8.10")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "phylobase" version))
        (sha256
          (base32
            "0jzr1gdvmi4l640hwwzh9bxqmpja69bn3ygnaqx37awvyh7khi2s"))))
    (properties `((upstream-name . "phylobase")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-ade4" ,r-ade4)
        ("r-ape" ,r-ape)
        ("r-rcpp" ,r-rcpp)
        ("r-rncl" ,r-rncl)
        ("r-rnexml" ,r-rnexml)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://github.com/fmichonneau/phylobase")
    (synopsis
      "Base Package for Phylogenetic Structures and Comparative Data")
    (description
      "This package provides a base S4 class for comparative methods, incorporating one or more trees and trait data.")
    (license license:gpl2+)))
 
(define-public r-zinbwave
  (package
    (name "r-zinbwave")
    (version "1.10.0")
    (source
      (origin
        (method url-fetch)
        (uri (bioconductor-uri "zinbwave" version))
        (sha256
          (base32
            "16giyks17hv6svl9kvhgd2vp14mbg3b3bp7z16bzcjf9adhf0wi5"))))
    (properties `((upstream-name . "zinbwave")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-biocparallel" ,r-biocparallel)
        ("r-edger" ,r-edger)
        ("r-genefilter" ,r-genefilter)
        ("r-matrix" ,r-matrix)
        ("r-singlecellexperiment"
         ,r-singlecellexperiment)
        ("r-softimpute" ,r-softimpute)
        ("r-summarizedexperiment"
         ,r-summarizedexperiment)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://bioconductor.org/packages/zinbwave")
    (synopsis
      "Zero-Inflated Negative Binomial Model for RNA-Seq Data")
    (description
      " Implements a general and flexible zero-inflated negative binomial model that can be used to provide a low-dimensional representations of single-cell RNA-seq data.  The model accounts for zero inflation (dropouts), over-dispersion, and the count nature of the data.  The model also accounts for the difference in library sizes and optionally for batch effects and/or other covariates, avoiding the need for pre-normalize the data.")
    (license license:artistic2.0)))
 
(define-public r-locfdr
  (package
    (name "r-locfdr")
    (version "1.1-8")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "locfdr" version))
        (sha256
          (base32
            "1falkbp2xz07am8jlhwlvyqvxnli4nwl188kd0g58vdfjcjy3mj2"))))
    (properties `((upstream-name . "locfdr")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/locfdr")
    (synopsis "Computes Local False Discovery Rates")
    (description
      "Computation of local false discovery rates.")
    (license license:gpl2)))
 
(define-public r-howmany
  (package
    (name "r-howmany")
    (version "0.3-1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "howmany" version))
        (sha256
          (base32
            "045ck8qahfg2swbgyf7dpl32ryq1m4sbalhr7m5qdgpm62vz8h7f"))))
    (properties `((upstream-name . "howmany")))
    (build-system r-build-system)
    (home-page
      "http://www.stats.ox.ac.uk/~meinshau/")
    (synopsis
      "A lower bound for the number of correct rejections")
    (description
      "When testing multiple hypotheses simultaneously, this package provides functionality to calculate a lower bound for the number of correct rejections (as a function of the number of rejected hypotheses), which holds simultaneously -with high probability- for all possible number of rejections.  As a special case, a lower bound for the total number of false null hypotheses can be inferred.  Dependent test statistics can be handled for multiple tests of associations.  For independent test statistics, it is sufficient to provide a list of p-values.")
    (license (list license:gpl2+ license:gpl3+))))
 
(define-public r-clusterexperiment
  (package
    (name "r-clusterexperiment")
    (version "2.8.0")
    (source
      (origin
        (method url-fetch)
        (uri (bioconductor-uri "clusterExperiment" version))
        (sha256
          (base32
            "1ib4j5xfdx6pxgxl86dir8275k3s4xzxjzvrh7d61hb81gdyk0mw"))))
    (properties
      `((upstream-name . "clusterExperiment")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-ape" ,r-ape)
        ("r-biocgenerics" ,r-biocgenerics)
        ("r-cluster" ,r-cluster)
        ("r-delayedarray" ,r-delayedarray)
        ("r-edger" ,r-edger)
        ("r-hdf5array" ,r-hdf5array)
        ("r-howmany" ,r-howmany)
        ("r-kernlab" ,r-kernlab)
        ("r-limma" ,r-limma)
        ("r-locfdr" ,r-locfdr)
        ("r-matrix" ,r-matrix)
        ("r-matrixstats" ,r-matrixstats)
        ("r-nmf" ,r-nmf)
        ("r-phylobase" ,r-phylobase)
        ("r-pracma" ,r-pracma)
        ("r-rcolorbrewer" ,r-rcolorbrewer)
        ("r-rcpp" ,r-rcpp)
        ("r-rspectra" ,r-rspectra)
        ("r-s4vectors" ,r-s4vectors)
        ("r-scales" ,r-scales)
        ("r-singlecellexperiment"
         ,r-singlecellexperiment)
        ("r-stringr" ,r-stringr)
        ("r-summarizedexperiment"
         ,r-summarizedexperiment)
        ("r-zinbwave" ,r-zinbwave)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://bioconductor.org/packages/clusterExperiment")
    (synopsis
      "Compare Clusterings for Single-Cell Sequencing")
    (description
      "This package provides functionality for running and comparing many different clusterings of single-cell sequencing data or other large mRNA Expression data sets.")
    (license license:artistic2.0)))
 
(define-public r-princurve
  (package
    (name "r-princurve")
    (version "2.1.5")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "princurve" version))
        (sha256
          (base32
            "0ifjwdpvydhn60aya84f5j0ymsq427j89j9a3g8pbigk6qnxj0g5"))))
    (properties `((upstream-name . "princurve")))
    (build-system r-build-system)
    (propagated-inputs `(("r-rcpp" ,r-rcpp)))
    (home-page
      "https://github.com/rcannood/princurve")
    (synopsis
      "Fit a Principal Curve in Arbitrary Dimension")
    (description
      "Fitting a principal curve to a data matrix in arbitrary dimensions.  Hastie and Stuetzle (1989) <doi:10.2307/2289936>.")
    (license license:gpl2)))
 
(define-public r-slingshot
  (package
    (name "r-slingshot")
    (version "1.6.1")
    (source
      (origin
        (method url-fetch)
        (uri (bioconductor-uri "slingshot" version))
        (sha256
          (base32
            "0gh91fkikw7y22sb00yvbjjssr64f4swikcz2ydri84c4jv8nvqa"))))
    (properties `((upstream-name . "slingshot")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-ape" ,r-ape)
        ("r-igraph" ,r-igraph)
        ("r-matrixstats" ,r-matrixstats)
        ("r-princurve" ,r-princurve)
        ("r-singlecellexperiment"
         ,r-singlecellexperiment)
        ("r-summarizedexperiment"
         ,r-summarizedexperiment)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://bioconductor.org/packages/slingshot")
    (synopsis
      "Tools for ordering single-cell sequencing")
    (description
      "This package provides functions for inferring continuous, branching lineage structures in low-dimensional data.  Slingshot was designed to model developmental trajectories in single-cell RNA sequencing data and serve as a component in an analysis pipeline after dimensionality reduction and clustering.  It is flexible enough to handle arbitrarily many branching events and allows for the incorporation of prior knowledge through supervised graph construction.")
    (license license:artistic2.0)))
 
(define-public r-tradeseq
  (package
    (name "r-tradeseq")
    (version "1.2.01")
    (source
      (origin
        (method url-fetch)
        (uri (bioconductor-uri "tradeSeq" version))
        (sha256
          (base32
            "1jqy2xn58j89lfsah9gvkphq9a5a8s7h6g5025r13n7ksh3whfbp"))))
    (properties `((upstream-name . "tradeSeq")))
    (build-system r-build-system)
    (propagated-inputs
      `(("r-biobase" ,r-biobase)
        ("r-biocparallel" ,r-biocparallel)
        ("r-clusterexperiment" ,r-clusterexperiment)
        ("r-dplyr" ,r-dplyr)
        ("r-edger" ,r-edger)
        ("r-ggplot2" ,r-ggplot2)
        ("r-igraph" ,r-igraph)
        ("r-magrittr" ,r-magrittr)
        ("r-mgcv" ,r-mgcv)
        ("r-monocle" ,r-monocle)
        ("r-pbapply" ,r-pbapply)
        ("r-princurve" ,r-princurve)
        ("r-rcolorbrewer" ,r-rcolorbrewer)
        ("r-s4vectors" ,r-s4vectors)
        ("r-singlecellexperiment"
         ,r-singlecellexperiment)
        ("r-slingshot" ,r-slingshot)
        ("r-summarizedexperiment"
         ,r-summarizedexperiment)
        ("r-tibble" ,r-tibble)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page
      "https://statomics.github.io/tradeSeq/index.html")
    (synopsis
      "trajectory-based differential expression analysis for sequencing data")
    (description
      "tradeSeq provides a flexible method for fitting regression models that can be used to find genes that are differentially expressed along one or multiple lineages in a trajectory.  Based on the fitted models, it uses a variety of tests suited to answer different questions of interest, e.g.  the discovery of genes for which expression is associated with pseudotime, or which are differentially expressed (in a specific region) along the trajectory.  It fits a negative binomial generalized additive model (GAM) for each gene, and performs inference on the parameters of the GAM.")
    (license expat)))

(define-public r-nnlm
  (package
  (name "r-nnlm")
  (version "0.4.3")
  (source
    (origin
      (method url-fetch)
      (uri "https://cran.r-project.org/src/contrib/Archive/NNLM/NNLM_0.4.3.tar.gz")
      (sha256
        (base32
          "0p7p26070w2j57z5i89pmpgd470yh2z0rrfzpalzdngc8mzp2rkj"))))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-rcpp",r-rcpp)
      ("r-rcpparmadillo",r-rcpparmadillo)
      ("r-rcppprogress",r-rcppprogress)))
  (home-page "https://github.com/linxihui/NNLM")
  (synopsis "Nonnegative Linear Models (NNLM)")
  (description "This is a package for Nonnegative Linear 
    Models (NNLM). It implements fast sequential 
    coordinate descent algorithms for nonnegative linear 
    regression and nonnegative matrix factorization (NMF 
    or NNMF). It supports mean square error and 
    Kullback-Leibler divergence loss. Many other features 
    are also implemented, including missing value 
    imputation, domain knowledge integration, designable 
    W and H matrices and multiple forms of regularizations.")
  (license license:bsd-2)))

(define-public r-rffc
  (package
  (name "r-rffc")
  (version "1.0")
  (source
    (origin
      (method url-fetch)
      (uri "http://download.r-forge.r-project.org/src/contrib/rfFC_1.0.tar.gz")
      (sha256
        (base32
          "05x9wgzsmx4vb12lmcspymgmpb2xw8bwryb8ysg7vzg2nkh0ma3g"))))
  (build-system r-build-system)
  (propagated-inputs
    `(("r-randomforest",r-randomforest)))
  (home-page "https://github.com/rforge/rffc/")
  (synopsis "Random Forest Feature Contributions ")
  (description "Functions for extracting feature contributions 
    from a random forest model from package 'randomForest'. Feature 
    contributions provide detailed information about the relationship 
    between data variables and the predicted value returned by random 
    forest model.")
  (license license:gpl2)))

(define-public r-sccnvcharacterizationhelper
  (package
  (name "r-sccnvcharacterizationhelper")
  (version "0.0.0.9000")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
            "https://github.com/UMCUGenetics/scCnvCharacterizationHelper/"
            "archive/" version ".tar.gz"))
      (sha256
        (base32
          "0rzmr4z20yy016d2mx3lbjlylidgqwfc1pr657vwzgk1wvvyv1cf"))))
  (build-system r-build-system)
  (propagated-inputs
   `(("r-genomicranges",r-genomicranges)
     ("r-genomeinfodb",r-genomeinfodb)
     ("r-iranges",r-iranges)
     ("r-rcurl",r-rcurl)
     ("r-jsonlite",r-jsonlite)
     ("r-ggplot2",r-ggplot2)
     ("r-rhtslib",r-rhtslib)))
  (home-page "https://github.com/UMCUGenetics/scCnvCharacterizationHelper/")
  (synopsis "Single-cell copy-number quantification pipeline helper.")
  (description "This package provides the basic building blocks for a
single-cell copy-number quantification pipeline.")
  (license license:gpl3)))


(define-public r-pacman
  (package
    (name "r-pacman")
    (version "0.5.1")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "pacman" version))
        (sha256
          (base32
            "0z7gngd6h83cpjhq1vg75wvzhdjbgjh7gj5d4zvvi9gd2lmagjcy"))))
    (properties `((upstream-name . "pacman")))
    (build-system r-build-system)
    (propagated-inputs `(("r-remotes" ,r-remotes)))
    (home-page "https://github.com/trinker/pacman")
    (synopsis "Package Management Tool")
    (description
      "Tools to more conveniently perform tasks associated with add-on packages.  pacman conveniently wraps library and package related functions and names them in an intuitive and consistent fashion.  It seeks to combine functionality from lower level functions which can speed up workflow.")
    (license license:gpl2)))





(define-public r-memuse
  (package
    (name "r-memuse")
    (version "4.1-0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "memuse" version))
        (sha256
          (base32
            "1bbjp8y0ji71956fbaxiil7ynq2nkmmgz7i9xps83m3bbp5d3mjq"))))
    (properties `((upstream-name . "memuse")))
    (build-system r-build-system)
    (home-page
      "https://github.com/shinra-dev/memuse")
    (synopsis "Memory Estimation Utilities")
    (description
      "How much ram do you need to store a 100,000 by 100,000 matrix? How much ram is your current R session using? How much ram do you even have? Learn the scintillating answer to these and many more such questions with the 'memuse' package.")
    (license #f)))


(define-public r-pinfsc50
  (package
    (name "r-pinfsc50")
    (version "1.2.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "pinfsc50" version))
        (sha256
          (base32
            "1547xyxmfb7zi8h9bsm6k67dcw4hpp129xzvmgwfw7r6p4af47zd"))))
    (properties `((upstream-name . "pinfsc50")))
    (build-system r-build-system)
    (home-page
      "https://cran.r-project.org/web/packages/pinfsc50")
    (synopsis
      "Sequence ('FASTA'), Annotation ('GFF') and Variants ('VCF') for 17 Samples of 'P. Infestans\" and 1 'P. Mirabilis'")
    (description
      "Genomic data for the plant pathogen \"Phytophthora infestans.\" It includes a variant file ('VCF'), a sequence file ('FASTA') and an annotation file ('GFF').  This package is intended to be used as example data for packages that work with genomic data.")
    (license (list license:gpl2+ license:gpl3+))))




(define-public r-vcfr
  (package
    (name "r-vcfr")
    (version "1.12.0")
    (source
      (origin
        (method url-fetch)
        (uri (cran-uri "vcfR" version))
        (sha256
          (base32
            "0lhxb3ac4fafwik9q3cds46svzf0hyca8k54chw3dpk50c0zz1yx"))))
    (properties `((upstream-name . "vcfR")))
    (build-system r-build-system)
    (inputs `(("zlib" ,zlib)))
    (propagated-inputs
      `(("r-ape" ,r-ape)
        ("r-dplyr" ,r-dplyr)
        ("r-magrittr" ,r-magrittr)
        ("r-memuse" ,r-memuse)
        ("r-pinfsc50" ,r-pinfsc50)
        ("r-rcpp" ,r-rcpp)
        ("r-stringr" ,r-stringr)
        ("r-tibble" ,r-tibble)
        ("r-vegan" ,r-vegan)
        ("r-viridislite" ,r-viridislite)))
    (native-inputs `(("r-knitr" ,r-knitr)))
    (home-page "https://github.com/knausb/vcfR")
    (synopsis "Manipulate and Visualize VCF Data")
    (description
      "Facilitates easy manipulation of variant call format (VCF) data.  Functions are provided to rapidly read from and write to VCF files.  Once VCF data is read into R a parser function extracts matrices of data.  This information can then be used for quality control or other purposes.  Additional functions provide visualization of genomic data.  Once processing is complete data may be written to a VCF file (*.vcf.gz).  It also may be converted into other popular R objects (e.g., genlight, DNAbin).  VcfR provides a link between VCF data and familiar R software.")
    (license license:gpl3)))

