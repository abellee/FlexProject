var scriptPath = fl.scriptURI;
var parentPath = scriptPath.substring(0, scriptPath.lastIndexOf("/"));
var xml = XML(FLfile.read(parentPath + "/data.xml"));
var config = XML(FLfile.read(parentPath + "/config.xml"));
var saveDir = xml.saveDir;
var data = XMLList(xml.item);
var padding = 5;
var right = 221;
var nameWidth = 510;
for each(var node in data){
	fl.openDocument(parentPath + "/" + config.template.fileName);
	var lib = fl.getDocumentDOM().library;
	
	var companySymbolIndex = lib.findItemIndex(config.template.company.symbolName);
	var companySymbol = lib.items[companySymbolIndex];
	var companyTextElement = companySymbol.timeline.layers[0].frames[0].elements[0];
	companyTextElement.setTextString(node.company);
	while(companyTextElement.width > 510){
		companyTextElement.textRuns[0].textAttrs.size--;
	}
	companyTextElement.x = -companyTextElement.width / 2;
	companyTextElement.y = -companyTextElement.height / 2;
	
	var togetherSymbolIndex = lib.findItemIndex(config.template.together.symbolName);
	var togetherSymbol = lib.items[togetherSymbolIndex];
	var togetherLabel0 = togetherSymbol.timeline.layers[0].frames[0].elements[0];
	var togetherLabel1 = togetherSymbol.timeline.layers[0].frames[0].elements[2];
	var togetherTextElement = togetherSymbol.timeline.layers[0].frames[0].elements[1];
	togetherTextElement.setTextString(node.together);
	togetherTextElement.x = togetherLabel1.x - togetherTextElement.width - padding;
	togetherLabel0.x = togetherTextElement.x - togetherLabel0.width - padding;
	
	var followSymbolIndex = lib.findItemIndex(config.template.follower.symbolName);
	var followSymbol = lib.items[followSymbolIndex];
	var followSymbol0 = followSymbol.timeline.layers[0].frames[0].elements[0];
	var followSymbol1 = followSymbol.timeline.layers[0].frames[0].elements[2];
	var followTextElement = followSymbol.timeline.layers[0].frames[0].elements[1];
	followTextElement.setTextString(node.follower);
	followTextElement.x = followSymbol1.x - followTextElement.width - padding;
	followSymbol0.x = followTextElement.x - followSymbol0.width - padding;
	
	var trustedSymbolIndex = lib.findItemIndex(config.template.trusted.symbolName);
	var trustedSymbol = lib.items[trustedSymbolIndex];
	var trustedSymbol0 = trustedSymbol.timeline.layers[0].frames[0].elements[0];
	var trustedSymbol1 = trustedSymbol.timeline.layers[0].frames[0].elements[2];
	var trustedTextElement = trustedSymbol.timeline.layers[0].frames[0].elements[1];
	trustedTextElement.setTextString(node.trusted);
	trustedTextElement.x = trustedSymbol1.x - trustedTextElement.width - padding;
	trustedSymbol0.x = trustedTextElement.x - trustedSymbol0.width - padding;
	
	var companyLayerIndex = fl.getDocumentDOM().getTimeline().findLayerIndex(config.template.company.layerName);
	var togetherLayerIndex = fl.getDocumentDOM().getTimeline().findLayerIndex(config.template.together.layerName);
	var followLayerIndex = fl.getDocumentDOM().getTimeline().findLayerIndex(config.template.follower.layerName);
	var trustedLayerIndex = fl.getDocumentDOM().getTimeline().findLayerIndex(config.template.trusted.layerName);
	
	FLfile.createFolder("file:///" + saveDir + "/" + node.company);
	fl.getDocumentDOM().exportPNG("file:///" + saveDir + "/" + node.company + "/0.png", true, false);
	fl.getDocumentDOM().exportSWF("file:///" + saveDir + "/" + node.company + "/" + node.company + ".png", true);
	fl.getDocumentDOM().close(false);
}
var forPSXML = "<data>\n	<docPath>" + saveDir + "</docPath>\n";
for each(var obj in data){
	var arr = FLfile.listFolder("file:///" + saveDir + "/" + obj.company, "files");
	forPSXML += "	<company>\n";
	forPSXML += "		<name>" + obj.company + "</name>\n";
	forPSXML += "		<images>\n";
	for each(var str in arr){
		if(str.indexOf(".swf") == -1){
			forPSXML += "			<image>" + str + "</image>\n";
		}
	}
	forPSXML += "		</images>\n";
	forPSXML += "	</company>\n";
}
forPSXML += "</data>";
FLfile.write(parentPath + "/forps.xml", forPSXML);
FLfile.runCommandLine(parentPath + "/callPS.bat");
fl.quit();
function trace(str){
	fl.outputPanel.trace(str);
}