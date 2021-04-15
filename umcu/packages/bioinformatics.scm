;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2016, 2017, 2018, 2019, 2020, 2021 Roel Janssen <roel@gnu.org>
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

(define-module (umcu packages bioinformatics)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages attr)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages bioconductor)
  #:use-module (gnu packages bioinformatics)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages check)
  #:use-module (gnu packages cmake)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cran)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages databases)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages java)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lsof)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages machine-learning)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages multiprecision)
  #:use-module (gnu packages ncurses)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages node)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module (gnu packages perl-compression)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages pth)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-science)
  #:use-module (gnu packages python-web)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages rdf)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages rsync)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages shells)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages statistics)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages tex)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wget)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages)
  #:use-module (guix build-system ant)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system r)
  #:use-module (guix build-system trivial)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (srfi srfi-1)
  #:use-module (umcu packages grid-engine)
  #:use-module (umcu packages perl)
  #:use-module (umcu packages python))

(define-public freec-mappability-tracks
  (package
    (name "freec-mappability-tracks")
    (version "hg19_100bp")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://xfer.curie.fr/get/nil/7hZIk1C63h0/"
                    version ".tar.gz"))
              (sha256
               (base32
                "1qp05na2lb7w35nqii9gzv4clmppi3hnk5w3kzfpz5sz27fw1lym"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((source-file (assoc-ref %build-inputs "source"))
               (output-dir (string-append %output "/share/freec"))
               (tar (string-append (assoc-ref %build-inputs "tar") "/bin/tar"))
               (PATH (string-append (assoc-ref %build-inputs "gzip") "/bin")))
           (setenv "PATH" PATH)
           (mkdir-p output-dir)
           (with-directory-excursion output-dir
             (system* tar "-xvf" source-file))))))
    (inputs
     `(("tar" ,tar)
       ("gzip" ,gzip)))
    (home-page "http://boevalab.com/FREEC")
    (synopsis "")
    (description "")
    (license #f)))

(define-public r-gsalib
  (package
   (name "r-gsalib")
   (version "2.1")
   (source
    (origin
     (method url-fetch)
     (uri (cran-uri "gsalib" version))
     (sha256
      (base32
       "1k3zjdydzb0dfh1ihih08d4cw6rdamgb97cdqna9mf0qdjc3pcp1"))))
   (build-system r-build-system)
   (home-page "http://cran.r-project.org/web/packages/gsalib")
   (synopsis "Utility Functions For GATK")
   (description "This package contains utility functions used by the Genome
Analysis Toolkit (GATK) to load tables and plot data.  The GATK is a toolkit
for variant discovery in high-throughput sequencing data.")
   (license license:expat)))

(define-public r-naturalsort
  (package
   (name "r-naturalsort")
   (version "0.1.3")
   (source (origin
            (method url-fetch)
            (uri (cran-uri "naturalsort" version))
            (sha256
             (base32
              "0mz801y9mzld9ypp3xmsjw2d8l9q97sdnv09wrci9xi3yg2sjf6d"))))
   (build-system r-build-system)
   (home-page "http://cran.r-project.org/web/packages/naturalsort")
   (synopsis "Natural Ordering")
   (description "This package provides functions related to human natural
ordering.  It handles adjacent digits in a character sequence as a number
so that natural sort function arranges a character vector by their numbers,
not digit characters.  It is typically seen when operating systems lists
file names.  For example, a sequence a-1.png, a-2.png, a-10.png looks
naturally ordered because 1 < 2 < 10 and natural sort algorithm arranges
so whereas general sort algorithms arrange it into a-1.png, a-10.png,
a-2.png owing to their third and fourth characters.")
   (license license:bsd-3)))

(define-public gatk-bin-3.8.1-no-intel-deflation
  (package
    (name "gatk")
    (version "3.8.1-aa8764d6c")
    (source (origin
             (method url-fetch)
             (uri "https://www.roelj.com/gatk-3.8.1-aa8764d6c.jar")
             (sha256
              (base32
               "1w46s2jh1q7h1r8shjw09y8yw27q15wlkviiqby3wv20haaqqjcg"))))
    (build-system gnu-build-system)
    (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'unpack)
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (replace 'install
          (lambda _
            (let ((out (string-append (assoc-ref %outputs "out")
                                      "/share/java/" ,name "/")))
              (mkdir-p out)
              (copy-file (assoc-ref %build-inputs "source")
                         (string-append out "/GenomeAnalysisTK.jar"))))))))
    (propagated-inputs
     `(("r-gsalib" ,r-gsalib)
       ("r-ggplot2" ,r-ggplot2)
       ("r-gplots" ,r-gplots)
       ("r-reshape" ,r-reshape)
       ("r-optparse" ,r-optparse)
       ("r-dnacopy" ,r-dnacopy)
       ("r-naturalsort" ,r-naturalsort)
       ("r-dplyr" ,r-dplyr)
       ("r-data-table" ,r-data-table)
       ("r-hmm" ,r-hmm)
       ("gatk-queue-bin-3.8-1" ,gatk-queue-bin-3.8-1)))
    (home-page "https://www.broadinstitute.org/gatk/")
    (synopsis "Package for analysis of high-throughput sequencing")
    (description "The Genome Analysis Toolkit or GATK is a software package for
analysis of high-throughput sequencing data, developed by the Data Science and
Data Engineering group at the Broad Institute.  The toolkit offers a wide
variety of tools, with a primary focus on variant discovery and genotyping as
well as strong emphasis on data quality assurance.  Its robust architecture,
powerful processing engine and high-performance computing features make it
capable of taking on projects of any size.")
    ;; There are additional restrictions, so it's nonfree.
    (license license:expat)))

(define-public gatk-queue-bin-3.8-1
  (package
    (name "gatk-queue")
    (version "3.8-1-0-gf15c1c3ef")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://www.roelj.com/gatk-queue-" version ".tar.bz2"))
              (sha256
               (base32 "0435lf2751w3l2m86m3h6girwr09kpiqahq3pj49gibqnyylx4sq"))))
    (build-system gnu-build-system)
    (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (replace 'install
          (lambda _
            (let ((out (string-append (assoc-ref %outputs "out")
                                      "/share/java/gatk/")))
              (mkdir-p out)
              (install-file "Queue.jar" out)))))))
    (home-page "https://www.broadinstitute.org/gatk/")
    (synopsis "Package for analysis of high-throughput sequencing")
    (description "The Genome Analysis Toolkit or GATK is a software package for
analysis of high-throughput sequencing data, developed by the Data Science and
Data Engineering group at the Broad Institute.  The toolkit offers a wide
variety of tools, with a primary focus on variant discovery and genotyping as
well as strong emphasis on data quality assurance.  Its robust architecture,
powerful processing engine and high-performance computing features make it
capable of taking on projects of any size.")
    ;; There are additional restrictions, so it's nonfree.
    (license license:expat)))

(define-public python-theano
  (package
    (name "python-theano")
    (version "1.0.2")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "Theano" version))
              (sha256
               (base32
                "1pmb5754qwiy1x2irciwn4xzsvwapdpi5agwwq8p1898sc1y0s37"))))
    (build-system python-build-system)
    (arguments `(#:tests? #f))
    (home-page "http://deeplearning.net/software/theano/")
    (synopsis "Optimizing compiler for evaluating mathematical expressions on CPUs and GPUs.")
    (description "Optimizing compiler for evaluating mathematical expressions on CPUs and GPUs.")
    (license license:bsd-3)))

(define-public python-pymc3
  (package
  (name "python-pymc3")
  (version "3.5")
  (source
    (origin
      (method url-fetch)
      (uri (pypi-uri "pymc3" version))
      (sha256
        (base32
          "1vi11z1cjhc1hxbjvxay9n7a599z13p583qa6lhvnc6pqs1yd230"))))
  (build-system python-build-system)
  (arguments `(#:tests? #f ))
  (propagated-inputs
    `(;("python-enum34" ,python-enum34)
      ("python-h5py" ,python-h5py)
      ("python-joblib" ,python-joblib)
      ("python-numpy" ,python-numpy)
      ("python-pandas" ,python-pandas)
      ("python-patsy" ,python-patsy)
      ("python-six" ,python-six)
      ("python-theano" ,python-theano)
      ("python-tqdm" ,python-tqdm)))
  (home-page "http://github.com/pymc-devs/pymc3")
  (synopsis
    "Probabilistic Programming in Python: Bayesian Modeling and Probabilistic Machine Learning with Theano")
  (description
    "Probabilistic Programming in Python: Bayesian Modeling and Probabilistic Machine Learning with Theano")
  (license license:asl2.0)))

(define-public gatk4
  (package
    (name "gatk4")
    (version "4.1.5.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/broadinstitute/gatk/releases/download/"
                    version "/gatk-" version ".zip"))
              (sha256
               (base32 "0aw8v4fsy4cmaji2rl7p42l58w2glrjxipygqk3m9k70rb155hbg"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((unzip   (string-append (assoc-ref %build-inputs "unzip") "/bin/unzip"))
               (tarball (assoc-ref %build-inputs "source"))
               (out     (string-append %output "/share/java/user-classes"))
               (bin     (string-append %output "/bin")))
           (mkdir-p out)
           (mkdir-p bin)
           (system (string-append unzip " " tarball))
           (chdir (string-append "gatk-" ,version))
           (install-file "gatk-package-4.1.5.0-local.jar" out)
           (symlink (string-append out "/gatk-package-4.1.5.0-local.jar")
                    (string-append out "/gatk.jar"))
           (install-file "gatk-package-4.1.5.0-spark.jar" out)
           (symlink (string-append out "/gatk-package-4.1.5.0-spark.jar")
                    (string-append out "/gatk-spark.jar"))
           (substitute* "gatk"
             (("/usr/bin/env python") (string-append
                                       (assoc-ref %build-inputs "python2")
                                       "/bin/python"))
             (("return \\[\"java\"\\]")
              (string-append "return [\"" (assoc-ref %build-inputs "icedtea-8") "/bin/java\"]"))
             (("findJar\\(\"local.jar\", envVariableOverride=GATK_LOCAL_JAR_ENV_VARIABLE\\)")
              (string-append "\"" out "/gatk.jar\""))
             (("findJar\\(\"spark.jar\", envVariableOverride=GATK_SPARK_JAR_ENV_VARIABLE\\)")
              (string-append "\"" out "/gatk-spark.jar\"")))
           (install-file "gatk" bin)))))
    (native-inputs
     `(("unzip" ,unzip)))
    (inputs
     `(("python2" ,python-2.7)
       ("icedtea-8" ,icedtea-8)))
    (propagated-inputs
     `(("r" ,r)
       ("r-gsalib" ,r-gsalib)
       ("r-ggplot2" ,r-ggplot2)
       ("r-gplots" ,r-gplots)
       ("r-reshape" ,r-reshape)
       ("r-optparse" ,r-optparse)
       ("r-dnacopy" ,r-dnacopy)
       ("r-naturalsort" ,r-naturalsort)
       ("r-dplyr" ,r-dplyr)
       ("r-data-table" ,r-data-table)
       ("r-hmm" ,r-hmm)
       ("python-certifi",python-certifi)
       ("openmpi" ,openmpi)
       ("openssl" ,openssl)
       ("python" ,python-3)
       ("readline" ,readline)
       ("python-setuptools" ,python-setuptools)
       ("sqlite" ,sqlite)
       ("tk" ,tk)
       ("python-wheel" ,python-wheel)
       ("xz" ,xz)
       ("zlib" ,zlib)
       ("python-bleach" ,python-bleach)
       ("python-cycler" ,python-cycler)
       ("python-h5py" ,python-h5py)
       ("python-html5lib" ,python-html5lib-0.9)
       ("python-joblib" ,python-joblib)
       ("python-keras" ,python-keras)
       ("python-markdown" ,python-markdown)
       ("python-matplotlib" ,python-matplotlib)
       ("python-numpy" ,python-numpy)
       ("python-pandas" ,python-pandas)
       ("python-patsy" ,python-patsy)
       ("python-protobuf" ,python-protobuf)
       ("python-pymc3" ,python-pymc3)
       ("python-pyparsing" ,python-pyparsing)
       ("python-dateutil" ,python-dateutil)
       ("python-pytz" ,python-pytz)
       ("python-pyyaml" ,python-pyyaml)
       ("python-scipy" ,python-scipy)
       ("python-six" ,python-six)
       ("python-theano" ,python-theano)
       ("python-tqdm" ,python-tqdm)
       ("python-werkzeug" ,python-werkzeug)
       ("python3" ,python-3)))
    (home-page "")
    (synopsis "")
    (description "")
    (license #f)))

(define-public google-cloud-sdk
  (package
    (name "google-cloud-sdk")
    (version "317.0.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/"
                    "google-cloud-sdk-" version "-linux-x86_64.tar.gz"))
              (sha256
               (base32 "0xkv5vjci0z0kiirmbbv6z6xw5n5nw20mvi80q0c3xphla8x828q"))))
    ;; We use the GNU build system mainly for its patch-shebang phases.
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f ; This is just copying a binary, so no tests to perform.
       #:phases
       (modify-phases %standard-phases
         (delete 'configure) ; No configuration, just copying.
         (delete 'build)     ; No building, just copying.
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out      (assoc-ref outputs "out"))
                    (bin      (string-append out "/bin"))
                    (lib      (string-append out "/lib"))
                    (platform (string-append out "/platform"))
                    (share    (string-append out "/share/google-cloud-sdk")))
               (for-each mkdir-p (list out share))
               (copy-recursively "bin" bin)
               (copy-recursively "lib" lib)
               (copy-recursively "platform" platform)))))))
    (propagated-inputs
     `(("python" ,python)
       ("coreutils" ,coreutils)))
    (home-page "https://cloud.google.com/sdk")
    (synopsis "Google Cloud SDK")
    (description "This package provides the Google Cloud SDK which includes the
command-line programs gsutil and gcloud among others.")
    (license #f)))

(define-public score-client
  (package
   (name "score-client")
   (version "5.0.0")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://artifacts.oicr.on.ca/artifactory/dcc-release/bio/"
                  "overture/score-client/" version "/score-client-" version
                  "-dist.tar.gz"))
            (sha256
             (base32 "05pvffd43aqdh92g1p37p9p00wciqxp45n5gyybxvpgs1cfdqsfm"))))
   ;; We use the GNU build system mainly for its patch-shebang phases.
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f ; This is just copying a binary, so no tests to perform.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; No configuration, just copying.
        (delete 'build)     ; No building, just copying.
        (replace 'install
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let* ((out (assoc-ref outputs "out"))
                   (etc (string-append out "/etc/score-client"))
                   (bin (string-append out "/bin"))
                   (lib (string-append out "/lib")))

              (for-each mkdir-p (list out etc bin lib))

              (substitute* "bin/score-client"
               (("`dirname \\$0`/..") out)
               (("\\$\\(cd \\$\\{BASE_DIR\\} && pwd -P\\)") out)
               (("exec java") (string-append
                               "exec " (assoc-ref inputs "openjdk")
                               "/bin/java"))
               (("-Dlogging.path=\\$\\{BASE_DIR\\}/logs")
                "-Dlogging.path=${HOME}")
               (("type -p java")
                (string-append "type -p "
                               (assoc-ref inputs "openjdk")
                               "/bin/java"))
               (("_java=java")
                (string-append "_java="
                               (assoc-ref inputs "openjdk")
                               "/bin/java"))
               (("\\$\\{CLIENT_DIR\\}/conf") etc))

              (copy-recursively "bin" bin)
              (copy-recursively "conf" etc)
              (copy-recursively "lib" lib)

              (wrap-program (string-append out "/bin/score-client")
                `("_JAVA_OPTIONS" ":" = (,(string-append
                                           "-Djavax.net.ssl.trustStore="
                                           (assoc-ref inputs "openjdk")
                                           "/lib/security/cacerts"))))))))))
   (inputs
    `(("openjdk" ,openjdk11)))
   (home-page "https://docs.icgc.org/software/download/#score-client")
   (synopsis "Tool to view ICGC data")
   (description "This package provides a tool to download or view data in
the cloud environments of ICGC.")
   (license license:gpl3)))

(define-public igv
  (package
    (name "igv")
    (version "2.8.10")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "http://data.broadinstitute.org/igv/projects/downloads/"
             "2.8/IGV_Linux_" version ".zip"))
       (sha256
        (base32 "1qrhsvl6z5h1kg3pji08fzqj08c6l2lxj0qv7hbvys3mymz4lfzv"))))
    (build-system gnu-build-system)
    (propagated-inputs
     `(("openjdk11" ,openjdk11)))
    (native-inputs
     `(("unzip" ,unzip)))
    (arguments
     `(#:tests? #f  ; No tests available.
       #:phases
       (modify-phases %standard-phases 
         (delete 'configure) ; Nothing to configure.
         (delete 'build) ; This is a binary package only.
         (replace 'install
           (lambda _
             (let* ((out (assoc-ref %outputs "out"))
                    (bin (string-append out "/bin"))
                    (lib (string-append out "/lib"))
                    (share (string-append out "/share/igv")))
               (mkdir-p share)
               (mkdir-p lib)
               (mkdir-p bin)
               (copy-recursively "lib" lib)
               (substitute* "igv.sh"
                 (("prefix=")
                  (string-append "prefix=" lib " # "))
                 (("\\$\\{prefix\\}/igv.args")
                  (string-append share "/igv.args"))
                 (("--module-path=\"\\$\\{prefix\\}/lib\"")
                  (string-append "--module-path=" lib))
                 (("exec java")
                  (string-append "exec " (assoc-ref %build-inputs "openjdk11")
                                 "/bin/java")))
               (install-file "igv.args" share)
               (install-file "igv.sh" bin)))))))
   (home-page "http://www.broadinstitute.org/software/igv/")
   (synopsis "Integrative Genomics Viewer")
   (description "The Integrative Genomics Viewer (IGV) is a high-performance
visualization tool for interactive exploration of large, integrated genomic
datasets.  It supports a wide variety of data types, including array-based and
next-generation sequence data, and genomic annotations.")
   ;; No license specified.
   (license license:non-copyleft)))
    
(define-public igvtools
  (package
   (name "igvtools")
   (version "2.3.71")
   (source (origin
     (method url-fetch)
     (uri (string-append
           "http://data.broadinstitute.org/igv/projects/downloads/2.3/igvtools_"
           version ".zip"))
     (sha256
      (base32 "1z7fx79jfsqm0ry89mchifxxrj7vl1h9f98x6p2r2vcbx8f4zvi8"))))
   (build-system gnu-build-system)
   (inputs
    `(("icedtea" ,icedtea-8)))
   (native-inputs
    `(("unzip" ,unzip)))
   (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (add-before 'install 'fix-java-command
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (substitute* "igvtools"
              (("java -D") (string-append
                            (assoc-ref inputs "icedtea")
                            "/bin/java -D")))))
        (replace 'install
          (lambda _
            (let* ((out (assoc-ref %outputs "out"))
                   (bin (string-append out "/share/java/" ,name)))
              (install-file "igvtools.jar" bin)
              (install-file "igvtools" bin)
              (mkdir (string-append bin "/genomes"))
              (copy-recursively "genomes" (string-append bin "/genomes"))))))))
   (home-page "http://www.broadinstitute.org/software/igv/")
   (synopsis "Integrative Genomics Viewer")
   (description "The Integrative Genomics Viewer (IGV) is a high-performance
visualization tool for interactive exploration of large, integrated genomic
datasets.  It supports a wide variety of data types, including array-based and
next-generation sequence data, and genomic annotations.")
   ;; No license specified.
   (license license:non-copyleft)))

