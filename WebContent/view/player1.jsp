<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../css/player.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<title>slinceOB-Player</title>
<style type="text/css">
</style>
</head>
<body>
	<!-- 播放器最外层边界 -->
	<div id="player">
		<!-- h5播放标签 controls-->
		<audio src="../voice/test.WAV" id="audio" ></audio>
		<!-- 波形显示 -->
		<div id="wave-form">
		</div>
		<!-- 控制 -->
		<div id="controller">
			<!-- 播放按钮 -->
			<button value="播放" id="btn_play">播放/暂停</button>
			<!-- 停止按钮 -->
			<button value="停止" id="btn_pause">停止</button>
			<span id="player-time"></span>/<span id="player-all"></span>
			<div id="progress">
				<span id="progress-span"></span>
			</div>
			<!-- 音量控制按钮 -->
			<input type="range" min="0" max="1" step="0.1" id="volume"
				width="100px" value="0.2" onchange="cheangeVol(this)">
			<!-- 静音按钮 -->
			<button id="btn_mute">静音</button>
			<!-- 播放进度条 -->

		</div>
		<!-- 文本展示 -->
		<div id="text"></div>
	</div>
	<script type="text/javascript">
		//获取h5播放器对象
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
			
			document.getElementById("player-time").innerHTML = 0+ "0";
			document.getElementById("player-all").innerHTML = formatSeconds(audio.duration);
		};
		

		/**
		 * 设置进度条进度
		 * @param per
		 * @returns
		 */
		function setProgress(per) {
			if (per) {
				$("#" + progress_node_id + " > span").css("width",
						String(per) + "%");
				document.getElementById("player-time").innerHTML  = formatSeconds(audio.currentTime);
				//$("#" + progress_node_id + " > span").html(per); 
			}
		}

		//为 <video> 元素添加 ontimeupdate 事件，如果当前播放位置改变则执行函数
		audio.ontimeupdate = function() {
			progressRun()
		};
		audio.volume = 0.2;
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
				setProgress(currentTime / duration * 100);
			}
		}

		/**
		 * 播放
		 */
		function doPlay() {
			if (audio.paused) {
				audio.play();
			} else if (audio.ended) {
				audio.play();
			} else if(audio.play) {
				audio.pause();
			}
		};
		/**
		 * 暂停
		 */
		function doPause() {
			if (audio.play) {
				audio.currentTime = 0;
			}
			;
		};
		/**
		 * 静音
		 */
		function doMute() {
			document.getElementById('volume').value = 0;
			audio.muted = true;
		};

		function cheangeVol(obj) {
			var vol = obj.value;

			if (vol == 0) {
				audio.muted = true;
			} else {
				audio.muted = false;
				audio.volume = document.getElementById("volume").value;
			}

		}

		/**
		 * 鼠标获取点击坐标,并控制进度条
		 * @param ev
		 * @returns
		 */
		function mouseDown(ev) {
			ev = ev || window.event;
			var scrollX = document.documentElement.scrollLeft
					|| document.body.scrollLeft;
			var mousePos = ev.pageX || ev.clientX + scrollX;
			var realX = $('#progress').position().left;

			var x = mousePos - realX;
			var width = document.getElementById("progress").offsetWidth;
			var per = x / width;
			setProgress(per * 100);
			var current = per * (audio.duration);
			if(!isNaN(current)) {
				audio.currentTime = current.toFixed(2);
			}
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
			if (theTime > 60) {
				theTime1 = parseInt(theTime / 60);
				theTime = parseInt(theTime % 60);
				if (theTime1 > 60) {
					theTime2 = parseInt(theTime1 / 60);
					theTime1 = parseInt(theTime1 % 60);
				}
			}
			var result = parseInt(theTime);
			if(result > 0 && result < 10) {
				result = "0" + result;
			}
			if (theTime1 > 0 && theTime1 < 10) {
				result = "0" + parseInt(theTime1) + ":" + result;
			}else if(theTime1 >= 10) {
				result =  parseInt(theTime1) + ":" + result;
			}
			if (theTime2 > 0 && theTime2 < 10) {
				result = "0" + parseInt(theTime2) + ":" + result;
			}else if(theTime2 >= 10){
				result = "" + parseInt(theTime2) + ":" + result;
			}
			return result;
		}
	</script>

</body>
</html>