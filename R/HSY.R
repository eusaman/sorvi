# The combination of some data and an aching desire for an answer does not
# ensure that a reasonable answer can be extracted from a given body of
# data. ~ John Tukey

# This file is a part of the soRvi program (http://louhos.github.com/sorvi/)

# Copyright (C) 2010-2012 Louhos <louhos.github.com>. All rights reserved.

# This program is open source software; you can redistribute it and/or modify 
# it under the terms of the FreeBSD License (keep this notice): 
# http://en.wikipedia.org/wiki/BSD_licenses

# This program is distributed in the hope that it will be useful, 
# but WITHOUT ANY WARRANTY; without even the implied warranty of 
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.




#' Retrieve HSY data 
#'
#' This script retrieves data from Helsinki Region Environmental
#' Services Authority (Helsingin seudun ymparistopalvelu HSY) through
#' the HSY website
#' http://www.hsy.fi/seututieto/kaupunki/paikkatiedot/Sivut/Avoindata.aspx
#' For details, see the HSY website, in particular the data description (in Finnish) at:
#' http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf. 
#' The data copyright is on (C) HSY 2011.
#' @aliases get.hsy
#' @param which.data  A string. Specify the name of the HSY data set to retrieve. Currently available options: Vaestoruudukko; Rakennustietoruudukko; SeutuRAMAVA; key.KATAKER. The first three are documented in HSY data description document (see above). The key.KATAKER contains manually parsed mapping for building categories from the HSY documentation.
#'
#' @return Shape object (from SpatialPolygonsDataFrame class)
#' @export
#' @references
#' See citation("sorvi") 
#' @author Leo Lahti \email{sorvi-commits@@lists.r-forge.r-project.org}
#' @examples # sp <- get.hsy("Vaestoruudukko")
#' @keywords utilities

