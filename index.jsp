<%@ page contentType = "text/html;charset=euc-kr" pageEncoding="EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.agencypro.aig.admin.event.EventManage"%>
<%@ page import="com.agencypro.aig.goods.CGoodsDAO"%>
<%@ include file="/common/common_module.jsp"%>
<%@ include file="/inc/front/front_title.jsp"%>
<%
	if (domainPath.equals(aigDomainName)) {
		V_DynamicServiceUrl = V_ServiceSSLUrl;
	}
	
	String ardsFileNm = "";
	String imgFileLoadUrl = "../common/viewImg.jsp?serverFileNm=";
	
	EventManage em = new EventManage();

	String cpcode = CUtil.checkNull((String)session.getAttribute("cpcode"));
	if ("".equals(cpcode)) {
		cpcode = CUtil.scanString((String)request.getParameter("hCpcode"));		
		session.setAttribute("cpcode", cpcode);
	}

	if("".equals(CUtil.checkNull(reqAgCode))){
		reqAgCode = CUtil.scanString((String)request.getParameter("hAgCode"));
	}
	
	String lastCpcode = "";
	if (!"".equals(cpcode) && cpcode.length() > 0) {
		lastCpcode = cpcode.charAt(cpcode.length() - 1) + "";
	}
	
	logcode = request.getRequestURL()+"";
	SimpleDateFormat formatter = new SimpleDateFormat( "yyyyMMddHHmmssSSS" );
	Date today = new Date();
	logcode += formatter.format( today );
	session.setAttribute("logcode", logcode);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html;charset=euc-kr">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="format-detection" content="telephone=no">
<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
<meta name="keywords" content="보험, AIA생명, AIA, 생명보험, 보장">
<meta name="description" content="AIA생명은 다양한 상품과 서비스로 고객의 니즈를 만족시키기 위해 최선을 다하고 있습니다. 사망보장, 질병, 상해는 물론 은퇴설계에 이르기까지 최적의 맞춤보장을 제공해 드립니다. ">
<meta property="og:image" content="http://www.aia.co.kr/content/dam/kr/ko/images/site/og/aia-life.png">
<title>(무) AIA Vitality 든든튼튼암보험(갱신형) | AIA</title>
<link rel="shortcut icon" type="image/x-icon" href="https://www.aia.co.kr/favicon.ico">
<script src="./js/jquery-2.1.1.min.js"></script>
<script>

function addViewportEvent(e,i){var t="scroll.addViewportEvent load.addViewportEvent resize.addViewportEvent";if(e=$.extend({parent:window,triggerPosition:!1,triggerPositionPercent:!1,enter:!1,leave:!1,visiblePercent:!1,visible:!1,invisible:!1},e||{}),"number"==typeof(e.triggerPosition&&e.triggerPositionPercent))return!0;$.fn.extend({destroy:function(){$(e.parent).off(t)}});return i.each(function(i,r){var n=!1,o=!1,s=!1,g=e.parent;$(g).on(t,function(){var i={Height:$(r).outerHeight(),ViewportHeight:$(g).height(),ScrollTop:$(document).scrollTop(),OffsetTop:$(r).offset().top},t=((i.ScrollTop+i.ViewportHeight-i.OffsetTop)/i.Height*100).toFixed(2),l=-((i.ScrollTop-i.OffsetTop-i.Height)/i.Height*100).toFixed(2),c=i.OffsetTop-i.ScrollTop-e.triggerPosition,v=(c/i.ViewportHeight*100-e.triggerPositionPercent).toFixed(2);o=t>=0&&l>=0,v>=50?v=50:-50>=v&&(v=-50),o&&100>=t?visiblePercent=t:o&&100>=l?visiblePercent=l:o?visiblePercent=100:visiblePercent=0,o&&(r.isVisible=o,r.isEnter=n,r.viewPortPositionPercent=v,r.viewPortPosition=c,r.visiblePercent=visiblePercent),o&&((!n&&e.triggerPositionPercent!==!1&&0>=v||e.triggerPosition&&0>=c)&&($(r).trigger("enter"),$.isFunction(e.enter)&&e.enter()),(n&&e.triggerPositionPercent!==!1&&v>0||e.triggerPosition&&c>0)&&($(r).trigger("leave"),$.isFunction(e.leave)&&e.leave())),!s&&visiblePercent>0&&($(r).trigger("visible"),$.isFunction(e.visible)&&e.visible()),s&&0==visiblePercent&&($(r).trigger("invisible"),$.isFunction(e.invisible)&&e.invisible(),$(r).trigger("leave"),$.isFunction(e.leave)&&e.leave()),$.isFunction(e.visiblePercent)&&e.visiblePercent(Number(visiblePercent),i),s=0!=visiblePercent,n=e.triggerPositionPercent&&0>=v&&o||e.triggerPosition&&0>=c&&o})})}

function calc() {
    $(".popup.calc").show();
    $(".popup.agree").hide();
}

function comp() {
    $(".popup.comp").show();
    $(".popup.agree").hide();
}

