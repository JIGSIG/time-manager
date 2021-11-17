(function(e){function t(t){for(var r,a,s=t[0],c=t[1],u=t[2],d=0,m=[];d<s.length;d++)a=s[d],Object.prototype.hasOwnProperty.call(o,a)&&o[a]&&m.push(o[a][0]),o[a]=0;for(r in c)Object.prototype.hasOwnProperty.call(c,r)&&(e[r]=c[r]);l&&l(t);while(m.length)m.shift()();return i.push.apply(i,u||[]),n()}function n(){for(var e,t=0;t<i.length;t++){for(var n=i[t],r=!0,s=1;s<n.length;s++){var c=n[s];0!==o[c]&&(r=!1)}r&&(i.splice(t--,1),e=a(a.s=n[0]))}return e}var r={},o={app:0},i=[];function a(t){if(r[t])return r[t].exports;var n=r[t]={i:t,l:!1,exports:{}};return e[t].call(n.exports,n,n.exports,a),n.l=!0,n.exports}a.m=e,a.c=r,a.d=function(e,t,n){a.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:n})},a.r=function(e){"undefined"!==typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},a.t=function(e,t){if(1&t&&(e=a(e)),8&t)return e;if(4&t&&"object"===typeof e&&e&&e.__esModule)return e;var n=Object.create(null);if(a.r(n),Object.defineProperty(n,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var r in e)a.d(n,r,function(t){return e[t]}.bind(null,r));return n},a.n=function(e){var t=e&&e.__esModule?function(){return e["default"]}:function(){return e};return a.d(t,"a",t),t},a.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},a.p="";var s=window["webpackJsonp"]=window["webpackJsonp"]||[],c=s.push.bind(s);s.push=t,s=s.slice();for(var u=0;u<s.length;u++)t(s[u]);var l=c;i.push([0,"chunk-vendors"]),n()})({0:function(e,t,n){e.exports=n("56d7")},"56d7":function(e,t,n){"use strict";n.r(t);n("e260"),n("e6cf"),n("cca6"),n("a79d");var r=n("2b0e"),o=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-app",{attrs:{id:"app"}},[e.$route.path.endsWith("api/")?void 0:e._e(),n("v-main",[n("keep-alive",{attrs:{include:["Login"]}},[n("router-view")],1)],1)],2)},i=[],a={name:"App",data:function(){return{drawer:!1}}},s=a,c=n("2877"),u=n("6544"),l=n.n(u),d=n("7496"),m=n("f6c4"),v=Object(c["a"])(s,o,i,!1,null,null,null),f=v.exports;l()(v,{VApp:d["a"],VMain:m["a"]});var p=n("8c4f"),h=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-app",{attrs:{id:"inspire"}},[n("v-main",[n("v-container",{attrs:{fluid:"","fill-height":""}},[n("v-layout",{attrs:{"align-center":"","justify-center":""}},[n("v-flex",{attrs:{xs12:"",sm8:"",md4:""}},[n("v-card",{staticClass:"elevation-12"},[n("v-toolbar",{attrs:{dark:"",color:"primary"}},[n("v-toolbar-title",[e._v("Login form")])],1),n("v-card-text",[n("v-form",[n("v-text-field",{attrs:{"prepend-icon":"person",name:"login",label:"Login",type:"text"},model:{value:e.email,callback:function(t){e.email=t},expression:"email"}}),n("v-text-field",{attrs:{id:"password","prepend-icon":"lock",name:"password",label:"Password",type:"password"},model:{value:e.password,callback:function(t){e.password=t},expression:"password"}})],1)],1),n("v-card-actions",[n("v-spacer"),n("v-btn",{attrs:{color:"primary"},on:{click:e.login}},[e._v("Login")])],1)],1)],1)],1)],1)],1)],1)},g=[],k={name:"Login",props:{source:String},data:function(){return{email:"",password:""}},computed:{},methods:{login:function(){var e={email:this.email,password_hash:this.password};this.$store.dispatch("userModule/login",e)}}},w=k,b=n("8336"),T=n("b0af"),S=n("99d9"),C=n("a523"),U=n("0e8f"),M=n("4bd4"),O=n("a722"),y=n("2fa4"),W=n("8654"),_=n("71d9"),x=n("2a7f"),I=Object(c["a"])(w,h,g,!1,null,null,null),j=I.exports;l()(I,{VApp:d["a"],VBtn:b["a"],VCard:T["a"],VCardActions:S["a"],VCardText:S["b"],VContainer:C["a"],VFlex:U["a"],VForm:M["a"],VLayout:O["a"],VMain:m["a"],VSpacer:y["a"],VTextField:W["a"],VToolbar:_["a"],VToolbarTitle:x["a"]});var L=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{attrs:{id:"app"}},[n("v-app",[n("AppBar"),n("v-main",{staticClass:"height: 90vh, black"},["user"===this.user.role?n("div",[n("User_home")],1):"manager"===this.user.role?n("div",[n("Manager_home")],1):"admin"===this.user.role?n("div",[n("Admin_home")],1):n("div",[e._v(" Ni A, ni B et ni C ")])])],1)],1)},V=[],F=n("5530"),A=n("2f62"),P=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-card",{attrs:{height:"100vh"}},[n("v-btn",{staticClass:"ml-4",attrs:{color:e.lastClock.status?"primary":"success",disabled:!this.selectedUser.id},on:{click:e.updateClock}},[e._v(" "+e._s(e.clockTitle)+" ")])],1)},D=[],E={name:"user_home",data:function(){return{action:"",elapsedTime:0,timer:void 0}},computed:Object(F["a"])(Object(F["a"])(Object(F["a"])(Object(F["a"])({},Object(A["b"])("userModule",{selectedUser:"user"})),Object(A["b"])("workingtimesModule",{events:"events",selectedWorkingTime:"selectedWorkingTime"})),Object(A["b"])("clockModule",{lastClock:"lastClock"})),{},{clockTitle:function(){var e=void 0,t=new Date(null);t.setSeconds(this.elapsedTime/1e3);var n=t.toUTCString();return e=n.substr(n.indexOf(":")-2,8),this.lastClock.status?e:"Clock'In!"}}),watch:{selectedUser:function(){this.$store.dispatch("clockModule/getClockForSelectedUser",this.selectedUser.id)}},methods:{viewDay:function(e){var t=e.date;this.focus=t,this.type="day"},getEventColor:function(e){return e.color},setToday:function(){this.focus=""},prev:function(){this.$refs.calendar.prev()},next:function(){this.$refs.calendar.next()},showEvent:function(e){var t=this,n=e.nativeEvent,r=e.event,o=function(){t.selectedEvent=r,t.selectedElement=n.target,requestAnimationFrame((function(){return requestAnimationFrame((function(){return t.selectedOpen=!0}))}))};this.selectedOpen?(this.selectedOpen=!1,requestAnimationFrame((function(){return requestAnimationFrame((function(){return o()}))}))):o(),n.stopPropagation(),this.$store.dispatch("workingtimesModule/getWorkingTimeForSelectedUser",r.id)},updateRange:function(e){var t=e.start,n=e.end,r={user:this.selectedUser,start:t.date+" 00:00:00",end:n.date+" 00:00:00"};this.$store.dispatch("workingtimesModule/getAllWorkingTimesForSelectedUser",r)},rnd:function(e,t){return Math.floor((t-e+1)*Math.random())+e},updateClock:function(){var e=this;this.lastClock.status?(clearInterval(this.timer),this.elapsedTime=0):(this.lastClock.status&&(this.elapsedTime=new Date(this.lastClock.time).getTime()),this.timer=setInterval((function(){e.elapsedTime+=1e3}),1e3)),this.$store.dispatch("clockModule/setClockForSelectedUser",this.selectedUser.id)}}},$=E,B=Object(c["a"])($,P,D,!1,null,"07ef616a",null),H=B.exports;l()(B,{VBtn:b["a"],VCard:T["a"]});var q=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-div",[e._v(" B ")])},J=[],N={name:"manager_home"},Y=N,z=Object(c["a"])(Y,q,J,!1,null,"4d7e8bbc",null),R=z.exports,G=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-card",[n("v-btn",{staticClass:"ml-4",attrs:{color:e.lastClock.status?"primary":"success",disabled:!this.selectedUser.id},on:{click:e.updateClock}},[e._v(" "+e._s(e.clockTitle)+" ")])],1)},K=[],Q={name:"admin_home",data:function(){return{action:"",elapsedTime:0,timer:void 0}},computed:Object(F["a"])(Object(F["a"])(Object(F["a"])(Object(F["a"])({},Object(A["b"])("userModule",{selectedUser:"user"})),Object(A["b"])("workingtimesModule",{events:"events",selectedWorkingTime:"selectedWorkingTime"})),Object(A["b"])("clockModule",{lastClock:"lastClock"})),{},{clockTitle:function(){var e=void 0,t=new Date(null);t.setSeconds(this.elapsedTime/1e3);var n=t.toUTCString();return e=n.substr(n.indexOf(":")-2,8),this.lastClock.status?e:"Clock'In!"}}),watch:{selectedUser:function(){this.$store.dispatch("clockModule/getClockForSelectedUser",this.selectedUser.id)}},methods:{viewDay:function(e){var t=e.date;this.focus=t,this.type="day"},getEventColor:function(e){return e.color},setToday:function(){this.focus=""},prev:function(){this.$refs.calendar.prev()},next:function(){this.$refs.calendar.next()},showEvent:function(e){var t=this,n=e.nativeEvent,r=e.event,o=function(){t.selectedEvent=r,t.selectedElement=n.target,requestAnimationFrame((function(){return requestAnimationFrame((function(){return t.selectedOpen=!0}))}))};this.selectedOpen?(this.selectedOpen=!1,requestAnimationFrame((function(){return requestAnimationFrame((function(){return o()}))}))):o(),n.stopPropagation(),this.$store.dispatch("workingtimesModule/getWorkingTimeForSelectedUser",r.id)},updateRange:function(e){var t=e.start,n=e.end,r={user:this.selectedUser,start:t.date+" 00:00:00",end:n.date+" 00:00:00"};this.$store.dispatch("workingtimesModule/getAllWorkingTimesForSelectedUser",r)},rnd:function(e,t){return Math.floor((t-e+1)*Math.random())+e},updateClock:function(){var e=this;this.lastClock.status?(clearInterval(this.timer),this.elapsedTime=0):(this.lastClock.status&&(this.elapsedTime=new Date(this.lastClock.time).getTime()),this.timer=setInterval((function(){e.elapsedTime+=1e3}),1e3)),this.$store.dispatch("clockModule/setClockForSelectedUser",this.selectedUser.id)}}},X=Q,Z=Object(c["a"])(X,G,K,!1,null,"5f613f34",null),ee=Z.exports;l()(Z,{VBtn:b["a"],VCard:T["a"]});var te=function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("v-app",[n("v-navigation-drawer",{staticStyle:{width:"100%"},attrs:{height:"10vh",width:"100vh",color:"black",permanent:""}},[n("v-container",{staticClass:"fill-height"},[n("v-app-bar-nav-icon",{staticClass:"blue",on:{click:function(t){t.stopPropagation(),e.drawer=!e.drawer}}})],1)],1),n("v-navigation-drawer",{attrs:{absolute:"",temporary:""},model:{value:e.drawer,callback:function(t){e.drawer=t},expression:"drawer"}},[n("v-system-bar"),n("v-list",[n("v-list-item",[n("v-list-item-avatar",[n("v-img",{attrs:{src:"https://cdn.vuetifyjs.com/images/john.png"}})],1)],1),n("v-list-item",{attrs:{link:""}},[n("v-list-item-content",[n("v-list-item-title",{staticClass:"text-h6"},[e._v(" John Leider ")]),n("v-list-item-subtitle",[e._v("john@vuetifyjs.com")])],1),n("v-list-item-action",[n("v-icon",[e._v("mdi-menu-down")])],1)],1)],1),n("v-divider"),n("v-list",{attrs:{nav:"",dense:""}},[n("v-list-item-group",{attrs:{color:"primary"},model:{value:e.selectedItem,callback:function(t){e.selectedItem=t},expression:"selectedItem"}},e._l(e.items,(function(t,r){return n("v-list-item",{key:r,on:{click:function(n){return e.drawerActions(t.action)}}},[n("v-list-item-icon",[n("v-icon",{domProps:{textContent:e._s(t.icon)}})],1),n("v-list-item-content",[n("v-list-item-title",{domProps:{textContent:e._s(t.text)}})],1)],1)})),1),n("v-spacer"),n("v-divider"),n("v-spacer"),n("v-list-item",{key:e.items.length,on:{click:e.disconnect}},[n("v-list-item-icon",[n("v-icon",{domProps:{textContent:e._s("mdi-cloud-upload")}})],1),n("v-list-item-content",[n("v-list-item-title",{domProps:{textContent:e._s("Logout")}})],1)],1)],1)],1)],1)},ne=[],re={name:"AppBar",data:function(){return{drawer:null,selectedItem:0,items:[{text:"My Files",icon:"mdi-folder",action:this.disconnect},{text:"Shared with me",icon:"mdi-account-multiple"},{text:"Starred",icon:"mdi-star"},{text:"Recent",icon:"mdi-history"},{text:"Offline",icon:"mdi-check-circle"},{text:"Uploads",icon:"mdi-upload"}]}},computed:Object(F["a"])({},Object(A["b"])("userModule",{user:"user"})),methods:{drawerActions:function(e){null!==e&&void 0!==e&&e.call()},disconnect:function(){this.$store.dispatch("userModule/disconnect")}}},oe=re,ie=n("5bc1"),ae=n("ce7e"),se=n("132d"),ce=n("adda"),ue=n("8860"),le=n("da13"),de=n("1800"),me=n("8270"),ve=n("5d23"),fe=n("1baa"),pe=n("34c3"),he=n("f774"),ge=n("afd9"),ke=Object(c["a"])(oe,te,ne,!1,null,null,null),we=ke.exports;l()(ke,{VApp:d["a"],VAppBarNavIcon:ie["a"],VContainer:C["a"],VDivider:ae["a"],VIcon:se["a"],VImg:ce["a"],VList:ue["a"],VListItem:le["a"],VListItemAction:de["a"],VListItemAvatar:me["a"],VListItemContent:ve["a"],VListItemGroup:fe["a"],VListItemIcon:pe["a"],VListItemSubtitle:ve["b"],VListItemTitle:ve["c"],VNavigationDrawer:he["a"],VSpacer:y["a"],VSystemBar:ge["a"]});var be={name:"Home",components:{Admin_home:ee,Manager_home:R,User_home:H,AppBar:we},computed:Object(F["a"])({},Object(A["b"])("userModule",{user:"user"}))},Te=be,Se=Object(c["a"])(Te,L,V,!1,null,null,null),Ce=Se.exports;l()(Se,{VApp:d["a"],VMain:m["a"]});var Ue=n("bc3a"),Me=n.n(Ue);r["a"].use(p["a"]);var Oe=function(e,t,n){var r=localStorage.getItem("user-token")||void 0;if(void 0!==r)return Me.a.defaults.headers.common["Authorization"]="Bearer "+r,void n();n("/login")},ye=[{path:"/",name:"Home",component:Ce,beforeEnter:Oe},{path:"/login",name:"Login",component:j,beforeEnter:function(e,t,n){var r=localStorage.getItem("user-token")||void 0;void 0!==r?n("/"):n()}}],We=new p["a"]({mode:"history",base:"",routes:ye}),_e=We,xe=(n("e9c4"),n("ac1f"),n("5319"),n("c740"),n("a434"),Me.a.create({withCredentials:!1,baseURL:"http://192.168.8.100:4000/api",headers:{Accept:"application/json","Content-Type":"application/json"}}));xe.interceptors.request.use((function(e){var t=Xe.getters["userModule/token"];return e.headers["Authorization"]="Bearer "+t,e}));var Ie=xe,je=function(){return{connectedUser:JSON.parse(localStorage.getItem("user")),currentSelectedUser:{},token:localStorage.getItem("user-token")||void 0,errorStatus:!1,errorMessage:"",userList:[]}},Le={register:function(e,t){var n=e.commit;Ie.post("/registration/signup",t).then((function(e){n("updateToken",{token:e.data.token}),n("updateConnectedUser",{user:e.data.user}),localStorage.setItem("user-token",e.data.token),localStorage.setItem("user",JSON.stringify(e.data.user)),Me.a.defaults.headers.common["Authorization"]="Bearer "+e.data.token,_e.push({path:"/"}).then((function(e){return console.log(e)}))})).catch((function(e){console.log(e),n("updateToken",{token:void 0})}))},login:function(e,t){var n=e.commit;Ie.post("/registration/signin",t).then((function(e){n("updateToken",{token:e.data.token}),n("updateConnectedUser",{user:e.data.user}),localStorage.setItem("user-token",e.data.token),localStorage.setItem("user",JSON.stringify(e.data.user)),Me.a.defaults.headers.common["Authorization"]="Bearer "+e.data.token,_e.push({path:"/"}).then((function(e){return console.log(e)}))})).catch((function(e){console.log(e),n("updateToken",{token:void 0})}))},disconnect:function(e){var t=e.commit;t("updateToken",{token:void 0}),localStorage.removeItem("user-token"),localStorage.removeItem("user"),delete Me.a.defaults.headers.common["Authorization"],_e.replace({path:"/login"}).then((function(e){return console.log(e)}))},createUser:function(e,t){var n=e.commit;Ie.post("/users",t).then((function(e){n("addToUserList",{user:e.data["data"]})})).catch((function(e){n("updateErrorStatus",e)}))},updateUserById:function(e,t){var n=e.commit;Ie.put("/users/"+t.id,t).then((function(e){n("updateUserInUserList",{user:e.data["data"]})})).catch((function(e){n("updateErrorStatus",e)}))},getAllUsers:function(e){var t=e.commit;Ie.get("/users/").then((function(e){t("setListOfUser",{users:e.data["data"]})})).catch((function(e){t("updateErrorStatus",e)}))},getUserById:function(e,t){var n=e.commit;Ie.get("/users/"+t).then((function(e){n("getUserById",{user:e.data["data"]})})).catch((function(e){void 0===t&&n("getUserById",{user:{}}),n("updateErrorStatus",e)}))},deleteUserById:function(e,t){var n=e.commit;Ie.delete("/users/"+t.id).then((function(){n("removeFromUserList",{user:t})})).catch((function(e){n("updateErrorStatus",e)}))}},Ve={updateToken:function(e,t){var n=t.token;e.loggedIn=void 0!==n,e.token=n},updateConnectedUser:function(e,t){var n=t.user;e.connectedUser=n},addToUserList:function(e,t){var n=t.user;e.userList.push(n)},updateUserInUserList:function(e,t){var n=t.user,r=e.userList.findIndex((function(e){return e.id===n.id}));Object.assign(e.userList[r],n)},setListOfUser:function(e,t){var n=t.users;e.userList=n},getUserById:function(e,t){var n=t.user;e.currentSelectedUser=n},removeFromUserList:function(e,t){for(var n=t.user,r=0;r<e.userList.length;r++)e.userList[r].id===n.id&&e.userList.splice(r,1)},updateErrorStatus:function(e,t){e.errorStatus=!e.errorStatus,e.errorMessage=t}},Fe={token:function(e){return e.token},user:function(e){return e.connectedUser},userList:function(e){return e.userList},selectedUser:function(e){return e.currentSelectedUser}},Ae={namespaced:!0,state:je,actions:Le,mutations:Ve,getters:Fe},Pe=(n("99af"),n("33d1"),n("ea98"),function(){return{currentWorkingTimes:[],currentWorkingTime:{},events:[]}}),De={getAllWorkingTimesForSelectedUser:function(e,t){var n=e.commit,r=t.user,o=t.start,i=t.end;Ie.get("/workingtimes/".concat(r.id,"?start=").concat(o,"&end=").concat(i)).then((function(e){n("updateWorkingTimes",{workingtimes:e.data["data"]})})).catch((function(e){void 0===r.id&&n("updateWorkingTimes",{workingtimes:[]}),console.log(e)}))},createWorkingTimeForSelectedUser:function(e,t){var n=e.commit,r=t.user,o=t.start,i=t.end;Ie.post("/workingtimes/".concat(r.id),{start:o,end:i}).then((function(e){n("addToWorkingTimesList",{workingtime:e.data["data"]})})).catch((function(e){console.log(e)}))},updateWorkingTimeForSelectedUser:function(e,t){var n=e.commit,r=t.event,o=t.start,i=t.end;Ie.put("/workingtimes/".concat(r.id),{start:o,end:i}).then((function(e){n("updateToWorkingTimesList",{workingtime:e.data["data"]})})).catch((function(e){console.log(e)}))},deleteWorkingTimeForSelectedUser:function(e,t){var n=e.commit;Ie.delete("/workingtimes/".concat(t.id)).then((function(){n("removeFromWorkingTimeList",{workingtime:t})})).catch((function(e){console.log(e)}))},getWorkingTimeForSelectedUser:function(e,t){var n=e.commit;Ie.get("/workingtimes/".concat(t)).then((function(e){n("getWorkingTime",{workingtime:e.data["data"]})})).catch((function(e){console.log(e)}))}},Ee={updateWorkingTimes:function(e,t){var n=t.workingtimes;e.events=[],e.currentWorkingTimes=n;for(var r=0;r<n.length;r++){var o=new Date(n.at(r).start),i=new Date(n.at(r).end);e.events.push({id:n.at(r).id,name:"WorkingTime "+n.at(r).id,start:o,end:i,color:"blue",timed:!0})}},addToWorkingTimesList:function(e,t){var n=t.workingtime;e.currentWorkingTimes=e.currentWorkingTimes.push(n);var r=new Date(n.start),o=new Date(n.end);e.events.push({id:n.id,name:"WorkingTime "+n.id,start:r,end:o,color:"blue",timed:!0})},updateToWorkingTimesList:function(e,t){var n=t.workingtime,r=e.currentWorkingTimes.findIndex((function(e){return e.id===n.id}));Object.assign(e.currentWorkingTimes[r],n);var o=e.events.findIndex((function(e){return e.id===n.id}));Object.assign(e.events[o],n);var i=e.events;e.events=[],e.events=i},removeFromWorkingTimeList:function(e,t){for(var n=t.workingtime,r=0;r<e.currentWorkingTimes.length;r++)e.currentWorkingTimes[r].id===n.id&&e.currentWorkingTimes.splice(r,1);for(var o=0;o<e.events.length;o++)e.events[o].id===n.id&&e.events.splice(o,1)},getWorkingTime:function(e,t){var n=t.workingtime;e.currentWorkingTime=n}},$e={events:function(e){return e.events},selectedWorkingTime:function(e){return e.currentWorkingTime}},Be={namespaced:!0,state:Pe,actions:De,mutations:Ee,getters:$e},He=(n("fb6a"),n("d3b7"),n("25f0"),function(){return{clocks:[],workingTimes:[],workedHoursPerMonth:[],scheduledWorkHoursPerMonth:[]}}),qe={getAllClockForUser:function(e,t){var n=e.commit;Ie.get("/clocks/"+t.id+"?all=true").then((function(e){n("updateClocks",{clocks:e.data["data"]})})).catch((function(e){void 0===t.id&&n("updateClocks",{clocks:[]}),console.log(e)}))},getAllWorkingTimesForSelectedUser:function(e,t){var n=e.commit,r=new Date,o=r.getFullYear()+"-01-01 00:00:00",i=r.getFullYear()+"-12-31 23:59:59";Ie.get("/workingtimes/".concat(t.id,"?start=").concat(o,"&end=").concat(i)).then((function(e){n("updateWorkingTimes",{workingtimes:e.data["data"]})})).catch((function(e){void 0===t.id&&n("updateWorkingTimes",{workingtimes:[]}),console.log(e)}))}},Je={updateClocks:function(e,t){var n=t.clocks;if(null!==n){e.clocks=n;for(var r=[],o=0;o<n.length-(n.length%2===0?0:1);o+=2){var i={in:n[o],out:n[o+1]};r.push(i)}if(n.length%2!==0){var a,s=new Date,c=s.toISOString().slice(0,10),u={in:n[n.length-1],out:{time:c+" "+s.getHours()+":"+s.getMinutes()+":"+s.getSeconds(),status:!1,id:(null===(a=n[n.length-1])||void 0===a?void 0:a.id)+1}};r.push(u)}var l=new Date;e.workedHoursPerMonth=[];for(var d=1;d<=12;d++){for(var m=d<10?"0"+d:d.toString(),v=new Date(l.getFullYear()+"-"+m+"-01 00:00:00").getTime(),f=new Date(l.getFullYear()+"-"+m+"-31 23:59:59").getTime(),p=0,h=0;h<r.length;h++){var g=new Date(r[h].in.time).getTime(),k=new Date(r[h].out.time).getTime();if(g>=v&&k<=f){var w=Math.floor((k-g)/1e3);p+=w/3600}}e.workedHoursPerMonth.push(p)}e.workedHoursPerMonth===[]&&(e.workedHoursPerMonth=[0,0,0,0,0,0,0,0,0,0,0,0])}},updateWorkingTimes:function(e,t){var n=t.workingtimes;e.workingTimes=n;var r=new Date;e.scheduledWorkHoursPerMonth=[];for(var o=1;o<=12;o++){for(var i=o<10?"0"+o:o.toString(),a=new Date(r.getFullYear()+"-"+i+"-01 00:00:00").getTime(),s=new Date(r.getFullYear()+"-"+i+"-31 23:59:59").getTime(),c=0,u=0;u<n.length;u++){var l=new Date(n[u].start).getTime(),d=new Date(n[u].end).getTime();if(l>=a&&d<=s){var m=Math.floor((d-l)/1e3);c+=m/3600}}e.scheduledWorkHoursPerMonth.push(c)}e.scheduledWorkHoursPerMonth===[]&&(e.scheduledWorkHoursPerMonth=[0,0,0,0,0,0,0,0,0,0,0,0])}},Ne={lineChartGetter:function(e){return e.workedHoursPerMonth},barChartGetter:function(e){return[e.workedHoursPerMonth,e.scheduledWorkHoursPerMonth]},doughnut_chart_data:function(e){return[e.workedHoursPerMonth[(new Date).getMonth()],e.scheduledWorkHoursPerMonth[(new Date).getMonth()]]}},Ye={namespaced:!0,state:He,actions:qe,mutations:Je,getters:Ne},ze=function(){return{lastClock:{status:!1}}},Re={setClockForSelectedUser:function(e,t){var n=e.commit;Ie.post("/clocks/".concat(t)).then((function(e){n("updateClock",{clock:e.data["data"]})})).catch((function(e){console.log("OOSOSOSOSS"),console.log(e.message)}))},getClockForSelectedUser:function(e,t){var n=e.commit;Ie.get("/clocks/".concat(t)).then((function(e){n("updateClock",{clock:e.data["data"]})})).catch((function(e){console.log(e)}))}},Ge={updateClock:function(e,t){var n=t.clock;null!==n&&(e.lastClock=n)}},Ke={lastClock:function(e){return e.lastClock}},Qe={namespaced:!0,state:ze,actions:Re,mutations:Ge,getters:Ke};r["a"].use(A["a"]);var Xe=new A["a"].Store({modules:{userModule:Ae,workingtimesModule:Be,chartModule:Ye,clockModule:Qe}}),Ze=n("f309");r["a"].use(Ze["a"]);var et=new Ze["a"]({});n("d1e78");r["a"].config.productionTip=!1,new r["a"]({vuetify:et,router:_e,store:Xe,render:function(e){return e(f)}}).$mount("#app")}});
//# sourceMappingURL=app.91edb169.js.map