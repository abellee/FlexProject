package
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import com.codeazur.as3swf.SWF;
	import com.codeazur.as3swf.SWFData;
	import com.codeazur.as3swf.data.SWFRectangle;
	import com.codeazur.as3swf.data.SWFSymbol;
	import com.codeazur.as3swf.data.consts.BitmapType;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG2;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG3;
	import com.codeazur.as3swf.tags.TagDefineBitsJPEG4;
	import com.codeazur.as3swf.tags.TagDoABC;
	import com.codeazur.as3swf.tags.TagEnd;
	import com.codeazur.as3swf.tags.TagFileAttributes;
	import com.codeazur.as3swf.tags.TagShowFrame;
	import com.codeazur.as3swf.tags.TagSymbolClass;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;
	
	import org.as3commons.bytecode.abc.AbcFile;
	import org.as3commons.bytecode.abc.enum.Opcode;
	import org.as3commons.bytecode.emit.IAbcBuilder;
	import org.as3commons.bytecode.emit.IClassBuilder;
	import org.as3commons.bytecode.emit.ICtorBuilder;
	import org.as3commons.bytecode.emit.IMethodBuilder;
	import org.as3commons.bytecode.emit.IPackageBuilder;
	import org.as3commons.bytecode.emit.impl.AbcBuilder;
	import org.as3commons.bytecode.io.AbcSerializer;
	
	public class SWFExport extends EventDispatcher
	{
		private var swf:SWF;
//		private var imgWidth:Number;
//		private var imgHeight:Number;
		
		private var abcBuilder:IAbcBuilder;
		private var packageBuilder:IPackageBuilder;
		private var symbolClass:TagSymbolClass;
		private var currentCharacterId:uint;
		
		private var imgWidth:int = 0;
		private var imgHeight:int = 0;
		
		public function SWFExport(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function createSWF(arr:Vector.<Bitmap>, identifier:String, path:String, folderName:String):Boolean
		{
			init();
			var len:int = arr.length;
			for(var i:int = 0; i<len; i++){
				imgWidth = arr[i].width;
				imgHeight = arr[i].height;
				addPNG(encodePNG(arr[i].bitmapData), identifier + "_" + i, arr[i].bitmapData);
			}
			addClass();
			var ba:ByteArray = publish();
			var file:File = new File(path);
			file = file.resolvePath(path).resolvePath(folderName).resolvePath(identifier + ".swf");
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeBytes(ba);
			fileStream.close();
			return true;
		}
		
		private function addClass():void
		{
			var classBuilder:IClassBuilder = packageBuilder.defineClass("TestClass", "flash.display.Sprite");
			classBuilder.isDynamic = true;
			classBuilder.defineProperty("testProperty", "String", "lijinbei");
			var ctorBuilder:ICtorBuilder = classBuilder.defineConstructor();
			ctorBuilder.defineArgument("int", true, imgWidth);
			ctorBuilder.defineArgument("int", true, imgHeight);
			ctorBuilder.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.pushscope)
				.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.getlocal_1)
				.addOpcode(Opcode.getlocal_2)
				.addOpcode(Opcode.constructsuper, [2])
				.addOpcode(Opcode.returnvoid);
			var method:IMethodBuilder = classBuilder.defineMethod("testMethod");
			method.returnType = "String";
			method.defineArgument("int");
			method.addOpcode(Opcode.getlocal_0)
				  .addOpcode(Opcode.pushscope)
				  .addOpcode(Opcode.pushint, [101])
				  .addOpcode(Opcode.getlocal_2)
				  .addOpcode(Opcode.multiply)
				  .addOpcode(Opcode.pushstring, [""])
				  .addOpcode(Opcode.add)
				  .addOpcode(Opcode.setlocal_2)
				  .addOpcode(Opcode.getlocal_2)
				  .addOpcode(Opcode.returnvalue);
		}
		
		private function addPNG(data:ByteArray, className:String, bd:BitmapData):void
		{
			var classBuilder:IClassBuilder = packageBuilder.defineClass(className, "flash.display.BitmapData");
			classBuilder.isDynamic = true;
			var ctorBuilder:ICtorBuilder = classBuilder.defineConstructor();
			ctorBuilder.defineArgument("int", true, imgWidth);
			ctorBuilder.defineArgument("int", true, imgHeight);
			ctorBuilder.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.pushscope)
				.addOpcode(Opcode.getlocal_0)
				.addOpcode(Opcode.getlocal_1)
				.addOpcode(Opcode.getlocal_2)
				.addOpcode(Opcode.constructsuper, [2])
				.addOpcode(Opcode.returnvoid);
			
			symbolClass.symbols.push(SWFSymbol.create(currentCharacterId, className));
			
			var bitmapAlphaData:ByteArray = new ByteArray();
