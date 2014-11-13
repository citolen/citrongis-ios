/*
 * Author citole_n
 * Created 17/05/2014
 */

var C = C || {};
var proj4 = proj4 || {};

C.Helpers = C.Helpers || {};

C.Helpers.ProjectionsHelper = {};

C.Helpers.ProjectionsHelper.WGS84 = new proj4.Proj('+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs');

C.Helpers.ProjectionsHelper.EPSG3857 = new proj4.Proj('+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext  +no_defs');