(function($) {
    var AIA_UI = {
		var : {
			sChecked : null,
			dChecked : null
		},

		popup: function() {
            $('[data-role="open_popup"]').on({
                "click" : function(e){
					var array = $(this).attr("data-send").split("|");
                    var target = $("[data-receive='"+ (array[0]) +"']");
                    target.show();
					if( array[1] == 1 ){
						target.find(".all_check").attr("onclick", "calc()");
					} else {
						target.find(".all_check").attr("onclick", "comp()");
					}
                    e.preventDefault();
                }
            });
            
            $(".popup .btn_close").on({
                "click" : function(e){
                    $(this).parents(".popup").hide();
                    e.preventDefault();
                }
            });
        },

        event : function(){
            $(".guide_area button").on({
                "click" : function(e){
                    var target = $(this).parents(".guide_area").find(".img");
                    if(target.hasClass("on")){
                        target.removeClass("on");
                    } else {
                        target.addClass("on");
						$("body, html").animate({ scrollTop :  $(".guide_area").offset().top }, 500);
                    }
                }
			});

			$(".floating .btn01, .floating .btn02").on({
				"click" : function(e){
					var _this 	= $(this);
					var target 	= $(".floating");
					if(! target.hasClass("on") ){
						target.addClass("on");
					} 

					$(".floating .calc, .floating .consult").hide();
					if( _this.attr("class") == "btn01" ){
						$(".floating .calc").show();
					} else {
						$(".floating .consult").show();
					}
					e.preventDefault();
				}
			});
			
			$(".floating .btn_toggle").on({
				"click" : function(e){
					var target 	= $(".floating");
					if( target.hasClass("on") ){
						target.removeClass("on");
					} else {
						target.addClass("on");
					}
					e.preventDefault();
				}
			});

			$(".popup.agree .all_check").on({
				"click" : function(e){
					$(".popup.agree .agree input[type='checkbox']").prop("checked", true);
					e.preventDefault();
				}
			});
		},

		scroll : function(){
			$(window).scroll(function(){
				var windowTop = $(window).scrollTop();
				if( AIA_UI.var.sChecked == "s1" ){
					var guideLine01 = $(".s02").offset().top - 50;
					var guideLine02 = $(".s08").offset().top - parseInt($(window).height());
					var guideLine03 = $(".guide_area").offset().top;
					
					if(  windowTop >= guideLine01 ){
						$("#AIA_wrap").addClass("show");
						if( windowTop > guideLine02 ){
							$("#AIA_wrap").removeClass("show");
						}
						if( windowTop > guideLine03  ){
							$("#AIA_wrap").addClass("show");
						}
					} else {
						$("#AIA_wrap").removeClass("show");
					} 
				} else {
					if( windowTop >= parseInt($("body").height() - $(window).height() - 100) ){
						$(".s07").addClass("mt");
					}
				}
			});
		},

        init: function() {
			AIA_UI.var.sChecked = $(window).width() > 900 ? "s2" : "s1";
			AIA_UI.var.dChecked = AIA_UI.var.sChecked;

			imgReplace();
			function imgReplace(){
				$("#AIA_wrap img").each(function(){
					if( AIA_UI.var.sChecked == "s1" ){
						$(this).attr("src", $(this).attr("data-mo-src"));
					} else {
						$(this).attr("src", $(this).attr("data-pc-src"));
					}
				});
			}

			$(window).resize(function(){
				AIA_UI.var.sChecked = $(window).width() > 900 ? "s2" : "s1";
				if( AIA_UI.var.sChecked != AIA_UI.var.dChecked ){
					imgReplace();
					AIA_UI.var.dChecked = AIA_UI.var.sChecked
				}
			});

            this.popup(), this.event(), this.scroll()
        }
    };
    $(function() {

		AIA_UI.init();

		var percent = (AIA_UI.var.sChecked == "s1" ? 60 : 40);
		var motionTargetArray = [".s01", ".s02", ".s03", ".s04", ".s05", ".s06", ".s07"];
		$.each( motionTargetArray, function(i,e){
			addViewportEvent({
				triggerPositionPercent: percent,
				enter: function () {
					$(e).addClass("mt");
				},
				leave : function(){
					//$(e).removeClass("mt");
				}
			}, $(e));
		});
	});
})(jQuery);
</script>

