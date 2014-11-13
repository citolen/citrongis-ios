/*
**  Extension.js
**
**  Author citole_n
**  16/08/2014
*/

var C = C || {};
C.Extension = C.Extension || {};

C.Extension.AR_STRINGS_LOCALIZATION = 'strings.json';
C.Extension.AR_PACKAGE = 'package.json';

//
C.Extension.Extension = function (handle) {
    "use strict";

    if (!handle || !handle.file(C.Extension.AR_PACKAGE)) return (null);
    this.handle = handle;

    var localization;
    if (this.handle.file(C.Extension.AR_STRINGS_LOCALIZATION)) {
        try {
            localization = JSON.parse(this.handle.file(C.Extension.AR_STRINGS_LOCALIZATION).asText());
        } catch (e) {
            localization = {};
        }
    } else {
        localization = {};
    }

    this.module = new C.Extension.Module(this, localization);

    this.package = JSON.parse(this.handle.file(C.Extension.AR_PACKAGE).asText());
};

// start an extension
C.Extension.Extension.prototype.run = function () {
    var startScript = this.package.main || 'src/main.js';
    if (!this.handle.file(startScript)) return (false);

    this.setupEnvironment();

    C.Extension.Require.call(this, startScript);
};

C.Extension.Extension.prototype.setupEnvironment = function () {

    'use strict';

    var templateEmitter = new EventEmitter();

    this.currentPath = "";
    this.module.global.UI = templateEmitter;
    this.module.global.strings = this.module.strings;
    //this.module.global.include = C.Extension.UI.include.bind(this);
    this.module.global.trigger = C.Extension.UI.trigger.bind(this);
    this.module.global.sendMessage = C.Extension.Manager.sendMessage.bind(this);
};
