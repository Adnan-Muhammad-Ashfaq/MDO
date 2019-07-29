/*
YUI 3.10.3 (build 2fb5187)
Copyright 2013 Yahoo! Inc. All rights reserved.
Licensed under the BSD License.
http://yuilibrary.com/license/
*/

YUI.add("axis-numeric",function(e,t){Y_Lang=e.Lang,e.NumericAxis=e.Base.create("numericAxis",e.Axis,[e.NumericImpl],{_getLabelByIndex:function(e,t){var n=this.get("minimum"),r=this.get("maximum"),i=(r-n)/(t-1),s,o=this.get("roundingMethod");return t-=1,e===0?s=n:e===t?s=r:(s=e*i,o==="niceNumber"&&(s=this._roundToNearest(s,i)),s+=n),parseFloat(s)},_getPoints:function(t,n,r,i,s){var o=e.NumericAxis.superclass._getPoints.apply(this,arguments);return s==="vertical"&&o.reverse(),o},_getDataFromLabelValues:function(t,n,r,i,s){var o=[],u,a,f=n.length,l,c,h,p,d=this.get("maximum"),v=this.get("minimum"),m=[],g=(i-r*2)/(d-v);s==="vertical"?(l="x",c="y"):(l="y",c="x"),h=t[l];for(a=0;a<f;a+=1)u=n[a],e.Lang.isNumber(u)&&u>=v&&u<=d&&(p={},p[l]=h,p[c]=i-r-(u-v)*g,o.push(p),m.push(u));return{points:o,values:m}},_hasDataOverflow:function(){var e,t,n;return this.get("setMin")||this.get("setMax")?!0:(e=this.get("roundingMethod"),t=this._actualMinimum,n=this._actualMaximum,Y_Lang.isNumber(e)&&(Y_Lang.isNumber(n)&&n>this._dataMaximum||Y_Lang.isNumber(t)&&t<this._dataMinimum)?!0:!1)}})},"3.10.3",{requires:["axis","axis-numeric-base"]});
