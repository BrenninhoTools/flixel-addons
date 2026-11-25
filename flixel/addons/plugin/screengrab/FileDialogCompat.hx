package flixel.addons.plugin.screengrab;

class FileDialogCompat
{
	public static macro function browseSave(onSelect:haxe.macro.Expr, directory:haxe.macro.Expr):haxe.macro.Expr
	{
		var legacy = try haxe.macro.Context.getType("lime.ui.FileDialogType") != null catch (e:Dynamic) false;
		if (legacy)
		{
			return macro
			{
				var dialog = new lime.ui.FileDialog();
				dialog.onSelect.add($onSelect);
				dialog.browse(lime.ui.FileDialogType.SAVE, "*.png", $directory);
			};
		}
		return macro lime.ui.FileDialog.saveFile(lime.app.Application.current.window, "Save screenshot", function(path:String, _)
		{
			$onSelect(path);
		}, [new lime.ui.FileDialogFilter("PNG image", "png")], $directory);
	}
}
