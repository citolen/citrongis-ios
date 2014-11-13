/*
**  include.js
**
**  Author citole_n
**  15/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};
C.Extension.UI = C.Extension.UI || {};

C.Extension.UI.include = function (filepath) {
    var fileExt = filepath.lastIndexOf('.');
    if (fileExt == -1 || fileExt == filepath.length)
        fileExt = "js";
    else {
        fileExt = filepath.substr(fileExt + 1);
    }
    if (fileExt == "js") {
        console.log('[JS include]', filepath);
        C.Extension.Require.call(this, filepath);
    }
    if (fileExt == "css") {
        console.log('[CSS include]', filepath);
        var s = document.createElement("style");
        s.innerHTML = C.Extension.Require.call(this, filepath);//this.handle.file(filepath).asText();
        document.getElementsByTagName("head")[0].appendChild(s);
    }
};
