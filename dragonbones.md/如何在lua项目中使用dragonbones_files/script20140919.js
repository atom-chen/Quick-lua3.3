
/* base.js */
(function(){function $(id){return document.getElementById(id);}
function setStyleDisplay(id,status){$(id).style.display=status;}
function goTop(a,t){a=a||0.1;t=t||16;var x1=0;var y1=0;var x2=0;var y2=0;var x3=0;var y3=0;if(document.documentElement){x1=document.documentElement.scrollLeft||0;y1=document.documentElement.scrollTop||0;}
if(document.body){x2=document.body.scrollLeft||0;y2=document.body.scrollTop||0;}
var x3=window.scrollX||0;var y3=window.scrollY||0;var x=Math.max(x1,Math.max(x2,x3));var y=Math.max(y1,Math.max(y2,y3));var speed=1+a;window.scrollTo(Math.floor(x/speed),Math.floor(y/speed));if(x>0||y>0){var f="MGJS.goTop("+a+", "+t+")";window.setTimeout(f,t);}}
function switchTab(showPanels,hidePanels,activeTab,activeClass,fadeTab,fadeClass){$(activeTab).className=activeClass;$(fadeTab).className=fadeClass;var panel,panelList;panelList=showPanels.split(',');for(var i=0;i<panelList.length;i++){var panel=panelList[i];if($(panel)){setStyleDisplay(panel,'block');}}
panelList=hidePanels.split(',');for(var i=0;i<panelList.length;i++){panel=panelList[i];if($(panel)){setStyleDisplay(panel,'none');}}}
function loadCommentShortcut(){$('comment').onkeydown=function(moz_ev){var ev=null;if(window.event){ev=window.event;}else{ev=moz_ev;}
if(ev!=null&&ev.ctrlKey&&ev.keyCode==13){$('submit').click();}}
$('submit').value+=' (Ctrl+Enter)';}
function getElementsByClassName(className,tag,parent){parent=parent||document;var allTags=(tag=='*'&&parent.all)?parent.all:parent.getElementsByTagName(tag);var matchingElements=new Array();className=className.replace(/\-/g,'\\-');var regex=new RegExp('(^|\\s)'+className+'(\\s|$)');var element;for(var i=0;i<allTags.length;i++){element=allTags[i];if(regex.test(element.className)){matchingElements.push(element);}}
return matchingElements;}
window['MGJS']={};window['MGJS']['$']=$;window['MGJS']['setStyleDisplay']=setStyleDisplay;window['MGJS']['goTop']=goTop;window['MGJS']['switchTab']=switchTab;window['MGJS']['loadCommentShortcut']=loadCommentShortcut;window['MGJS']['getElementsByClassName']=getElementsByClassName;})();

/* delay execution */
jQuery(function ($){

/* search box */
var searchbox = MGJS.$("searchbox");
var searchtxt = MGJS.getElementsByClassName("textfield", "input", searchbox)[0];
var searchbtn = MGJS.getElementsByClassName("button", "input", searchbox)[0];
var tiptext = "请输入关键字...";
if(searchtxt.value == "" || searchtxt.value == tiptext) {
	searchtxt.className += " searchtip";
	searchtxt.value = tiptext;
}
searchtxt.onfocus = function(e) {
	if(searchtxt.value == tiptext) {
		searchtxt.value = "";
		searchtxt.className = searchtxt.className.replace(" searchtip", "");
	}
}
searchtxt.onblur = function(e) {
	if(searchtxt.value == "") {
		searchtxt.className += " searchtip";
		searchtxt.value = tiptext;
	}
}
searchbtn.onclick = function(e) {
	if(searchtxt.value == "" || searchtxt.value == tiptext) {
		return false;
	}
}

/* gotop */
$.fn.floatdiv=function(location){
	//ie6要隐藏纵向滚动条
	var isIE6=false;
	var test = document.createElement('div');
	test.innerHTML = '<!--[if lt IE 7]>1<![endif]-->';
	if ('1' === test.innerHTML) {
	    isIE6 = true;
	}
	if(isIE6){
		$("html").css("overflow-x","auto").css("overflow-y","hidden");
		isIE6=true;
	};
	return this.each(function(){
		var loc;//层的绝对定位位置
		if(location==undefined || location.constructor == String){
			switch(location){
				case("rightbottom")://右下角
					loc={right:"0px",bottom:"0px"};
					break;
				case("leftbottom")://左下角
					loc={left:"0px",bottom:"0px"};
					break;	
				case("lefttop")://左上角
					loc={left:"0px",top:"0px"};
					break;
				case("righttop")://右上角
					loc={right:"0px",top:"0px"};
					break;
				case("middle")://居中
					var r=0;//居左
					var t=0;//居上
					var windowWidth,windowHeight;//窗口的高和宽
					//取得窗口的高和宽
					if (self.innerHeight) {
						windowWidth=self.innerWidth;
						windowHeight=self.innerHeight;
					}else if (document.documentElement&&document.documentElement.clientHeight) {
						windowWidth=document.documentElement.clientWidth;
						windowHeight=document.documentElement.clientHeight;
					}else if (document.body) {
						windowWidth=document.body.clientWidth;
						windowHeight=document.body.clientHeight;
					}
					var thisW = $(this).outerWidth();
					//l=windowWidth/2-$(this).width()/2;
					//t=windowHeight/2-$(this).height()/2;
					if(windowWidth-thisW > 980) { r = (windowWidth-980) / 2 - thisW;}
					else {r = 0; }
					//loc={left:l+"px",bottom:t+"px"};
					loc={right:r+"px",bottom:"0px"};
					break;
				default://默认为右下角
					loc={right:"0px",bottom:"0px"};
					break;
			}
		}else{
			loc=location;
		}
		$(this).css("z-index","9999").css(loc).css("position","fixed");
		if(isIE6){
			if(loc.right!=undefined){
				//2008-4-1修改：当自定义right位置时无效，这里加上一个判断
				//有值时就不设置，无值时要加18px已修正层位置
				if($(this).css("right")==null || $(this).css("right")==""){
					$(this).css("right","18px");
				}
			}
			$(this).css("position","absolute");
		}
	});
};
$("#gotop").floatdiv("middle");
$(window).resize(function(){$("#gotop").floatdiv("middle");});
$(window).bind('scroll', function() {
	var isShow = $(document).scrollTop() > 2;
    $("#gotop").css('display',isShow ? "block" : "none");
});

});
