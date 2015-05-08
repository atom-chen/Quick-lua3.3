var showFlashLib=function($){
	var swfs={};var lib={};
	lib.showFlash=function(id){
		var o=swfs[id];if(!o){return;}
		swfobject.embedSWF(o.swf,id,o.w,o.h,o.v,showFlashExpressInstallSWFURL,o.vars,o.par,o.att);
		$("#"+id+"_show").css({display:"none"});$("#"+id+"_hide").css({display:"block"});
	};
	lib.hideFlash=function(id){
		var o = swfs[id];if(!o){return;}
		var node = null;var pos = null;
		if($("#"+id).next()!==null){pos = "next";node = $("#"+id).next();}
		else if($("#"+id).prev()!==null){pos="prev";node=$("#"+id).prev();}
		else if($("#"+id).parent()!==null){pos="parent";node=$("#"+id).parent();}
		swfobject.removeSWF(id);
		$("#"+id+"_show").css({display:"block"});$("#"+id+"_hide").css({display:"none"});
		var txt='<div id="'+id+'"></div>';
		if("next"===pos){node.before(txt);}
		else if("prev"===pos){node.after(txt);}
		else if("parent"===pos){node.append(txt);}
	};
	lib.initBox=function(src,id,w,h,v,vars,par,att){
		var html = '<div style="cursor:pointer;text-align:center;display:black;"><p id="'+id+'_show" style=""><img src="'+window.showFlashIconURL+'" alt="'+window.showFlashHidingStateText+'" title="'+window.showFlashHidingStateText+'"></img><br/>'+window.showFlashHidingStateText+'</p>';
		html += '<p id="'+id+'_hide" style=""><img src="'+window.showFlashIconURL+'" alt="'+window.showFlashShowingStateText+'" title="'+window.showFlashShowingStateText+'"></img><br/>'+window.showFlashShowingStateText+'</p></div>';
		swfs[id] = {swf:src,id:id,w:w,h:h,v:v||"9",vars:vars,par:par,att:att};
		$("#"+id).before(html);
		$("#"+id).css({display:"none"});
		$("#"+id+"_show").css({display:"block"});$("#"+id+"_hide").css({display:"none"});
		$("#"+id+"_show").click(function(){showFlashLib.showFlash(id);});
		$("#"+id+"_hide").click(function(){showFlashLib.hideFlash(id);});
	};
	lib.createBox=function(src,w,h,v,vars,par,att){
		var id="showFlashBox_"+Math.floor(Math.random()*10000);
		var html='<div id="'+id+'"></div>';
		document.writeln(html);
		showFlashLib.initBox(src,id,w,h,v,vars,par,att);
	};
	return lib;
}(jQuery);