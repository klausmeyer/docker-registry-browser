// popper.js@1.16.1 downloaded from https://ga.jspm.io/npm:popper.js@1.16.1/dist/umd/popper.js

var e="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var t={};
/**!
 * @fileOverview Kickass library to create and place poppers near their reference elements.
 * @version 1.16.1
 * @license
 * Copyright (c) 2016 Federico Zivolo and contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */(function(e,r){t=r()})(t,(function(){var t="undefined"!==typeof window&&"undefined"!==typeof document&&"undefined"!==typeof navigator;var r=function(){var e=["Edge","Trident","Firefox"];for(var r=0;r<e.length;r+=1)if(t&&navigator.userAgent.indexOf(e[r])>=0)return 1;return 0}();function microtaskDebounce(e){var t=false;return function(){if(!t){t=true;window.Promise.resolve().then((function(){t=false;e()}))}}}function taskDebounce(e){var t=false;return function(){if(!t){t=true;setTimeout((function(){t=false;e()}),r)}}}var n=t&&window.Promise;
/**
  * Create a debounced version of a method, that's asynchronously deferred
  * but called in the minimum time possible.
  *
  * @method
  * @memberof Popper.Utils
  * @argument {Function} fn
  * @returns {Function}
  */var o=n?microtaskDebounce:taskDebounce;
/**
   * Check if the given variable is a function
   * @method
   * @memberof Popper.Utils
   * @argument {Any} functionToCheck - variable to check
   * @returns {Boolean} answer to: is a function?
   */function isFunction(e){var t={};return e&&"[object Function]"===t.toString.call(e)}function getStyleComputedProperty(e,t){if(1!==e.nodeType)return[];var r=e.ownerDocument.defaultView;var n=r.getComputedStyle(e,null);return t?n[t]:n}
/**
   * Returns the parentNode or the host of the element
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @returns {Element} parent
   */function getParentNode(e){return"HTML"===e.nodeName?e:e.parentNode||e.host}
/**
   * Returns the scrolling parent of the given element
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @returns {Element} scroll parent
   */function getScrollParent(e){if(!e)return document.body;switch(e.nodeName){case"HTML":case"BODY":return e.ownerDocument.body;case"#document":return e.body}var t=getStyleComputedProperty(e),r=t.overflow,n=t.overflowX,o=t.overflowY;return/(auto|scroll|overlay)/.test(r+o+n)?e:getScrollParent(getParentNode(e))}
/**
   * Returns the reference node of the reference object, or the reference object itself.
   * @method
   * @memberof Popper.Utils
   * @param {Element|Object} reference - the reference element (the popper will be relative to this)
   * @returns {Element} parent
   */function getReferenceNode(e){return e&&e.referenceNode?e.referenceNode:e}var i=t&&!!(window.MSInputMethodContext&&document.documentMode);var a=t&&/MSIE 10/.test(navigator.userAgent);
/**
   * Determines if the browser is Internet Explorer
   * @method
   * @memberof Popper.Utils
   * @param {Number} version to check
   * @returns {Boolean} isIE
   */function isIE(e){return 11===e?i:10===e?a:i||a}
/**
   * Returns the offset parent of the given element
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @returns {Element} offset parent
   */function getOffsetParent(e){if(!e)return document.documentElement;var t=isIE(10)?document.body:null;var r=e.offsetParent||null;while(r===t&&e.nextElementSibling)r=(e=e.nextElementSibling).offsetParent;var n=r&&r.nodeName;return n&&"BODY"!==n&&"HTML"!==n?-1!==["TH","TD","TABLE"].indexOf(r.nodeName)&&"static"===getStyleComputedProperty(r,"position")?getOffsetParent(r):r:e?e.ownerDocument.documentElement:document.documentElement}function isOffsetContainer(e){var t=e.nodeName;return"BODY"!==t&&("HTML"===t||getOffsetParent(e.firstElementChild)===e)}
/**
   * Finds the root node (document, shadowDOM root) of the given element
   * @method
   * @memberof Popper.Utils
   * @argument {Element} node
   * @returns {Element} root node
   */function getRoot(e){return null!==e.parentNode?getRoot(e.parentNode):e}
/**
   * Finds the offset parent common to the two provided nodes
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element1
   * @argument {Element} element2
   * @returns {Element} common offset parent
   */function findCommonOffsetParent(e,t){if(!e||!e.nodeType||!t||!t.nodeType)return document.documentElement;var r=e.compareDocumentPosition(t)&Node.DOCUMENT_POSITION_FOLLOWING;var n=r?e:t;var o=r?t:e;var i=document.createRange();i.setStart(n,0);i.setEnd(o,0);var a=i.commonAncestorContainer;if(e!==a&&t!==a||n.contains(o))return isOffsetContainer(a)?a:getOffsetParent(a);var s=getRoot(e);return s.host?findCommonOffsetParent(s.host,t):findCommonOffsetParent(e,getRoot(t).host)}
/**
   * Gets the scroll value of the given element in the given side (top and left)
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @argument {String} side `top` or `left`
   * @returns {number} amount of scrolled pixels
   */function getScroll(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:"top";var r="top"===t?"scrollTop":"scrollLeft";var n=e.nodeName;if("BODY"===n||"HTML"===n){var o=e.ownerDocument.documentElement;var i=e.ownerDocument.scrollingElement||o;return i[r]}return e[r]}
/*
   * Sum or subtract the element scroll values (left and top) from a given rect object
   * @method
   * @memberof Popper.Utils
   * @param {Object} rect - Rect object you want to change
   * @param {HTMLElement} element - The element from the function reads the scroll values
   * @param {Boolean} subtract - set to true if you want to subtract the scroll values
   * @return {Object} rect - The modifier rect object
   */function includeScroll(e,t){var r=arguments.length>2&&void 0!==arguments[2]&&arguments[2];var n=getScroll(t,"top");var o=getScroll(t,"left");var i=r?-1:1;e.top+=n*i;e.bottom+=n*i;e.left+=o*i;e.right+=o*i;return e}
/*
   * Helper to detect borders of a given element
   * @method
   * @memberof Popper.Utils
   * @param {CSSStyleDeclaration} styles
   * Result of `getStyleComputedProperty` on the given element
   * @param {String} axis - `x` or `y`
   * @return {number} borders - The borders size of the given axis
   */function getBordersSize(e,t){var r="x"===t?"Left":"Top";var n="Left"===r?"Right":"Bottom";return parseFloat(e["border"+r+"Width"])+parseFloat(e["border"+n+"Width"])}function getSize(e,t,r,n){return Math.max(t["offset"+e],t["scroll"+e],r["client"+e],r["offset"+e],r["scroll"+e],isIE(10)?parseInt(r["offset"+e])+parseInt(n["margin"+("Height"===e?"Top":"Left")])+parseInt(n["margin"+("Height"===e?"Bottom":"Right")]):0)}function getWindowSizes(e){var t=e.body;var r=e.documentElement;var n=isIE(10)&&getComputedStyle(r);return{height:getSize("Height",t,r,n),width:getSize("Width",t,r,n)}}var classCallCheck=function(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")};var s=function(){function defineProperties(e,t){for(var r=0;r<t.length;r++){var n=t[r];n.enumerable=n.enumerable||false;n.configurable=true;"value"in n&&(n.writable=true);Object.defineProperty(e,n.key,n)}}return function(e,t,r){t&&defineProperties(e.prototype,t);r&&defineProperties(e,r);return e}}();var defineProperty=function(e,t,r){t in e?Object.defineProperty(e,t,{value:r,enumerable:true,configurable:true,writable:true}):e[t]=r;return e};var f=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var r=arguments[t];for(var n in r)Object.prototype.hasOwnProperty.call(r,n)&&(e[n]=r[n])}return e};
/**
   * Given element offsets, generate an output similar to getBoundingClientRect
   * @method
   * @memberof Popper.Utils
   * @argument {Object} offsets
   * @returns {Object} ClientRect like output
   */function getClientRect(e){return f({},e,{right:e.left+e.width,bottom:e.top+e.height})}
/**
   * Get bounding client rect of given element
   * @method
   * @memberof Popper.Utils
   * @param {HTMLElement} element
   * @return {Object} client rect
   */function getBoundingClientRect(e){var t={};try{if(isIE(10)){t=e.getBoundingClientRect();var r=getScroll(e,"top");var n=getScroll(e,"left");t.top+=r;t.left+=n;t.bottom+=r;t.right+=n}else t=e.getBoundingClientRect()}catch(e){}var o={left:t.left,top:t.top,width:t.right-t.left,height:t.bottom-t.top};var i="HTML"===e.nodeName?getWindowSizes(e.ownerDocument):{};var a=i.width||e.clientWidth||o.width;var s=i.height||e.clientHeight||o.height;var f=e.offsetWidth-a;var l=e.offsetHeight-s;if(f||l){var p=getStyleComputedProperty(e);f-=getBordersSize(p,"x");l-=getBordersSize(p,"y");o.width-=f;o.height-=l}return getClientRect(o)}function getOffsetRectRelativeToArbitraryNode(e,t){var r=arguments.length>2&&void 0!==arguments[2]&&arguments[2];var n=isIE(10);var o="HTML"===t.nodeName;var i=getBoundingClientRect(e);var a=getBoundingClientRect(t);var s=getScrollParent(e);var f=getStyleComputedProperty(t);var l=parseFloat(f.borderTopWidth);var p=parseFloat(f.borderLeftWidth);if(r&&o){a.top=Math.max(a.top,0);a.left=Math.max(a.left,0)}var u=getClientRect({top:i.top-a.top-l,left:i.left-a.left-p,width:i.width,height:i.height});u.marginTop=0;u.marginLeft=0;if(!n&&o){var d=parseFloat(f.marginTop);var c=parseFloat(f.marginLeft);u.top-=l-d;u.bottom-=l-d;u.left-=p-c;u.right-=p-c;u.marginTop=d;u.marginLeft=c}(n&&!r?t.contains(s):t===s&&"BODY"!==s.nodeName)&&(u=includeScroll(u,t));return u}function getViewportOffsetRectRelativeToArtbitraryNode(e){var t=arguments.length>1&&void 0!==arguments[1]&&arguments[1];var r=e.ownerDocument.documentElement;var n=getOffsetRectRelativeToArbitraryNode(e,r);var o=Math.max(r.clientWidth,window.innerWidth||0);var i=Math.max(r.clientHeight,window.innerHeight||0);var a=t?0:getScroll(r);var s=t?0:getScroll(r,"left");var f={top:a-n.top+n.marginTop,left:s-n.left+n.marginLeft,width:o,height:i};return getClientRect(f)}
/**
   * Check if the given element is fixed or is inside a fixed parent
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @argument {Element} customContainer
   * @returns {Boolean} answer to "isFixed?"
   */function isFixed(e){var t=e.nodeName;if("BODY"===t||"HTML"===t)return false;if("fixed"===getStyleComputedProperty(e,"position"))return true;var r=getParentNode(e);return!!r&&isFixed(r)}
/**
   * Finds the first parent of an element that has a transformed property defined
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @returns {Element} first transformed parent or documentElement
   */function getFixedPositionOffsetParent(e){if(!e||!e.parentElement||isIE())return document.documentElement;var t=e.parentElement;while(t&&"none"===getStyleComputedProperty(t,"transform"))t=t.parentElement;return t||document.documentElement}
/**
   * Computed the boundaries limits and return them
   * @method
   * @memberof Popper.Utils
   * @param {HTMLElement} popper
   * @param {HTMLElement} reference
   * @param {number} padding
   * @param {HTMLElement} boundariesElement - Element used to define the boundaries
   * @param {Boolean} fixedPosition - Is in fixed position mode
   * @returns {Object} Coordinates of the boundaries
   */function getBoundaries(e,t,r,n){var o=arguments.length>4&&void 0!==arguments[4]&&arguments[4];var i={top:0,left:0};var a=o?getFixedPositionOffsetParent(e):findCommonOffsetParent(e,getReferenceNode(t));if("viewport"===n)i=getViewportOffsetRectRelativeToArtbitraryNode(a,o);else{var s=void 0;if("scrollParent"===n){s=getScrollParent(getParentNode(t));"BODY"===s.nodeName&&(s=e.ownerDocument.documentElement)}else s="window"===n?e.ownerDocument.documentElement:n;var f=getOffsetRectRelativeToArbitraryNode(s,a,o);if("HTML"!==s.nodeName||isFixed(a))i=f;else{var l=getWindowSizes(e.ownerDocument),p=l.height,u=l.width;i.top+=f.top-f.marginTop;i.bottom=p+f.top;i.left+=f.left-f.marginLeft;i.right=u+f.left}}r=r||0;var d="number"===typeof r;i.left+=d?r:r.left||0;i.top+=d?r:r.top||0;i.right-=d?r:r.right||0;i.bottom-=d?r:r.bottom||0;return i}function getArea(e){var t=e.width,r=e.height;return t*r}
/**
   * Utility used to transform the `auto` placement to the placement with more
   * available space.
   * @method
   * @memberof Popper.Utils
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function computeAutoPlacement(e,t,r,n,o){var i=arguments.length>5&&void 0!==arguments[5]?arguments[5]:0;if(-1===e.indexOf("auto"))return e;var a=getBoundaries(r,n,i,o);var s={top:{width:a.width,height:t.top-a.top},right:{width:a.right-t.right,height:a.height},bottom:{width:a.width,height:a.bottom-t.bottom},left:{width:t.left-a.left,height:a.height}};var l=Object.keys(s).map((function(e){return f({key:e},s[e],{area:getArea(s[e])})})).sort((function(e,t){return t.area-e.area}));var p=l.filter((function(e){var t=e.width,n=e.height;return t>=r.clientWidth&&n>=r.clientHeight}));var u=p.length>0?p[0].key:l[0].key;var d=e.split("-")[1];return u+(d?"-"+d:"")}
/**
   * Get offsets to the reference element
   * @method
   * @memberof Popper.Utils
   * @param {Object} state
   * @param {Element} popper - the popper element
   * @param {Element} reference - the reference element (the popper will be relative to this)
   * @param {Element} fixedPosition - is in fixed position mode
   * @returns {Object} An object containing the offsets which will be applied to the popper
   */function getReferenceOffsets(e,t,r){var n=arguments.length>3&&void 0!==arguments[3]?arguments[3]:null;var o=n?getFixedPositionOffsetParent(t):findCommonOffsetParent(t,getReferenceNode(r));return getOffsetRectRelativeToArbitraryNode(r,o,n)}
/**
   * Get the outer sizes of the given element (offset size + margins)
   * @method
   * @memberof Popper.Utils
   * @argument {Element} element
   * @returns {Object} object containing width and height properties
   */function getOuterSizes(e){var t=e.ownerDocument.defaultView;var r=t.getComputedStyle(e);var n=parseFloat(r.marginTop||0)+parseFloat(r.marginBottom||0);var o=parseFloat(r.marginLeft||0)+parseFloat(r.marginRight||0);var i={width:e.offsetWidth+o,height:e.offsetHeight+n};return i}
/**
   * Get the opposite placement of the given one
   * @method
   * @memberof Popper.Utils
   * @argument {String} placement
   * @returns {String} flipped placement
   */function getOppositePlacement(e){var t={left:"right",right:"left",bottom:"top",top:"bottom"};return e.replace(/left|right|bottom|top/g,(function(e){return t[e]}))}
/**
   * Get offsets to the popper
   * @method
   * @memberof Popper.Utils
   * @param {Object} position - CSS position the Popper will get applied
   * @param {HTMLElement} popper - the popper element
   * @param {Object} referenceOffsets - the reference offsets (the popper will be relative to this)
   * @param {String} placement - one of the valid placement options
   * @returns {Object} popperOffsets - An object containing the offsets which will be applied to the popper
   */function getPopperOffsets(e,t,r){r=r.split("-")[0];var n=getOuterSizes(e);var o={width:n.width,height:n.height};var i=-1!==["right","left"].indexOf(r);var a=i?"top":"left";var s=i?"left":"top";var f=i?"height":"width";var l=i?"width":"height";o[a]=t[a]+t[f]/2-n[f]/2;o[s]=r===s?t[s]-n[l]:t[getOppositePlacement(s)];return o}
/**
   * Mimics the `find` method of Array
   * @method
   * @memberof Popper.Utils
   * @argument {Array} arr
   * @argument prop
   * @argument value
   * @returns index or -1
   */function find(e,t){return Array.prototype.find?e.find(t):e.filter(t)[0]}
/**
   * Return the index of the matching object
   * @method
   * @memberof Popper.Utils
   * @argument {Array} arr
   * @argument prop
   * @argument value
   * @returns index or -1
   */function findIndex(e,t,r){if(Array.prototype.findIndex)return e.findIndex((function(e){return e[t]===r}));var n=find(e,(function(e){return e[t]===r}));return e.indexOf(n)}
/**
   * Loop trough the list of modifiers and run them in order,
   * each of them will then edit the data object.
   * @method
   * @memberof Popper.Utils
   * @param {dataObject} data
   * @param {Array} modifiers
   * @param {String} ends - Optional modifier name used as stopper
   * @returns {dataObject}
   */function runModifiers(e,t,r){var n=void 0===r?e:e.slice(0,findIndex(e,"name",r));n.forEach((function(e){e["function"]&&console.warn("`modifier.function` is deprecated, use `modifier.fn`!");var r=e["function"]||e.fn;if(e.enabled&&isFunction(r)){t.offsets.popper=getClientRect(t.offsets.popper);t.offsets.reference=getClientRect(t.offsets.reference);t=r(t,e)}}));return t}function update(){if(!(this||e).state.isDestroyed){var t={instance:this||e,styles:{},arrowStyles:{},attributes:{},flipped:false,offsets:{}};t.offsets.reference=getReferenceOffsets((this||e).state,(this||e).popper,(this||e).reference,(this||e).options.positionFixed);t.placement=computeAutoPlacement((this||e).options.placement,t.offsets.reference,(this||e).popper,(this||e).reference,(this||e).options.modifiers.flip.boundariesElement,(this||e).options.modifiers.flip.padding);t.originalPlacement=t.placement;t.positionFixed=(this||e).options.positionFixed;t.offsets.popper=getPopperOffsets((this||e).popper,t.offsets.reference,t.placement);t.offsets.popper.position=(this||e).options.positionFixed?"fixed":"absolute";t=runModifiers((this||e).modifiers,t);if((this||e).state.isCreated)(this||e).options.onUpdate(t);else{(this||e).state.isCreated=true;(this||e).options.onCreate(t)}}}
/**
   * Helper used to know if the given modifier is enabled.
   * @method
   * @memberof Popper.Utils
   * @returns {Boolean}
   */function isModifierEnabled(e,t){return e.some((function(e){var r=e.name,n=e.enabled;return n&&r===t}))}
/**
   * Get the prefixed supported property name
   * @method
   * @memberof Popper.Utils
   * @argument {String} property (camelCase)
   * @returns {String} prefixed property (camelCase or PascalCase, depending on the vendor prefix)
   */function getSupportedPropertyName(e){var t=[false,"ms","Webkit","Moz","O"];var r=e.charAt(0).toUpperCase()+e.slice(1);for(var n=0;n<t.length;n++){var o=t[n];var i=o?""+o+r:e;if("undefined"!==typeof document.body.style[i])return i}return null}function destroy(){(this||e).state.isDestroyed=true;if(isModifierEnabled((this||e).modifiers,"applyStyle")){(this||e).popper.removeAttribute("x-placement");(this||e).popper.style.position="";(this||e).popper.style.top="";(this||e).popper.style.left="";(this||e).popper.style.right="";(this||e).popper.style.bottom="";(this||e).popper.style.willChange="";(this||e).popper.style[getSupportedPropertyName("transform")]=""}this.disableEventListeners();(this||e).options.removeOnDestroy&&(this||e).popper.parentNode.removeChild((this||e).popper);return this||e}
/**
   * Get the window associated with the element
   * @argument {Element} element
   * @returns {Window}
   */function getWindow(e){var t=e.ownerDocument;return t?t.defaultView:window}function attachToScrollParents(e,t,r,n){var o="BODY"===e.nodeName;var i=o?e.ownerDocument.defaultView:e;i.addEventListener(t,r,{passive:true});o||attachToScrollParents(getScrollParent(i.parentNode),t,r,n);n.push(i)}function setupEventListeners(e,t,r,n){r.updateBound=n;getWindow(e).addEventListener("resize",r.updateBound,{passive:true});var o=getScrollParent(e);attachToScrollParents(o,"scroll",r.updateBound,r.scrollParents);r.scrollElement=o;r.eventsEnabled=true;return r}function enableEventListeners(){(this||e).state.eventsEnabled||((this||e).state=setupEventListeners((this||e).reference,(this||e).options,(this||e).state,(this||e).scheduleUpdate))}function removeEventListeners(e,t){getWindow(e).removeEventListener("resize",t.updateBound);t.scrollParents.forEach((function(e){e.removeEventListener("scroll",t.updateBound)}));t.updateBound=null;t.scrollParents=[];t.scrollElement=null;t.eventsEnabled=false;return t}function disableEventListeners(){if((this||e).state.eventsEnabled){cancelAnimationFrame((this||e).scheduleUpdate);(this||e).state=removeEventListeners((this||e).reference,(this||e).state)}}
/**
   * Tells if a given input is a number
   * @method
   * @memberof Popper.Utils
   * @param {*} input to check
   * @return {Boolean}
   */function isNumeric(e){return""!==e&&!isNaN(parseFloat(e))&&isFinite(e)}function setStyles(e,t){Object.keys(t).forEach((function(r){var n="";-1!==["width","height","top","right","bottom","left"].indexOf(r)&&isNumeric(t[r])&&(n="px");e.style[r]=t[r]+n}))}function setAttributes(e,t){Object.keys(t).forEach((function(r){var n=t[r];false!==n?e.setAttribute(r,t[r]):e.removeAttribute(r)}))}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Object} data.styles - List of style properties - values to apply to popper element
   * @argument {Object} data.attributes - List of attribute properties - values to apply to popper element
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The same data object
   */function applyStyle(e){setStyles(e.instance.popper,e.styles);setAttributes(e.instance.popper,e.attributes);e.arrowElement&&Object.keys(e.arrowStyles).length&&setStyles(e.arrowElement,e.arrowStyles);return e}
/**
   * Set the x-placement attribute before everything else because it could be used
   * to add margins to the popper margins needs to be calculated to get the
   * correct popper offsets.
   * @method
   * @memberof Popper.modifiers
   * @param {HTMLElement} reference - The reference element used to position the popper
   * @param {HTMLElement} popper - The HTML element used as popper
   * @param {Object} options - Popper.js options
   */function applyStyleOnLoad(e,t,r,n,o){var i=getReferenceOffsets(o,t,e,r.positionFixed);var a=computeAutoPlacement(r.placement,i,t,e,r.modifiers.flip.boundariesElement,r.modifiers.flip.padding);t.setAttribute("x-placement",a);setStyles(t,{position:r.positionFixed?"fixed":"absolute"});return r}
/**
   * @function
   * @memberof Popper.Utils
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Boolean} shouldRound - If the offsets should be rounded at all
   * @returns {Object} The popper's position offsets rounded
   *
   * The tale of pixel-perfect positioning. It's still not 100% perfect, but as
   * good as it can be within reason.
   * Discussion here: https://github.com/FezVrasta/popper.js/pull/715
   *
   * Low DPI screens cause a popper to be blurry if not using full pixels (Safari
   * as well on High DPI screens).
   *
   * Firefox prefers no rounding for positioning and does not have blurriness on
   * high DPI screens.
   *
   * Only horizontal placement and left/right values need to be considered.
   */function getRoundedOffsets(e,t){var r=e.offsets,n=r.popper,o=r.reference;var i=Math.round,a=Math.floor;var s=function noRound(e){return e};var f=i(o.width);var l=i(n.width);var p=-1!==["left","right"].indexOf(e.placement);var u=-1!==e.placement.indexOf("-");var d=f%2===l%2;var c=f%2===1&&l%2===1;var v=t?p||u||d?i:a:s;var h=t?i:s;return{left:v(c&&!u&&t?n.left-1:n.left),top:h(n.top),bottom:h(n.bottom),right:v(n.right)}}var l=t&&/Firefox/i.test(navigator.userAgent);
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function computeStyle(e,t){var r=t.x,n=t.y;var o=e.offsets.popper;var i=find(e.instance.modifiers,(function(e){return"applyStyle"===e.name})).gpuAcceleration;void 0!==i&&console.warn("WARNING: `gpuAcceleration` option moved to `computeStyle` modifier and will not be supported in future versions of Popper.js!");var a=void 0!==i?i:t.gpuAcceleration;var s=getOffsetParent(e.instance.popper);var p=getBoundingClientRect(s);var u={position:o.position};var d=getRoundedOffsets(e,window.devicePixelRatio<2||!l);var c="bottom"===r?"top":"bottom";var v="right"===n?"left":"right";var h=getSupportedPropertyName("transform");var m=void 0,g=void 0;g="bottom"===c?"HTML"===s.nodeName?-s.clientHeight+d.bottom:-p.height+d.bottom:d.top;m="right"===v?"HTML"===s.nodeName?-s.clientWidth+d.right:-p.width+d.right:d.left;if(a&&h){u[h]="translate3d("+m+"px, "+g+"px, 0)";u[c]=0;u[v]=0;u.willChange="transform"}else{var b="bottom"===c?-1:1;var y="right"===v?-1:1;u[c]=g*b;u[v]=m*y;u.willChange=c+", "+v}var w={"x-placement":e.placement};e.attributes=f({},w,e.attributes);e.styles=f({},u,e.styles);e.arrowStyles=f({},e.offsets.arrow,e.arrowStyles);return e}
/**
   * Helper used to know if the given modifier depends from another one.<br />
   * It checks if the needed modifier is listed and enabled.
   * @method
   * @memberof Popper.Utils
   * @param {Array} modifiers - list of modifiers
   * @param {String} requestingName - name of requesting modifier
   * @param {String} requestedName - name of requested modifier
   * @returns {Boolean}
   */function isModifierRequired(e,t,r){var n=find(e,(function(e){var r=e.name;return r===t}));var o=!!n&&e.some((function(e){return e.name===r&&e.enabled&&e.order<n.order}));if(!o){var i="`"+t+"`";var a="`"+r+"`";console.warn(a+" modifier is required by "+i+" modifier in order to work, be sure to include it before "+i+"!")}return o}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function arrow(e,t){var r;if(!isModifierRequired(e.instance.modifiers,"arrow","keepTogether"))return e;var n=t.element;if("string"===typeof n){n=e.instance.popper.querySelector(n);if(!n)return e}else if(!e.instance.popper.contains(n)){console.warn("WARNING: `arrow.element` must be child of its popper element!");return e}var o=e.placement.split("-")[0];var i=e.offsets,a=i.popper,s=i.reference;var f=-1!==["left","right"].indexOf(o);var l=f?"height":"width";var p=f?"Top":"Left";var u=p.toLowerCase();var d=f?"left":"top";var c=f?"bottom":"right";var v=getOuterSizes(n)[l];s[c]-v<a[u]&&(e.offsets.popper[u]-=a[u]-(s[c]-v));s[u]+v>a[c]&&(e.offsets.popper[u]+=s[u]+v-a[c]);e.offsets.popper=getClientRect(e.offsets.popper);var h=s[u]+s[l]/2-v/2;var m=getStyleComputedProperty(e.instance.popper);var g=parseFloat(m["margin"+p]);var b=parseFloat(m["border"+p+"Width"]);var y=h-e.offsets.popper[u]-g-b;y=Math.max(Math.min(a[l]-v,y),0);e.arrowElement=n;e.offsets.arrow=(r={},defineProperty(r,u,Math.round(y)),defineProperty(r,d,""),r);return e}
/**
   * Get the opposite placement variation of the given one
   * @method
   * @memberof Popper.Utils
   * @argument {String} placement variation
   * @returns {String} flipped placement variation
   */function getOppositeVariation(e){return"end"===e?"start":"start"===e?"end":e}
/**
   * List of accepted placements to use as values of the `placement` option.<br />
   * Valid placements are:
   * - `auto`
   * - `top`
   * - `right`
   * - `bottom`
   * - `left`
   *
   * Each placement can have a variation from this list:
   * - `-start`
   * - `-end`
   *
   * Variations are interpreted easily if you think of them as the left to right
   * written languages. Horizontally (`top` and `bottom`), `start` is left and `end`
   * is right.<br />
   * Vertically (`left` and `right`), `start` is top and `end` is bottom.
   *
   * Some valid examples are:
   * - `top-end` (on top of reference, right aligned)
   * - `right-start` (on right of reference, top aligned)
   * - `bottom` (on bottom, centered)
   * - `auto-end` (on the side with more space available, alignment depends by placement)
   *
   * @static
   * @type {Array}
   * @enum {String}
   * @readonly
   * @method placements
   * @memberof Popper
   */var p=["auto-start","auto","auto-end","top-start","top","top-end","right-start","right","right-end","bottom-end","bottom","bottom-start","left-end","left","left-start"];var u=p.slice(3);
/**
   * Given an initial placement, returns all the subsequent placements
   * clockwise (or counter-clockwise).
   *
   * @method
   * @memberof Popper.Utils
   * @argument {String} placement - A valid placement (it accepts variations)
   * @argument {Boolean} counter - Set to true to walk the placements counterclockwise
   * @returns {Array} placements including their variations
   */function clockwise(e){var t=arguments.length>1&&void 0!==arguments[1]&&arguments[1];var r=u.indexOf(e);var n=u.slice(r+1).concat(u.slice(0,r));return t?n.reverse():n}var d={FLIP:"flip",CLOCKWISE:"clockwise",COUNTERCLOCKWISE:"counterclockwise"};
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function flip(e,t){if(isModifierEnabled(e.instance.modifiers,"inner"))return e;if(e.flipped&&e.placement===e.originalPlacement)return e;var r=getBoundaries(e.instance.popper,e.instance.reference,t.padding,t.boundariesElement,e.positionFixed);var n=e.placement.split("-")[0];var o=getOppositePlacement(n);var i=e.placement.split("-")[1]||"";var a=[];switch(t.behavior){case d.FLIP:a=[n,o];break;case d.CLOCKWISE:a=clockwise(n);break;case d.COUNTERCLOCKWISE:a=clockwise(n,true);break;default:a=t.behavior}a.forEach((function(s,l){if(n!==s||a.length===l+1)return e;n=e.placement.split("-")[0];o=getOppositePlacement(n);var p=e.offsets.popper;var u=e.offsets.reference;var d=Math.floor;var c="left"===n&&d(p.right)>d(u.left)||"right"===n&&d(p.left)<d(u.right)||"top"===n&&d(p.bottom)>d(u.top)||"bottom"===n&&d(p.top)<d(u.bottom);var v=d(p.left)<d(r.left);var h=d(p.right)>d(r.right);var m=d(p.top)<d(r.top);var g=d(p.bottom)>d(r.bottom);var b="left"===n&&v||"right"===n&&h||"top"===n&&m||"bottom"===n&&g;var y=-1!==["top","bottom"].indexOf(n);var w=!!t.flipVariations&&(y&&"start"===i&&v||y&&"end"===i&&h||!y&&"start"===i&&m||!y&&"end"===i&&g);var O=!!t.flipVariationsByContent&&(y&&"start"===i&&h||y&&"end"===i&&v||!y&&"start"===i&&g||!y&&"end"===i&&m);var E=w||O;if(c||b||E){e.flipped=true;(c||b)&&(n=a[l+1]);E&&(i=getOppositeVariation(i));e.placement=n+(i?"-"+i:"");e.offsets.popper=f({},e.offsets.popper,getPopperOffsets(e.instance.popper,e.offsets.reference,e.placement));e=runModifiers(e.instance.modifiers,e,"flip")}}));return e}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function keepTogether(e){var t=e.offsets,r=t.popper,n=t.reference;var o=e.placement.split("-")[0];var i=Math.floor;var a=-1!==["top","bottom"].indexOf(o);var s=a?"right":"bottom";var f=a?"left":"top";var l=a?"width":"height";r[s]<i(n[f])&&(e.offsets.popper[f]=i(n[f])-r[l]);r[f]>i(n[s])&&(e.offsets.popper[f]=i(n[s]));return e}
/**
   * Converts a string containing value + unit into a px value number
   * @function
   * @memberof {modifiers~offset}
   * @private
   * @argument {String} str - Value + unit string
   * @argument {String} measurement - `height` or `width`
   * @argument {Object} popperOffsets
   * @argument {Object} referenceOffsets
   * @returns {Number|String}
   * Value in pixels, or original string if no values were extracted
   */function toValue(e,t,r,n){var o=e.match(/((?:\-|\+)?\d*\.?\d*)(.*)/);var i=+o[1];var a=o[2];if(!i)return e;if(0===a.indexOf("%")){var s=void 0;switch(a){case"%p":s=r;break;case"%":case"%r":default:s=n}var f=getClientRect(s);return f[t]/100*i}if("vh"===a||"vw"===a){var l=void 0;l="vh"===a?Math.max(document.documentElement.clientHeight,window.innerHeight||0):Math.max(document.documentElement.clientWidth,window.innerWidth||0);return l/100*i}return i}
/**
   * Parse an `offset` string to extrapolate `x` and `y` numeric offsets.
   * @function
   * @memberof {modifiers~offset}
   * @private
   * @argument {String} offset
   * @argument {Object} popperOffsets
   * @argument {Object} referenceOffsets
   * @argument {String} basePlacement
   * @returns {Array} a two cells array with x and y offsets in numbers
   */function parseOffset(e,t,r,n){var o=[0,0];var i=-1!==["right","left"].indexOf(n);var a=e.split(/(\+|\-)/).map((function(e){return e.trim()}));var s=a.indexOf(find(a,(function(e){return-1!==e.search(/,|\s/)})));a[s]&&-1===a[s].indexOf(",")&&console.warn("Offsets separated by white space(s) are deprecated, use a comma (,) instead.");var f=/\s*,\s*|\s+/;var l=-1!==s?[a.slice(0,s).concat([a[s].split(f)[0]]),[a[s].split(f)[1]].concat(a.slice(s+1))]:[a];l=l.map((function(e,n){var o=(1===n?!i:i)?"height":"width";var a=false;return e.reduce((function(e,t){if(""===e[e.length-1]&&-1!==["+","-"].indexOf(t)){e[e.length-1]=t;a=true;return e}if(a){e[e.length-1]+=t;a=false;return e}return e.concat(t)}),[]).map((function(e){return toValue(e,o,t,r)}))}));l.forEach((function(e,t){e.forEach((function(r,n){isNumeric(r)&&(o[t]+=r*("-"===e[n-1]?-1:1))}))}));return o}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @argument {Number|String} options.offset=0
   * The offset value as described in the modifier description
   * @returns {Object} The data object, properly modified
   */function offset(e,t){var r=t.offset;var n=e.placement,o=e.offsets,i=o.popper,a=o.reference;var s=n.split("-")[0];var f=void 0;f=isNumeric(+r)?[+r,0]:parseOffset(r,i,a,s);if("left"===s){i.top+=f[0];i.left-=f[1]}else if("right"===s){i.top+=f[0];i.left+=f[1]}else if("top"===s){i.left+=f[0];i.top-=f[1]}else if("bottom"===s){i.left+=f[0];i.top+=f[1]}e.popper=i;return e}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function preventOverflow(e,t){var r=t.boundariesElement||getOffsetParent(e.instance.popper);e.instance.reference===r&&(r=getOffsetParent(r));var n=getSupportedPropertyName("transform");var o=e.instance.popper.style;var i=o.top,a=o.left,s=o[n];o.top="";o.left="";o[n]="";var l=getBoundaries(e.instance.popper,e.instance.reference,t.padding,r,e.positionFixed);o.top=i;o.left=a;o[n]=s;t.boundaries=l;var p=t.priority;var u=e.offsets.popper;var d={primary:function primary(e){var r=u[e];u[e]<l[e]&&!t.escapeWithReference&&(r=Math.max(u[e],l[e]));return defineProperty({},e,r)},secondary:function secondary(e){var r="right"===e?"left":"top";var n=u[r];u[e]>l[e]&&!t.escapeWithReference&&(n=Math.min(u[r],l[e]-("right"===e?u.width:u.height)));return defineProperty({},r,n)}};p.forEach((function(e){var t=-1!==["left","top"].indexOf(e)?"primary":"secondary";u=f({},u,d[t](e))}));e.offsets.popper=u;return e}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function shift(e){var t=e.placement;var r=t.split("-")[0];var n=t.split("-")[1];if(n){var o=e.offsets,i=o.reference,a=o.popper;var s=-1!==["bottom","top"].indexOf(r);var l=s?"left":"top";var p=s?"width":"height";var u={start:defineProperty({},l,i[l]),end:defineProperty({},l,i[l]+i[p]-a[p])};e.offsets.popper=f({},a,u[n])}return e}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by update method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function hide(e){if(!isModifierRequired(e.instance.modifiers,"hide","preventOverflow"))return e;var t=e.offsets.reference;var r=find(e.instance.modifiers,(function(e){return"preventOverflow"===e.name})).boundaries;if(t.bottom<r.top||t.left>r.right||t.top>r.bottom||t.right<r.left){if(true===e.hide)return e;e.hide=true;e.attributes["x-out-of-boundaries"]=""}else{if(false===e.hide)return e;e.hide=false;e.attributes["x-out-of-boundaries"]=false}return e}
/**
   * @function
   * @memberof Modifiers
   * @argument {Object} data - The data object generated by `update` method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {Object} The data object, properly modified
   */function inner(e){var t=e.placement;var r=t.split("-")[0];var n=e.offsets,o=n.popper,i=n.reference;var a=-1!==["left","right"].indexOf(r);var s=-1===["top","left"].indexOf(r);o[a?"left":"top"]=i[r]-(s?o[a?"width":"height"]:0);e.placement=getOppositePlacement(t);e.offsets.popper=getClientRect(o);return e}
/**
   * Modifier function, each modifier can have a function of this type assigned
   * to its `fn` property.<br />
   * These functions will be called on each update, this means that you must
   * make sure they are performant enough to avoid performance bottlenecks.
   *
   * @function ModifierFn
   * @argument {dataObject} data - The data object generated by `update` method
   * @argument {Object} options - Modifiers configuration and options
   * @returns {dataObject} The data object, properly modified
   */var c={shift:{order:100,enabled:true,fn:shift},offset:{order:200,enabled:true,fn:offset,offset:0},preventOverflow:{order:300,enabled:true,fn:preventOverflow,priority:["left","right","top","bottom"],padding:5,boundariesElement:"scrollParent"},keepTogether:{order:400,enabled:true,fn:keepTogether},arrow:{order:500,enabled:true,fn:arrow,element:"[x-arrow]"},flip:{order:600,enabled:true,fn:flip,behavior:"flip",padding:5,boundariesElement:"viewport",flipVariations:false,flipVariationsByContent:false},inner:{order:700,enabled:false,fn:inner},hide:{order:800,enabled:true,fn:hide},computeStyle:{order:850,enabled:true,fn:computeStyle,gpuAcceleration:true,x:"bottom",y:"right"},applyStyle:{order:900,enabled:true,fn:applyStyle,onLoad:applyStyleOnLoad,
/**
       * @deprecated since version 1.10.0, the property moved to `computeStyle` modifier
       * @prop {Boolean} gpuAcceleration=true
       * If true, it uses the CSS 3D transformation to position the popper.
       * Otherwise, it will use the `top` and `left` properties
       */
gpuAcceleration:void 0}};
/**
   * Default options provided to Popper.js constructor.<br />
   * These can be overridden using the `options` argument of Popper.js.<br />
   * To override an option, simply pass an object with the same
   * structure of the `options` object, as the 3rd argument. For example:
   * ```
   * new Popper(ref, pop, {
   *   modifiers: {
   *     preventOverflow: { enabled: false }
   *   }
   * })
   * ```
   * @type {Object}
   * @static
   * @memberof Popper
   */var v={placement:"bottom",positionFixed:false,eventsEnabled:true,removeOnDestroy:false,onCreate:function onCreate(){},onUpdate:function onUpdate(){},modifiers:c};
/**
   * @callback onCreate
   * @param {dataObject} data
   */
/**
   * @callback onUpdate
   * @param {dataObject} data
   */var h=function(){
/**
     * Creates a new Popper.js instance.
     * @class Popper
     * @param {Element|referenceObject} reference - The reference element used to position the popper
     * @param {Element} popper - The HTML / XML element used as the popper
     * @param {Object} options - Your custom options to override the ones defined in [Defaults](#defaults)
     * @return {Object} instance - The generated Popper.js instance
     */
function Popper(t,r){var n=this||e;var i=arguments.length>2&&void 0!==arguments[2]?arguments[2]:{};classCallCheck(this||e,Popper);(this||e).scheduleUpdate=function(){return requestAnimationFrame(n.update)};(this||e).update=o((this||e).update.bind(this||e));(this||e).options=f({},Popper.Defaults,i);(this||e).state={isDestroyed:false,isCreated:false,scrollParents:[]};(this||e).reference=t&&t.jquery?t[0]:t;(this||e).popper=r&&r.jquery?r[0]:r;(this||e).options.modifiers={};Object.keys(f({},Popper.Defaults.modifiers,i.modifiers)).forEach((function(e){n.options.modifiers[e]=f({},Popper.Defaults.modifiers[e]||{},i.modifiers?i.modifiers[e]:{})}));(this||e).modifiers=Object.keys((this||e).options.modifiers).map((function(e){return f({name:e},n.options.modifiers[e])})).sort((function(e,t){return e.order-t.order}));(this||e).modifiers.forEach((function(e){e.enabled&&isFunction(e.onLoad)&&e.onLoad(n.reference,n.popper,n.options,e,n.state)}));this.update();var a=(this||e).options.eventsEnabled;a&&this.enableEventListeners();(this||e).state.eventsEnabled=a}s(Popper,[{key:"update",value:function update$$1(){return update.call(this||e)}},{key:"destroy",value:function destroy$$1(){return destroy.call(this||e)}},{key:"enableEventListeners",value:function enableEventListeners$$1(){return enableEventListeners.call(this||e)}},{key:"disableEventListeners",value:function disableEventListeners$$1(){return disableEventListeners.call(this||e)}
/**
       * Collection of utilities useful when writing custom modifiers.
       * Starting from version 1.7, this method is available only if you
       * include `popper-utils.js` before `popper.js`.
       *
       * **DEPRECATION**: This way to access PopperUtils is deprecated
       * and will be removed in v2! Use the PopperUtils module directly instead.
       * Due to the high instability of the methods contained in Utils, we can't
       * guarantee them to follow semver. Use them at your own risk!
       * @static
       * @private
       * @type {Object}
       * @deprecated since version 1.8
       * @member Utils
       * @memberof Popper
       */}]);return Popper}();h.Utils=("undefined"!==typeof window?window:e).PopperUtils;h.placements=p;h.Defaults=v;return h}));var r=t;export default r;