<style>
@font-face {
	font-family: "NanumSquareBold";
	src: url(./font/NanumSquareB.eot);
	src: url(./font/NanumSquareB.eot?#iefix) format("embedded-opentype"), url(./font/NanumSquareB.woff) format("woff"), url(./font/NanumSquareB.ttf) format("truetype");
}

@font-face {
	font-family: "NanumSquareRegular";
	src: url(./font/NanumSquareR.eot);
	src: url(./font/NanumSquareR.eot?#iefix) format("embedded-opentype"), url(./font/NanumSquareR.woff) format("woff"), url(./font/NanumSquareR.ttf) format("truetype");
}

html,body,div,ul,ol,li,dl,dt,dd,h1,h2,h3,h4,h5,h6,p,input,button,th,td,select,textarea,a { margin: 0; padding: 0; box-sizing: border-box; }
body,a,input,button,select,strong,textarea { color: #000; font-family: "NanumSquareRegular","맑은 고딕",Arial,Sans-serif; font-size: 15px; letter-spacing: -1px; word-break: keep-all; }
h1,h2,h3,h4,h5,h6 { font-size: 100%; }
fieldset,img { border: 0 none; }
img { vertical-align: top; }
ol,ul { list-style: none; }
address { font-style: normal; }
button, button[type="button"] { border: 0; cursor: pointer; background:none; outline: none; }
em { font-style: normal; }
select { -webkit-border-radius: 0; background: transparent; }
input[type="text"] { border: none; color: #000; outline: none; }
a { text-decoration: none; }
h2, h3 { font-weight: normal; }
.bold { font-family: "NanumSquareBold"; }
input:-ms-input-placeholder { color: #7f7f7f !important; }
input::-webkit-input-placeholder { color: #7f7f7f; }
input::-moz-placeholder { color: #7f7f7f; }
.hide { position: absolute; left: -9999px; top: -9999px; font-size: 0; line-height: 0; height: 0; overflow: hidden; }

.fade_up_blur { opacity: 0; transform: translateY(40px); transition: 0.5s all; filter: blur(20px); }
.mt .fade_up_blur { opacity: 1; transform: translateY(0); filter: blur(0); }

@media screen and (min-width : 1080px) {
	.inner { position: relative; width: 1080px; margin: 0 auto; text-align: center; }
	.only_pc { display: block; }
	.only_mo { display: none; }
	.motion > * { position:absolute; }

	.header { height:74px; background:#f3f3f3; }
	.header a.btn_home {  display: block; position: absolute; left:0; top:0; height: 100%; width:300px; text-indent: -9999px; }

	.db_box input[type="text"] { width: 100%; height: 40px; padding: 0 15px; line-height: 41px; font-size: 20px;  border-radius: 2px; background:#fff;  }
	.db_box ul { margin-top:24px; }
	.db_box ul:after { content:""; display:block; clear:both; }
	.db_box ul li:after { content: ""; display: block; clear: both; }
	.db_box ul li { float:left; position: relative; width:100%; height: 40px; margin-bottom: 10px; }
	.db_box ul li:last-child { margin-bottom:0; }
	.db_box ul li.name { display: inline-block; width: 234px; }
	.db_box ul li.name input { float: left; }
	.db_box ul li.sex { float: right; position: relative; width: 72px; height: 40px; padding: 0; }
	.db_box ul li.sex input { width: 1px; height: 1px; overflow: hidden; position: absolute; left: -9999px; }
	.db_box ul li.sex input + label { position: absolute; top: 0; left:0; display: block; width: 34px; height: 40px; cursor: pointer; color:#000; font-size:22px; line-height:41px; background:#d3d3d3; text-align:center; }
	.db_box ul li.sex label:last-child { right:0; left:auto; }
	.db_box ul li.sex input:checked + label { color:#fff; background:#d31145; }
	.db_box .btn_area { width:100%; margin-top:25px; }
	.db_box .btn_area a { float:left; }
	.db_box .btn_area a + a { float:right; }
	
	.contents .top { position:relative; height:174px; text-align:center; background:#d31145; }
	.contents .top img { position:relative; top:35px; }
	.contents .top:after { content:""; display:block; position:absolute; bottom:-20px; left:50%; margin-left:-19px; width:0; height:0; border-top:20px solid #d31145; border-bottom:20px solid none; border-right:19px solid transparent; border-left:19px solid transparent; }
	
	.s01 .db_box { position: absolute; right:56px; top:22px; width: 360px; height: 384px; padding:22px 20px; border:2px solid #f76578; border-radius: 15px; background:#f3f3f3; }
	.s01 .inner { height:500px; }
	.s01 .inner > * { position:absolute; }
	.s01 .img { left:34px; bottom:0; z-index:2; }
	.s01 .img01 { left:245px; top:63px; transition-delay: 0.2s; }
	.s01 .img02 { left:260px; top:163px; transition-delay: 0.4s; }
	.s01 .img03 { left:220px; top:310px; transition-delay: 0.6s; }
	.s01 .guide { left:665px; bottom:10px; }
	
	.s02 .inner { padding:80px 0 90px; }
	.s02 .img02 { margin-top:52px; margin-left:52px; transition-delay: 0.4s; }

	.s03 .inner { padding:80px 0 90px; }
	.s03 .img02 { margin-top:52px; transition-delay: 0.4s; }

	.s04 .inner { padding:80px 0 90px; }
	.s04 .img02 { margin-top:52px; transition-delay: 0.4s; }

	.s05 .inner { padding:80px 0 90px; }
	.s05 .top img { top:65px; }	
	.s05 .img02 { margin-top:14px; transition-delay: 0.4s; }
	.s05 .guide { margin-top:12px; }

	.s06 .top img { top:65px; }	
	.s06 .inner { padding:80px 0; }
	.s06 .img01 { position:relative; }
	.s06 .img01 .obj01 { position:absolute; top:289px; left:364px; width:90px; transform:rotate(-12deg); }
	.s06 .img01 .obj01 img { width:100%; }
	.s06 .img01 .obj02 { position:absolute; top:357px; left:399px; width:45px;  }
	.s06 .img01 .obj02 img { width:100%; }
	.s06 .img02 { margin-top:85px; transition-delay: 0.8s; }
	.s06.mt .img01 .obj01 { top:232px; left:589px; transition:all 1.6s 0.5s ease-out;  }
	.s06.mt .img01 .obj02 { top:426px; left:612px; transition:all 1.6s 0.6s ease-out;  }
	
	.s07 .top { background:#231847; }
	.s07 .top:after { border-top-color:#231847; }
	.s07 .inner { padding:50px 0 75px; }
	.s07 .img02 { margin-top:19px; transition-delay: 0.4s; }
	.s07 .guide { margin-top:24px; }

	.s08 .inner { padding:55px 0; }
	.s08 .db_box { width:874px; margin: 0 auto; }
	.s08 .db_box ul { margin-top:0; }

	.s08 .db_box ul li { float:left; width:auto; padding:0; margin:0; margin-left:20px; }
	.s08 .db_box ul li:first-child { margin-left:0; }
	.s08 .db_box ul li input { width:250px; padding:0 16px; background:#ececec; }
	.s08 .db_box ul li.sex { width:72px; margin-left:10px; }
	.s08 .db_box .btn_area { width:100%; margin-top:35px; text-align:center; }
	.s08 .db_box .btn_area a { float:none; margin:0 5px; }

	.guide_area .subTitle { height:60px; background-color: #dcd7d3; }
	.guide_area .subTitle .wrap { height: 100%; }
	.guide_area .subTitle .wrap button { display: block; width: 1040px; height: 100%; margin: 0 auto; text-align: center; }
	.guide_area .subTitle .wrap button img { vertical-align: middle; }
	.guide_area .img { display: none; width: 1040px; margin: 20px auto 0; padding-bottom: 100px; text-align: center; }
	.guide_area .img.on { display: block; }

	.footer { background:#fcfcfc; }
	.footer a { display:block; position:absolute; left:119px; top:500px; width:120px; height:40px; text-indent:-9999px;  }

	.popup { display: none; }
	.popup .mask { position: fixed; left: 0; top: 0; right: 0; bottom: 0; background: #000; opacity: 0.7; filter: alpha(opacity=70); z-index: 100; }
	.popup .popup_content { position: fixed; left: 50%; top: 50%; background: #fff; z-index: 101; }
	.popup.agree button { outline: none; }
	.popup.agree .popup_content { width:800px; height:900px; padding:30px; margin-left:-400px; margin-top:-450px; background:#fff; border:4px solid #d31145; border-radius: 56px; }
	.popup.agree .wrap { padding:0; }
	.popup.agree .wrap .agree { margin-top: 25px; }
	.popup.agree .wrap .agree > div { position: relative;  margin-top: 5px;  }
	.popup.agree .wrap .agree input { position: absolute; left: -9999px; width: 1px; height: 1px; overflow: hidden; }
	.popup.agree .wrap .agree label { display:block; height:42px; padding-left: 36px; background: url("<%=imgFilePath%>w20210311_popup_radio_off.png") no-repeat left 0 top 7px / 24px auto; }
	.popup.agree .wrap .agree label img { position:relative; top:9px; height:20px; }
	.popup.agree .wrap .agree input:checked + label { background-image: url("<%=imgFilePath%>c20211029_popup_radio_on.png"); }
	.popup.agree .wrap .agree .toggle { height:382px; margin:6px 0 10px; background:#f6f6f6; overflow:auto; }
	.popup.agree .wrap .agree .toggle img { width:100%; }
	.popup.agree .wrap .all_check { margin-top:15px; }
	.popup.agree .wrap .all_check,
	.popup.agree .wrap .all_check img { width:100%; }
	.popup.agree .btn_close { display:block; position:absolute; top:25px; right:30px; width:25px; height:25px;  }
	.popup.agree .btn_close img { width:100%; }

	.popup.type02 .popup_content { border-top: 25px solid #dc3e69; text-align: center; }
	.popup.type02 .popup_content h2 { margin-top: 50px; padding-top: 70px; background: url("<%=imgFilePath%>w20210311_popup_icon01.png") no-repeat center 0; }
	.popup.type02 .popup_content p.text { margin-top: 22px; font-size: 20px; line-height: 26px; padding: 0 5px; }
	.popup.type02 .popup_content p.text span { color: #dc3e69; }
	.popup.type02 .popup_content p.guide { margin-top: 28px; font-size: 18px; color:#7f7f7f; }
	.popup.comp .popup_content { width: 512px; height: 406px; margin-top: -203px; margin-left: -256px; }
	.popup.comp .popup_content h2 { font-size: 42px; }
	.popup.comp .popup_content h2 span { color:#dc3e69; }
	.popup.comp .btn_close { position: absolute; top: 12px; right: 12px; }
	.popup.calc .popup_content { width: 512px; height: 406px; margin-top: -203px; margin-left: -256px; }
	.popup.calc .popup_content h2 { font-size: 20px; }
	.popup.calc .popup_content .calc_area { margin-top: 12px; font-size: 43px; }
	.popup.calc .popup_content .calc_area span { color: #dc3e69; }
	.popup.calc .popup_content .calc_area strong { margin: 0 38px; font-size: 42px; color: #dc3e69; }
	.popup.calc .btn_close { position: absolute; top: 12px; right: 12px; }
}

@media screen and (max-width : 1079px) {
	img { width: 100%; border: none; vertical-align: top; }
	.only_pc { display: none; }
	.only_mo { display: block; }
	.inner { position: relative; width: 100%; }

	#AIA_wrap.show { padding-bottom:20vw; }
	.motion > * { position:absolute; }
	
	.header a { display: block; position: absolute;  top:0; height: 100%; text-indent: -9999px; }
	.header a.btn_home { left:0; width:39%; }
	.header a.btn_tele { right:0; width:47%; }

	.db_box input[type="text"] { width: 100%; height: 10.2222vw; padding: 0 3.8888vw; line-height: 10.2222vw; font-size: 5.1111vw;  border-radius: 2px; background:#fff;  }
	.db_box ul { margin-top:5.5555vw; padding:0 6.6666vw; }
	.db_box ul:after { content:""; display:block; clear:both; }
	.db_box ul li:after { content: ""; display: block; clear: both; }
	.db_box ul li { float:left; position: relative; width:100%; height: 10.2222vw; margin-bottom: 2.4444vw; }
	.db_box ul li:last-child { margin-bottom:0; }
	.db_box ul li.name { display: inline-block; width: 65.4444vw; }
	.db_box ul li.name input { float: left; }
	.db_box ul li.sex { float: right; position: relative; width: 18.6666vw; height: 10.2222vw; padding: 0; }
	.db_box ul li.sex input { width: 1px; height: 1px; overflow: hidden; position: absolute; left: -9999px; }
	.db_box ul li.sex input + label { position: absolute; top: 0; left:0; display: block; width: 8.8888vw; height: 10.2222vw; cursor: pointer; color:#000; font-size:5.6666vw; line-height:10.2222vw; background:#d3d3d3; text-align:center; }
	.db_box ul li.sex label:last-child { right:0; left:auto; }
	.db_box ul li.sex input:checked + label { color:#fff; background:#d31145; }
	.db_box .btn_area { width:100%; margin-top:4.4444vw; padding:0 2vw; }
	.db_box .btn_area:after { content:""; display:block; clear:both; }
	.db_box .btn_area a { float:left; width:47.6666vw; }
	.db_box .btn_area a + a { float:right; }
	
	.contents .top { position:relative; height:28.8888vw; text-align:center; background:#d31145; }
	.contents .top img { position:relative; top:11.1111vw; width:auto; height:6.8888vw; }
	.contents .top:after { content:""; display:block; position:absolute; bottom:-2.4vw; left:50%; margin-left:-2.4444px; width:0; height:0; border-top:2.6666vw solid #d31145; border-bottom:2.6666vw solid none; border-right:2.4444vw solid transparent; border-left:2.4444vw solid transparent; }

	.s01 .inner { padding-bottom:88.7777vw; margin-bottom:11.1111vw; }
	.s01 .db_box { position: absolute; left:0; bottom:0; padding:6.6666vw 0; border-top:1px solid #d31145; background:#f3f3f3; }
	.s01 .db_box h3 { width:66.2222vw; margin:0 auto; }
	
	.s01 .db_box:after { content:""; display:block; position:absolute; bottom:-6.5vw; left:0; width:100%; height:7.1111vw; background:url("<%=imgFilePath%>m20211029_aia_db_bg01.png") no-repeat center center / 100% auto; }
	.s01 .img01 { width:80.3333vw; margin:4.4444vw auto 0; transition-delay: 0.2s; }
	.s01 .img02 { width:81.6666vw; margin:3.3333vw auto 0; transition-delay: 0.4s; }
	.s01 .img03 { width:100%; margin:1.7777vw auto 0; transition-delay: 0.6s; }
	.s01 .guide { width:93.2222vw; margin:2vw auto 0; }
	
	.s02 .inner { padding:5vw 0; padding-left:7.3333vw; }
	.s02 .img01 { width:85.1111vw; }
	.s02 .img02 { width:65.7777vw; margin:10vw auto 0; transition-delay: 0.4s; }

	.s03 .inner { padding:5vw 0; padding-left:7.3333vw; }
	.s03 .img01 { width:87.7777vw; }
	.s03 .img02 { width:74.6666vw; margin:10vw auto 0; transition-delay: 0.4s; }

	.s04 .inner { padding:5vw 0; padding-left:7.3333vw; }
	.s04 .img01 { width:84.1111vw; }
	.s04 .img02 { width:75.8888vw; margin:10vw auto 0; transition-delay: 0.4s; }

	.s05 { margin-top:8.8888vw; }
	.s05 .inner { padding:10.6666vw 0 8.2222vw; }
	.s05 .img01 { width:90.4444vw; margin:0 auto; }
	.s05 .img02 { width:66.2222vw; margin:2.2222vw auto 0; transition-delay: 0.4s; }
	.s05 .guide { width:85.5555vw; margin:9.5555vw auto 0; }

	.s06 .inner { padding:17.7777vw 0 10vw; }
	.s06 .img01 { position:relative; width:88.1111vw; margin:0 auto; }
	.s06 .img01 .obj01 { position:absolute; top:53vw; left:13vw; width:21vw; transform:rotate(-12deg); }
	.s06 .img01 .obj02 { position:absolute; top:69vw; left:16vw; width:7.5555vw;  }
	.s06 .img02 { width:95.2222vw; margin:17.3333vw auto 0; transition-delay: 1.2s; }
	.s06.mt .img01 .obj01 { top:45vw; left:46vw; transition:all 1.6s 0.5s ease-out;  }
	.s06.mt .img01 .obj02 { top:82vw; left:54vw; transition:all 1.6s 0.6s ease-out;  }
	
	.s07 .top { height:40.4444vw; background:#231847; }
	.s07 .top img { top:8vw; width:88.2222vw; height:auto; }
	.s07 .top:after { border-top-color:#231847; }
	.s07 .inner { padding:8.4444vw 0 14.4444vw; }
	.s07 .img01,
	.s07 .img02,
	.s07 .img03,
	.s07 .img04 { width:83.3333vw; margin:2.6666vw auto 0;  }
	.s07 .img02 { transition-delay: 0.4s; }
	.s07 .img03 { transition-delay: 0.8s; }
	.s07 .img04 { transition-delay: 1.2s; }
	.s07 .guide { width:93vw; margin:3vw auto 0; }

	.s08 .db_box { padding:6.6666vw 0 9vw; border-top:1px solid #d31145; border-bottom:1px solid #d31145; background:#f3f3f3; }
	.s08 .db_box h3 { width:66.2222vw; margin:0 auto; }
	
	.guide_area .subTitle { height: 9.7777vw; background-color: #dcd7d3; }
	.guide_area .subTitle .wrap { height: 100%; }
	.guide_area .subTitle .wrap button { display: block; width: 100%; height: 100%; margin: 0 auto; text-align: center; }
	.guide_area .subTitle .wrap button img { width:48.2222vw; vertical-align: middle; }
	.guide_area .img { display: none; width: 100%; margin: 3vw auto 0; padding-bottom: 10vw; text-align: center; }
	.guide_area .img.on { display: block; }

	.footer a { display:block; position:absolute; left:10vw; top:82vw; width:27vw; height:10vw; text-indent:-9999px;  }

	.floating { position:fixed; left:0; bottom:-22vw; width:100%; background:#fff; z-index:-1; transition:opacity 0.3s; opacity:0; }
	.show .floating { opacity:1; bottom:0; z-index:20; }
	.floating .layer { position:absolute; left:0; bottom:-55vw; height:67vw; transition:bottom 0.5s; background:#f3f3f3; border-top:1px solid #d31145; }
	.floating.on .layer { bottom: 7vw; }
	.floating .inner { padding:2.2222vw 3vw; background:#f3f3f3; border-top:1px solid #d31145; }
	.floating.on .inner { border-top:none; }
	.floating .inner ul li { float:left; width:50%; }
	.floating .inner ul:after { content:""; display:block; clear:both; }
	.floating .db_box { position:static; padding:2vw 4vw 6vw; }
	.floating .db_box input[type="text"] { background:#fff; border-radius: 2px; }
	.floating .db_box ul { margin-top:0; padding:0; }
	.floating .db_box ul li { width:auto; padding:0; }
	.floating .db_box ul li.sex { width:45.3333vw; margin-right:0; }
	.floating .db_box ul li.phone { float:right; }
	.floating .db_box ul li input { width:45.5555vw; padding:0 10px; font-size:4.2vw; }
	.floating .db_box ul li.sex input + label { width:21.85vw; height:10.2222vw; border-radius:2px; font-size:5.7777vw; color:#010101; background:#fff; border:1px solid #b6b6b6; border-top-color:#e1e1e1; }
	.floating .db_box ul li.sex input:checked + label { background:#d31145; color:#fff; }
	
	.floating .db_box .btn_area { width:100%; margin-left:0; margin-top:4vw; padding:0;}
	.floating .db_box .btn_area:after { content:""; display:block; clear:both; }
	.floating .db_box .btn_area a { display:inline-block; width:42%; }
	.floating .db_box .btn_area .result { float:right; width:58%; }
	.floating .db_box .btn_area.calc .result { display:block; }
	.floating .db_box .btn_area.calc .result { position:relative; }
	.floating .db_box .btn_area.calc .result input { position:absolute; height:5.3333vw; padding:0; font-size:3.7777vw; line-height:5.5vw; text-align:center; border:1px solid #d5d5d5; border-radius: 1px; font-family: "NanumSquareBold"; }
	.floating .db_box .btn_area.calc .result .user_name { left:2.6666vw; top:1.7vw; width:16.2222vw; color:#000; }
	.floating .db_box .btn_area.calc .result .user_premium { left:12.7vw; top:8.4vw; width:19.3333vw; color:#ff386f; }
	.floating .db_box .btn_area.consult { display:none; }
	.floating .btn .btn_toggle { position:absolute; top:-5.3vw; left:50%; margin-left:-6vw; width:12vw; height:5.3333vw; text-indent:-9999px; background:url("<%=imgFilePath%>m20211029_aia_float_close.png") no-repeat 0 0 / 100% auto; }
	.floating.on .btn .btn_toggle { background-image:url("<%=imgFilePath%>m20211029_aia_float_close.png"); }

	.popup { display: none; }
	.popup .mask { position: fixed; left: 0; top: 0; right: 0; bottom: 0; background: #000; opacity: 0.7; filter: alpha(opacity=70); z-index: 100; }
	.popup .popup_content { position: fixed; left: 50%; top: 50%; background: #fff; z-index: 101; }
	.popup.agree button { outline: none; }
	.popup.agree .popup_content { width: 93%; left: 3.5%; top: 2%; margin:0; padding:5vw; border-radius: 8vw; background:#fff; border:2px solid #d31145; }
	.popup.agree .popup_content .img {width:74%;}
	.popup.agree .popup_content .img img {width:100%;}
	.popup.agree .wrap { padding:0; }
	.popup.agree .wrap .agree { margin-top: 3.6666vw; }
	.popup.agree .wrap .agree > div { position: relative;  margin-top: 5px;  }
	.popup.agree .wrap .agree input { position: absolute; left: -9999px; width: 1px; height: 1px; overflow: hidden; }
	.popup.agree .wrap .agree label { display:block; height:6.6666vw; padding-left: 5.1111vw; background: url("<%=imgFilePath%>w20210311_popup_radio_off.png") no-repeat left 0 top 1.5vw / 3.8888vw auto; }
	.popup.agree .wrap .agree label img { position:relative; top:2vw; width:auto; height:3.3333vw; }
	.popup.agree .wrap .agree input:checked + label { background-image: url("<%=imgFilePath%>c20211029_popup_radio_on.png"); }
	.popup.agree .wrap .agree .toggle { height:50vw; margin:1.1111vw 0 2.2222vw; border:1px solid #dfdfdf; overflow:auto; }
	.popup.agree .wrap .agree .toggle img { width:100%; }
	.popup.agree .wrap .all_check { margin-top:3vw; }
	.popup.agree .wrap .all_check,
	.popup.agree .wrap .all_check img { width:100%; }
	.popup.agree .wrap .btn_area .btn_result { display:none; }
	.popup.agree .wrap .btn_area { margin-top:3.3333vw; padding-bottom:4.4444vw; }
	.popup.agree .wrap .btn_area:after { content:""; display:block; clear:both; }
	.popup.agree .wrap .btn_area a { display:block; float:right; width:42.2222vw; }
	.popup.agree .btn_close { display:block; position:absolute; top:3.3333vw; right:3.3333vw; width:5vw; height:5vw;  }
	.popup.agree .btn_close img { width:100%; }

	.popup.type02 .popup_content { width:94%; left: 3%; top: 50%;}
	.popup.type02 .popup_content { border-top: 5vw solid #dc3e69; text-align: center; padding-bottom:8vw; }
	.popup.type02 .popup_content h2 { margin-top: 10vw; padding-top: 14vw; background: url("<%=imgFilePath%>m20210311_popup_icon01.png") no-repeat center 0 / 11vw auto; }
	.popup.type02 .popup_content p.text { margin-top: 6vw; font-size: 4vw; line-height: 5.2vw; padding: 0 1vw; }
	.popup.type02 .popup_content p.text span { color: #dc3e69; }
	.popup.type02 .popup_content p.guide { margin-top: 3.2vw; font-size: 3.6vw; color:#7f7f7f; }
	.popup.comp .popup_content { margin-top:-40vw; }
	.popup.comp .popup_content h2 { font-size: 8.4vw; line-height:10vw; }
	.popup.comp .popup_content h2 span { color:#dc3e69; }
	.popup.comp .btn_close { position: absolute; top:8px; right: 8px; }
	.popup.calc .popup_content { margin-top:-40vw; }
	.popup.calc .popup_content h2 { font-size: 4vw; }
	.popup.calc .popup_content .calc_area { margin-top: 2.4vw; font-size: 8.6vw; }
	.popup.calc .popup_content .calc_area span { color: #dc3e69; }
	.popup.calc .popup_content .calc_area strong { margin: 0 7.6vw; font-size: 8.4vw; color: #dc3e69; }
	.popup.calc .btn_close { position: absolute; top:8px; right: 8px; }
}
</style>
<%@ include file="/event/landingManage.jsp"%>
<%@ include file="/common/front/tracking/webLog_common_head.jsp"%>
<script type="text/javascript" src="../common/js/common_02.js"></script>
</head>
<body>
	<div id="AIA_wrap">
		<div class="header">
			<div class="inner">
				<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_header.gif" data-mo-src="<%=imgFilePath%>m20211029_aia_header.gif" alt="AIA Vitalaty 지금 바로 전문가와상담하려면 1600-0880">
				<a href="#" class="btn_home" >AIA Vitalaty</a>
				<a href="tel:1600-0880" class="btn_tele only_mo" >전화 : 1600-0880</a>
			</div>
		</div> 
		<div class="contents">
			<div class="s01">
				<div class="inner">
					<div class="img only_pc"><img src="<%=imgFilePath%>w20211029_aia_s01_img01.png" class="only_pc" alt="모뎅"></div>
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s01_txt01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s01_txt01.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s01_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s01_txt02.png" alt=""></div>
					<div class="img03 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s01_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s01_txt03.png" alt=""></div>
					<div class="db_box">
						<h3><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_db_tit01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_db_tit01.png" alt=""></h3>
						<form method="post" action="" name="frm">
							<ul>
								<li class="name">
									<input type="text" id="rn_cust_name" name="rn_cust_name" placeholder="이름" >
								</li>		
								<li class="sex">
									<input type="radio" id="rn_sex1" name="rn_sex" value="M" checked="checked">
									<label for="rn_sex1">남</label>
									<input type="radio" id="rn_sex2" name="rn_sex" value="F">
									<label for="rn_sex2">여</label>
								</li>
								<li class="birth">
									<input type="text" id="rn_jumin1" name="rn_jumin1" maxlength="6" placeholder="생년월일 ( 예 730804 )">
								</li>
								<li class="phone">
									<input type="text" id="cr_mphone" name="cr_mphone" maxlength="11" placeholder="연락처 ( 예 01012345678 )">
								</li>
							</ul>
							<input type="hidden" name="reqProd" value=" " />
							<input type="hidden" name="cust_join_path" value="" />
							<input type="hidden" name="cr_memo" value="<%=request.getRequestURL()%>" />
							<input type="hidden" name="onyxtranyn" value="Y" />
							<input type="hidden" name="cust_uyn" value="" />
							<input type="hidden" name="cust_eyn" value="" />
							<input type="hidden" name="insuAge" id="insuAge" />
							<input type="hidden" name="brthDt" value="" />
							<%@ include file="/mobile/mobile_common.jsp" %>
						</form>	
						<div class="btn_area">
							<a href="#" data-role="open_popup" data-send="popup_event|1" >
								<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_db_btn01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_db_btn01.png" alt="내 보험료 계산">
							</a>
							<a href="#" data-role="open_popup" data-send="popup_event|2" >
								<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_db_btn02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_db_btn02.png" alt="무료 상담 신청">
							</a>
						</div>
					</div>
					<div class="guide"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s01_txt04.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s01_txt04.png" alt=""></div>
				</div>
			</div>

			<div class="s02">
				<div class="top only_pc"><img src="<%=imgFilePath%>w20211029_aia_s02_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s02_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s02_txt01.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s02_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s02_txt02.png" alt=""></div>
				</div>
			</div>

			<div class="s03">
				<div class="top only_pc"><img src="<%=imgFilePath%>w20211029_aia_s03_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s03_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s03_txt01.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s03_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s03_txt02.png" alt=""></div>
				</div>
			</div>

			<div class="s04">
				<div class="top only_pc"><img src="<%=imgFilePath%>w20211029_aia_s04_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s04_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s04_txt01.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s04_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s04_txt02.png" alt=""></div>
				</div>
			</div>

			<div class="s05">
				<div class="top"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s05_txt01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s05_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s05_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s05_txt02.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s05_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s05_txt03.png" alt=""></div>
					<div class="guide"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s05_txt04.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s05_txt04.png" alt=""></div>
				</div>
			</div>

			<div class="s06">
				<div class="top"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s06_txt01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s06_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur">
						<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s06_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s06_txt02.png" alt="">
						<div class="motion">
							<div class="obj01"><img src="<%=imgFilePath%>w20211029_aia_s06_obj01.gif" alt=""></div>
							<div class="obj02"><img src="<%=imgFilePath%>w20211029_aia_s06_obj02.gif" alt=""></div>
						</div>
					</div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s06_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s06_txt03.png" alt=""></div>
				</div>
			</div>

			<div class="s07">
				<div class="top"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s07_txt01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s07_txt01.png" alt=""></div>
				<div class="inner">
					<div class="img01 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s07_txt02.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s07_txt02.png" alt=""></div>
					<div class="img02 fade_up_blur"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s07_txt03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s07_txt03.png" alt=""></div>
					<div class="img03 fade_up_blur only_mo"><img src="<%=imgFilePath%>m20211029_aia_s07_txt04.png" alt=""></div>
					<div class="img04 fade_up_blur only_mo"><img src="<%=imgFilePath%>m20211029_aia_s07_txt05.png" alt=""></div>
					<div class="guide"><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_s07_txt04.png" data-mo-src="<%=imgFilePath%>m20211029_aia_s07_txt06.png" alt=""></div>
				</div>
			</div>

			<div class="s08">
				<div class="top only_pc"><img src="<%=imgFilePath%>w20211029_aia_s08_txt01.png" alt=""></div>
				<div class="inner">
					<div class="db_box">
						<h3 class="only_mo"><img src="<%=imgFilePath%>m20211029_aia_db_tit01.png" alt=""></h3>
						<form method="post" action="" name="frm">
							<ul>
								<li class="name">
									<input type="text" id="rn_cust_name2" name="rn_cust_name" placeholder="이름" >
								</li>		
								<li class="sex">
									<input type="radio" id="rn_sex3" name="rn_sex2" value="M" checked="checked">
									<label for="rn_sex3">남</label>
									<input type="radio" id="rn_sex4" name="rn_sex2" value="F">
									<label for="rn_sex4">여</label>
								</li>
								<li class="birth">
									<input type="text" id="rn_jumin2" name="rn_jumin1" maxlength="6" placeholder="생년월일 ( 예 730804 )">
								</li>
								<li class="phone">
									<input type="text" id="cr_mphone2" name="cr_mphone" maxlength="11" placeholder="연락처 ( 예 01012345678 )">
								</li>
							</ul>
							<input type="hidden" name="reqProd" value=" " />
							<input type="hidden" name="cust_join_path" value="" />
							<input type="hidden" name="cr_memo" value="<%=request.getRequestURL()%>" />
							<input type="hidden" name="onyxtranyn" value="Y" />
							<input type="hidden" name="cust_uyn" value="" />
							<input type="hidden" name="cust_eyn" value="" />
							<input type="hidden" name="insuAge" id="insuAge" />
							<input type="hidden" name="brthDt" value="" />
							<%@ include file="/mobile/mobile_common.jsp" %>
						</form>	
						<div class="btn_area">
							<a href="#" data-role="open_popup" data-send="popup_event|1" >
								<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_db_btn03.png" data-mo-src="<%=imgFilePath%>m20211029_aia_db_btn01.png" alt="내 보험료 계산">
							</a>
							<a href="#" data-role="open_popup" data-send="popup_event|2" >
								<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_db_btn04.png" data-mo-src="<%=imgFilePath%>m20211029_aia_db_btn02.png" alt="무료 상담 신청">
							</a>
						</div>
					</div>
				</div>
			</div>

            <!-- guide_area -->
            <div class="guide_area">
				<div class="subTitle">
					<div class="wrap">
						<button><img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_guide_txt01.png" data-mo-src="<%=imgFilePath%>m20211029_aia_guide_txt01.png" alt="가입시 알아두어야 할 사항"></button>
					</div>
				</div>
				<div class="img">
					<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w_guaranteedissue_ddtt.jpg" data-mo-src="<%=imgFilePath%>m_guaranteedissue_ddtt.jpg" alt="가입시 유의사항 이미지">
					<div class="btn">
						<a href="https://www.aia.co.kr/ko/disclosure/our-products/insurance-product-list.html" target="_blank" >
							<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_aia_guide_btn01.gif" data-mo-src="<%=imgFilePath%>m20210311_aia_guide_btn01.gif" alt="보호금융상품등록부">
						</a>
					</div>
				</div>
            </div>
			<!-- end : guide_area -->
		</div>

		<div class="footer">
			<div class="inner">
				<img src="<%=imgFilePath%>c20211029_blank.gif" data-pc-src="<%=imgFilePath%>w20211029_aia_footer.gif" data-mo-src="<%=imgFilePath%>m20211029_aia_footer.gif" alt="하단문구참조">
				<a href="#">AIA.COM</a>
				<div class="hide">
					<h2>AIA</h2>
					<p>AIA생명보험 주식회사 사업자정보</p>
					<p>대표이사 : 피터정</p>
					<address>주소 : 서울시 중구 통일로 2길 16 AIA타워</address>
					<p>사업자등록번호 : 711-87-00663</p>
					<p>통신판매신고번호 : 2020-서울중구-1209호</p>
					<p>AIA생명 고객센터 1588-9898</p>
					<p>청양 관련 문의 1600-0880</p>
					<p>바이탈리티 관련문의 1566-8777</p>
				</div>
			</div>
		</div>

		<!-- 플로팅바 -->
		<div class="floating only_mo" >
			<div class="layer">
				<div class="db_box">
					<form method="post" action="" name="frm3">
						<ul>
							<li class="name">
								<input type="text" name="rn_cust_name" placeholder="이름" >
							</li>
							<li class="sex">
								<input type="radio" id="rn_sex5" name="rn_sex3" value="M" checked="checked">
								<label for="rn_sex5">남</label>
								<input type="radio" id="rn_sex6" name="rn_sex3" value="F">
								<label for="rn_sex6">여</label>
							</li>
							<li class="birth">
								<input type="text" name="rn_jumin1" maxlength="6" placeholder="생년월일 (예 730804)" onKeyUp="onlyNumber(this);" onKeyPress="checkInt()">
							</li>
							<li class="phone">
								<input type="text" name="cr_mphone" maxlength="11" placeholder="휴대폰번호(’-’없이 입력)" onKeyUp="onlyNumberWithBar(this);numToTel(this);" onKeyPress="checkInt()" >
							</li>
						</ul>
						<input type="hidden" name="reqProd" value=" " />
						<input type="hidden" name="cust_join_path" value="" />
						<input type="hidden" name="cr_memo" value="<%=request.getRequestURL()%>" />
						<input type="hidden" name="onyxtranyn" value="Y" />
						<input type="hidden" name="cust_uyn" value="" />
						<input type="hidden" name="cust_eyn" value="" />
						<input type="hidden" name="insuAge" id="insuAge" />
						<input type="hidden" name="brthDt" value="" />
						<%@ include file="/mobile/mobile_common.jsp" %>
					</form>

					<div class="btn_area calc">
						<!-- 플로팅바 "보험료 결과보기" 버튼 -->
						<a href="#" data-role="open_popup" data-send="popup_event|1" ><img src="<%=imgFilePath%>m20210311_aia_float_btn03.png" alt="보험료 결과보기"></a>
						<div class="result">
							<img src="<%=imgFilePath%>m20211029_aia_float_text01.png" alt="">
							<input type="text" class="user_name" readonly >
							<input type="text" class ="user_premium" name="calcVal3" readonly value="???"></input>
						</div>
					</div>

					<div class="btn_area consult">
						<!-- 플로팅바 "상담 신청하기" 버튼 -->
						<a href="#" data-role="open_popup" data-send="popup_event|2" ><img src="<%=imgFilePath%>m20210311_aia_float_btn04.png" alt="상담 신청하기"></a>
						<div class="result">
							<img src="<%=imgFilePath%>m20211029_aia_float_text02.png" alt="">
						</div>
					</div>
				</div>	
				
				<div class="btn">
					<button class="btn_toggle">열기/닫기</button>
				</div>
			</div>
			
			<div class="inner">
				<ul>
					<li><a href="#" class="btn01"><img src="<%=imgFilePath%>m20211029_aia_db_btn01.png" alt="내 보험료 계산"></a></li>
					<li><a href="#" class="btn02"><img src="<%=imgFilePath%>m20211029_aia_db_btn02.png" alt="무료 상담 신청"></a></li>
				</ul>
			</div>
		</div>
		<!-- // 플로팅바 -->


		<!-- popup : 개인정보 동의 팝업 -->
		<div class="popup agree" data-receive="popup_event">
			<div class="mask"></div>
			<div class="popup_content">
				<div class="img">
					<img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_title01.png" data-mo-src="<%=imgFilePath%>m20210311_popup_title01.png" alt="AIA가 고객님만을 위한 맞춤 보장을 설계 중입니다" >
				</div>
				<div class="wrap">
					<div class="agree_area">
						<div class="agree">
							<div>
								<input type="checkbox" class="checkbox" id="cust_uyn1" name="cust_uyn1">
								<label for="cust_uyn1"><img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_text01.png" data-mo-src="<%=imgFilePath%>m20210311_popup_text01.png" alt="개인정보 수집 및 이용 동의 (필수)"></label>
								<div class="toggle">
									<img src="<%=imgFilePath%>c20211029_popup_agree01.png" alt="개인정보 수집 및 이용 동의 약관" >
								</div>
							</div>
						</div>
						<button class="all_check" > <!-- 내보험료 계산 / 무료상담신청 클릭에 따라 calc() / comp() 온클릭 이벤트 생성함. -->
							<img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_btn01.png" data-mo-src="<%=imgFilePath%>m20210311_popup_btn01.png" alt="전체 동의하기" >
						</button>
					</div>
				</div>
				
				<button class="btn_close">
					<img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_btn_close.png" data-mo-src="<%=imgFilePath%>m20210311_popup_btn_close.png" alt="팝업 닫기" >
				</button>
			</div>
		</div>
		<!-- // popup : 개인정보 동의 팝업 -->

		<!-- popup : 상담신청 완료-->
		<div class="popup type02 comp" >
			<div class="mask"></div>
			<div class="popup_content">
				<h2 class="bold">보험상담 신청이<br><span>완료</span>되었습니다</h2>
				<p class="guide">멤버십 가입 시(월 5,500원) 바이탈리티 할인 혜택 및<br>보험료 할인 혜택을 받으실 수 있습니다 </p>
				<p class="text bold">빠른 시일 내에 <span>전문상담원</span>이 보장내역과 보험료를<br>친절하게 설명해드립니다. (평일기준)</p>
				<button class="btn_close"><img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_btn_close02.png" data-mo-src="<%=imgFilePath%>m20210311_popup_btn_close02.png" alt="팝업 닫기"></button>
			</div>
		</div>
		<!-- // popup : 상담신청 완료 -->

		<!-- popup : 보험료 계산 -->
		<div class="popup type02 calc">
			<div class="mask"></div>
			<div class="popup_content">
				<h2 class="bold"><span id="user_name">XXX</span> 고객님의 보험료는</h2>
				<div class="calc_area bold">월 <span>[<strong id="user_premium">00,000</strong>]</span>원</div>
				<p class="guide">멤버십 가입 시(월 5,500원) 바이탈리티 할인 혜택 및<br>보험료 할인 혜택을 받으실 수 있습니다 </p>
				<p class="text bold">빠른 시일 내에 <span>전문상담원</span>이 보장내역과 보험료를<br>친절하게 설명해드립니다. (평일기준)</p>
				<button class="btn_close"><img src="<%=imgFilePath%>c20210311_blank.gif" data-pc-src="<%=imgFilePath%>w20210311_popup_btn_close02.png" data-mo-src="<%=imgFilePath%>m20210311_popup_btn_close02.png" alt="팝업 닫기"></button>
			</div>
		</div>
		<!-- // popup : 보험료 계산 -->
	</div>

<div id="_layerTracking" style="display:none;position:absolute;">
	<%@ include file="/common/front/tracking/webLog_common_body.jsp"%>
	<iframe id="_trck" title="빈프레임" name="_trck" src="" width="0" height="0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" leftmargin="no" topmargin="no" ></iframe>
</div>	
</body>
</html>