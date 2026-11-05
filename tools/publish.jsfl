var base = "file:///C|/Users/Alpha/Documents/GitHub/Frontline-Defender/";
fl.outputPanel.clear();
var doc = fl.openDocument(base + "source/game/Frontline%20Defender%20-%20game.fla");
if (doc) {
  FLfile.write(base + "logs/animate-open.txt", "Opened: " + doc.name);
  doc.publish();
  fl.compilerErrors.save(base + "logs/compile-errors.txt");
  fl.outputPanel.save(base + "logs/animate-output.txt");
  FLfile.write(base + "logs/publish-done.txt", "Publish finished");
}
