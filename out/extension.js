"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.deactivate = deactivate;
exports.activate = activate;
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
const vscode = __importStar(require("vscode"));
const path_1 = require("path");
const fs_1 = require("fs");
const promises_1 = require("fs/promises");
// This method is called when your extension is deactivated
function deactivate() { }
// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
function activate(context) {
    const _moveselectiontofiledisposable = vscode.commands.registerCommand('sensibleextensions.moveselectiontofile', async (c) => {
        const _workspace = vscode.window;
        if (!_workspace.activeTextEditor) {
            vscode.window.showErrorMessage("A workspace must be opened.");
        }
        const _editor = _workspace.activeTextEditor;
        if (!_editor) {
            return;
        }
        const _selection = _editor.selection;
        const _selectedRange = new vscode.Range(_selection.start, _selection.end);
        const _highlightedText = _editor.document.getText(_selectedRange);
        let _name = await vscode.window.showInputBox({ placeHolder: "Please enter file name" }) || "";
        if (!_name.includes(".")) {
            const _extension = await vscode.window.showInputBox({ placeHolder: "Please enter file extension" }) || "";
            _name += `.${_extension}`;
        }
        const _pathSplit = c.fsPath.split("\\");
        const _path = _pathSplit.slice(0, _pathSplit.length - 1).join("/");
        const _fileUri = vscode.Uri.file(`${_path}/${_name}`);
        vscode.workspace.fs.writeFile(_fileUri, Buffer.from(_highlightedText))
            .then(() => {
            _editor.edit(_builder => {
                _builder.replace(_selection, "");
            });
            vscode.window.showInformationMessage(`${_path}/${_name} created.`);
        });
    });
    context.subscriptions.push(_moveselectiontofiledisposable);
    const _createterraformprojectdisposable = vscode.commands.registerCommand('sensibleextensions.createterraformproject', async (c) => {
        let _projectData = { organization: "", workspaceprefix: "" };
        _projectData.organization = await vscode.window.showInputBox({ placeHolder: "Please enter organization" }) || "";
        _projectData.workspaceprefix = await vscode.window.showInputBox({ placeHolder: "Please enter name of workspace prefix" }) || "";
        const _name = "terraform";
        try {
            let _pSplit = c.fsPath.split("\\");
            let _p = _pSplit.slice(0, _pSplit.length - 1).join('/');
            let _fPath = `${_p}/${_name}`;
            (0, promises_1.mkdir)(_fPath);
            const _templatepath = ".\\resources\\templates\\terraform\\newProject";
            const _fullPath = context.asAbsolutePath(_templatepath);
            let _templateFolder = (0, fs_1.readdirSync)(_fullPath);
            _templateFolder.forEach((x) => {
                createFromTemplate(_fullPath, x, _fPath, _name, _projectData);
            });
            // Directory to start from
            const searchValue = [
                { search: '|organization|', value: _projectData.organization },
                { search: '|workspaceprefix|', value: _projectData.workspaceprefix }
            ];
            const _newFiles = getAllFiles(_fPath);
            _newFiles.forEach((file) => {
                replaceTexts(file, searchValue);
            });
            vscode.window.showInformationMessage(`${_name} created.`);
        }
        catch (error) {
            vscode.window.showErrorMessage(error.message);
        }
    });
    context.subscriptions.push(_createterraformprojectdisposable);
}
function createFromTemplate(templatePath, fileName, path, moduleName, data) {
    let _currentEntry = `${templatePath}/${fileName}`;
    if ((0, fs_1.lstatSync)(_currentEntry).isDirectory()) {
        let _subItem = (0, fs_1.readdirSync)(_currentEntry);
        if (_subItem.length > 0) {
            const _destination = `${path}/${fileName}`;
            (0, fs_1.cpSync)(_currentEntry, _destination, { recursive: true });
        }
    }
    else {
        const _content = (0, fs_1.readFileSync)(_currentEntry, 'utf-8');
        const _replacedText = _content.replaceAll('|templateLower|', moduleName.toLowerCase());
        (0, promises_1.writeFile)(`${path}/${fileName.replaceAll("template", moduleName).replace('.txt', '')}`, _replacedText);
    }
}
function getAllFiles(dirPath) {
    const files = (0, fs_1.readdirSync)(dirPath);
    let result = [];
    files.forEach((file) => {
        const filePath = (0, path_1.join)(dirPath, file);
        const stat = (0, fs_1.statSync)(filePath);
        if (stat.isDirectory()) {
            result = result.concat(getAllFiles(filePath));
        }
        else {
            result.push(filePath);
        }
    });
    return result;
}
const replaceText = async (filePath, from, to) => {
    const fileContent = await (0, promises_1.readFile)(filePath, 'utf8');
    const replacedContent = fileContent.replaceAll(from, to);
    await (0, promises_1.writeFile)(filePath, replacedContent, 'utf8');
};
const replaceTexts = async (filePath, replacements) => {
    let replacedContent = await (0, promises_1.readFile)(filePath, 'utf8');
    if (replacedContent.length > 0) {
        if (replacements.some(x => replacedContent.includes(x.search))) {
            replacements.forEach((entry) => {
                replacedContent = replacedContent.replaceAll(entry.search, entry.value);
            });
            await (0, promises_1.writeFile)(filePath, replacedContent, 'utf8');
        }
    }
};
//# sourceMappingURL=extension.js.map