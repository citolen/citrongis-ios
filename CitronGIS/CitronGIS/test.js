

function fileChanged(str) {
    var extZip = new JSZip(str, { base64: true});
    var e = new C.Extension.Extension(extZip);
    
    debugPackage(e.package);
    C.Extension.Manager.register(e);
    
    
    e.module.ui.on('display', function (element) {
        document.body.style.backgroundColor = 'rgba(0,0,0, 0)';
        document.body.appendChild(element);
    });
    
    e.run();
}


function debugPackage(package) {
    log("name:" + package.name);
    log("version:" + package.version);
    log("main:" + package.main);
}