//			trace(bd.getPixel(0 % 180, int(0 / 180)).toString(16), (bd.getPixel(0 % 180, int(0 / 180)) >> 24) && 0xFFFFFF);
//			trace(data.length, 54 * 121, 54 * 121 * 4);
			var str:String = "";
			for(var i:int = 0; i<imgWidth * imgHeight; i++){
				var alpha:int = bd.getPixel32(i % imgWidth, int(i / imgWidth)) >> 24 & 0xFF;
				bitmapAlphaData[i] = alpha;
//				bitmapAlphaData[i + 1] = alpha;
//				bitmapAlphaData[i + 2] = alpha;
//				bitmapAlphaData[i + 3] = alpha;
////				trace(alpha);
//				trace(bitmapAlphaData[i]);
			}
			
//			data.compress();
			bitmapAlphaData.compress();
			
			var defineBitsJPEG2:TagDefineBitsJPEG3 = new TagDefineBitsJPEG3();
			defineBitsJPEG2.characterId = currentCharacterId;
			defineBitsJPEG2.bitmapType = BitmapType.JPEG;
			defineBitsJPEG2.bitmapData.writeBytes(data);
			defineBitsJPEG2.bitmapAlphaData.writeBytes(bitmapAlphaData);
			
			swf.tags.push(defineBitsJPEG2);
			
			currentCharacterId++;
		}
		
		private function init():void
		{
			swf = new SWF();
			swf.tags.push(new TagFileAttributes());
			abcBuilder = new AbcBuilder();
			packageBuilder = abcBuilder.definePackage("");
			symbolClass = new TagSymbolClass();
			currentCharacterId = 1;
		}
		
		private function publish():ByteArray
		{
			var abcFile:AbcFile = abcBuilder.build();
			var abcSerializer:AbcSerializer = new AbcSerializer();
			var abcBytes:ByteArray = abcSerializer.serializeAbcFile(abcFile);
			
			swf.tags.push(TagDoABC.create(abcBytes));
			swf.tags.push(symbolClass);
			swf.tags.push(new TagShowFrame());
			swf.tags.push(new TagEnd());
			
			var swfData:SWFData = new SWFData();
			swf.publish(swfData);
			return swfData;
		}
		
		// Source: http://www.wischik.com/lu/programmer/get-image-size.html
		private function determinePNGSize(data:ByteArray):Boolean {
			// PNG: the first frame is by definition an IHDR frame, which gives dimensions
			if (data[0] == 0x89
				&& data[1] == 0x50 && data[2] == 0x4e && data[3] == 0x47 // "PNG"
				&& data[4] == 0x0D && data[5] == 0x0A && data[6] == 0x1A && data[7] == 0x0A
				&& data[12] == 0x49 && data[13] == 0x48 && data[14] == 0x44 && data[15] == 0x52) { // "IHDR"
				imgWidth = (data[16] << 24) | (data[17] << 16) | (data[18] << 8) | data[19];
				imgHeight = (data[20] << 24) | (data[21] << 16) | (data[22] << 8) | data[23];
				return true;
			}
			trace("WARNING: determinePNGSize(): No size found");
			return false;
		}
		
		private function encodePNG(bitmap:BitmapData):ByteArray
		{
			return new JPGEncoder().encode(bitmap);
		}
	}
}