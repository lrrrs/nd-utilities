/*
*
*  Finds image in a folder with the suffix "@2x.png", shrinks them by 50% and exports them 
*  as a file with the "@2x" removed.
*
*  Rob Seward 2011
*/

$.level = 2; //activate debugger if there are problems

var dlg=
"dialog{text:'Script Interface',bounds:[100,100,500,220],"+
"folder:EditText{bounds:[10,40,310,60] , text:'' ,properties:{multiline:false,noecho:false,readonly:false}},"+
"recurse:Checkbox{bounds:[260,10,361,50] , text:'Recursive' },"+
"Browse:Button{bounds:[320,40,390,61] , text:'<<' },"+
"statictext0:StaticText{bounds:[10,10,240,27] , text:'Please select Folder' ,properties:{scrolling:undefined,multiline:undefined}},"+
"Process:Button{bounds:[10,80,190,101] , text:'Process' },"+
"button2:Button{bounds:[210,80,390,101] , text:'Cancel' }};"
var win = new Window(dlg,'JPGE / PNG image resize 50%');
win.center();
win.folder.enabled=false;
win.Browse.onClick = function() 
{ 
	selectedFolder = Folder.selectDialog( "Please select a folder to process");  
	if(selectedFolder != null) win.folder.text = decodeURI(selectedFolder); 
}

win.Process.onClick = function() 
{ 
	if(win.folder.text == '') 
	{
		alert("No folder has been selected!");
		return;
	}
	
	win.close(1);
	folderList = [];
	
	if(win.recurse.value)
	{
		processFolder(selectedFolder);
		folderList.unshift(selectedFolder);
	}
	else
	{
		folderList.unshift(selectedFolder);
	}
	ProcessFiles();
	
	function ProcessFiles()
	{
		for(var a in folderList)
		{
			var fileList = folderList[a].getFiles(/\.(jpg|png)$/i);
			
			for(var s in fileList)
			{
				var startRulerUnits = app.preferences.rulerUnits;
				app.preferences.rulerUnits = Units.PIXELS;
				var file = fileList[s];
				open(file);
				var Name = activeDocument.name;//.match(/(.*)\.[^\.]+$/)[1];
				
				//alert(Name);
				
				if(/@2x.png/.test(Name))
				{
					halveImage();
					var saveFileName = activeDocument.name.replace(/@2x.png/,".png");
					var saveFile = File(activeDocument.path + "/" + saveFileName);
					SavePNG(saveFile);
				}
				else if(/@2x.jpg/.test(Name))
				{
					halveImage();
					var saveFileName = activeDocument.name.replace(/@2x.jpg/,".jpg");
					var saveFile = File(activeDocument.path + "/" + saveFileName);
					SaveJPEG(saveFile);
				}
				
				app.activeDocument.close(SaveOptions.DONOTSAVECHANGES);
				app.preferences.rulerUnits = startRulerUnits;
			}
		}
	}
	
	function processFolder(folder) 
	{
		var fileList = folder.getFiles()
		for (var i = 0; i < fileList.length; i++) 
		{
			var file = fileList[i];
			if (file instanceof Folder) 
			{
				folderList.push(file);  
				processFolder(file);
			}
		}
	}
}

win.show();

function halveImage() 
{ 
	var doc=activeDocument;
	var newWidth = doc.width * 0.5;
	var newHeight = doc.height * 0.5;
	doc.resizeImage(newWidth, newHeight, undefined, ResampleMethod.BICUBIC);
}

function SavePNG(savefile)
{	
	opts = new ExportOptionsSaveForWeb();
    opts.format = SaveDocumentType.PNG;
    opts.PNG8 = false;
    opts.quality = 100; 
	activeDocument.exportDocument(savefile, ExportType.SAVEFORWEB, opts);
}

function SaveJPEG(savefile)
{	
	opts = new ExportOptionsSaveForWeb();
    opts.format = SaveDocumentType.JPEG;
    opts.quality = 90; 
	activeDocument.exportDocument(savefile, ExportType.SAVEFORWEB, opts);
}