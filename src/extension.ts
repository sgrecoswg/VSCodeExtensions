// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';
import { readFileSync, readdirSync, lstatSync } from 'fs';
import { mkdir, writeFile, readFile, readdir, lstat} from 'fs/promises';

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

	// // Use the console to output diagnostic information (console.log) and errors (console.error)
	// // This line of code will only be executed once when your extension is activated
	// console.log('Congratulations, your extension "sensibleextensions" is now active!');

	// // The command has been defined in the package.json file
	// // Now provide the implementation of the command with registerCommand
	// // The commandId parameter must match the command field in package.json
	// const disposable = vscode.commands.registerCommand('sensibleextensions.helloWorld', () => {
	// 	// The code you place here will be executed every time your command is executed
	// 	// Display a message box to the user
	// 	vscode.window.showInformationMessage('Hello World from SensibleExtensions!');
	// });

	// context.subscriptions.push(disposable);

	const _moveselectiontofiledisposable = vscode.commands.registerCommand('sensibleextensions.moveselectiontofile',async (c) => {
		
		const _workspace = vscode.window;
		if(!_workspace.activeTextEditor) {vscode.window.showErrorMessage("A workspace must be opened.");}

		const _editor = _workspace.activeTextEditor;
		if(!_editor) {return;}

		const _selection = _editor.selection;
		const _selectedRange = new vscode.Range(_selection.start,_selection.end);
		const _highlightedText = _editor.document.getText(_selectedRange);

		let _name = await vscode.window.showInputBox({placeHolder : "Please enter file name"}) || "";
		if(!_name.includes(".")){
			const _extension = await vscode.window.showInputBox({placeHolder : "Please enter file extension"}) || "";
			_name += `.${_extension}`;
		}
		const _pathSplit = c.fsPath.split("\\");
		const _path = _pathSplit.slice(0,_pathSplit.length-1).join("/");
		const _fileUri = vscode.Uri.file(`${_path}/${_name}`);
		
		vscode.workspace.fs.writeFile(_fileUri,Buffer.from(_highlightedText))
						   .then(()=>{

								_editor.edit(_builder => {
									_builder.replace(_selection,"");
								});	
								
								vscode.window.showInformationMessage(`${_path}/${_name} created.`);	
						   });

	});
	context.subscriptions.push(_moveselectiontofiledisposable);

	const _createterraformprojectdisposable = vscode.commands.registerCommand('sensibleextensions.createterraformproject',async (c) => {
		let _projectData = {organization:"",workspaceprefix:""};
		_projectData.organization = await vscode.window.showInputBox({placeHolder : "Please enter organization"}) || "";		
		_projectData.workspaceprefix = await vscode.window.showInputBox({placeHolder : "Please enter name of workspace prefix"}) || "";		
		const _name = "terraform";
		
		try {
			let _pSplit = c.fsPath.split("\\");
			let _p = _pSplit.slice(0,_pSplit.length-1).join('/');
			let _fPath = `${_p}/${_name}`;
			mkdir(_fPath);
			const _templatepath = ".\\resources\\templates\\terraform\\newProject";
			const _fullPath = context.asAbsolutePath(_templatepath);
			let _templateFolder = readdirSync(_fullPath);
			_templateFolder.forEach((x)=>{
				createFromTemplate(_fullPath,x,_fPath,_name,_projectData);
				vscode.window.showInformationMessage(`${_name} created.`);	
			});
		} catch (error:any) {
			vscode.window.showErrorMessage(error.message);
		}
	});
	context.subscriptions.push(_createterraformprojectdisposable);

}


function createFromTemplate(templatePath:string,fileName:string,path:string,moduleName:string,data:any){

	let _currentEntry = `${templatePath}/${fileName}`;
	if (lstatSync(_currentEntry).isDirectory()) {
		let _subItem = readdirSync(_currentEntry);
		if (_subItem.length >0) {
			mkdir(`${path}/${moduleName}`);
			_subItem.forEach((y)=>{
				const _content = readFileSync(`${path}/${fileName}/${y}`,'utf-8');

				let _replacedText = _content.replaceAll('|organization|',data.organization);
				_replacedText = _content.replaceAll('|workspaceprefix|',data.workspaceprefix);

				writeFile(`${path}/${fileName}/${y.replace('.txt','')}`,_replacedText);
			});
		}
	} else {
		const _content = readFileSync(_currentEntry,'utf-8');
		const _replacedText = _content.replaceAll('|templateLower|',moduleName.toLowerCase());
		writeFile(`${path}/${fileName.replaceAll("template",moduleName).replace('.txt','')}`,_replacedText);
	}
}


// This method is called when your extension is deactivated
export function deactivate() {}