GetHSY <- function (which.data = "Vaestoruudukko") {

  data.path <- "http://www.hsy.fi/seututieto/Documents/Paikkatiedot/"

  if (which.data %in% c("Vaestoruudukko", "Rakennustietoruudukko", "SeutuRAMAVA")) {

    # Vaestotietoruudukko: Ruutukohtaista tietoa vaeston lukumaarasta,
    # ikajakaumasta ja asumisvaljyydesta  

    # Rakennustietoruudukko: Ruutukohtaista tietoa rakennusten
    # lukumaarasta, kerrosalasta, kayttotarkoituksesta ja
    # aluetehokkuudesta. Ruutukoko 500x500 metria.

    # SeutuRAMAVA: kaupunginosittain summattua tietoa
    # rakennusmaavarannosta

    # ESRI
    destfile <- paste(which.data, "_SHP.zip", sep = "")
    data.url <- paste(data.path, which.data, "_SHP.zip", sep = "")
    message(paste("Dowloading HSY data from ", data.url, " in file ", destfile))
    download.file(data.url, destfile = destfile)
                  
  } else if (which.data == "key.KATAKER") {

    # Identifiers for different building types were manually scraped 3.12.2012 from
    # http://www.hsy.fi/seututieto/Documents/Paikkatiedot/Tietokuvaukset_kaikki.pdf
    # (C) HSY 2011 (http://www.hsy.fi)

    KATAKER.key <- c(
    "1"   = "Yhden asunnon talot", 
    "12"  = "Kahden asunnon talot", 
    "13"  = "Muut erilliset pientalot", 
    "21"  = "Rivitalot", 
    "22"  = "Ketjutalot", 
    "32"  = "Luhtitalot", 
    "39"  = "Muut kerrostalot", 
    "41"  = "Vapaa-ajan asunnot",
    "111" = "Myymalahallit", 
    "112" = "Liike- ja tavaratalot, kauppakeskukset",
    "119" = "Myymalarakennukset ", 
    "121" = "Hotellit, motellit, matkustajakodit, kylpylahotellit", 
    "123" = "Loma- lepo- ja virkistyskodit", 
    "124" = "Vuokrattavat lomamokit ja osakkeet (liiketoiminnallisesti)", 
    "129" = "Muut majoitusliikerakennukset",
    "131" = "Asuntolat, vanhusten palvelutalot, asuntolahotellit",
    "139" = "Muut majoitusrakennukset", 
    "141" = "Ravintolat, ruokalat ja baarit", 
    "151" = "Toimistorakennukset", 
    "161" = "Rautatie- ja linja- autoasemat, lento- ja satamaterminaalit", 
    "162" = "Kulkuneuvojen suoja- ja huoltorakennukset", 
    "163" = "Pysakointitalot", 
    "164" = "Tietoliikenteen rakennukset", 
    "165" = "Muut liikenteen rakennukset", 
    "169" = "Muut liikenteen rakennukset", 
    "211" = "Keskussairaalat", 
    "213" = "Muut sairaalat", 
    "214" = "Terveyskeskukset", 
    "215" = "Terveydenhoidon erityislaitokset (mm. kuntoutuslaitokset)", 
    "219" = "Muut terveydenhoitorakennukset", 
    "221" = "Vanhainkodit", 
    "222" = "Lastenkodit, koulukodit", 
    "223" = "Kehitysvammaisten hoitolaitokset", 
    "229" = "Muut huoltolaitosrakennukset", 
    "231" = "Lasten paivakodit", 
    "239" = "Muut sosiaalitoimen rakennukset", 
    "241" = "Vankilat", 
    "311" = "Teatterit, konsertti- ja kongressitalot, oopperat", 
    "312" = "Elokuvateatterit",
    "322" = "Kirjastot", 
    "323" = "Museot, taidegalleriat",
    "324" = "Nayttelyhallit", 
    "331" = "Seurain-, nuoriso- yms. talot",
    "341" = "Kirkot, kappelit, luostarit, rukoushuoneet",
    "342" = "Seurakuntatalot", 
    "349" = "Muut uskonnollisten yhteisojen rakennukset", 
    "351" = "Jaahallit", 
    "352" = "Uimahallit", 
    "353" = "Tennis-, squash- ja sulkapallohallit",
    "354" = "Monitoimi- ja muut urheiluhallit",
    "359" = "Muut urheilu- ja kuntoilurakennukset", 
    "369" = "Muut kokoontumis- rakennukset", 
    "511" = "Peruskoulut, lukiot ja muut", 
    "521" = "Ammatilliset oppilaitokset", 
    "531" = "Korkeakoulu- rakennukset",
    "532" = "Tutkimuslaitosrakennukset", 
    "541" = "Jarjestojen, liittojen, tyonantajien yms.  opetusrakennukset", 
    "549" = "Muualla luokittelemattomat opetusrakennukset", 
    "611" = "Voimalaitosrakennukset", 
    "613" = "Yhdyskuntatekniikan rakennukset", 
    "691" = "Teollisuushallit", 
    "692" = "Teollisuus- ja pienteollisuustalot", 
    "699" = "Muut teollisuuden tuotantorakennukset", 
    "711" = "Teollisuusvarastot",
    "712" = "Kauppavarastot", 
    "719" = "Muut varastorakennukset",
    "721" = "Paloasemat", 
    "722" = "Vaestonsuojat", 
    "723" = "Halytyskeskukset",
    "729" = "Muut palo- ja pelastustoimen rakennukset", 
    "811" = "Navetat, sikalat, kanalat yms.", 
    "819" = "Elainsuojat, ravihevostallit, maneesit", 
    "891" = "Viljankuivaamot ja viljan sailytysrakennukset, siilot", 
    "892" = "Kasvihuoneet", 
    "893" = "Turkistarhat", 
    "899" = "Muut maa-, metsa- ja kalatalouden rakennukset", 
    "931" = "Saunarakennukset",
    "941" = "Talousrakennukset", 
    "999" = "Muut rakennukset", 
    "999999999" = "Puuttuvan tiedon merkki")

    res <- data.frame(list(key = as.integer(names(KATAKER.key)), description = KATAKER.key))
    return(res)

  } else {
    stop("Provide proper data name.")
  }

  # Unzip the files

  .InstallMarginal("utils")

  unzip(destfile)

  if (which.data == "SeutuRAMAVA") {

    # Need to read with rgdal, the readShapePoly had problems in
    # handling this file

    # Read info of municipalities and election areas from Tilastoteskus
    .InstallMarginal("rgdal")

    sp <- rgdal::readOGR(".", layer = "SeutuRAMAVA_2010")
    # Convert to UTF-8 where needed 
    nams <- c("OMLAJI_1S", "OMLAJI_2S", "OMLAJI_3S", "NIMI", "NIMI_SE")
    for (nam in nams) {    
      sp[[nam]] <-  factor(iconv(sp[[nam]], from = "latin1", to = "UTF-8"))
    }
  } else if (which.data == "Rakennustietoruudukko") {
    sp <- sorvi::ReadShape("Rakennustietoruudukko_2010_region.shp")
  } else if (which.data == "Vaestoruudukko") {
    sp <- sorvi::ReadShape("Vaestoruudukko_2010_region.shp")
  }

  sp
}