(define-public metamaps
  (let ((commit "e23f8a8688159ff0d092557a40305dbc7acc2342"))
    (package
     (name "metamaps")
     (version (string-append "0.0-" (string-take commit 7)))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/DiltheyLab/MetaMaps.git")
                    (commit commit)))
              (sha256
               (base32
                "0h9ahkv7axw4qzgbvhsz4r699swiv64hlwjy6h8s11vjls2dslrp"))))
     (build-system gnu-build-system)
     (arguments
      `(#:configure-flags (list (string-append
                                 "--with-boost="
                                 (assoc-ref %build-inputs "boost")))
        #:tests? #f
        #:phases
        (modify-phases %standard-phases
          (add-after 'unpack 'shared-boost
            (lambda _
              (substitute* "configure.ac"
               (("libboost_math_c99.a") "libboost_math_c99.so")))))))
     (native-inputs
      `(("autoconf" ,autoconf)))
     (inputs
      `(("boost" ,boost)
        ("zlib" ,zlib)
        ("gsl" ,gsl)))
     (home-page "https://github.com/DiltheyLab/MetaMaps")
     (synopsis "Long-read metagenomic analysis")
     (description "MetaMaps is tool specifically developed for the analysis
of long-read (PacBio/Oxford Nanopore) metagenomic datasets.")
     (license license:public-domain))))

(define-public king-bin-2.1.2
  (package
    (name "king")
    (version "2.1.2")
    ;; WARNING: There's no source code.  This downloads a tarball with the
    ;; executable.
    (source (origin
      (method url-fetch)
      (uri "http://people.virginia.edu/~wc9c/KING/Linux-king.tar.gz")
      (file-name (string-append name "-" version "-bin.tar.gz"))
      (sha256
       (base32 "0asrgj4m20mll0psk2238asda4w1brzb5wlqjmaijknhflw60pj0"))))
    (build-system gnu-build-system)
    ;; The executable is linked to 64-bit libraries.
    (supported-systems '("x86_64-linux"))
    ;; WARNING: The host system's libz.so.1 is used because we only have an
    ;; executable that is linked already.
    (native-inputs
     `(("zlib" ,zlib)))
    (arguments
     `(#:tests? #f ; There are no tests to run.
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (delete 'build)
         (delete 'validate-runpath) ; It uses the host's libraries anyway.
         (replace 'unpack
          (lambda _
            (mkdir-p "king")
            (chdir "king")
            (zero? (system* "tar" "xvf" (assoc-ref %build-inputs "source")))))
         (replace 'install
           (lambda _
             (let ((out (string-append (assoc-ref %outputs "out") "/bin")))
               (mkdir-p out)
               (copy-file "king" (string-append out "/king"))))))))
    (home-page "http://people.virginia.edu/~wc9c/KING/")
    (synopsis "Program making use of high-throughput SNP data")
    (description "KING is a toolset making use of high-throughput SNP data
typically seen in a genome-wide association study (GWAS) or a sequencing
project.  Applications of KING include family relationship inference and
pedigree error checking, population substructure identification, forensics,
gene mapping, etc.")
    ;; WARNING: There's no license specified.  This is non-free software.
    (license license:non-copyleft)))

(define-public pbgzip
  (let ((commit "2b09f97b5f20b6d83c63a5c6b408d152e3982974"))
    (package
      (name "pbgzip")
      (version (string-take commit 7))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/nh13/pbgzip.git")
                      (commit commit)))
                (file-name (string-append name "-" version))
                (sha256
                 (base32
                  "1mlmq0v96irbz71bgw5zcc43g1x32zwnxx21a5p1f1ch4cikw1yd"))))
      (build-system gnu-build-system)
      (arguments
       `(#:phases
         (modify-phases %standard-phases
           (add-after 'unpack 'autogen
             (lambda _
               (zero? (system* "sh" "autogen.sh")))))))
      (native-inputs
       `(("autoconf" ,autoconf)
         ("automake" ,automake)))
      (inputs
       `(("zlib" ,zlib)))
      (home-page "https://github.com/nh13/pbgzip")
      (synopsis "Parallel Block GZIP")
      (description "This tool and API implements parallel block gzip.  For many
formats, in particular Genomics Data Formats, data are compressed in
fixed-length blocks such that they can be easily indexed based on a (genomic)
coordinate order, since typically each block is sorted according to this order.
This allows for each block to be individually compressed (deflated), or more
importantly, decompressed (inflated), with the latter enabling random retrieval
of data in large files (gigabytes to terabytes).  @code{pbgzip} is not limited
to any particular format, but certain features are tailored to Genomics Data
Formats when enabled (see below). Parallel decompression is somewhat faster,
but truly the speedup comes during compression.")
      (license license:expat))))

(define-public picard-bin-1.141
  (package
   (name "picard")
   (version "1.141")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/broadinstitute/picard/releases/download/"
                  version "/picard-tools-" version ".zip"))
            (sha256
             (base32 "1ari9j37a0v8bm03c77pw729bqwbqqn6h15rw028jhl1iz4rgd5g"))))
   (build-system gnu-build-system)
   (propagated-inputs
    `(("icedtea" ,icedtea-8)))
   (native-inputs
    `(("unzip" ,unzip)))
   (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (replace 'unpack
          (lambda _
            (zero? (system* "unzip" (assoc-ref %build-inputs "source")))))
        (replace 'install
          (lambda _
            (let ((out (string-append (assoc-ref %outputs "out")
                                      "/share/java/picard/")))
              (chdir (string-append "picard-tools-" ,version))
              (install-file (string-append "htsjdk-" ,version ".jar") out)
              (install-file "libIntelDeflater.so" out)
              (install-file "picard-lib.jar" out)
              (install-file "picard.jar" out)))))))
   (home-page "http://broadinstitute.github.io/picard/")
    (synopsis "A set of Java command line tools for manipulating high-throughput
sequencing data (HTS) data and formats")
    (description "Picard comprises Java-based command-line utilities that
manipulate SAM files, and a Java API (HTSJDK) for creating new programs that
read and write SAM files. Both SAM text format and SAM binary (BAM) format are
supported.")
    (license license:expat)))

(define-public rmblast
  (package (inherit blast+)
    (name "rmblast")
    (version "2.10.1")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/"
                    version "/ncbi-blast-" version "+-src.tar.gz"))
              (sha256
               (base32
                "11kvrrl0mcwww6530r55hccpg3x3msmhr3051fwnjbq8rzg2j1qi"))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  ;; Remove bundled bzip2, zlib and pcre.
                  (delete-file-recursively "c++/src/util/compress/bzip2")
                  (delete-file-recursively "c++/src/util/compress/zlib")
                  (delete-file-recursively "c++/src/util/regexp")
                  (substitute* "c++/src/util/compress/Makefile.in"
                    (("bzip2 zlib api") "api"))
                  ;; Remove useless msbuild directory
                  (delete-file-recursively
                   "c++/src/build-system/project_tree_builder/msbuild")
                  #t))))))

(define-public pathseq-pipeline-tools
  (let ((commit "2a4f15d5dec1b2fbf707cab4a8517eedff070a33"))
    (package
      (name "pathseq-pipeline-tools")
      (version "1.0")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/ChandraPedamallu/PathSeq.git")
                      (commit commit)))
                (file-name (string-append name "-" version "-checkout"))
                (sha256
                 (base32
                  "141fwk1knknvmrddpgpqiqcdcz7iarqrw28609j1smjr33dkwn3n"))))
      (build-system gnu-build-system)
      (arguments
       `(#:tests? #f ; There are no tests
         #:phases
         (modify-phases %standard-phases
           (delete 'configure)
           (replace 'build
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (with-directory-excursion "Java"
                 ;; Remove pre-compiled files.
                 (system* "rm" "-rf"
                          "*.class"
                          "QualFilter_July2016.java"
                          "QualFilter_RemoveDuplicate_July2016.java")
                 (system "ls -lh")
                 ;; Compile all java classes.
                 (system (string-append
                          (assoc-ref inputs "java")
                          "/bin/javac -cp ../3rdparty/sam-1.52.jar *.java"))
                 ;; Pack the Java classes into one jar.
                 (system (string-append
                          (assoc-ref inputs "java")
                          "/bin/jar -cvf ../PathSeq.jar *.class")))))
           (replace 'install
             (lambda* (#:key inputs outputs #:allow-other-keys)
               (let* ((out (assoc-ref outputs "out"))
                      (java-dir (string-append out "/share/java/user-classes")))
                 (install-file "PathSeq.jar" java-dir)))))))
      (inputs
       `(("java" ,icedtea-8 "jdk")))
      (native-search-paths
       (list (search-path-specification
              (variable "GUIX_JARPATH")
              (files (list "share/java/user-classes")))))
      (home-page "http://software.broadinstitute.org/pathseq/")
      (synopsis "Pipeline for identifying microbial sequences in human data")
      (description "PathSeq is a computational tool for the identification and
analysis of microbial sequences in high-throughput human sequencing data that
is designed to work with large numbers of sequencing reads in a scalable
manner.")
      ;; MIT license.
      (license license:expat))))

