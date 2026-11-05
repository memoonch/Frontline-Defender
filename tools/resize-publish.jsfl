var base = "file:///C|/Users/Alpha/Documents/GitHub/Frontline-Defender/";
var doc = fl.getDocumentDOM();
if (!doc) doc = fl.openDocument(base + "source/game/Frontline%20Defender%20-%20game.fla");
if (doc && doc.name == "Frontline Defender - game.fla") {
  doc.width = 960;
  doc.height = 540;
  fl.saveDocument(doc);
  doc.publish();
  fl.compilerErrors.save(base + "logs/resize-compile.txt");
  fl.outputPanel.save(base + "logs/resize-output.txt");
  FLfile.write(base + "logs/resize-done.txt", "Published 960x540");
}

