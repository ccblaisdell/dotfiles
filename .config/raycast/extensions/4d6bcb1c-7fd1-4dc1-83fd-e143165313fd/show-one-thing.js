"use strict";var i=Object.defineProperty;var m=Object.getOwnPropertyDescriptor;var c=Object.getOwnPropertyNames;var d=Object.prototype.hasOwnProperty;var h=(e,t)=>{for(var u in t)i(e,u,{get:t[u],enumerable:!0})},f=(e,t,u,o)=>{if(t&&typeof t=="object"||typeof t=="function")for(let a of c(t))!d.call(e,a)&&a!==u&&i(e,a,{get:()=>t[a],enumerable:!(o=m(t,a))||o.enumerable});return e};var p=e=>f(i({},"__esModule",{value:!0}),e);var C={};h(C,{default:()=>l});module.exports=p(C);var n=require("@raycast/api"),r=require("react/jsx-runtime"),s=new n.Cache;function l(){let e=s.get("onething");return e?((0,n.updateCommandMetadata)({subtitle:e}),(0,r.jsx)(n.MenuBarExtra,{title:e,children:(0,r.jsx)(g,{})})):((0,n.updateCommandMetadata)({subtitle:null}),null)}function g(){return n.environment.launchType===n.LaunchType.UserInitiated&&(0,n.launchCommand)({name:"set-one-thing",type:n.LaunchType.UserInitiated}),null}0&&(module.exports={});
