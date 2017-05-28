// 获取h5播放器对象
var audio = document.getElementById("audio");
	// 获取进度条对象
var progress_node_id = "progress";
// 文本就绪事件
window.onload = function() {  
	
    var btn_play = document.getElementById("btn_play");  
    var btn_pause = document.getElementById("btn_pause");  
    var btn_mute = document.getElementById("btn_mute");  
    var btn_volume = document.getElementById('volume');
    var progress = document.getElementById("progress");
    // 绑定函数
    btn_play.addEventListener('click', doPlay, false);  
    btn_pause.addEventListener('click', doPause, false);  
    btn_mute.addEventListener('click', doMute, false);
    progress.addEventListener('click', mouseDown(this), false);
    btn_volume.value = audio.volume;  
    btn_volume.addEventListener('change',function(e) {  
        myVol= e.target.value;  
        audio.volume=myVol;  
        if (myVol==0) {  
        	audio.muted = true;  
        } else {  
        	audio.muted = false;  
        }  
        return false;  
    }, true);  
};

/**
 * 设置进度条进度
 * @param per
 * @returns
 */
function setProgress(per) { 
	if (per) { 
	  $("#" + progress_node_id + " > span").css("width", String(per) + "%" ); 
	  //$("#" + progress_node_id + " > span").html(per); 
	} 
}

//为 <video> 元素添加 ontimeupdate 事件，如果当前播放位置改变则执行函数
audio.ontimeupdate = function() {progressRun()};

/**
 * 播放器控制进度条前进
 * @returns
 */
function progressRun() {
    var duration = audio.duration;
    var currentTime = audio.currentTime;
    if (currentTime >= duration) { 
    	  alert("播放结束"); 
    	  return; 
    } 
	if (currentTime <= duration) {
	  setProgress(currentTime/duration*100); 
	} 
}

/**
 * 播放
 */
function doPlay() {  
    if (audio.paused) {  
    	audio.play();  
    } else if (audio.ended) {  
    	audio.currentTime=0;  
    	audio.play();  
    };  
};  
/**
 * 暂停
 */
function doPause() {  
    if (audio.play) {  
    	audio.pause();  
    };  
}; 
/**
 * 静音
 */
function doMute() {  
    document.getElementById('volume').value = 0;  
    audio.muted = true;  
}; 

function cheangeVolume(obj) {
	audio.volume = document.getElementById("volume").value;
}

/**
 * 鼠标获取点击坐标,并控制进度条
 * @param ev
 * @returns
 */
function mouseDown(ev) 
{ 
ev= ev || window.event; 
var mousePos = mouseCoords(ev); 
//alert(ev.pageX); 
document.getElementById("xxx").value = mousePos.x; 
document.getElementById("yyy").value = mousePos.y; 

var x = mousePos.x;
var width = document.getElementById("progress").offsetWidth;
var per = x/width;


setProgress(per*100);
audio.currentTime=per*(audio.duration);
} 

function mouseCoords(ev) 
{ 
if(ev.pageX || ev.pageY){ 
return {x:ev.pageX, y:ev.pageY}; 
} 
return { 
x:ev.clientX + document.body.scrollLeft - document.body.clientLeft, 
y:ev.clientY + document.body.scrollTop - document.body.clientTop 
}; 
}	
document.getElementById("progress").onmousedown = mouseDown;

/**
 * 将秒转换成时分秒
 * @param value
 * @returns
 */
function formatSeconds(value) {
    var theTime = parseInt(value);// 秒
    var theTime1 = 0;// 分
    var theTime2 = 0;// 小时
    if(theTime > 60) {
        theTime1 = parseInt(theTime/60);
        theTime = parseInt(theTime%60);
            if(theTime1 > 60) {
            theTime2 = parseInt(theTime1/60);
            theTime1 = parseInt(theTime1%60);
            }
    }
        var result = ""+parseInt(theTime)+"秒";
        if(theTime1 > 0) {
        result = ""+parseInt(theTime1)+"分"+result;
        }
        if(theTime2 > 0) {
        result = ""+parseInt(theTime2)+"小时"+result;
        }
    return result;
}