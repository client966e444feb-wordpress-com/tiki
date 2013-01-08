/* x_img.js compiled from X 4.0 with XC 0.27b. Distributed by GNU LGPL. For copyrights, license, documentation and more visit Cross-Browser.com */
function xImgAsyncWait(fnStatus, fnInit, fnError, sErrorImg, sAbortImg, imgArray){var i, imgs = imgArray || document.images;for (i = 0; i < imgs.length; ++i) {imgs[i].onload = imgOnLoad;imgs[i].onerror = imgOnError;imgs[i].onabort = imgOnAbort;}xIAW.fnStatus = fnStatus;xIAW.fnInit = fnInit;xIAW.fnError = fnError;xIAW.imgArray = imgArray;xIAW();function imgOnLoad(){this.wasLoaded = true;}function imgOnError(){if (sErrorImg && !this.wasError) {this.src = sErrorImg;}this.wasError = true;}function imgOnAbort(){if (sAbortImg && !this.wasAborted) {this.src = sAbortImg;}this.wasAborted = true;}}function xIAW(){var me = arguments.callee;if (!me) {return; }var i, imgs = me.imgArray ? me.imgArray : document.images;var c = 0, e = 0, a = 0, n = imgs.length;for (i = 0; i < n; ++i) {if (imgs[i].wasError) {++e;}else if (imgs[i].wasAborted) {++a;}else if (imgs[i].complete || imgs[i].wasLoaded) {++c;}}if (me.fnStatus) {me.fnStatus(n, c, e, a);}if (c + e + a == n) {if ((e || a) && me.fnError) {me.fnError(n, c, e, a);}else if (me.fnInit) {me.fnInit();}}else setTimeout('xIAW()', 250);}function xImgRollSetup(p,s,x){var ele, id;for (var i=3; i<arguments.length; ++i) {id = arguments[i];if (ele = xGetElementById(id)) {ele.xIOU = p + id + x;ele.xIOO = new Image();ele.xIOO.src = p + id + s + x;ele.onmouseout = imgOnMouseout;ele.onmouseover = imgOnMouseover;}}function imgOnMouseout(e){if (this.xIOU) {this.src = this.xIOU;}}function imgOnMouseover(e){if (this.xIOO && this.xIOO.complete) {this.src = this.xIOO.src;}}}function xTriStateImage(idOut, urlOver, urlDown, fnUp) {var img;if (typeof Image != 'undefined' && document.getElementById) {img = document.getElementById(idOut);if (img) {var urlOut = img.src;var i = new Image();i.src = urlOver;i = new Image();i.src = urlDown;img.onmouseover = function(){this.src = urlOver;};img.onmouseout = function(){this.src = urlOut;};img.onmousedown = function(){this.src = urlDown;};img.onmouseup = function(){this.src = urlOver;if (fnUp) {fnUp();}};}}this.onunload = function(){if (xIE4Up && img) { img.onmouseover = img.onmouseout = img.onmousedown = null;img = null;}};    }