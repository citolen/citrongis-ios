/*
**  Require.js
**
**  Author citole_n
**  17/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};

/*
**  Require an extension or file
*/
C.Extension.Require = function (path) {

    'use strict';

    console.log('[require]', path, 'from', this.currentPath);

    if (this.handle && this.module && this.package) { /* Called from an extension context */
        var filepath = path;
        if (!this.handle.file(filepath) && this.currentPath.lastIndexOf('/') !== -1)
            filepath = C.Utils.Path.normalize(this.currentPath.substr(0, this.currentPath.lastIndexOf('/')) + '/' + filepath);
        if (!this.handle.file(filepath))
        {
            /*
            ** this is propably an extension name, should check in the local extension library and then on citrongis api
            */
            return (undefined);
        }

        if (this.handle.file(filepath)) {

            var content = this.handle.file(filepath).asText();
            var context = C.Utils.Context.copy(this, filepath);
            var fileExtension = path.split('.').pop();

            if (fileExtension === 'js') { /* js (execute) */
                eval('(function (module, require) {\
                    ' + content + '\
                    }).call(context.module.global, context.module, C.Extension.Require.bind(context));');
            }

            return (content);
        }
    } else {

    }
    return (undefined);
};
