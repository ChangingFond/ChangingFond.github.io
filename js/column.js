"use strict";!function(){function n(){return Array.prototype.slice.call(document.querySelectorAll.apply(document,arguments))}if(n(".columns .column-right").length&&n(".columns .column-right-shadow").length&&!n(".columns .column-right-shadow")[0].children.length){var l=!0,o=!1,r=void 0;try{for(var t,c=n(".columns .column-right")[0].children[Symbol.iterator]();!(l=(t=c.next()).done);l=!0){var e=t.value;n(".columns .column-right-shadow")[0].append(e.cloneNode(!0))}}catch(n){o=!0,r=n}finally{try{!l&&c.return&&c.return()}finally{if(o)throw r}}}}();