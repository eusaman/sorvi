\name{SplitSpatial}
\alias{SplitSpatial}
\title{Split a Spatial*DataFrame object into a list of Spatial*DataFrames}
\usage{
  SplitSpatial(sp.object, split.field)
}
\arguments{
  \item{sp.object}{A Spatial*DataFrame object to be
  splitted}

  \item{split.field}{A string describing the identifier
  field for the subregions}
}
\value{
  a list of Shape objects (from SpatialPolygonsDataFrame
  class)
}
\description{
  Subregions of a Spatial*DataFrame are splitted into a
  list based on a field containing a identifier which must
  be a factor.
}
\details{
  No schema or CRS checking is performed as all the spatial
  information and geometries are coming from a common
  source.
}
\examples{
#
}
\author{
  Joona Lehtomaki
  \email{sorvi-commits@lists.r-forge.r-project.org}
}
\references{
  See citation("sorvi")
}