(define-public xqilla
  (package
   (name "xqilla")
   (version "2.3.4")
   (source (origin
            (method url-fetch)
            (uri (string-append "mirror://sourceforge/xqilla/XQilla-"
                                version ".tar.gz"))
            (sha256
             (base32 "1sq2b43hqzk9jq11sr0xc498z933a0rpfwvjp5z2xzii2rwk29i9"))))
   (build-system gnu-build-system)
   (arguments
    `(#:configure-flags (list (string-append
                               "--with-xerces="
                               (assoc-ref %build-inputs "xerces-c")))))
   (inputs
    `(("xerces-c" ,xerces-c)))
   (home-page "http://xqilla.sourceforge.net/")
   (synopsis "XQuery and XPath utility")
   (description "XQilla is an XQuery and XPath 2 library and command line
utility written in C++ implemented on top of the Xerces-C library.")
   (license license:asl2.0)))

(define-public star-2.4.2a
  (package
    (name "star")
    (version "2.4.2a")
    (source (origin
              (method url-fetch)
              (uri (string-append "https://github.com/alexdobin/STAR/archive/"
                                  "STAR_" version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "1c3rnm7r5l0kl3d04gl1g7938xqf1c2l0mla87rlplqg1hcns5mc"))
              (modules '((guix build utils)))
              (snippet
               '(begin
                  (substitute* "source/Makefile"
                    (("/bin/rm") "rm"))
                  ;; Remove pre-built binaries and bundled htslib sources.
                  (delete-file-recursively "bin/MacOSX_x86_64")
                  (delete-file-recursively "bin/Linux_x86_64")
                  (delete-file-recursively "source/htslib")
                  #t))))
    (build-system gnu-build-system)
    (arguments
     '(#:tests? #f ;no check target
       #:make-flags '("STAR")
       #:phases
       (modify-phases %standard-phases
         (add-after 'unpack 'enter-source-dir
           (lambda _ (chdir "source") #t))
         (add-after 'enter-source-dir 'do-not-use-bundled-htslib
           (lambda _
             (substitute* "Makefile"
               (("(Depend.list: \\$\\(SOURCES\\) parametersDefault\\.xxd) htslib"
                 _ prefix) prefix))
             (substitute* '("BAMfunctions.cpp"
                            "signalFromBAM.h"
                            ;"bam_cat.h"
                            "bam_cat.c"
                            "STAR.cpp"
                            "bamRemoveDuplicates.cpp")
               (("#include \"htslib/([^\"]+\\.h)\"" _ header)
                (string-append "#include <" header ">")))
             (substitute* "IncludeDefine.h"
               (("\"htslib/(htslib/[^\"]+.h)\"" _ header)
                (string-append "<" header ">")))
             #t))
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((bin (string-append (assoc-ref outputs "out") "/bin/")))
               (install-file "STAR" bin))
             #t))
         (delete 'configure))))
    (native-inputs
     `(("vim" ,vim))) ; for xxd
    (inputs
     `(("htslib" ,htslib)
       ("zlib" ,zlib)))
    (home-page "https://github.com/alexdobin/STAR")
    (synopsis "Universal RNA-seq aligner")
    (description
     "The Spliced Transcripts Alignment to a Reference (STAR) software is
based on a previously undescribed RNA-seq alignment algorithm that uses
sequential maximum mappable seed search in uncompressed suffix arrays followed
by seed clustering and stitching procedure.  In addition to unbiased de novo
detection of canonical junctions, STAR can discover non-canonical splices and
chimeric (fusion) transcripts, and is also capable of mapping full-length RNA
sequences.")
    ;; STAR is licensed under GPLv3 or later; htslib is MIT-licensed.
    (license license:gpl3+)))

(define-public star-fusion
  (package
   (name "star-fusion")
   (version "1.0.0")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/STAR-Fusion/STAR-Fusion/releases/"
                  "download/v" version "/STAR-Fusion-v" version
                  ".FULL.tar.gz"))
            (sha256
             (base32 "19p5lwq2f95hgii7fdidz03845nkhf3pjfvp8v3midrsb0s6p7df"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f ; There is no test phase.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; There is nothing to configure.
        (delete 'build) ; There is nothing to compile/build.
        (add-before 'install 'patch-external-tools
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let ((samtools (string-append (assoc-ref inputs "samtools") "/bin/samtools"))
                  (gunzip (string-append (assoc-ref inputs "gzip") "/bin/gunzip"))
                  (zcat (string-append (assoc-ref inputs "gzip") "/bin/zcat"))
                  (cat (string-append (assoc-ref inputs "coreutils") "/bin/cat"))
                  (wc (string-append (assoc-ref inputs "coreutils") "/bin/wc"))
                  (sort (string-append (assoc-ref inputs "coreutils") "/bin/sort"))
                  (mkdir (string-append (assoc-ref inputs "coreutils") "/bin/mkdir")))
              (substitute* "util/append_breakpoint_junction_info.pl"
                (("samtools") samtools))
              (substitute* "util/incorporate_FFPM_into_final_report.pl"
                (("gunzip") gunzip))
              (substitute* "util/STAR-Fusion.predict" (("gunzip") gunzip))
              (substitute* "util/incorporate_FFPM_into_final_report.pl" (("wc") wc))
              (substitute* "util/convert_to_FFPM.pl" (("wc") wc))
              (substitute* "util/incorporate_FFPM_into_final_report.pl"
                (("cat \\$fq_file") (string-append cat " $fq_file")))
              (substitute* "util/partition_FUSION_EVIDENCE_fastqs_by_fusion.pl"
                (("sort \\$tmp_paired") (string-append sort " $tmp_paired")))
              (substitute* "util/convert_to_FFPM.pl"
                (("\"cat \\$fq_filename") (string-append "\"" cat " $fq_filename")))
              (substitute* "util/convert_to_FFPM.pl"
                (("zcat \\$fq_filename") (string-append zcat " $fq_filename")))
              (substitute* "util/partition_FUSION_EVIDENCE_fastqs_by_fusion.pl"
                (("mkdir") mkdir))
              (substitute* "util/STAR-Fusion.filter" (("mkdir") mkdir))
              (substitute* "util/STAR-Fusion.predict" (("mkdir") mkdir)))))
        (replace 'install
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
              (mkdir-p bin)
              (install-file "STAR-Fusion" bin)
              (copy-recursively "PerlLib" (string-append bin "/PerlLib"))
              (copy-recursively "util" (string-append bin "/util"))
              (copy-recursively "FusionFilter"
                                (string-append bin "/FusionFilter"))))))))
   (inputs
    `(("perl" ,perl)
      ("samtools" ,samtools)
      ("coreutils" ,coreutils)
      ("gzip" ,gzip)))
   (propagated-inputs
    `(("perl-carp" ,perl-carp)
      ("perl-pathtools" ,perl-pathtools)
      ("perl-db-file" ,perl-db-file)
      ("perl-uri" ,perl-uri)
      ("perl-set-intervaltree" ,perl-set-intervaltree)))
   (home-page "https://github.com/STAR-Fusion/STAR-Fusion/")
   (synopsis "")
   (description "")
   (license #f)))

(define-public snpeff-bin-4.1
  (package
   (name "snpeff")
   (version "4.1")
   (source (origin
             (method url-fetch)
            (uri "mirror://sourceforge/snpeff/snpEff_v4_1_core.zip")
            (sha256
             (base32 "1vjgj6aacjsw6iczy09h18q5kx8ppxrrcq8w38g159zq7y3732kb"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (replace 'install
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let* ((current-dir (getcwd))
                   (out (assoc-ref %outputs "out"))
                   (bin (string-append out "/share/java/" ,name))
                   (share (string-append out "/share/snpeff"))
                   (clinvar-file (string-append
                                  (assoc-ref inputs "clinvar")
                                  "/share/clinvar/GRCh37/clinvar.vcf.gz"))
                   (snpeff-db-dir (string-append share "/data"))
                   (snpeff-db (assoc-ref inputs "snpeff-database"))
                   (dbsnp-file (string-append (assoc-ref inputs "dbsnp")
                                             "/share/dbsnp/dbSnp.vcf.gz"))
                   (create-and-copy
                    (lambda (dir)
                      (mkdir (string-append bin "/" dir))
                      (copy-recursively dir (string-append bin "/" dir)))))
              (mkdir-p bin)
              (mkdir-p share)
              (substitute* "snpEff.config"
                (("data.dir = ./data/")
                 (string-append "data.dir = " share "/data"))
                (("database.local.clinvar      = ./db/GRCh38/clinvar/clinvar-latest.vcf.gz")
                 (string-append "database.local.clinvar      = " clinvar-file))
                (("database.local.dbsnp        = ./db/GRCh38/dbSnp/dbSnp.vcf.gz")
                 (string-append "database.local.dbsnp        = " dbsnp-file)))
              (chdir share)
              (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db)
              (chdir current-dir)

              (install-file "snpEff.config" bin)
              (install-file "snpEff.jar" bin)
              (install-file "SnpSift.jar" bin)
              (map create-and-copy '("scripts" "galaxy"))))))))
   (native-inputs
    `(("unzip" ,unzip)
      ("perl" ,perl)
      ("python" ,python-2)
      ("bash" ,bash)
      ("r" ,r)))
   (inputs
    `(("perl" ,perl)
      ("python" ,python)
      ("bash" ,bash)
      ("r" ,r)
      ("icedtea" ,icedtea-7)
      ("clinvar" ,clinvar-grch37)
      ("gwascatalog" ,gwascatalog)
      ("dbnsfp" ,dbnsfp)
      ("snpeff-database"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_1/"
               "snpEff_v4_1_GRCh37.74.zip"))
         (sha256
          (base32 "1p02n1dd4b04vf425wm7c5b749rjxj6va78ibbfzdhggl38wg345"))))
      ("dbsnp" ,dbsnp)))
   (home-page "http://snpeff.sourceforge.net/")
   (synopsis "Genetic variant annotation and effect prediction toolbox.")
   (description "Genetic variant annotation and effect prediction toolbox.
It annotates and predicts the effects of variants on genes (such as amino
acid changes).")
   ;; No license specified.
   (license license:non-copyleft)))

(define-public snpeff-bin-4.1h
 (package (inherit snpeff-bin-4.1)
  (name "snpeff")
  (version "4.1h")
  (source (origin
      (method url-fetch)
      (uri "mirror://sourceforge/snpeff/snpEff_v4_1h_core.zip")
      (sha256
        (base32 "1j45jp4y8wj0q01clxsx46w1f4jm2wh85yl1mbrha7qbqs8c1qn3"))))))

(define-public snpeff-bin-4.3t
 (package (inherit snpeff-bin-4.1)
  (name "snpeff")
  (version "4.3t")
  (source (origin
      (method url-fetch)
      (uri "mirror://sourceforge/snpeff/snpEff_v4_3t_core.zip")
      (sha256
       (base32 "0i12mv93bfv8xjwc3rs2x73d6hkvi7kgbbbx3ry984l3ly4p6nnm"))))
  (arguments
    `(#:tests? #f ; This is a binary package only, so no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure) ; Nothing to configure.
        (delete 'build) ; This is a binary package only.
        (replace 'install
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (chdir "../snpEff")
            (let* ((current-dir (getcwd))
                   (out (assoc-ref %outputs "out"))
                   (bin (string-append out "/share/java/" ,name))
                   (patch-bin (string-append (assoc-ref %build-inputs "patch")
                                             "/bin/patch"))
                   (share (string-append out "/share/snpeff"))
                   (clinvar-file (string-append
                                  (assoc-ref inputs "clinvar")
                                  "/share/clinvar/GRCh37/clinvar.vcf.gz"))
                   (snpeff-db-dir (string-append share "/data"))
                   (snpeff-db (assoc-ref inputs "snpeff-database"))
                   (snpeff-db-GRCm38.86 (assoc-ref inputs "snpeff-database-GRCm38.86"))
                   (snpeff-db-GRCh37.75 (assoc-ref inputs "snpeff-database-GRCh37.75"))
                   (snpeff-db-UMD3.1.86 (assoc-ref inputs "snpeff-database-UMD3.1.86"))
                   (snpeff-db-GRCh38.86 (assoc-ref inputs "snpeff-database-GRCh38.86"))
                   (dbsnp-dir (string-append (assoc-ref inputs "dbsnp")
                                             "/share/dbsnp/"))
                   (gwascatalog-file (string-append
                                      (assoc-ref inputs "gwascatalog")
                                      "/share/gwascatalog/gwascatalog.txt"))
                   (dbnsfp-file (string-append
                                 (assoc-ref inputs "dbnsfp")
                                 "/share/dbnsfp/dbNSFP2.9_gene.complete.gz"))
                   (create-and-copy
                    (lambda (dir)
                      (mkdir (string-append bin "/" dir))
                      (copy-recursively dir (string-append bin "/" dir)))))
              (mkdir-p bin)
              (mkdir-p share)
              (substitute* "snpEff.config"
                (("data.dir = ./data/")
                 (string-append "data.dir = " share "/data"))
                (("database.clinvar.GRCh37                 = ./db/GRCh37/clinvar/clinvar-latest.vcf.gz")
                 (string-append "database.clinvar.GRCh37      = " clinvar-file))
                (("database.dbsnp.GRCh37                   = ./db/GRCh37/dbSnp/")
                 (string-append "database.dbsnp.GRCh37        = " dbsnp-dir))
                (("database.gwascatalog.GRCh37             = ./db/GRCh37/gwasCatalog/gwascatalog.txt")
                 (string-append "database.gwascatalog.GRCh37        = " gwascatalog-file))
                (("database.dbnsfp.GRCh37                  = ./db/GRCh37/dbNSFP/dbNSFP.txt.gz")
                 (string-append "database.dbnsfp.GRCh37                  = " dbnsfp-file)))
              (chdir share)
              (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db)
              (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db-GRCm38.86)
	      (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db-GRCh37.75)
	      (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db-GRCh38.86)
	      (system* (string-append (assoc-ref inputs "unzip")
                                      "/bin/unzip") snpeff-db-UMD3.1.86)
                                      
              (chdir current-dir)
              (install-file "snpEff.config" bin)
              (install-file "snpEff.jar" bin)
              (install-file "SnpSift.jar" bin)
              (for-each create-and-copy '("scripts" "galaxy"))

              ;; Backport settings from an older snpEff version by
              ;; applying the following patch.
              (with-directory-excursion bin
                (format #t "Applying patches... ")
                (let ((patch-file (assoc-ref %build-inputs "patch-file")))
                  (format #t
                   (if (zero? (system (string-append patch-bin " < " patch-file)))
                       " Succeeded.~%"
                       " Failed.~%"))))

              #t))))))
  (native-inputs
    `(("unzip" ,unzip)
      ("perl" ,perl)
      ("python" ,python-2)
      ("bash" ,bash)
      ("r" ,r)
      ("patch" ,patch)
      ("patch-file"
       ,(origin
         (method url-fetch)
         (uri (search-patch "snpeff-4.3t-backport-settings.patch"))
         (sha256
          (base32
           "1hw44vzcb6k8fq66740kd7kcdmb68bf5zbibc467bcxiiay8xpca"))))))
  (inputs
    `(("perl" ,perl)
      ("python" ,python)
      ("bash" ,bash)
      ("r" ,r)
      ("icedtea" ,icedtea-7)
      ("clinvar" ,clinvar-grch37)
      ("gwascatalog" ,gwascatalog)
      ("dbnsfp" ,dbnsfp)
      ("snpeff-database"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_3/"
               "snpEff_v4_3_hg19.zip"))
         (sha256
          (base32 "0rnaa858shjgxx284m73ikf2a1k11n3gc7861svczm2f98wwhar2"))))
    ("snpeff-database-GRCm38.86"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_3/"
               "snpEff_v4_3_GRCm38.86.zip"))
         (sha256
          (base32 "0rsdgv01yc33ppr8z412gk07xq098vsl8qhhii7s34kchk0qa746"))))
    ("snpeff-database-UMD3.1.86"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_3/"
               "snpEff_v4_3_UMD3.1.86.zip"))
         (sha256
          (base32 "0h4d7w3n5pr1lfbmf921z4rx163n93qfw2klv94qw7syl3db6lli"))))
    ("snpeff-database-GRCh38.86"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_3/"
               "snpEff_v4_3_GRCh38.86.zip"))
         (sha256
          (base32 "1rf8q7l732ayjq2lpny4s75zpij05j00151374nqblk4wri2mz0i"))))

    ("snpeff-database-GRCh37.75"
       ,(origin
         (method url-fetch)
         (uri (string-append
               "mirror://sourceforge/snpeff/databases/v4_3/"
               "snpEff_v4_3_GRCh37.75.zip"))
         (sha256
          (base32 "19c8wwx91vq47z7j7f455vsv8jw067x5rd7449d1z0nln82zpmhm"))))
      ("dbsnp" ,dbsnp)))))

(define-public strelka-1.0.15
  (package
    (name "strelka")
    (version "1.0.15")
    (source (origin
      (method url-fetch)
      (uri (string-append
            ;;"ftp://strelka:''@ftp.illumina.com/v1-branch/v"
            ;;version "/strelka_workflow-" version ".tar.gz"))
            "https://sites.google.com/site/strelkasomaticvariantcaller/home/"
            "download/" name "_workflow-" version ".tar.gz"))
      (sha256
       (base32 "1cwad2wlhdk09702ivblfiyv921af0al7s1gm1dn2d3b0v31qrp2"))
      (patches (list (search-patch "strelka-disable-tests.patch")
                     (search-patch "strelka-disable-install.patch")))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (add-before 'install 'build-some-more
           (lambda _
             (with-directory-excursion "strelka"
               (zero? (system* "make" "-j" (number->string
                                            (parallel-job-count))
                               "install")))))
         (replace 'install
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (perl-lib-dir (string-append out "/lib/perl5/site_perl/"
                                                 ,(package-version perl)))
                    (bin (string-append out "/bin"))
                    (lib (string-append out "/lib"))
                    (libexec (string-append out "/libexec")))

               ;; Substitute the binary directories for samtools and bgzip.
               (substitute* '("src/perl/bin/configureStrelkaWorkflow.pl"
                              "src/perl/libexec/callSomaticVariants.pl"
                              "src/perl/libexec/consolidateResults.pl")
                            (("my \\$samtoolsDir = File::Spec->catdir\\(\\$optDir,'samtools'\\);")
                             (string-append "my $samtoolsDir = \""
                                            (assoc-ref inputs "samtools") "/bin\";"))
                            (("my \\$samtoolsBin = File::Spec->catfile\\(\\$optDir,'samtools','samtools'\\);")
                             (string-append "my $samtoolsBin = \""
                                            (assoc-ref inputs "samtools")
                                            "/bin/samtools\";")))

               (substitute* "src/perl/libexec/consolidateResults.pl"
                 (("my \\$bgzipBin = File::Spec->catfile\\(\\$optDir,'tabix','bgzip'\\);")
                  (string-append "my $bgzipBin = \"" (assoc-ref inputs "htslib") "/bin/bgzip\";"))
                 (("my \\$getHeaderCmd = \"bash")
                  (string-append "my $getHeaderCmd = \"" (assoc-ref inputs "bash") "/bin/bash")))

               (mkdir-p perl-lib-dir)
               (mkdir-p lib)
               (mkdir-p libexec)

               ;; Instead of patching out $optDir throughout the code, we can create
               ;; an empty directory so that these checks pass.  We already patched the
               ;; path to samtools and bgzip, so this should be fine.
               (mkdir-p (string-append out "/opt/samtools"))

               (install-file "src/c++/libexec/countFastaBases" libexec)
               (install-file "src/perl/bin/configureStrelkaWorkflow.pl" bin)
               (install-file "src/perl/libexec/consolidateResults.pl" libexec)
               (install-file "src/perl/libexec/filterSomaticVariants.pl" libexec)
               (install-file "src/perl/libexec/callSomaticVariants.pl" libexec)
               (install-file "src/perl/lib/Utils.pm" perl-lib-dir)
               (install-file "strelka/src/bin/strelka2" bin)
               (install-file "strelka/src/bin/starling2" bin)
               (install-file "strelka/src/bin/strelkaSiteSimulator" bin)

               ;; Also add Utils.pm to the lib folder, because strelka manipulates
               ;; its own Perl path to search in this folder.
               (install-file "src/perl/lib/Utils.pm" lib)

               ;; The configureStrelkaWorkflow.pl script looks for the
               ;; strelka2 binary in the libexec directory.
               (system* "ln" "--symbolic"
                        (string-append bin "/strelka2")
                        (string-append libexec "/strelka2"))))))))
    (inputs
     `(("boost" ,boost)
       ("perl" ,perl)
       ("bash" ,bash)
       ("zlib" ,zlib)
       ("samtools" ,samtools)))
    (native-inputs
     `(("bash" ,bash)
       ("python" ,python-2)
       ("gcc" ,gcc-toolchain-5)))
    (propagated-inputs
     `(("vcftools" ,vcftools)
       ("htslib" ,htslib)))
    (native-search-paths (package-native-search-paths perl))
    (home-page "https://sites.google.com/site/strelkasomaticvariantcaller/")
    (synopsis "Somatic variant calling workflow for matched tumor-normal samples")
    (description "Analysis package designed to detect somatic SNVs and small
indels from the aligned sequencing reads of matched tumor-normal samples")
    ;; WARNING: The license is "Illumina Open Source Software License 1".
    ;; This effectively makes it nonfree software.
    (license license:non-copyleft)))

(define-public strelka-1.0.14
  (package (inherit strelka-1.0.15)
    (name "strelka")
    (version "1.0.14")
    (source (origin
      (method url-fetch)
      (uri (string-append
        "ftp://strelka:''@ftp.illumina.com/v1-branch/v"
        version "/strelka_workflow-" version ".tar.gz"))
      (sha256
        (base32 "0f9g2pkr1f7s4r8sxl53jxr2cjpyx53zf3va0jj8fxzavxiwmbmk"))
      (patches (list (search-patch "strelka-disable-tests.patch")
                     (search-patch "strelka-disable-install.patch")))))
    (propagated-inputs
     `(("vcftools" ,vcftools)
       ("htslib" ,htslib)))))

(define-public codemin
  (package
   (name "codemin")
   (version "1.0.5")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/Illumina/strelka/raw/"
                  "5a993884687f2d92f794109e171d0bdeb95e504d"
                  "/redist/CodeMin-1.0.5.tar.bz2"))
            (sha256
             (base32 "1y8wsli1q626i80p3dmrc65p77ch164hj2sbxv497i9y89kvk35s"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f ; There are no tests.
      #:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (delete 'build)
        (replace 'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let ((include-dir (string-append
                                (assoc-ref outputs "out") "/include")))
              (mkdir-p include-dir)
              (copy-recursively "include" include-dir)))))))
   (home-page "https://github.com/Illumina/strelka/tree/master/redist")
   (synopsis "Set of lightweight minimization functions.")
   (description "The CodeMin minimization library provides a set of lightweight
minimization functions originally developed for the CodeAxe phylogenetic
analysis package.")
   ;; MIT license.
   (license license:expat)))

(define-public strelka-2.9.2
  (package
   (name "strelka")
   (version "2.9.2")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/Illumina/strelka/releases/download/v"
                  version "/strelka-" version ".release_src.tar.bz2"))
            (sha256
             (base32 "19bq2wzlxmnv8rx112y8z0sfvgsajnd0m945njmfy9p170qjqr27"))
            (patches
             (list (search-patch "strelka2-unbundle-dependencies.patch")))))
   (build-system cmake-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (add-after 'unpack 'unbundle-dependencies
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (substitute* "redist/CMakeLists.txt"
              ;; HTSlib
              (("superset\\(HTSLIB_DIR \"\\$\\{CMAKE_CURRENT_BINARY_DIR\\}/\\$\\{HTSLIB_PREFIX\\}\"\\)")
               (format #f "superset(HTSLIB_DIR \"~a/bin\")" (assoc-ref inputs "htslib")))
              (("superset\\(HTSLIB_LIBRARY \"\\$\\{HTSLIB_DIR\\}/libhts.a\"\\)")
               (format #f "superset(HTSLIB_LIBRARY \"~a/lib/libhts.so\")"
                       (assoc-ref inputs "htslib")))
              ;; SAMtools
              (("set\\(SAMTOOLS_DIR \"\\$\\{CMAKE_CURRENT_BINARY_DIR}/\\$\\{SAMTOOLS_PREFIX\\}\"\\)")
               (format #f "set(SAMTOOLS_DIR \"~a/bin\")"
                       (assoc-ref inputs "samtools")))
              (("set\\(SAMTOOLS_LIBRARY \"\\$\\{SAMTOOLS_DIR\\}/libbam.a\"\\)")
               (format #f "set(SAMTOOLS_LIBRARY \"~a/lib/libbam.a\")"
                       (assoc-ref inputs "samtools"))))))
        (add-after 'install 'install-shared-libraries
          (lambda* (#:key inputs outputs  #:allow-other-keys)
            (let ((libdir (string-append (assoc-ref outputs "out") "/lib")))
              (mkdir-p libdir)
              (map (lambda (file)
                     (copy-file file (string-append libdir "/" (basename file))))
                   (find-files "." "\\.so")))))
        (add-after 'install 'patch-python-bin
          (lambda* (#:key inputs outputs  #:allow-other-keys)
            (let ((patch-path (string-append (assoc-ref outputs "out") "/lib/python")))
              (substitute* (list (string-append patch-path "/makeRunScript.py")
                                 (string-append patch-path "/pyflow/pyflow.py"))
                (("/usr/bin/env python")
                 (string-append (assoc-ref inputs "python") "/bin/python")))))))))
   (inputs
    `(("boost" ,boost)
      ("perl" ,perl)
      ("bash" ,bash)
      ("zlib" ,zlib)
      ("samtools" ,samtools)
      ("rapidjson" ,rapidjson)
      ("codemin" ,codemin)
      ("curl" ,curl)
      ("xz" ,xz)
      ("openssl" ,openssl)
      ("samtools" ,samtools)
      ("zlib" ,zlib)
      ("python" ,python)))
   (native-inputs
    `(("bash" ,bash)
      ("python" ,python-2)
      ("doxygen" ,doxygen)
      ("graphviz" ,graphviz)))
   (propagated-inputs
    `(("vcftools" ,vcftools)
      ("htslib" ,htslib)))
   (native-search-paths (package-native-search-paths perl))
   (home-page "https://github.com/Illumina/strelka")
   (synopsis "Small variant caller")
   (description "Strelka2 is a fast and accurate small variant caller optimized
for analysis of germline variation in small cohorts and somatic variation in
tumor/normal sample pairs.  The germline caller employs an efficient tiered
haplotype model to improve accuracy and provide read-backed phasing, adaptively
selecting between assembly and a faster alignment-based haplotyping approach at
each variant locus.  The germline caller also analyzes input sequencing data
using a mixture-model indel error estimation method to improve robustness to
indel noise.  The somatic calling model improves on the original Strelka method
for liquid and late-stage tumor analysis by accounting for possible tumor cell
contamination in the normal sample.  A final empirical variant re-scoring step
using random forest models trained on various call quality features has been
added to both callers to further improve precision.")
   (license license:gpl3+)))

(define-public strelka strelka-2.9.2)

(define (varscan version commit hash)
  (let ((jar-file (string-append "varscan-" version ".jar")))
    (package
      (name "varscan")
      (version version)
      (source (origin
                (method url-fetch)
                (uri (string-append
                      "https://github.com/dkoboldt/varscan/raw/"
                      commit "/VarScan.v" version ".source.jar"))
                (sha256 (base32 hash))))
      (build-system ant-build-system)
      (arguments
       `(#:tests? #f ; No test target.
         #:phases
         (modify-phases %standard-phases
           (replace 'unpack
             (lambda _
               (mkdir "source")
               (chdir "source")
               (and
                ;; Unpack the Java archive containing the source files.
                (zero? (system* "jar" "xf" (assoc-ref %build-inputs "source")))
                ;; Remove existing compiled output.
                (with-directory-excursion "net/sf/varscan/"
                  (for-each (lambda (file)
                              (unless (string= (string-take-right file 5) ".java")
                                (zero? (system* "rm" file))))
                            (find-files "." #:directories? #f))))))
           (replace 'build
             (lambda _
               ;; Keep a list of files to be included in the JAR.
               (let ((out-files '("META-INF/MANIFEST.MF"))
                     (sources-dir "net/sf/varscan/"))
                 (and
                  (with-directory-excursion sources-dir
                    (for-each
                     (lambda (file)
                       (when (string= (string-take-right file 5) ".java")
                         ;; Compile the source files.
                         (zero? (system* "javac" file))
                         ;; Add to list of files to be included in the JAR.
                         (set! out-files
                               (append
                                out-files
                                (list (string-append sources-dir
                                  (string-drop-right (string-drop file 2) 5)
                                  ".class"))))))
                     (find-files "." #:directories? #f)))
                  ;; Construct the Java archive.
                  (let ((params (append '("jar" "cfm" ,jar-file) out-files)))
                    (zero? (apply system* params)))))))
           (replace 'install
             (lambda _
               (let ((out (string-append (assoc-ref %outputs "out")
                                         "/share/java/varscan/")))
                 (install-file ,jar-file out)))))))
      (home-page "http://dkoboldt.github.io/varscan/")
      (synopsis "Variant detection in massively parallel sequencing data")
      (description "")
      ;; Free for non-commercial use by academic, government, and
      ;; non-profit/not-for-profit institutions
      (license license:non-copyleft))))

(define-public varscan-2.4.0
  (varscan "2.4.0" "ed3227992f31725548d6106dc7fcd0bd8879ff1e"
           "1qyl93awj31qg4pbwaicm5vgq4zv5b9aqa10dpna9qrvbcqfdz90"))

(define-public varscan-2.4.1
  (varscan "2.4.1" "91f116629b2addce523a2eabe118b1cd7a538444"
           "0y45ympkza7qwcbcisg006286pwjbr5978n03hx5nvl09f0mapk8"))

(define-public varscan-2.4.2
  (varscan "2.4.2" "18425ce00e3ced8afc624bd86de142b1cd1e0eb0"
           "14f7fp0yaj3lsif1dpjdci7kz3b2fd9qic3299a2bvgk3rv3lp6n"))

(define-public manta-1.6.0
  (package
   (name "manta")
   (version "1.6.0")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/Illumina/manta/archive/v"
                  version ".tar.gz"))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
              (base32 "08b440hrxm5v5ac2iw76iaa398mgj6qa7yc1cfqjrfd3jm57rkkn"))
            (patches (list (search-patch "manta-relax-dependency-checking.patch")))))
   (build-system cmake-build-system)
   (arguments
    `(#:phases
      (modify-phases %standard-phases
        ;; The 'manta-relax-dependency-checking.patch' sets the samtools path to
        ;; '/usr/bin'.  This allows us to substitute it for the actual path
        ;; of samtools in the store.
        (add-before 'configure 'patch-samtools-path
          (lambda* (#:key inputs #:allow-other-keys)
            (substitute* "redist/CMakeLists.txt"
             (("set\\(SAMTOOLS_DIR \"/usr/bin\"\\)")
              (string-append "set(SAMTOOLS_DIR \""
                             (assoc-ref inputs "samtools") "/bin\")")))
            #t))
        (add-before 'configure 'fix-tool-paths
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (substitute* "src/python/lib/mantaOptions.py"
              (("bgzipBin=joinFile\\(libexecDir,exeFile\\(\"bgzip\"\\)\\)")
               (string-append "bgzipBin=\"" (string-append
                                             (assoc-ref inputs "htslib")
                                             "/bin/bgzip") "\""))
              (("htsfileBin=joinFile\\(libexecDir,exeFile\\(\"htsfile\"\\)\\)")
               (string-append "htsfileBin=\"" (string-append
                                               (assoc-ref inputs "htslib")
                                               "/bin/htsfile") "\""))
              (("tabixBin=joinFile\\(libexecDir,exeFile\\(\"tabix\"\\)\\)")
               (string-append "tabixBin=\"" (string-append
                                           (assoc-ref inputs "htslib")
                                           "/bin/tabix" "\"")))
              (("samtoolsBin=joinFile\\(libexecDir,exeFile\\(\"samtools\"\\)\\)")
               (string-append "samtoolsBin=\"" (string-append
                                              (assoc-ref inputs "samtools")
                                              "/bin/samtools" "\""))))
            (substitute* '("src/demo/runMantaWorkflowDemo.py"
                           "src/python/bin/configManta.py"
                           "src/python/lib/makeRunScript.py"
                           "src/python/libexec/cat.py"
                           "src/python/libexec/convertInversion.py"
                           "src/python/libexec/denovo_scoring.py"
                           "src/python/libexec/extractSmallIndelCandidates.py"
                           "src/python/libexec/mergeBam.py"
                           "src/python/libexec/mergeChromDepth.py"
                           "src/python/libexec/ploidyFilter.py"
                           "src/python/libexec/sortBam.py"
                           "src/python/libexec/sortEdgeLogs.py"
                           "src/python/libexec/sortVcf.py"
                           "src/python/libexec/updateSampleFTFilter.py"
                           "src/python/libexec/vcfCmdlineSwapper.py"
                           "src/srcqc/run_cppcheck.py")
                         (("/usr/bin/env python") (string-append
                                                    (assoc-ref inputs "python")
                                                    "/bin/python")))
            #t))
        (add-after 'install 'fix-pyflow-shebang
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (substitute* (string-append (assoc-ref outputs "out")
                                        "/lib/python/pyflow/pyflow.py")
              (("#!/usr/bin/env python")
               (string-append "#!" (assoc-ref inputs "python")
                              "/bin/python")))
            #t)))))
    (inputs
     `(("cmake" ,cmake)
       ("boost" ,boost)
       ("pyflow" ,pyflow-2)
       ("python" ,python-2)
       ("cppcheck" ,cppcheck)
       ("doxygen" ,doxygen)
       ("graphviz" ,graphviz)
       ("htslib" ,htslib)
       ("samtools" ,samtools)
       ("zlib" ,zlib)
       ("bash" ,bash)))
    (home-page "https://github.com/Illumina/manta")
   (synopsis "Structural variant and indel caller for mapped sequencing data")
   (description "Manta calls structural variants (SVs) and indels from mapped
paired-end sequencing reads.  It is optimized for analysis of germline variation
in small sets of individuals and somatic variation in tumor/normal sample pairs.
Manta discovers, assembles and scores large-scale SVs, medium-sized indels and
large insertions within a single efficient workflow.")
   (license license:gpl3)))

(define-public iq-tree
  (package
    (name "iq-tree")
    (version "1.6.12")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/Cibiv/IQ-TREE/archive/v"
                    version ".tar.gz"))
              (sha256
               (base32 "11528sxv9hkmg20r2fy9zyq0rylbrhcjnh6cr61dwmx1wwnhj54n"))))
    (build-system cmake-build-system)
    (arguments
     `(#:configure-flags '("-DIQTREE_FLAGS=omp")
       #:tests? #f))
    (inputs
     `(("eigen" ,eigen)
       ("zlib" ,zlib)))
    (home-page "http://www.iqtree.org/")
    (synopsis "Efficient software for phylogenomic inference")
    (description
     "This package provides software for phylogenomic inference.")
    (license license:gpl2)))

(define-public cat
  (package
   (name "cat")
   (version "5.0.3")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/dutilh/CAT/archive/v"
                  version".tar.gz"))
            (sha256
             (base32
              "1gbq4vj0i7srylvb56ipmzcnh8zk34kfmyx76fbxh2cljp0p4k7x"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (delete 'build)
        (replace 'install
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let ((bin (string-append (assoc-ref outputs "out") "/bin"))
                  (share (string-append (assoc-ref outputs "out") "/share/CAT")))
              (mkdir-p bin)
              (mkdir-p share)
              (with-directory-excursion "CAT_pack"
                (install-file "CAT" bin)

                ;; Don't pollute the "bin" directory with Python libraries.
                (map (lambda (file)
                       (when (string-suffix? ".py" file)
                         (install-file file share)))
                     (find-files "."))

                ;; Make sure CAT can find its Python libraries.
                (wrap-program (string-append bin "/CAT")
                 `("PYTHONPATH" ":" = (,share "$PYTHONPATH"))))))))))
   (inputs
    `(("diamond" ,diamond)
      ("prodigal" ,prodigal)
      ("python" ,python)))
   (home-page "https://github.com/dutilh/CAT")
   (synopsis "Tool for taxonomic classification of contigs and metagenome-assembled genomes")
   (description "Contig Annotation Tool (CAT) and Bin Annotation Tool (BAT)
are pipelines for the taxonomic classification of long DNA sequences and
metagenome assembled genomes (MAGs/bins) of both known and (highly) unknown
microorganisms, as generated by contemporary metagenomics studies.  The core
algorithm of both programs involves gene calling, mapping of predicted ORFs
against the nr protein database, and voting-based classification of the entire
contig / MAG based on classification of the individual ORFs.  CAT and BAT can
be run from intermediate steps if files are formated appropriately")
   (license license:expat)))

(define-public clinvar
  (package
   (name "clinvar-vcf")
   (version "GRCh38-20200919")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh38/clinvar.vcf.gz"))
            (sha256
             (base32
	      "06wdfg6wkksra4if1hil78p9707l9zq8h74cc4mpqrhl1vv8j8sq"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let ((source-file (assoc-ref %build-inputs "source"))
              (output-dir (string-append %output "/share/clinvar/GRCh38")))
          (mkdir-p output-dir)
          (copy-file source-file
                     (string-append output-dir "/clinvar.vcf.gz"))))))
   (home-page "https://www.ncbi.nlm.nih.gov/clinvar/")
   (synopsis "Public archive of reports of human genetic variation")
   (description "ClinVar is a freely accessible, public archive of reports
of the relationships among human variations and phenotypes, with supporting
evidence.  ClinVar thus facilitates access to and communication about the
relationships asserted between human variation and observed health status,
and the history of that interpretation.  ClinVar processes submissions
reporting variants found in patient samples, assertions made regarding their
clinical significance, information about the submitter, and other supporting
data.  The alleles described in submissions are mapped to reference sequences,
and reported according to the HGVS standard.  ClinVar then presents the data
for interactive users as well as those wishing to use ClinVar in daily
workflows and other local applications.  ClinVar works in collaboration with
interested organizations to meet the needs of the medical genetics community
as efficiently and effectively as possible.")
   (license #f)))

(define-public clinvar-grch37
  (package (inherit clinvar)
    (version "GRCh37-20200919")
    (source (origin
             (method url-fetch)
             (uri (string-append
                   "ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf_GRCh37/clinvar.vcf.gz"))
             (sha256
              (base32
               "0srdr8mwf2wnch8v5gkdj0lqqmm50inzysh9cb4gb7ndrbwhharv"))))
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let ((source-file (assoc-ref %build-inputs "source"))
              (output-dir (string-append %output "/share/clinvar/GRCh37")))
          (mkdir-p output-dir)
          (copy-file source-file
                     (string-append output-dir "/clinvar.vcf.gz"))))))))

(define-public dbsnp
  (package
    (name "dbsnp")
    (version "human_9606")
    (source (origin
              (method url-fetch)
              (uri "ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606/VCF/00-All.vcf.gz")
              (sha256
               (base32
                "0f2zzi0br0c1dvlx6wfgfm6f7rgp0kb19gb6p0kxzbs3n92viiqa"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((source-file (assoc-ref %build-inputs "source"))
                (output-dir  (string-append %output "/share/dbsnp"))
                (output-file (string-append output-dir "/dbSnp.vcf.gz")))
           (mkdir-p output-dir)
           (copy-file source-file output-file)
           (symlink output-file (string-append output-dir "/00-All.vcf.gz"))))))
    (home-page "https://www.ncbi.nlm.nih.gov/projects/SNP/")
    (synopsis "Short genetic variations")
    (description "")
    (license #f)))

(define-public 1000genomes-phase1-indels
  (package
    (name "1000genomes-phase1-indels")
    (version "b37")
    (source (origin
              (method url-fetch)
              (uri (string-append "ftp://"
                                  "gsapubftp-anonymous@"
                                  "ftp.broadinstitute.org/bundle/b37/"
                                  "1000G_phase1.indels.b37.vcf.gz"))
              (sha256
               (base32 "173kkmyvyvfa55v2rbpywsrp7159yyl1sx30y243jkxzkjrgc7bc"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((source-file (assoc-ref %build-inputs "source"))
                (output-dir (string-append %output "/share/1000G"))
                (output-file-uncompressed (string-append output-dir
                                            "/1000G_phase1.indels.b37.vcf"))
                (output-file (string-append output-file-uncompressed ".gz"))
                (java (string-append (assoc-ref %build-inputs "icedtea")
                                     "/bin/java"))
                (igvtools (string-append (assoc-ref %build-inputs "igvtools")
                                         "/share/java/igvtools/igvtools.jar"))
                (path (string-append (assoc-ref %build-inputs "htslib") "/bin:"
                                     (assoc-ref %build-inputs "gzip") "/bin")))
           ;; The gunzip command needs to find gzip in PATH.
           (setenv "PATH" path)
           (mkdir-p output-dir)
           (copy-file source-file output-file)

           ;; To create the index, we need to compress the VCF file with
           ;; bgzip, instead of the regular gzip.
           (system* "gunzip" output-file)
           (system* "bgzip" output-file-uncompressed)

           ;; Finally, we can index the file using igvtools.
           (system* java "-jar" igvtools "index" output-file)))))
    (inputs
     `(("icedtea" ,icedtea-7)
       ("igvtools" ,igvtools)
       ("htslib" ,htslib)
       ("gzip" ,gzip)))
    (home-page "http://www.internationalgenome.org/")
    (synopsis "Initial map of insertions and deletions in the human genome")
    (description "")
    (license #f)))

(define-public mills-1000G-gold-standard-indels
  (package
    (name "1000genomes-mills-gold-standard-indels")
    (version "b37")
    (source (origin
              (method url-fetch)
              (uri (string-append "ftp://"
                                  "gsapubftp-anonymous@"
                                  "ftp.broadinstitute.org/bundle/b37/"
                                  "Mills_and_1000G_gold_standard.indels.b37.vcf.gz"))
              (sha256
               (base32 "1n9bf6chfr9pxhk0mfiiqy28pmkyb0xpxz0rwvwrw031cw39dc1l"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((source-file (assoc-ref %build-inputs "source"))
                (output-dir (string-append %output "/share/1000G"))
                (output-file-wo-ext
                 (string-append output-dir
                                "/Mills_and_1000G_gold_standard.indels.b37"))
                (bcf-output-file (string-append output-file-wo-ext ".bcf"))
                (output-file-uncompressed (string-append output-file-wo-ext ".vcf"))
                (output-file (string-append output-file-uncompressed ".gz"))
                (java (string-append (assoc-ref %build-inputs "icedtea")
                                     "/bin/java"))
                (igvtools (string-append (assoc-ref %build-inputs "igvtools")
                                         "/share/java/igvtools/igvtools.jar"))
                (path (string-append (assoc-ref %build-inputs "htslib") "/bin:"
                                     (assoc-ref %build-inputs "gzip") "/bin:"
                                     (assoc-ref %build-inputs "bcftools") "/bin:"
                                     (assoc-ref %build-inputs "grep") "/bin")))

           ;; The gunzip command needs to find gzip in PATH.
           (setenv "PATH" path)
           (mkdir-p output-dir)
           (copy-file source-file output-file)

           ;; To create the index, we need to compress the VCF file with
           ;; bgzip, instead of the regular gzip.
           (system* "gunzip" output-file)
           (chmod output-file-uncompressed #o644)

           ;; The "vcf" file seems to be actually a "bcf" file.  We can use bcftools to
           ;; convert it to a VCF file.
           (rename-file output-file-uncompressed bcf-output-file)
           (system (string-append "bcftools view "
                                  bcf-output-file
                                  " | grep -v bcftools_view > "
                                  output-file-uncompressed))

           (system* "bgzip" output-file-uncompressed)
           (delete-file bcf-output-file)

           ;; Finally, we can index the file using igvtools.
           (system* java "-jar" igvtools "index" output-file)))))
    (inputs
     `(("icedtea" ,icedtea-7)
       ("igvtools" ,igvtools)
       ("htslib" ,htslib)
       ("gzip" ,gzip)
       ("bcftools" ,bcftools)
       ("grep" ,grep)))
    (home-page "http://www.internationalgenome.org/")
    (synopsis "Initial map of insertions and deletions in the human genome")
    (description "")
    (license #f)))

(define-public dbsnp-138
  (package
    (name "dbsnp")
    (version "138-b37")
    (source (origin
              (method url-fetch)
              (uri (string-append "ftp://"
                                  "gsapubftp-anonymous@"
                                  "ftp.broadinstitute.org/bundle/b37/"
                                  "dbsnp_138.b37.vcf.gz"))
              (sha256
               (base32 "0c7i6qw6j6chhqni826jr98b4kfjg72mql36wdfydiiv7679zx5n"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let* ((source-file (assoc-ref %build-inputs "source"))
                (output-dir (string-append %output "/share/1000G"))
                (output-file-uncompressed (string-append output-dir
                                            "/dbsnp_138.b37.vcf"))
                (output-file (string-append output-file-uncompressed ".gz"))
                (java (string-append (assoc-ref %build-inputs "icedtea")
                                     "/bin/java"))
                (igvtools (string-append (assoc-ref %build-inputs "igvtools")
                                         "/share/java/igvtools/igvtools.jar"))
                (path (string-append (assoc-ref %build-inputs "htslib") "/bin:"
                                     (assoc-ref %build-inputs "gzip") "/bin")))
           ;; The gunzip command needs to find gzip in PATH.
           (setenv "PATH" path)
           (mkdir-p output-dir)
           (copy-file source-file output-file)

           ;; To create the index, we need to compress the VCF file with
           ;; bgzip, instead of the regular gzip.
           (system* "gunzip" output-file)
           (system* "bgzip" output-file-uncompressed)

           ;; Finally, we can index the file using igvtools.
           (system* java "-jar" igvtools "index" output-file)))))
    (inputs
     `(("icedtea" ,icedtea-7)
       ("igvtools" ,igvtools)
       ("htslib" ,htslib)
       ("gzip" ,gzip)))
    (home-page "")
    (synopsis "")
    (description "")
    (license #f)))

(define-public dx-tracks
  (package
    (name "dx-tracks")
    (version "1.2.1")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/UMCUGenetics/Dx_tracks/releases/"
                    "download/v" version "/v" version ".tar.gz"))
              (sha256
               (base32 "0vcyd888yq6qqal5n9l5g361nzx3wq70zlbn9bhza2qkhfd3n5pp"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((tar (string-append (assoc-ref %build-inputs "tar") "/bin/tar"))
               (input-file (assoc-ref %build-inputs "source"))
               (output-dir (string-append %output "/share/data/dx-tracks"))
               (PATH (string-append (assoc-ref %build-inputs "gzip") "/bin")))
           (setenv "PATH" PATH)
           (mkdir-p output-dir)
           (with-directory-excursion output-dir
             (system* tar "-xvf" input-file "--strip-components=1"))))))
    (inputs
     `(("tar" ,tar)
       ("gzip" ,gzip)))
    (home-page "https://github.com/UMCUGenetics/Dx_tracks")
    (synopsis "")
    (description "")
    ;; The files are licensed CC-BY-ND.  The NoDerivatives clause makes it
    ;; non-free, and therefore, the license cannot be added to Guix upstream.
    (license #f)))

(define-public dbnsfp
  (package
    (name "dbnsfp")
    (version "2.9.3")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "ftp://dbnsfp:dbnsfp@dbnsfp.softgenetics.com/dbNSFPv"
                    version ".zip"))
              (sha256
               (base32
                "132z7rayqdwc04b8bw19amvwyhg67vyscyv1zrb486r49icf73mz"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((source-file (assoc-ref %build-inputs "source"))
               (output-dir  (string-append %output "/share/dbnsfp"))
               (unzip       (string-append (assoc-ref %build-inputs "unzip") "/bin/unzip"))
               (gzip        (string-append (assoc-ref %build-inputs "gzip") "/bin/gzip")))
           (mkdir-p output-dir)
           (with-directory-excursion output-dir
             (system* unzip source-file)
             (for-each (lambda (file)
                         (format #t "Compressing ~s~%" file)
                         (system* gzip file))
                       (find-files output-dir)))))))
    (inputs
     `(("unzip" ,unzip)
       ("gzip" ,gzip)))
    (home-page "https://sites.google.com/site/jpopgen/dbNSFP")
    (synopsis "Database for functional prediction of non-synonymous SNPs")
    (description " dbNSFP is a database developed for functional prediction and
annotation of all potential non-synonymous single-nucleotide variants (nsSNVs)
in the human genome.")
    (license #f)))

(define-public giab-na12878-high-confidence-regions
  (package
    (name "giab-na12878-high-confidence-regions")
    (version "NISTv3.2.2")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/"
                    "NA12878_HG001/" version "/NA12878_GIAB_highconf_IllFB"
                    "-IllGATKHC-CG-Ion-Solid_ALLCHROM_v3.2.2_highconf.bed"))
              (sha256
               (base32 "1adj878im498lfplklkir7v2chv1bxamgw3y2a62599wvbhap79q"))))
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((source-file (assoc-ref %build-inputs "source"))
               (output-dir (string-append %output "/share/giab")))
           (mkdir-p output-dir)
           (copy-file source-file
                      (string-append output-dir "/NA12878_GIAB_highconf_IllFB"
                                     "-IllGATKHC-CG-Ion-Solid_ALLCHROM_v3.2.2"
                                     "_highconf.bed"))))))
    (home-page "http://jimb.stanford.edu/giab")
    (synopsis "")
    (description "")
    (license #f)))

(define-public gwascatalog
  (package
   (name "gwascatalog")
   (version "GRCh37")
   (source (origin
            (method url-fetch)
            ;(uri "http://www.genome.gov/admin/gwascatalog.txt")
            (uri "http://www.roelj.com/gwascatalog.txt")
            (sha256
             (base32
              "137xb3r3w6k8syj6dh6a856fvszcjlylwpzp98m35w5q52vxhdnx"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder
      (begin
        (use-modules (guix build utils))
        (let ((source-file (assoc-ref %build-inputs "source"))
              (output-dir (string-append %output "/share/gwascatalog")))
          (mkdir-p output-dir)
          (copy-file source-file
                     (string-append output-dir "/gwascatalog.txt"))))))
   (home-page "http://www.genome.gov/")
   (synopsis "Extra data sets used by snpEff.")
   (description "This package contains extra data sets used by snpEff.")
   (license #f)))

(define-public libmaus
  (package
   (name "libmaus")
   (version "0.0.196")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/gt1/libmaus/archive/"
                  version "-release-20150326095654.tar.gz"))
            (sha256
             (base32
              "0g92bl37ci8pzkgi2xnn2bck7y655jwcb1bm3mg42mj5lf5x2i5b"))))
   (build-system gnu-build-system)
   (native-inputs
    `(("pkg-config" ,pkg-config)))
   (inputs
    `(("zlib" ,zlib)))
   (home-page "https://github.com/gt1/libmaus")
   (synopsis "Collection of bioinformatics data structures and algorithms")
   (description "This package contains a collection of bioinformatics data
structures and algorithms.  It provides I/O classes, bitio classes, text
indexing classes and BAM sequence alignment functionality.")
   (license license:gpl3+)))

(define-public biobambam
  (package
   (name "biobambam")
   (version "0.0.191")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/gt1/biobambam/archive/" version
                  "-release-20150401083643.tar.gz"))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "065fcwdh5sb6dg3mf5qk9w2818jxm27pvbv976qc00y7np2y2nqz"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f))
   (inputs
    `(("libmaus" ,libmaus)
      ("zlib" ,zlib)))
   (native-inputs
    `(("pkg-config" ,pkg-config)))
   (home-page "https://github.com/gt1/biobambam")
   (synopsis "Collection of tools to work with BAM files")
   (description "This package contains the following programs: bamcollate2,
bammarkduplicates, bammaskflags, bamrecompress, bamsort, bamtofastq.")
   (license license:gpl3+)))

(define-public pcap-core
  (package
   (name "pcap-core")
   (version "3.5.0")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/ICGC-TCGA-PanCancer/PCAP-core/archive/v"
                  version ".tar.gz"))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "06im5lf00jyghwmqjzb3dpglgjx7pi5ysda75fw8ygmj1fi5q8kj"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (replace 'configure
          (lambda* (#:key outputs #:allow-other-keys)
            (system* "perl" "Makefile.PL"
                     (string-append "PREFIX=" (assoc-ref outputs "out"))))))))
   (propagated-inputs
    `(("bwa" ,bwa)
      ("samtools" ,samtools)
      ("biobambam" ,biobambam)))
   (native-inputs
    `(("perl-module-install" ,perl-module-install)
      ("perl-module-build" ,perl-module-build)
      ("perl-file-sharedir-install" ,perl-file-sharedir-install)
      ("perl" ,perl)
      ("perltidy" ,perltidy)))
   (home-page "https://github.com/ICGC-TCGA-PanCancer/PCAP-core")
   (synopsis "NGS reference implementations and helper code for the ICGC/TCGA
Pan-Cancer Analysis Project")
   (description "")
   (license license:gpl2+)))

(define-public allelecount
  (package
    (name "allelecount")
    (version "3.3.1")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/cancerit/alleleCount/archive/v"
                    version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "0yza03nma4y5f34x61pdi902fkv9hzkfbpry9qs3nphjf6q5wcwj"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-before 'build 'move-to-subdirectory
           (lambda _
             (chdir "perl")))
         (replace 'build
           (lambda* (#:key inputs outputs #:allow-other-keys)
             (system* "perl" "Makefile.PL"
                      (string-append "PREFIX=" (assoc-ref outputs "out")))
             (system* "make")
             ;; Build the C alleleCounter program.
             (chdir "../c")
             (mkdir-p "bin")
             (substitute* "src/bam_access.c"
               (("\\#include <cram\\/cram.h>") "#include <htslib/cram.h>"))
             (system* "make")
             ;; Don't interfere with the "make install" command for the Perl
             ;; version.
             (chdir "../perl")))
         (add-after 'install 'install-allelecounter
           (lambda* (#:key outputs #:allow-other-keys)
             (let ((out (string-append (assoc-ref outputs "out") "/bin")))
               (install-file "../c/bin/alleleCounter" out)))))))
    (propagated-inputs
     `(("perl-const-fast" ,perl-const-fast)
       ("perl-sub-exporter-progressive" ,perl-sub-exporter-progressive)
       ("perl-bio-db-hts" ,perl-bio-db-hts)
       ("bioperl-minimal" ,bioperl-minimal)))
    (inputs
     `(("zlib" ,zlib)
       ("htslib" ,htslib)
       ("perl-pod-coverage" ,perl-pod-coverage)
       ("perl-file-which" ,perl-file-which)
       ("perl-test-fatal" ,perl-test-fatal)
       ("perl-try-tiny" ,perl-try-tiny)
       ("samtools" ,samtools)))
    (native-inputs
     `(("perl-module-build" ,perl-module-build)
       ("perl" ,perl)))
    (home-page "https://github.com/cancerit/alleleCount")
    (synopsis "Support code for NGS copy number algorithms")
    (description "This package primarily exists to prevent code duplication
between some other projects, specifically AscatNGS and Battenburg.")
    (license license:agpl3+)))

(define-public cgpvcf
  (package
   (name "cgpvcf")
   (version "2.0.4")
   (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/cancerit/cgpVcf/archive/v"
                                version ".tar.gz"))
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32 "009vpq2l1pxqfsvckapzxav5xr6kcjvg3krrfdx40qammcr4q1ak"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (replace 'configure
          (lambda* (#:key outputs #:allow-other-keys)
            (system* "perl" "Makefile.PL"
                     (string-append "PREFIX=" (assoc-ref outputs "out"))))))))
   (propagated-inputs
    `(("perl-bio-pipeline-comparison" ,perl-bio-pipeline-comparison)
      ("perl-const-fast" ,perl-const-fast)
      ("perl-data-uuid" ,perl-data-uuid)
      ("perl-datetime" ,perl-datetime)))
   (native-inputs
    `(("perl-module-install" ,perl-module-install)
      ("perl-module-build" ,perl-module-build)
      ("perl" ,perl)
      ("perltidy" ,perltidy)))
   (home-page "http://cancerit.github.io/cgpVcf/")
   (synopsis "")
   (description "")
   (license license:agpl3+)))

;; FIXME: This software cannot be trusted.
;; There is no source code, nor an intent to support any other version than
;; the "latest", which can change any moment.
(define-public impute2-bin
  (package
    (name "impute2")
    (version "2.3.2")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://mathgen.stats.ox.ac.uk/impute/impute_v"
                    version "_x86_64_static.tgz"))
              (sha256
               (base32 "0py4m0asp1459nn1xsv552n3azqcfhipa4si8bzxs1a58q05jqcm"))))
    (supported-systems '("x86_64-linux"))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (delete 'build)
         (replace 'install
           (lambda _
             (let ((out (string-append (assoc-ref %outputs "out") "/bin")))
               (install-file "impute2" out)))))))
    (home-page "https://mathgen.stats.ox.ac.uk/impute/impute_v2.html")
    (synopsis "")
    (description "")
    (license #f)))

(define-public r-ascat
  (let ((commit "9fb25feaae2d7d25a17f5eff7b99666ad7afbba8"))
    (package
     (name "r-ascat")
     (version (string-append "2.5.1-" (string-take commit 7)))
     (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/Crick-CancerGenomics/ascat.git")
                    (commit commit)))
              (sha256
               (base32
                "02fxhqv4yf9dby8mmjb39fyqd141k3z4nhj0p8m2h4n7a476bdsc"))))
     (build-system r-build-system)
     (arguments
      `(#:phases
        (modify-phases %standard-phases
         (add-after 'unpack 'move-to-ascat-dir
           (lambda _
             (chdir "ASCAT"))))))
     (propagated-inputs
      `(("r-rcolorbrewer" ,r-rcolorbrewer)))
     (home-page "https://github.com/Crick-CancerGenomics/ascat")
     (synopsis "ASCAT copy number R package")
     (description "This package provides the ASCAT R package that can be used
to infer tumour purity, ploidy and allele-specific copy number profiles.")
     (license license:gpl3))))

(define-public cgp-battenberg-r
  (package
   (name "cgp-battenberg-r")
   (version "2.2.8")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/Wedge-Oxford/battenberg/archive/v"
                  version ".tar.gz"))
            (sha256
             (base32 "0gi9zv8clr795mzplf1d3dm5agc78xz40kmwckcjqaji4dnbcik1"))))
   (build-system r-build-system)
   (propagated-inputs
    `(("r-devtools" ,r-devtools)
      ("r-readr" ,r-readr)
      ("r-doparallel" ,r-doparallel)
      ("r-ggplot2" ,r-ggplot2)
      ("r-rcolorbrewer" ,r-rcolorbrewer)
      ("r-gridextra" ,r-gridextra)
      ("r-gtools" ,r-gtools)
      ("r-ascat" ,r-ascat)))
   (home-page "https://github.com/Wedge-Oxford/battenberg")
   (synopsis "Battenberg R package for subclonal copy number estimation")
   (description "This package contains the Battenberg R package for subclonal
copy number estimation.")
   (license license:gpl3)))

(define-public cgp-battenberg-3.3.0
  (package
    (name "cgp-battenberg")
    (version "3.3.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/cancerit/cgpBattenberg/archive/v"
                    version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "17rrciv8c8vdvcx4yljkkl8rlzlpasrnl0i2c0q72zxvzgh9c8z3"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ;; The Perl in Guix does not support threads.
         ;; The forks module is a drop-in replacement for it, so it
         ;; is easier to use that instead of recompiling Perl.
         (add-after 'unpack 'enable-threads
           (lambda _
             (substitute* "perl/bin/battenberg.pl"
               (("use strict;") "use forks;\nuse strict;"))))
         (add-before 'build 'move-to-subdirectory
           (lambda _
             (chdir "perl")))
         (replace 'build
           (lambda* (#:key outputs #:allow-other-keys)
             (system* "perl" "Makefile.PL"
                      (string-append "PREFIX=" (assoc-ref outputs "out")))
             (system* "make")))
         (add-before 'reset-gzip-timestamps 'fix-permissions
           (lambda* (#:key outputs #:allow-other-keys)
             (chmod (string-append
                     (assoc-ref outputs "out")
                     "/lib/perl5/site_perl/5.30.2/"
                     "auto/share/module/Sanger-CGP-Battenberg-Implement"
                     "/battenberg/probloci.txt.gz") #o644)))
         (add-after 'reset-gzip-timestamps 'fix-permissions-after
           (lambda* (#:key outputs #:allow-other-keys)
             (chmod (string-append
                     (assoc-ref outputs "out")
                     "/lib/perl5/site_perl/5.30.2/"
                     "auto/share/module/Sanger-CGP-Battenberg-Implement"
                     "/battenberg/probloci.txt.gz") #o444))))))
    (propagated-inputs
     `(("allelecount" ,allelecount)
       ("htslib" ,htslib)
       ("which" ,which)
       ("pcap-core" ,pcap-core)
       ("perl-bio-pipeline-comparison" ,perl-bio-pipeline-comparison)
       ("impute2-bin" ,impute2-bin)
       ("cgpvcf" ,cgpvcf)
       ("perl-const-fast" ,perl-const-fast)
       ("perl-sub-exporter-progressive" ,perl-sub-exporter-progressive)
       ("perl-bio-db-hts" ,perl-bio-db-hts)
       ("bioperl-minimal" ,bioperl-minimal)
       ("perl-ipc-system-simple" ,perl-ipc-system-simple)
       ("perl-file-which" ,perl-file-which)
       ("perl-log-message" ,perl-log-message)
       ("perl-term-ui" ,perl-term-ui)
       ("perl-file-sharedir" ,perl-file-sharedir)
       ("perl-capture-tiny" ,perl-capture-tiny)
       ("perl-forks" ,perl-forks)
       ("perl-bsd-resource" ,perl-bsd-resource)
       ("perl-sub-identify" ,perl-sub-identify)
       ("perl-autodie" ,perl-autodie)
       ("perl-archive-extract" ,perl-archive-extract)
       ("perl" ,perl)
       ("cgp-battenberg-r" ,cgp-battenberg-r)
       ("lsof" ,lsof)))
    (native-inputs
     `(("perl-module-install" ,perl-module-install)
       ("perl-module-build" ,perl-module-build)
       ("perl-file-sharedir-install" ,perl-file-sharedir-install)))
    (home-page "https://github.com/cancerit/cgpBattenberg")
    (synopsis "Battenberg algorithm and associated implementation script")
    (description "This package provides a perl wrapper and an R program for the
Battenberg algorithm that can detect subclonality and copy number in matched
NGS data.")
    (license license:gpl3+)))

(define-public cgp-battenberg
  (package
    (name "cgp-battenberg")
    (version "1.5.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/cancerit/cgpBattenberg/archive/"
                    version ".tar.gz"))
              (file-name (string-append name "-" version ".tar.gz"))
              (sha256
               (base32
                "11g1ryyfi4k5cbfp25dam9kl7wx1c3pqg2247ldhczk872mbcgz6"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         ;; The Perl in Guix does not support threads.
         ;; The forks module is a drop-in replacement for it, so it
         ;; is easier to use that instead of recompiling Perl.
         (add-after 'unpack 'enable-threads
           (lambda _
             (substitute* "perl/bin/battenberg.pl"
               (("use strict;") "use forks;\nuse strict;"))))
         (add-before 'build 'move-to-subdirectory
           (lambda _
             (chdir "perl")))
         (replace 'build
           (lambda* (#:key outputs #:allow-other-keys)
             (system* "perl" "Makefile.PL"
                      (string-append "PREFIX=" (assoc-ref outputs "out")))
             (system* "make")))
         (add-before 'reset-gzip-timestamps 'fix-permissions
           (lambda* (#:key outputs #:allow-other-keys)
             (chmod (string-append
                     (assoc-ref outputs "out")
                     "/lib/perl5/site_perl/5.30.2/"
                     "auto/share/module/Sanger-CGP-Battenberg-Implement"
                     "/battenberg/probloci.txt.gz") #o644)))
         (add-after 'reset-gzip-timestamps 'fix-permissions-after
           (lambda* (#:key outputs #:allow-other-keys)
             (chmod (string-append
                     (assoc-ref outputs "out")
                     "/lib/perl5/site_perl/5.30.2/"
                     "auto/share/module/Sanger-CGP-Battenberg-Implement"
                     "/battenberg/probloci.txt.gz") #o444))))))
    (propagated-inputs
     `(("allelecount" ,allelecount)
       ("htslib" ,htslib)
       ("which" ,which)
       ("pcap-core" ,pcap-core)
       ("perl-bio-pipeline-comparison" ,perl-bio-pipeline-comparison)
       ("impute2-bin" ,impute2-bin)
       ("cgpvcf" ,cgpvcf)
       ("perl-const-fast" ,perl-const-fast)
       ("perl-sub-exporter-progressive" ,perl-sub-exporter-progressive)
       ("perl-bio-db-hts" ,perl-bio-db-hts)
       ("bioperl-minimal" ,bioperl-minimal)
       ("perl-ipc-system-simple" ,perl-ipc-system-simple)
       ("perl-file-which" ,perl-file-which)
       ("perl-log-message" ,perl-log-message)
       ("perl-term-ui" ,perl-term-ui)
       ("perl-file-sharedir" ,perl-file-sharedir)
       ("perl-capture-tiny" ,perl-capture-tiny)
       ("perl-forks" ,perl-forks)
       ("perl-bsd-resource" ,perl-bsd-resource)
       ("perl-sub-identify" ,perl-sub-identify)
       ("perl-autodie" ,perl-autodie)
       ("perl-archive-extract" ,perl-archive-extract)
       ("perl" ,perl)))
    (native-inputs
     `(("perl-module-install" ,perl-module-install)
       ("perl-module-build" ,perl-module-build)
       ("perl-file-sharedir-install" ,perl-file-sharedir-install)))
    (home-page "https://github.com/cancerit/cgpBattenberg")
    (synopsis "Battenberg algorithm and associated implementation script")
    (description "This package provides a perl wrapper and an R program for the
Battenberg algorithm that can detect subclonality and copy number in matched
NGS data.")
    (license license:gpl3+)))

(define-public cgp-pindel
  (package
    (name "cgp-pindel")
    (version "2.2.4")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/cancerit/cgpPindel/archive/v"
                    version ".tar.gz"))
              (sha256
               (base32
                "1vadlyffabqj696k9nnzqprxn5avf0a5iykpqjxmw8n2180lppvw"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-before 'build 'move-to-subdirectory
           (lambda _
             (chdir "perl")))
         (replace 'build
           (lambda* (#:key outputs #:allow-other-keys)
             (system* "perl" "Makefile.PL"
                      (string-append "PREFIX=" (assoc-ref outputs "out")))
             (system* "make"))))))
    (propagated-inputs
     `(("perl" ,perl)
       ("pcap-core" ,pcap-core)
       ("cgpvcf" ,cgpvcf)
       ("bioperl-minimal" ,bioperl-minimal)
       ("perl-bio-db-hts" ,perl-bio-db-hts)
       ("perl-const-fast" ,perl-const-fast)
       ("perl-file-which" ,perl-file-which)
       ("perl-pod-coverage" ,perl-pod-coverage)
       ("perl-list-moreutils" ,perl-list-moreutils)
       ("perl-test-fatal" ,perl-test-fatal)
       ("perl-try-tiny" ,perl-try-tiny)
       ("perl-capture-tiny" ,perl-capture-tiny)
       ("perl-term-ui" ,perl-term-ui)
       ("perl-log-message" ,perl-log-message)
       ("perl-ipc-system-simple" ,perl-ipc-system-simple)
       ("perl-sub-exporter-progressive" ,perl-sub-exporter-progressive)
       ("perl-devel-cover" ,perl-devel-cover)))
    (native-inputs
     `(("perl-module-install" ,perl-module-install)
       ("perl-module-build" ,perl-module-build)
       ("perl-file-sharedir-install" ,perl-file-sharedir-install)))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:agpl3+)))

(define-public last
  (package
   (name "last")
   (version "1080")
   (source (origin
            (method url-fetch)
            (uri (string-append "http://last.cbrc.jp/last-" version ".zip"))
            (sha256
               (base32
                "0az6xiqkbdcq858m1dlwvf7f7pa5fjldckkawcj8a38a2fq9drds"))))
   (build-system gnu-build-system)
   (native-inputs
    `(("unzip" ,unzip)
      ("sed" ,sed)))
   (inputs
    `(("zlib" ,zlib)))
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (add-after 'unpack 'set-c-compiler
         (lambda* (#:key outputs #:allow-other-keys)
           (substitute* "src/makefile"
            (("# -Wconversion") "CC=gcc"))
           (substitute* "makefile"
            (("prefix = /usr/local")
             (string-append
              "prefix = " (assoc-ref outputs "out")))))))))
   (home-page "http://last.cbrc.jp/")
   (synopsis "Genome-scale sequence comparison")
   (description "")
   (license license:gpl3)))

(define-public python-nanosv
  (package
   (name "python-nanosv")
   (version "1.2.4")
   (source (origin
            (method url-fetch)
            (uri (pypi-uri "NanoSV" version))
            (sha256
             (base32
              "1wl2daj0bwrl8fx5xi8j8hfs3mp3vg3qycy66538n032v1qkc6xg"))))
   (build-system python-build-system)
   (propagated-inputs
    `(("python-configparser" ,python-configparser)
      ("python-pysam" ,python-pysam)
      ("python-pyvcf" ,python-pyvcf)))
   (home-page "https://github.com/mroosmalen/nanosv")
   (synopsis "Structural variation detection tool for Oxford Nanopore data.")
   (description "Structural variation detection tool for Oxford Nanopore data.")
   (license license:expat)))

(define-public primer3-1.1.4
  (package
    (name "primer3")
    (version "1.1.4")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://github.com/primer3-org/primer3/archive/v"
                    version ".tar.gz"))
              (sha256
               (base32
                "1nkxyw811xbb7gid0dbcw4k7yg3q1mw6hv96076xx0j10ishmh1w"))))
    (build-system gnu-build-system)
    (arguments
     `(#:tests? #f
       #:phases
       (modify-phases %standard-phases
         (delete 'configure)
         (add-before 'build 'change-directory
           (lambda _ (chdir "src")))
         (replace 'install
           (lambda* (#:key outputs #:allow-other-keys)
             (let* ((out (assoc-ref outputs "out"))
                    (bin (string-append out "/bin")))
               (mkdir-p bin)
               (for-each (lambda (file) (install-file file bin))
                         '("primer3_core" "oligotm" "ntdpal"))))))))
    (inputs
     `(("perl" ,perl)))
    (home-page "https://github.com/primer3-org/primer3")
    (synopsis "Tool to design PCR primers")
    (description "Design PCR primers from DNA sequence. Widely used (190k 
Google hits for \"primer3\").  From mispriming libraries to sequence quality
 data to the generation of internal oligos, primer3 does it.")
    (license license:gpl2)))

(define-public sharc
  (package
   (name "sharc")
   (version "1.0-slurm")
   (source (origin
            (method url-fetch)
            (uri "https://github.com/UMCUGenetics/SHARC/archive/1.0.tar.gz")
            (file-name (string-append name "-" version ".tar.gz"))
            (sha256
             (base32
              "05121h8nrrsd4j9xk0dg92p1js6m849x8p2vj5mss1fzf50cdyv7"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f ; There are no tests
      #:phases
      (modify-phases %standard-phases
                     (delete 'configure)
                     (delete 'build)
                     (add-after 'unpack 'patch-external-programs
                                (lambda* (#:key inputs outputs #:allow-other-keys)
                                  (let* ((out        (assoc-ref outputs "out"))
                                         (share      (string-append out "/share/sharc"))
                                         (venvdir    (string-append share "/venv/bin"))
                                         (scriptsdir (string-append share "/scripts"))
                                         (primerdir  (string-append scriptsdir "/primers"))
                                         (stepsdir   (string-append share "/steps"))
                                         (filesdir   (string-append share "/files")))
                                    (substitute* "sharc.sh"
                                                 (("/hpc/cog_bioinf/cuppen/personal_data/jvalleinclan/tools_kloosterman/minimap2_v2.12/minimap2")
                                                  (string-append (assoc-ref inputs "minimap2") "/bin/minimap2"))
                                                 (("SHARCDIR=\\$\\(dirname \\$\\{BASH_SOURCE\\[0\\]\\}\\)")
                                                  (string-append "SHARCDIR='" out "'"))
                                                 (("VENV=\\$SHARCDIR/venv/bin/activate")
                                                  (string-append "VENV=" venvdir "/activate"))
                                                 (("STEPSDIR=\\$SHARCDIR/steps")
                                                  (string-append "STEPSDIR=" stepsdir))
                                                 (("SCRIPTSDIR=\\$SHARCDIR/scripts")
                                                  (string-append "SCRIPTSDIR=" scriptsdir))
                                                 (("FILESDIR=\\$SHARCDIR/files")
                                                  (string-append "FILESDIR=" filesdir))
                                                 (("python \\$PON_SCRIPT") "PY2 $PON_SCRIPT")
                                                 (("\\$PRIMER_DESIGN_DIR/primer3/src/primer3_core")
                                                  (string-append (assoc-ref inputs "primer3") "/bin/primer3_core"))
                                                 (("\\$\\{FILESDIR\\}/gnomad_v2.1_sv.sites.vcf")
                                                  (string-append (assoc-ref inputs "gnomad-sv-sites")
                                                                 "/share/gnomad/gnomad_v2.1_sv.sites.vcf")))

                                    (substitute* '("steps/vcf_fasta.sh"
                                                   "steps/vcf_primer_filter.sh"
                                                   "steps/somatic_ranking.sh"
                                                   "steps/top20_report.sh"
                                                   "steps/somatic_feature_selection.sh"
                                                   "steps/randomForest.sh"
                                                   "steps/randomForest.sh"
                                                   "steps/randomForest.sh"
                                                   "steps/bed_annotation.sh")
                                                 (("/hpc/cog_bioinf/cuppen/project_data/Jose_SHARC/sharc/scripts")
                                                  scriptsdir))

                                    (substitute* '("steps/vcf_fasta.sh"
                                                   "steps/nanosv.sh"
                                                   "steps/vcf_primer_filter.sh"
                                                   "steps/somatic_ranking.sh"
                                                   "steps/top20_report.sh"
                                                   "steps/somatic_feature_selection.sh"
                                                   "steps/randomForest.sh"
                                                   "steps/bed_annotation.sh")
                                                 (("VENV='/hpc/cog_bioinf/cuppen/project_data/Jose_SHARC/sharc/venv/bin/activate'")
                                                  (string-append venvdir "/activate")))

                                    (substitute* '("steps/calculate_coverage.sh"
                                                   "steps/nanosv.sh"
                                                   "steps/somatic_feature_selection.sh")
                                                 (("/hpc/cog_bioinf/cuppen/project_data/Jose_SHARC/sharc/files")
                                                  filesdir))

                                    (substitute* "steps/minimap2.sh"
                                                 (("/hpc/cog_bioinf/cuppen/personal_data/jvalleinclan/tools_kloosterman/minimap2_v2.12/minimap2")
                                                  (string-append (assoc-ref inputs "minimap2") "/bin/minimap2")))

                                    (substitute* '("steps/bed_annotation.sh"
                                                   "steps/calculate_coverage.sh"
                                                   "steps/create_bed_annotation_jobs.sh"
                                                   "steps/minimap2.sh"
                                                   "steps/nanosv.sh"
                                                   "steps/primer_design.sh"
                                                   "steps/primer_ranking.sh"
                                                   "steps/randomForest.sh"
                                                   "steps/sharc_filter.sh"
                                                   "steps/somatic_feature_selection.sh"
                                                   "steps/somatic_ranking.sh"
                                                   "steps/top20_report.sh"
                                                   "steps/vcf_fasta.sh"
                                                   "steps/vcf_filter.sh"
                                                   "steps/vcf_primer_filter.sh"
                                                   "steps/vcf_split.sh"
                                                   "sharc.sh")
                                                 (("/hpc/local/CentOS7/cog_bioinf/sambamba_v0.6.5/sambamba")
                                                  (string-append (assoc-ref inputs "sambamba") "/bin/sambamba"))
                                                 (("#!/bin/bash")
                                                  (format #f "#!~a/bin/bash~%~%~{export ~:a~%~}"
                                                          (assoc-ref inputs "bash")
                                                          `(,(let ((python-inputs
                                                                    (delete #f
                                                                            (map (lambda (pair)
                                                                                   (if (string-prefix? "python-" (car pair))
                                                                                       (format #f "~a/lib/python~a/site-packages"
                                                                                               (cdr pair) "3.8")
                                                                                       #f))
                                                                                 inputs))))
                                                               (format #f "PYTHONPATH=\"~a~{:~a~}\""
                                                                       (car python-inputs)
                                                                       (cdr python-inputs)))
                                                            ,(format #f "R_LIBS_SITE=~s" (getenv "R_LIBS_SITE")))))
                                                 (("Rscript")
                                                  (string-append (assoc-ref inputs "r") "/bin/Rscript"))
                                                 (("qsub")
                                                  (string-append (assoc-ref inputs "grid-engine-core") "/bin/qsub -V"))
                                                 (("python ")
                                                  (string-append (assoc-ref inputs "python") "/bin/python3 "))
                                                 (("PY2")
                                                  (string-append (assoc-ref inputs "python-2") "/bin/python"))
                                                 (("NanoSV ")
                                                  (string-append (assoc-ref inputs "python-nanosv") "/bin/NanoSV "))
                                                 (("module load R") ""))

                                    (substitute* "steps/create_bed_annotation_jobs.sh"
                                                 (("bash \\$STEPSDIR")
                                                  (string-append (assoc-ref inputs "bash") "/bin/bash $STEPSDIR")))

                                    (substitute* "scripts/run_randomForest.R"
                                                 (("/hpc/cog_bioinf/kloosterman/common_scripts/sharc/scripts") scriptsdir)
                                                 (("randomforest_vl_v3_3overlap_p96_r99.5_pc0.39.Rdata")
                                                  "randomforest_v3_3overlap_p96_r99.5_pc0.39.Rdata"))

                                    ;; Use Guix's Python.
                                    (substitute* '("scripts/add_predict_annotation.py"
                                                   "scripts/create_features_table.py"
                                                   "scripts/get_closest_feature.py"
                                                   "scripts/primer_ranking.py"
                                                   "scripts/somatic_feature_selection.py"
                                                   "scripts/somatic_ranking.py"
                                                   "scripts/top20_report.py"
                                                   "scripts/vcf_primer_filter.py"
                                                   "scripts/vcf_to_fasta.py")
                                                 (("/usr/bin/python") (string-append
                                                                       (assoc-ref inputs "python")
                                                                       "/bin/python3")))

                                    (substitute* '("scripts/primers/primerBATCH1"
                                                   "scripts/primers/amplicons3.pl"
                                                   "scripts/primers/format_primers1.pl")
                                                 (("/usr/bin/perl")
                                                  (string-append (assoc-ref inputs "perl") "/bin/perl")))

                                    (substitute* "scripts/annotate_sv_vcf_file.py"
                                                 (("/usr/bin/python") (string-append
                                                                       (assoc-ref inputs "python-2")
                                                                       "/bin/python")))

                                    (substitute* "scripts/primers/primerBATCH1"
                                                 (("/hpc/cuppen/projects/TP0001_General/COLO/analysis/jvalleinclan/bin/tools_kloosterman/primer3/primers")
                                                  primerdir))

                                    (substitute* "scripts/primers/amplicons3.pl"
                                                 (("eprimer3 ") (string-append (assoc-ref inputs "emboss") "/bin/eprimer3 ")))

                                    #t)))

                     (replace 'install
                              (lambda* (#:key inputs outputs #:allow-other-keys)
                                (let* ((out        (assoc-ref outputs "out"))
                                       (bin        (string-append out "/bin"))
                                       (share      (string-append out "/share/sharc"))
                                       (venvdir    (string-append share "/venv/bin"))
                                       (scriptsdir (string-append share "/scripts"))
                                       (stepsdir   (string-append share "/steps"))
                                       (filesdir   (string-append share "/files")))
                                  (mkdir-p bin)
                                  (mkdir-p venvdir)
                                  (mkdir-p scriptsdir)
                                  (mkdir-p stepsdir)
                                  (mkdir-p filesdir)
                                  (copy-recursively "scripts" scriptsdir)
                                  (copy-recursively "steps" stepsdir)
                                  (copy-recursively "files" filesdir)

                                  ;; Create an empty virtual environment
                                  (call-with-output-file (string-append venvdir "/activate")
                                    (lambda (port)
                                      (format port "export DEACTIVATE_PATH=$PATH~%")
                                      (format port "export PATH=$PATH:~s~%" venvdir)
                                      (format port "printf \"Environment activated.\\n\";~%")))
                                  (let ((deactivate (string-append venvdir "/deactivate")))
                                    (call-with-output-file deactivate
                                      (lambda (port)
                                        (format port "#!~a/bin/bash~%" (assoc-ref inputs "bash"))
                                        (format port "export PATH=${DEACTIVATE_PATH}~%")
                                        (format port "printf \"Environment deactivated.\\n\";~%exit 0;~%")))
                                    (chmod deactivate #o555))
                                  (install-file "sharc.sh" bin)
                                  (with-directory-excursion bin
                                                            (symlink "sharc.sh" "sharc"))))))))
   (inputs
    `(("awk" ,gawk)
      ("bash" ,bash)
      ("coreutils" ,coreutils)
      ("emboss" ,emboss)
      ("grep" ,grep)
      ("grid-engine-core" ,qsub-slurm)
      ("minimap2" ,minimap2)
      ("primer3" ,primer3-1.1.4)
      ("perl" ,perl)
      ("python" ,python)
      ("python-aniso8601" ,python-aniso8601)
      ("python-certifi" ,python-certifi)
      ("python-chardet" ,python-chardet)
      ("python-configparser" ,python-configparser)
      ("python-flask" ,python-flask)
      ("python-flask-restful" ,python-flask-restful)
      ("python-idna" ,python-idna)
      ("python-itsdangerous" ,python-itsdangerous)
      ("python-jinja2" ,python-jinja2)
      ("python-markupsafe" ,python-markupsafe)
      ("python-nanosv" ,python-nanosv)
      ("python-pymongo" ,python-pymongo)
      ("python-pysam" ,python-pysam)
      ("python-pytz" ,python-pytz)
      ("python-pyvcf" ,python-pyvcf)
      ("python-requests" ,python-requests)
      ("python-six" ,python-six)
      ("python-urllib3" ,python-urllib3)
      ("python-werkzeug" ,python-werkzeug)
      ("python-2" ,python-2)
      ("r" ,r-minimal)
      ("r-ggplot2" ,r-ggplot2)
      ("r-randomforest", r-randomforest)
      ("r-rocr" ,r-rocr)
      ("sambamba" ,sambamba)
      ("sed" ,sed)
      ("gnomad-sv-sites" ,gnomad-sv-sites-2.1)))
   (native-search-paths
    (append (package-native-search-paths bash)
            (package-native-search-paths python)
            (package-native-search-paths perl)
            (package-native-search-paths r)))
   (search-paths native-search-paths)
   (home-page "https://github.com/UMCUGenetics/SHARC")
   (synopsis "Somatic SV pipeline for tumor-only Nanopore sequencing data")
   (description "SHARC is a pipeline for somatic SV calling and filtering
from tumor-only Nanopore sequencing data. It performs mapping, SV calling,
SV filtering, random forest classification, blacklist filtering and SV
prioritization, followed by automated primer design for PCR amplicons of
80-120 bp that are useful to track cancer ctDNA molecules in liquid
biopsies.")
   (license license:gpl3)))

(define-public sharc-local
  (package (inherit sharc)
     (name "sharc")
     (version "1.0-local")
     (inputs
      `(("awk" ,gawk)
        ("bash" ,bash)
        ("coreutils" ,coreutils)
        ("emboss" ,emboss)
        ("grep" ,grep)
        ("grid-engine-core" ,qsub-local)
        ("minimap2" ,minimap2)
        ("primer3" ,primer3-1.1.4)
        ("perl" ,perl)
        ("python" ,python)
        ("python-aniso8601" ,python-aniso8601)
        ("python-certifi" ,python-certifi)
        ("python-chardet" ,python-chardet)
        ("python-configparser" ,python-configparser)
        ("python-flask" ,python-flask)
        ("python-flask-restful" ,python-flask-restful)
        ("python-idna" ,python-idna)
        ("python-itsdangerous" ,python-itsdangerous)
        ("python-jinja2" ,python-jinja2)
        ("python-markupsafe" ,python-markupsafe)
        ("python-nanosv" ,python-nanosv)
        ("python-pymongo" ,python-pymongo)
        ("python-pysam" ,python-pysam)
        ("python-pytz" ,python-pytz)
        ("python-pyvcf" ,python-pyvcf)
        ("python-requests" ,python-requests)
        ("python-six" ,python-six)
        ("python-urllib3" ,python-urllib3)
        ("python-werkzeug" ,python-werkzeug)
        ("python-2" ,python-2)
        ("r" ,r-minimal)
        ("r-ggplot2" ,r-ggplot2)
        ("r-randomforest", r-randomforest)
        ("r-rocr" ,r-rocr)
        ("sambamba" ,sambamba)
        ("sed" ,sed)
        ("gnomad-sv-sites" ,gnomad-sv-sites-2.1)))))

(define-public sharc-sge
  (package (inherit sharc)
     (name "sharc")
     (version "1.0-sge")
     (inputs
      `(("awk" ,gawk)
        ("bash" ,bash)
        ("coreutils" ,coreutils)
        ("emboss" ,emboss)
        ("grep" ,grep)
        ("grid-engine-core" ,grid-engine-core)
        ("minimap2" ,minimap2)
        ("primer3" ,primer3-1.1.4)
        ("perl" ,perl)
        ("python" ,python)
        ("python-aniso8601" ,python-aniso8601)
        ("python-certifi" ,python-certifi)
        ("python-chardet" ,python-chardet)
        ("python-configparser" ,python-configparser)
        ("python-flask" ,python-flask)
        ("python-flask-restful" ,python-flask-restful)
        ("python-idna" ,python-idna)
        ("python-itsdangerous" ,python-itsdangerous)
        ("python-jinja2" ,python-jinja2)
        ("python-markupsafe" ,python-markupsafe)
        ("python-nanosv" ,python-nanosv)
        ("python-pymongo" ,python-pymongo)
        ("python-pysam" ,python-pysam)
        ("python-pytz" ,python-pytz)
        ("python-pyvcf" ,python-pyvcf)
        ("python-requests" ,python-requests)
        ("python-six" ,python-six)
        ("python-urllib3" ,python-urllib3)
        ("python-werkzeug" ,python-werkzeug)
        ("python-2" ,python-2)
        ("r" ,r-minimal)
        ("r-ggplot2" ,r-ggplot2)
        ("r-randomforest", r-randomforest)
        ("r-rocr" ,r-rocr)
        ("sambamba" ,sambamba)
        ("sed" ,sed)
        ("gnomad-sv-sites" ,gnomad-sv-sites-2.1)))))

(define-public gnomad-sv-sites-2.1
  (package
   (name "gnomad-sv-sites")
   (version "2.1")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://storage.googleapis.com/gnomad-public/"
                  "papers/2019-sv/gnomad_v" version "_sv.sites.vcf.gz"))
            (sha256
             (base32
              "18gxfnar8n5r06mj0ykyq4fkw3q3qqbrfnprgi18db0xzf6lh94k"))))
   (build-system trivial-build-system)
   (arguments
     `(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((gzip     (string-append (assoc-ref %build-inputs "gzip") "/bin/gzip"))
               (sv-sites (assoc-ref %build-inputs "source"))
               (out      (string-append %output "/share/gnomad")))
           (mkdir-p out)
           (with-directory-excursion out
             (zero? (system
                     (string-append
                      gzip " -d " sv-sites
                      " -c > gnomad_v2.1_sv.sites.vcf"))))))))
   (inputs `(("gzip" ,gzip)))
   (home-page "https://gnomad.broadinstitute.org")
   (synopsis "gnomAD structural variant sites")
   (description "This package provides in uncompressed version of the gnomAD
 structural variant sites.")
   (license license:cc0)))

(define-public glibc-locales-2.27
  (package (inherit (make-glibc-locales glibc-2.27))
           (name "glibc-locales-2.27")))

(define-public glibc-locales-2.28
  (package (inherit (make-glibc-locales glibc-2.28))
           (name "glibc-locales-2.28")))

(define-public scan_for_matches
  (package
   (name "scan_for_matches")
   (version "0.0")
   (source (origin
            (method url-fetch)
            (uri "http://www.theseed.org/servers/downloads/scan_for_matches.tgz")
            (sha256
             (base32 "13ynw9i6j76884pdi249qhvgpvr6ii7hnfkwnllaryxxxwq7kcf6"))))
   (build-system gnu-build-system)
   (arguments
    `(#:tests? #f
      #:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (replace 'build
          (lambda _
            (invoke "gcc" "-O2" "-o" "scan_for_matches"  "ggpunit.c" "scan_for_matches.c")))
        (replace 'install
          (lambda* (#:key outputs #:allow-other-keys)
            (let ((bin (string-append (assoc-ref outputs "out") "/bin")))
              (install-file "scan_for_matches" bin)))))))
   (home-page "https://blog.theseed.org/servers/2010/07/scan-for-matches.html")
   (synopsis "Utility for locating patterns in DNA")
   (description "This package provides a utility for locating patterns in DNA
 or protein FASTA files.")
   (license #f)))
