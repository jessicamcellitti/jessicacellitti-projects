<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>flux · knowledge system</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=DM+Mono:ital,wght@0,300;0,400;0,500;1,400&family=DM+Sans:opsz,wght@9..40,300;9..40,400;9..40,500;9..40,600&family=Lora:ital,wght@0,400;0,500;1,400&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box;margin:0;padding:0}
html,body{height:100%;overflow:hidden;font-family:'DM Sans',sans-serif}
.page{display:none;height:100vh;flex-direction:column;overflow:hidden}
.page.active{display:flex}
#page-home{background:#141210;color:#F5F0E8}
#page-grid,#page-current,#page-pulse{background:#EDEAE4;color:#1E1C19}
@keyframes syncSpin{to{transform:rotate(360deg)}}
.hamburger{display:none;flex-direction:column;gap:5px;cursor:pointer;background:none;border:none;padding:4px}
.hamburger span{display:block;width:22px;height:1.5px;background:#B8B0A8}
.mobile-nav{position:fixed;top:0;right:0;bottom:0;width:260px;background:#141210;border-left:0.5px solid #2C2926;z-index:1000;transform:translateX(100%);transition:transform 0.3s;display:flex;flex-direction:column;padding:60px 32px 32px}
.mobile-nav.open{transform:translateX(0)}
.mobile-nav-close{position:absolute;top:16px;right:16px;background:none;border:none;color:#9B948C;font-size:20px;cursor:pointer}
.mobile-nav-overlay{position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:999;opacity:0;pointer-events:none;transition:opacity 0.3s}
.mobile-nav-overlay.open{opacity:1;pointer-events:all}
.mobile-nav-links{display:flex;flex-direction:column;gap:8px}
.mobile-nav-btn{font-family:'DM Sans',sans-serif;font-size:18px;font-weight:500;color:#9B948C;background:none;border:none;border-bottom:0.5px solid #2C2926;padding:10px 0;cursor:pointer;text-align:left;transition:color 0.2s;width:100%}
.mobile-nav-btn:hover,.mobile-nav-btn.active{color:#F5F0E8}
.mobile-nav-label{font-size:11px;font-family:'DM Mono',monospace;letter-spacing:0.1em;text-transform:uppercase;color:#9B948C;margin-bottom:16px}

:root{
  --pitch:#141210;--surface:#191714;--edge:#2C2926;
  --ash:#9B948C;--stone:#B8B0A8;--parchment:#F5F0E8;
  --canvas:#EDEAE4;--rule:#D6D1C8;--ink:#4A4540;--carbon:#1E1C19;
  --ember:#E8620A;--ember-d:#C44E04;--ember-g:rgba(232,98,10,0.1);
  --fern:#1D9E75;--signal:#C42B2B;--straw:#D4A017;
  --sans:'DM Sans',sans-serif;--mono:'DM Mono',monospace;
}
*{box-sizing:border-box;margin:0;padding:0}

body{background:var(--pitch);color:var(--parchment);font-family:var(--sans);display:flex;flex-direction:column}

/* NAV */
nav{height:52px;display:flex;align-items:center;padding:0 36px;border-bottom:0.5px solid var(--edge);flex-shrink:0;gap:14px}
.wm{font-size:22px;font-weight:500;letter-spacing:-0.05em}
.wm span{color:var(--ember)}
.nav-tag{font-family:var(--mono);font-size:14px;color:var(--ash);letter-spacing:0.06em;padding:3px 10px;border:0.5px solid var(--edge);border-radius:2px}

/* MAIN SPLIT */
.main{flex:1;display:grid;grid-template-columns:1fr 1fr;min-height:0}

/* LEFT */
.left{
  padding:52px 48px;
  display:flex;flex-direction:column;justify-content:space-between;
  border-right:0.5px solid var(--edge);
  position:relative;overflow:hidden;
}
.left-glow{
  position:absolute;width:500px;height:500px;border-radius:50%;
  background:radial-gradient(circle,rgba(232,98,10,0.07) 0%,transparent 70%);
  top:-120px;right:-120px;pointer-events:none;
}
.eyebrow{font-family:var(--mono);font-size:14px;letter-spacing:0.14em;text-transform:uppercase;color:var(--ember);margin-bottom:20px;opacity:0;animation:fu 0.5s ease forwards 0.1s}
.hero-title{font-size:clamp(44px,5vw,72px);font-weight:500;letter-spacing:-0.04em;line-height:1.0;margin-bottom:20px;opacity:0;animation:fu 0.6s ease forwards 0.25s}
.hero-title span{color:var(--ember)}
.hero-sub{font-size:15px;color:var(--stone);line-height:1.7;font-weight:300;max-width:420px;opacity:0;animation:fu 0.6s ease forwards 0.4s}
.layers{display:flex;gap:8px;flex-wrap:wrap;opacity:0;animation:fu 0.6s ease forwards 0.55s}
.ltag{font-family:var(--mono);font-size:15px;letter-spacing:0.04em;padding:8px 16px;border-radius:3px;border:0.5px solid var(--edge);color:var(--ash);cursor:pointer;transition:all 0.2s}
.ltag:hover,.ltag.on{border-color:var(--ember);color:var(--ember);background:var(--ember-g)}
.ltag .n{color:var(--ember);margin-right:8px;font-size:13px}
.cta{display:flex;gap:10px;align-items:center;opacity:0;animation:fu 0.6s ease forwards 0.7s;flex-wrap:wrap}
.btn-t{font-family:var(--mono);font-size:15px;letter-spacing:0.04em;padding:12px 28px;background:var(--ember);color:var(--pitch);border:none;border-radius:3px;cursor:pointer;font-weight:500;transition:all 0.2s}
.btn-t:hover{background:#FF7A2A;transform:translateY(-1px)}
.btn-e{font-family:var(--mono);font-size:15px;letter-spacing:0.04em;padding:12px 28px;background:transparent;color:var(--stone);border:0.5px solid var(--edge);border-radius:3px;cursor:pointer;transition:all 0.2s}
.btn-e:hover{border-color:var(--stone);color:var(--parchment)}
.btn-r{font-family:var(--mono);font-size:15px;padding:12px 14px;background:transparent;color:var(--ash);border:0.5px solid var(--edge);border-radius:3px;cursor:pointer;transition:all 0.2s}
.btn-r:hover{color:var(--stone)}

/* RIGHT */
.right{
  background:var(--canvas);
  padding:36px 40px;
  display:flex;flex-direction:column;
  gap:0;overflow-y:auto;
}
.map-label{font-family:var(--mono);font-size:14px;letter-spacing:0.14em;text-transform:uppercase;color:var(--ash);margin-bottom:14px}

.same-tool-wrapper{
  border:1px solid rgba(232,98,10,0.2);
  border-radius:12px;
  padding:16px;
  background:rgba(232,98,10,0.03);
  position:relative;
  display:flex;
  flex-direction:column;
  gap:0;
}
.same-tool-label{
  position:absolute;
  top:-10px;left:16px;
  font-family:var(--mono);font-size:10px;
  letter-spacing:0.1em;text-transform:uppercase;
  color:var(--ember-d);
  background:var(--canvas);
  padding:0 8px;
}
.sources{display:grid;grid-template-columns:repeat(3,1fr);gap:8px}
.src{background:var(--parchment);border:0.5px solid var(--rule);border-radius:8px;padding:14px 16px}
.src-t{font-size:15px;font-weight:500;color:var(--carbon);letter-spacing:-0.01em}
.src-s{font-size:14px;font-family:var(--mono);color:var(--ash);margin-top:3px}

.conn{height:28px;display:flex;justify-content:center;align-items:center;position:relative}
.conn::after{content:'';position:absolute;left:50%;top:0;bottom:0;width:0.5px;background:linear-gradient(to bottom,var(--rule),var(--ink));opacity:0.4}
.conn-arrow{position:relative;z-index:1;background:var(--canvas);padding:0 10px;font-size:14px;color:var(--ink);opacity:0.5}
.conn-wide{height:28px;position:relative}
.conn-wide::before{content:'';position:absolute;left:5%;right:5%;top:0;height:0.5px;background:var(--rule);opacity:0.4}
.conn-wide::after{content:'';position:absolute;left:50%;top:0;bottom:0;width:0.5px;background:linear-gradient(to bottom,var(--rule),var(--canvas));opacity:0.4}

.lnode{border-radius:10px;padding:18px 20px;cursor:pointer;transition:all 0.2s;position:relative;border:0.5px solid var(--edge)}
.lnode:hover{transform:translateX(3px)}
.lnode-dark{background:var(--pitch)}
.lnode-mid{background:var(--carbon)}
.lnode-ey{font-family:var(--mono);font-size:13px;letter-spacing:0.12em;text-transform:uppercase;color:var(--ember);margin-bottom:4px}
.lnode-t{font-size:19px;font-weight:500;letter-spacing:-0.02em;color:var(--parchment)}
.lnode-d{font-size:14px;color:var(--ash);font-family:var(--mono);margin-top:5px;letter-spacing:0.02em;line-height:1.55}
.lnode-arr{position:absolute;right:18px;top:50%;transform:translateY(-50%);color:var(--ember);opacity:0.5;font-size:16px;transition:all 0.2s}
.lnode:hover .lnode-arr{opacity:1;right:14px}

.dist{display:grid;grid-template-columns:repeat(3,1fr);gap:6px}
.dn{background:var(--parchment);border:0.5px solid var(--rule);border-radius:8px;padding:10px 14px}
.dn-t{font-size:15px;font-weight:500;color:var(--carbon);letter-spacing:-0.01em}
.dn-s{font-size:13px;font-family:var(--mono);color:var(--ash);margin-top:2px}
.dn-kb{background:#F5FFF9;border-color:rgba(29,158,117,0.3)}
.dn-kb .dn-s{color:var(--fern)}

.pulse-node{border-radius:10px;padding:18px 20px;background:var(--pitch);border:0.5px solid var(--edge);cursor:pointer;transition:all 0.2s;position:relative}
.pulse-node:hover{transform:translateX(3px)}
.pulse-grid{
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:10px;
  margin-bottom:6px;
}
.pulse-item{
  background:var(--surface);
  border:0.5px solid var(--edge);
  border-radius:6px;
  padding:10px 12px;
}
.pulse-item-title{
  font-size:13px;
  font-weight:500;
  color:var(--parchment);
  letter-spacing:-0.01em;
  margin-bottom:3px;
}
.pulse-item-sub{
  font-size:12px;
  font-family:var(--mono);
  color:var(--ash);
  line-height:1.5;
  letter-spacing:0.01em;
}

.loops{display:flex;gap:6px;flex-wrap:wrap;margin-top:8px}
.prod-zone{
  border:1.5px dashed var(--rule);
  border-radius:10px;
  padding:16px 20px;
  background:transparent;
  position:relative;
}
.prod-label{
  font-family:var(--mono);
  font-size:11px;
  letter-spacing:0.14em;
  text-transform:uppercase;
  color:var(--ash);
  background:var(--canvas);
  padding:0 8px;
  position:absolute;
  top:-9px;
  left:16px;
}
.prod-modes{
  display:grid;
  grid-template-columns:1fr auto 1fr auto 1fr;
  gap:0;
  align-items:center;
}
.prod-mode{padding:4px 8px}
.prod-mode-title{
  font-size:13px;
  font-weight:500;
  color:var(--ink);
  letter-spacing:-0.01em;
  margin-bottom:3px;
}
.prod-mode-sub{
  font-size:12px;
  font-family:var(--mono);
  color:var(--ash);
  line-height:1.4;
}
.prod-divider{
  width:0.5px;
  height:36px;
  background:var(--rule);
  margin:0 8px;
}
.lnode.dim{opacity:0.35;transform:none}

/* distribution — paired rows */
.dist-section{display:flex;flex-direction:column;gap:8px}
.dist-section-label{
  font-family:var(--mono);
  font-size:12px;
  letter-spacing:0.12em;
  text-transform:uppercase;
  color:var(--ash);
  margin-bottom:2px;
}
.dist-pair{display:flex;align-items:center;gap:10px}
.dist-pair-label{
  font-family:var(--mono);
  font-size:11px;
  letter-spacing:0.08em;
  text-transform:uppercase;
  color:var(--rule);
  width:52px;
  flex-shrink:0;
  text-align:right;
}
.dist-pair-row{
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:6px;
  flex:1;
}
.gc{
  background:var(--parchment);
  border:0.5px solid var(--rule);
  border-radius:6px;
  padding:7px 10px;
  display:flex;
  align-items:baseline;
  gap:8px;
}
.gc-t{
  font-size:12px;
  font-weight:500;
  color:var(--carbon);
  letter-spacing:-0.01em;
  white-space:nowrap;
}
.gc-s{
  font-size:11px;
  font-family:var(--mono);
  color:var(--ash);
}
.gc-kb{
  background:#F5FFF9;
  border-color:rgba(29,158,117,0.3);
}
.gc-kb .gc-s{color:var(--fern)}
.pulse-node.dim{opacity:0.35;transform:none}
.lnode.lit{border-color:var(--ember);box-shadow:0 0 0 1px rgba(232,98,10,0.2)}
.pulse-node.lit{border-color:var(--ember);box-shadow:0 0 0 1px rgba(232,98,10,0.2)}
.src.lit{border-color:rgba(232,98,10,0.5);background:#FDF5EE}
.src.dim{opacity:0.35}
.gc.lit{border-color:rgba(232,98,10,0.4);background:#FDF5EE}
.gc.dim{opacity:0.35}
.loop{font-family:var(--mono);font-size:12px;color:var(--ink);padding:4px 10px;border:0.5px dashed var(--rule);border-radius:2px;letter-spacing:0.04em}
.loop span{color:var(--ember-d);margin-right:3px}

/* TOUR */
.tour{position:fixed;inset:0;background:rgba(20,18,16,0.92);backdrop-filter:blur(8px);z-index:200;display:flex;align-items:center;justify-content:center;opacity:0;pointer-events:none;transition:opacity 0.3s}
.tour.on{opacity:1;pointer-events:all}
.tour-card{background:var(--surface);border:0.5px solid var(--edge);border-radius:12px;padding:44px;max-width:520px;width:90%;position:relative;transform:translateY(16px);transition:transform 0.3s}
.tour.on .tour-card{transform:translateY(0)}
.t-ey{font-family:var(--mono);font-size:13px;letter-spacing:0.14em;text-transform:uppercase;color:var(--ember);margin-bottom:16px}
.t-title{font-size:26px;font-weight:500;letter-spacing:-0.03em;color:var(--parchment);margin-bottom:12px;line-height:1.2}
.t-body{font-size:15px;color:var(--stone);line-height:1.75;margin-bottom:32px}
.t-actions{display:flex;gap:10px;align-items:center}
.t-next{font-family:var(--mono);font-size:15px;padding:11px 26px;background:var(--ember);color:var(--pitch);border:none;border-radius:3px;cursor:pointer;font-weight:500;transition:background 0.2s;letter-spacing:0.04em}
.t-next:hover{background:#FF7A2A}
.t-skip{font-family:var(--mono);font-size:13px;color:var(--ash);cursor:pointer;background:none;border:none;padding:11px 10px;transition:color 0.2s;letter-spacing:0.04em}
.t-skip:hover{color:var(--stone)}
.t-dots{display:flex;gap:6px;margin-left:auto;align-items:center}
.t-dot{width:6px;height:6px;border-radius:50%;background:var(--edge);transition:background 0.2s}
.t-dot.on{background:var(--ember)}
.t-close{position:absolute;top:16px;right:16px;background:none;border:none;color:var(--ash);cursor:pointer;font-size:18px;padding:4px;transition:color 0.2s;line-height:1}
.t-close:hover{color:var(--parchment)}

/* PAGE TRANSITIONS */


@keyframes fu{from{opacity:0;transform:translateY(14px)}to{opacity:1;transform:translateY(0)}}

.right::-webkit-scrollbar{width:4px}
.right::-webkit-scrollbar-track{background:var(--canvas)}
.right::-webkit-scrollbar-thumb{background:var(--rule);border-radius:2px}


:root{
  --pitch:#141210;--surface:#191714;--edge:#2C2926;
  --ash:#9B948C;--stone:#B8B0A8;--parchment:#F5F0E8;
  --canvas:#EDEAE4;--paper:#FEFCF9;--rule:#D6D1C8;
  --ink:#4A4540;--carbon:#1E1C19;
  --ember:#E8620A;--ember-d:#C44E04;--ember-g:rgba(232,98,10,0.08);
  --fern:#1D9E75;--fern-g:rgba(29,158,117,0.08);
  --signal:#C42B2B;--signal-g:rgba(196,43,43,0.08);
  --straw:#D4A017;--straw-g:rgba(212,160,23,0.08);
  --sans:'DM Sans',sans-serif;--mono:'DM Mono',monospace;
  --radius:10px;
}
*{box-sizing:border-box;margin:0;padding:0}



/* ── NAV ── */
nav{
  height:54px;display:flex;align-items:center;
  padding:0 36px;background:var(--pitch);
  border-bottom:0.5px solid var(--edge);
  flex-shrink:0;gap:14px;z-index:10;
}
.wm{font-size:20px;font-weight:500;letter-spacing:-0.05em;color:var(--parchment);text-decoration:none;font-family:var(--sans)}
.wm span{color:var(--ember)}
.nav-div{width:0.5px;height:18px;background:var(--edge)}
.nav-links{display:flex;gap:24px}
.nl{font-family:var(--sans);font-size:14px;color:var(--ash);letter-spacing:0.01em;cursor:pointer;transition:color 0.2s;background:none;border:none;padding:0;text-decoration:none}
.nl:hover{color:var(--stone)}
.nl.active{color:var(--parchment)}
.nav-r{margin-left:auto}
.sync-btn{
  font-family:var(--sans);font-size:14px;color:var(--ember);
  border:0.5px solid rgba(232,98,10,0.5);padding:8px 18px;
  border-radius:3px;cursor:pointer;background:transparent;
  transition:all 0.2s;letter-spacing:0.04em;display:flex;align-items:center;gap:7px;
}
.sync-btn:hover{background:var(--ember-g)}
.sync-btn.syncing{color:var(--straw);border-color:var(--straw);pointer-events:none}
.sync-icon{display:inline-block}
.sync-btn.syncing .sync-icon{animation:spin 1s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}

/* ── TOOLBAR ── */
.toolbar{
  padding:14px 36px;
  background:#FFFFFF;
  border-bottom:0.5px solid var(--rule);
  display:flex;align-items:center;gap:10px;
  flex-wrap:wrap;flex-shrink:0;
}
.toolbar-left{display:flex;align-items:center;gap:8px;flex:1;flex-wrap:wrap}
.toolbar-right{display:flex;align-items:center;gap:8px;flex-shrink:0}

select{
  font-family:var(--sans);font-size:14px;font-weight:500;color:var(--ink);
  background:var(--canvas);border:0.5px solid var(--rule);
  padding:7px 30px 7px 13px;border-radius:6px;cursor:pointer;
  appearance:none;-webkit-appearance:none;
  background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%239B948C'/%3E%3C/svg%3E");
  background-repeat:no-repeat;background-position:right 10px center;
  transition:border-color 0.2s;
}
select:focus{outline:none;border-color:var(--ember)}
select.active{border-color:var(--ember);color:var(--carbon);background-color:rgba(232,98,10,0.04)}

.view-toggle{display:flex;border:0.5px solid var(--rule);border-radius:6px;overflow:hidden}
.vt-btn{
  font-size:16px;padding:7px 12px;
  background:var(--canvas);color:var(--ash);border:none;cursor:pointer;
  transition:all 0.2s;line-height:1;
}
.vt-btn.on{background:var(--carbon);color:var(--parchment)}

/* ── STATS BAR ── */
.stats-bar{
  padding:10px 36px;background:var(--carbon);
  border-bottom:0.5px solid var(--edge);
  border-top:2px solid var(--ember);
  display:flex;align-items:center;gap:12px;flex-shrink:0;
}
.stats-count{font-size:14px;font-weight:500;color:var(--stone)}
.stats-count strong{color:var(--parchment);font-weight:500}
.stats-pills{display:flex;gap:6px;flex-wrap:wrap}
.sp{font-size:13px;padding:5px 13px;border-radius:20px;letter-spacing:0.01em;user-select:none;text-transform:lowercase}

/* page framing */
.page-framing{
  background:var(--pitch);
  border-bottom:0.5px solid var(--edge);
  padding:20px 36px;
  flex-shrink:0;
}
.page-framing-inner{
  display:flex;align-items:baseline;gap:20px;flex-wrap:wrap;
}
.pf-title{
  font-size:22px;font-weight:500;
  color:var(--parchment);letter-spacing:-0.03em;
  flex-shrink:0;
}
.pf-desc{
  font-size:15px;color:var(--stone);
  line-height:1.6;max-width:520px;
}

/* tabs */
.tabs{
  display:flex;gap:0;
  background:var(--pitch);
  border-bottom:0.5px solid var(--edge);
  padding:0 36px;
  flex-shrink:0;
}
.tab{
  font-family:var(--sans);font-size:14px;font-weight:500;
  color:var(--ash);background:none;border:none;
  padding:12px 20px;cursor:pointer;
  border-bottom:2px solid transparent;
  transition:all 0.2s;letter-spacing:0.01em;
  margin-bottom:-0.5px;
}
.tab:hover{color:var(--stone)}
.tab.active{color:var(--parchment);border-bottom-color:var(--ember)}

/* outputs view */
.outputs-view{
  flex:1;overflow-y:auto;padding:28px 36px;
  background:var(--canvas);
}
.outputs-view::-webkit-scrollbar{width:4px}
.outputs-view::-webkit-scrollbar-track{background:var(--canvas)}
.outputs-view::-webkit-scrollbar-thumb{background:var(--rule);border-radius:2px}
.ov-grid{display:flex;flex-direction:column;gap:20px}
.ov-pair{display:grid;grid-template-columns:1fr 1fr;gap:14px}
.ov-pair-label{
  font-size:12px;font-weight:600;letter-spacing:0.1em;
  text-transform:uppercase;color:var(--ash);
  margin-bottom:8px;
}
.ov-card{
  background:var(--paper);border:0.5px solid var(--rule);
  border-radius:var(--radius);padding:20px 22px;
  position:relative;overflow:hidden;
}
.ov-card::before{
  content:'';position:absolute;top:0;left:0;right:0;height:3px;
}
.ov-workreamp::before{background:#4A90E2}
.ov-notion::before{background:#1E1C19}
.ov-gitbook::before{background:#3884FF}
.ov-slack::before{background:#4A154B}
.ov-loops::before{background:#FF4F00}
.ov-tool{
  display:flex;align-items:center;gap:10px;margin-bottom:14px;
}
.ov-tool-name{font-size:17px;font-weight:500;color:var(--carbon);letter-spacing:-0.02em}
.ov-tool-type{font-size:13px;color:var(--ash)}
.ov-blocks{display:flex;flex-direction:column;gap:6px}
.ov-block-row{
  display:flex;align-items:center;gap:10px;
  padding:8px 12px;background:var(--canvas);
  border-radius:6px;border:0.5px solid var(--rule);
  cursor:pointer;transition:all 0.15s;
}
.ov-block-row:hover{border-color:var(--ember-d);background:rgba(232,98,10,0.03)}
.ov-block-title{font-size:14px;font-weight:500;color:var(--carbon);flex:1;letter-spacing:-0.01em}
.ov-block-count{font-size:13px;color:var(--ash);margin-top:8px;font-style:italic}
.sp-current{background:rgba(29,158,117,0.2);color:#4DCEA0;border:0.5px solid rgba(29,158,117,0.4);cursor:pointer;transition:all 0.2s}
.sp-current:hover,.sp-current.active{background:rgba(29,158,117,0.35);border-color:#1D9E75}
.sp-flagged{background:rgba(196,43,43,0.2);color:#F07070;border:0.5px solid rgba(196,43,43,0.4);cursor:pointer;transition:all 0.2s}
.sp-flagged:hover,.sp-flagged.active{background:rgba(196,43,43,0.35);border-color:#C42B2B}
.sp-review{background:rgba(212,160,23,0.2);color:#E8C060;border:0.5px solid rgba(212,160,23,0.4);cursor:pointer;transition:all 0.2s}
.sp-review:hover,.sp-review.active{background:rgba(212,160,23,0.35);border-color:#D4A017}
.sp-needs{background:rgba(144,24,24,0.2);color:#F09090;border:0.5px solid rgba(144,24,24,0.4);cursor:pointer;transition:all 0.2s}
.sp-needs:hover,.sp-needs.active{background:rgba(144,24,24,0.35);border-color:#901818}
.clear-btn{font-size:13px;color:var(--ash);cursor:pointer;margin-left:auto;background:none;border:none;display:none;letter-spacing:0.01em;transition:color 0.2s}
.clear-btn:hover{color:var(--stone)}
.clear-btn.show{display:block}

/* ── GRID AREA ── */
.grid-area{flex:1;overflow-y:auto;padding:28px 36px}
.grid-area::-webkit-scrollbar{width:4px}
.grid-area::-webkit-scrollbar-track{background:var(--canvas)}
.grid-area::-webkit-scrollbar-thumb{background:var(--rule);border-radius:2px}

/* ── CARD GRID ── */
.card-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:14px}
.card-list{display:flex;flex-direction:column;gap:8px}

/* ── BLOCK CARD ── */
.block-card{
  background:var(--paper);
  border:0.5px solid var(--rule);
  border-radius:var(--radius);
  padding:20px 22px 18px 26px;
  cursor:pointer;transition:all 0.2s;
  position:relative;overflow:hidden;
}
.block-card::before{
  content:'';position:absolute;left:0;top:0;bottom:0;width:5px;
  border-radius:var(--radius) 0 0 var(--radius);
}
.block-card.s-current::before{background:var(--fern)}
.block-card.s-flagged::before{background:var(--signal)}
.block-card.s-in-review::before{background:var(--straw)}
.block-card.s-needs-update::before{background:#901818}
.block-card:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(0,0,0,0.07)}
.block-card.s-current{background:#F4FBF7;border-color:rgba(29,158,117,0.15)}
.block-card.s-flagged{background:#FFF7F7;border-color:rgba(196,43,43,0.15)}
.block-card.s-needs-update{background:#FFF4F4;border-color:rgba(144,24,24,0.15)}
.block-card.s-in-review{background:#FFFCF0;border-color:rgba(212,160,23,0.15)}

.block-card.scanning{animation:scanPulse 0.35s ease}
.block-card.newly-flagged{background:#FFF7F7;border-color:rgba(196,43,43,0.3);animation:flagAppear 0.6s ease forwards}
.block-card.newly-flagged::before{background:var(--signal)}
@keyframes scanPulse{
  0%{background:var(--paper)}
  50%{background:rgba(232,98,10,0.05);border-color:rgba(232,98,10,0.25)}
  100%{background:var(--paper)}
}
@keyframes flagAppear{
  0%{background:var(--paper);border-color:var(--rule)}
  40%{background:rgba(196,43,43,0.06)}
  100%{background:#FFF7F7;border-color:rgba(196,43,43,0.3)}
}

.card-eyebrow{font-family:var(--sans);font-size:13px;color:var(--ash);letter-spacing:0.01em;margin-bottom:8px}
.card-title{font-size:17px;font-weight:500;color:var(--carbon);letter-spacing:-0.02em;margin-bottom:12px;line-height:1.25}
.card-status-row{display:flex;align-items:center;gap:6px;margin-bottom:6px}
.card-audience{font-size:13px;color:var(--ash);text-transform:lowercase}
.card-footer{display:flex;align-items:center;justify-content:space-between;margin-top:14px;padding-top:12px;border-top:0.5px solid var(--rule)}
.card-date{font-family:var(--sans);font-size:13px;color:var(--ash)}
.card-type{font-size:12px;color:var(--ash)}

/* ── LIST CARD ── */
.list-card{
  background:var(--paper);border:0.5px solid var(--rule);
  border-radius:8px;padding:14px 18px 14px 22px;
  cursor:pointer;transition:all 0.2s;
  position:relative;overflow:hidden;
  display:flex;align-items:center;gap:16px;
}
.list-card::before{
  content:'';position:absolute;left:0;top:0;bottom:0;width:5px;
  border-radius:8px 0 0 8px;
}
.list-card.s-current::before{background:var(--fern)}
.list-card.s-flagged::before{background:var(--signal)}
.list-card.s-in-review::before{background:var(--straw)}
.list-card.s-needs-update::before{background:#901818}
.list-card:hover{transform:translateX(2px)}
.list-card.s-current{background:#F4FBF7;border-color:rgba(29,158,117,0.15)}
.list-card.s-flagged{background:#FFF7F7;border-color:rgba(196,43,43,0.15)}
.list-card.s-needs-update{background:#FFF4F4;border-color:rgba(144,24,24,0.15)}
.list-card.s-in-review{background:#FFFCF0;border-color:rgba(212,160,23,0.15)}
.list-card.scanning{animation:scanPulse 0.35s ease}
.list-card.newly-flagged{background:#FFF7F7;border-color:rgba(196,43,43,0.3);animation:flagAppear 0.6s ease forwards}
.list-card.newly-flagged::before{background:var(--signal)}
.lc-id{font-family:var(--mono);font-size:13px;color:var(--ash);width:48px;flex-shrink:0}
.lc-title{font-size:15px;font-weight:500;color:var(--carbon);letter-spacing:-0.01em;flex:1}
.lc-status{flex-shrink:0}
.lc-audience{font-size:13px;color:var(--ash);flex-shrink:0;width:64px;text-transform:lowercase}
.lc-date{font-family:var(--sans);font-size:13px;color:var(--ash);width:100px;text-align:right;flex-shrink:0}

/* ── STATUS TAGS ── */
.stag{
  display:inline-flex;align-items:center;gap:5px;
  font-size:13px;padding:4px 11px;border-radius:20px;
  letter-spacing:0.01em;white-space:nowrap;text-transform:lowercase;
}
.stag-dot{width:6px;height:6px;border-radius:50%;flex-shrink:0}
.st-current{background:var(--fern-g);color:#0A6644;border:0.5px solid rgba(29,158,117,0.3)}
.st-flagged{background:var(--signal-g);color:var(--signal);border:0.5px solid rgba(196,43,43,0.3)}
.st-in-review{background:var(--straw-g);color:#7A4E08;border:0.5px solid rgba(212,160,23,0.3)}
.st-needs-update{background:#FDE8E8;color:#901818;border:0.5px solid rgba(144,24,24,0.3)}

/* tier tags — outline only */
.ttag{font-family:var(--sans);font-size:13px;padding:4px 11px;border-radius:20px;letter-spacing:0.01em;white-space:nowrap;text-transform:lowercase}
.tt-pass{font-family:var(--sans);color:var(--ash);border:1.5px dotted var(--rule);background:transparent}
.tt-review{font-family:var(--sans);color:var(--ink);border:0.5px solid var(--rule);background:transparent}
.tt-rebuild{font-family:var(--sans);color:var(--carbon);border:0.5px solid #9B948C;background:transparent;font-weight:600}

/* version */
.vtag{font-family:var(--mono);font-size:13px;color:var(--ember-d);padding:4px 10px;border:0.5px solid rgba(232,98,10,0.3);border-radius:20px;background:transparent;text-transform:lowercase}

/* ── EMPTY STATE ── */
.empty{display:flex;flex-direction:column;align-items:center;justify-content:center;padding:80px 20px;text-align:center;grid-column:1/-1}
.empty-title{font-size:18px;font-weight:500;color:var(--carbon);margin-bottom:8px}
.empty-sub{font-size:14px;color:var(--ash)}

/* ── MODAL ── */
.modal-overlay{
  position:fixed;inset:0;background:rgba(20,18,16,0.65);
  backdrop-filter:blur(8px);z-index:100;
  display:flex;align-items:flex-start;justify-content:center;
  opacity:0;pointer-events:none;transition:opacity 0.25s;
  padding:48px 24px 24px;
  overflow-y:auto;
}
.modal-overlay.on{opacity:1;pointer-events:all}
.modal{
  background:var(--paper);border-radius:16px;
  border:0.5px solid var(--rule);
  width:100%;max-width:700px;
  transform:translateY(24px) scale(0.97);
  transition:transform 0.25s;
  box-shadow:0 24px 60px rgba(0,0,0,0.12);
  flex-shrink:0;
  margin:auto 0;
}
.modal-overlay.on .modal{transform:translateY(0) scale(1)}
.modal-overlay::-webkit-scrollbar{width:4px}
.modal-overlay::-webkit-scrollbar-track{background:transparent}
.modal-overlay::-webkit-scrollbar-thumb{background:var(--edge);border-radius:2px}

.modal-header{
  padding:32px 36px 24px;
  border-bottom:0.5px solid var(--rule);
  position:sticky;top:0;
  background:var(--paper);
  border-radius:16px 16px 0 0;z-index:1;
}
.modal-eyebrow{font-family:var(--sans);font-size:13px;color:var(--ash);letter-spacing:0.02em;margin-bottom:10px}
.modal-title{font-size:26px;font-weight:500;color:var(--carbon);letter-spacing:-0.03em;margin-bottom:16px;line-height:1.1}
.modal-meta{display:flex;align-items:center;gap:8px;flex-wrap:wrap}
.modal-close{
  position:absolute;top:24px;right:24px;
  background:var(--canvas);border:0.5px solid var(--rule);
  color:var(--ink);cursor:pointer;font-size:15px;
  width:30px;height:30px;border-radius:6px;
  display:flex;align-items:center;justify-content:center;
  transition:all 0.2s;
}
.modal-close:hover{background:var(--rule)}

.modal-body{padding:28px 36px 36px}

.ms{margin-bottom:28px}
.ms:last-child{margin-bottom:0}
.ms-label{
  font-size:12px;font-weight:600;letter-spacing:0.08em;
  text-transform:uppercase;color:var(--ash);
  margin-bottom:10px;
}
.ms-value{font-size:15px;color:var(--carbon);line-height:1.75}
.ms-mono{font-family:var(--mono);font-size:14px;color:var(--ink);line-height:1.7}
.ms-divider{height:0.5px;background:var(--rule);margin:28px 0}

/* version history */
.vh{display:flex;flex-direction:column;gap:8px}
.vh-item{
  display:grid;grid-template-columns:44px 88px 1fr;
  align-items:start;gap:12px;
  padding:12px 14px;background:var(--canvas);
  border-radius:8px;border:0.5px solid var(--rule);
}
.vh-item.current{background:rgba(29,158,117,0.06);border-color:rgba(29,158,117,0.25)}
.vh-v{font-family:var(--mono);font-size:14px;color:var(--ember-d);font-weight:500}
.vh-item.current .vh-v{color:#0A6644}
.vh-date{font-family:var(--sans);font-size:13px;color:var(--ash)}
.vh-note{font-size:14px;color:var(--ink);line-height:1.55}

/* outputs */
.outputs{display:flex;flex-direction:column;gap:8px}
.output-row{
  display:flex;align-items:center;gap:12px;
  padding:12px 16px;background:var(--canvas);
  border-radius:8px;border:0.5px solid var(--rule);
}
.or-channel{font-size:15px;font-weight:500;color:var(--carbon);flex:1;letter-spacing:-0.01em}
.or-links{display:flex;gap:8px}
.or-link{
  font-family:var(--sans);font-size:13px;font-weight:500;
  padding:5px 14px;border-radius:4px;cursor:pointer;
  border:0.5px solid var(--rule);color:var(--ink);
  background:var(--paper);transition:all 0.2s;
  text-decoration:none;letter-spacing:0.01em;
}
.or-link:hover{border-color:var(--ember-d);color:var(--ember-d)}
.or-link.share{color:var(--fern);border-color:rgba(29,158,117,0.3);background:rgba(29,158,117,0.04)}
.or-link.share:hover{border-color:var(--fern);background:rgba(29,158,117,0.08)}

/* share link box */
.share-box{
  display:flex;align-items:center;gap:10px;
  padding:14px 16px;background:var(--canvas);
  border-radius:8px;border:0.5px solid var(--rule);
  margin-bottom:8px;
}
.sb-url{font-family:var(--mono);font-size:15px;color:var(--ember-d);flex:1}
.sb-copy{
  font-family:var(--sans);font-size:13px;font-weight:500;color:var(--ash);
  background:var(--paper);border:0.5px solid var(--rule);
  padding:6px 14px;border-radius:4px;cursor:pointer;
  transition:all 0.2s;letter-spacing:0.01em;white-space:nowrap;
}
.sb-copy:hover{color:var(--carbon);border-color:var(--carbon)}
.sb-note{font-size:13px;color:var(--ash);line-height:1.6}

/* ── SYNC TOAST ── */
.toast{
  position:fixed;bottom:28px;right:28px;
  background:var(--pitch);border:0.5px solid var(--edge);
  border-radius:10px;padding:16px 20px;z-index:200;
  transform:translateY(80px);opacity:0;transition:all 0.3s;
  max-width:300px;min-width:220px;
}
.toast.show{transform:translateY(0);opacity:1}
.toast-title{font-size:14px;font-weight:600;color:var(--ember);margin-bottom:5px}
.toast-body{font-family:var(--sans);font-size:13px;color:var(--stone);line-height:1.6}

/* ── MOBILE ── */
.link-popup{
  position:fixed;
  background:var(--carbon);
  color:var(--parchment);
  padding:12px 16px;
  border-radius:8px;
  font-size:13px;
  line-height:1.6;
  max-width:300px;
  white-space:pre-line;
  z-index:300;
  opacity:0;
  transform:translateY(6px) scale(0.96);
  transition:opacity 0.18s, transform 0.18s;
  pointer-events:none;
  box-shadow:0 8px 24px rgba(0,0,0,0.25);
}
.link-popup.show{
  opacity:1;
  transform:translateY(0) scale(1);
}


.sync-nudge{
  position:fixed;
  top:100px;right:28px;
  background:var(--pitch);
  border:0.5px solid var(--ember);
  border-radius:10px;
  padding:18px 20px;
  max-width:240px;
  z-index:150;
  opacity:0;
  transform:translateY(-8px);
  transition:all 0.4s;
  pointer-events:none;
  box-shadow:0 8px 32px rgba(0,0,0,0.2);
}
.sync-nudge.show{
  opacity:1;
  transform:translateY(0);
  pointer-events:all;
}
.sn-arrow{
  font-size:18px;color:var(--ember);
  margin-bottom:6px;
  animation:bounce 1.5s ease infinite;
}
@keyframes bounce{
  0%,100%{transform:translateY(0)}
  50%{transform:translateY(-4px)}
}
.sn-title{
  font-size:15px;font-weight:600;
  color:var(--parchment);
  margin-bottom:6px;
  letter-spacing:-0.01em;
}
.sn-body{
  font-size:13px;color:var(--stone);
  line-height:1.6;margin-bottom:14px;
}
.sn-cta{
  font-family:var(--sans);font-size:13px;font-weight:500;
  color:var(--pitch);background:var(--ember);
  border:none;border-radius:3px;
  padding:7px 14px;cursor:pointer;
  letter-spacing:0.04em;width:100%;
  transition:background 0.2s;
}
.sn-cta:hover{background:#FF7A2A}
.sn-close{
  position:absolute;top:10px;right:10px;
  background:none;border:none;
  color:var(--ash);cursor:pointer;
  font-size:14px;line-height:1;
  transition:color 0.2s;
}
.sn-close:hover{color:var(--parchment)}

/* PAGE TRANSITIONS */


/* MOBILE NAV */
.hamburger{display:none;flex-direction:column;gap:5px;cursor:pointer;background:none;border:none;padding:4px}
.hamburger span{display:block;width:22px;height:1.5px;background:var(--stone);transition:all 0.2s}
.mobile-nav{position:fixed;top:0;right:0;bottom:0;width:260px;background:var(--pitch);border-left:0.5px solid var(--edge);z-index:200;transform:translateX(100%);transition:transform 0.3s ease;display:flex;flex-direction:column;padding:60px 32px 32px}
.mobile-nav.open{transform:translateX(0)}
.mobile-nav-close{position:absolute;top:16px;right:16px;background:none;border:none;color:var(--ash);font-size:20px;cursor:pointer;padding:4px;transition:color 0.2s}
.mobile-nav-close:hover{color:var(--parchment)}
.mobile-nav-overlay{position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:199;opacity:0;pointer-events:none;transition:opacity 0.3s}
.mobile-nav-overlay.open{opacity:1;pointer-events:all}
.mobile-nav-links{display:flex;flex-direction:column;gap:8px}
.mobile-nav-link{font-family:var(--sans);font-size:18px;font-weight:500;color:var(--ash);text-decoration:none;padding:10px 0;border-bottom:0.5px solid var(--edge);transition:color 0.2s}
.mobile-nav-link:hover,.mobile-nav-link.active{color:var(--parchment)}
.mobile-nav-label{font-size:11px;font-family:var(--mono);letter-spacing:0.1em;text-transform:uppercase;color:var(--ash);margin-bottom:16px}



:root{
  --pitch:#141210;--surface:#191714;--edge:#2C2926;
  --ash:#9B948C;--stone:#B8B0A8;--parchment:#F5F0E8;
  --canvas:#EDEAE4;--paper:#FEFCF9;--rule:#D6D1C8;
  --ink:#4A4540;--carbon:#1E1C19;
  --ember:#E8620A;--ember-d:#C44E04;--ember-g:rgba(232,98,10,0.08);
  --fern:#1D9E75;--fern-g:rgba(29,158,117,0.08);
  --signal:#C42B2B;--straw:#D4A017;
  --eng:#3B5BDB;--eng-g:rgba(59,91,219,0.06);--eng-border:rgba(59,91,219,0.2);
  --sans:'DM Sans',sans-serif;
  --serif:'Lora',serif;
  --mono:'DM Mono',monospace;
}
*{box-sizing:border-box;margin:0;padding:0}



/* NAV */
nav{
  height:54px;display:flex;align-items:center;
  padding:0 36px;background:var(--pitch);
  border-bottom:0.5px solid var(--edge);
  flex-shrink:0;gap:14px;z-index:10;
}
.wm{font-size:20px;font-weight:500;letter-spacing:-0.05em;color:var(--parchment);text-decoration:none}
.wm span{color:var(--ember)}
.nav-div{width:0.5px;height:18px;background:var(--edge)}
.nav-links{display:flex;gap:24px}
.nl{font-family:var(--sans);font-size:14px;color:var(--ash);cursor:pointer;transition:color 0.2s;background:none;border:none;padding:0;text-decoration:none}
.nl:hover{color:var(--stone)}
.nl.active{color:var(--parchment);font-weight:500}

/* PAGE HEADER */
.page-header{
  background:var(--pitch);
  border-bottom:0.5px solid var(--edge);
  padding:22px 36px;
  flex-shrink:0;
  display:flex;align-items:flex-start;justify-content:space-between;
  flex-wrap:wrap;gap:16px;
}
.ph-title{font-size:22px;font-weight:500;color:var(--parchment);letter-spacing:-0.03em;margin-bottom:5px}
.ph-desc{font-size:15px;color:var(--stone);line-height:1.6;max-width:560px}
.view-toggle{
  display:flex;background:var(--surface);
  border:0.5px solid var(--edge);border-radius:6px;overflow:hidden;flex-shrink:0;
}
.vt{font-family:var(--sans);font-size:14px;font-weight:500;color:var(--ash);background:none;border:none;padding:9px 20px;cursor:pointer;transition:all 0.2s}
.vt.on{background:var(--ember);color:var(--pitch)}
.vt:not(.on):hover{color:var(--stone)}

/* SEARCH BAR */
.search-bar{
  padding:14px 36px;background:var(--paper);
  border-bottom:0.5px solid var(--rule);
  display:flex;align-items:center;gap:12px;flex-shrink:0;flex-wrap:wrap;
}
.search-wrap{position:relative;flex:1;max-width:380px}
.search-input{
  width:100%;font-family:var(--sans);font-size:14px;color:var(--carbon);
  background:var(--canvas);border:0.5px solid var(--rule);
  padding:8px 14px 8px 36px;border-radius:6px;outline:none;transition:border-color 0.2s;
}
.search-input:focus{border-color:var(--ember)}
.search-icon{position:absolute;left:12px;top:50%;transform:translateY(-50%);font-size:14px;color:var(--ash);pointer-events:none}
.search-count{font-size:15px;color:var(--ash)}
.kfilters{display:flex;gap:6px;flex-wrap:wrap;margin-left:auto}
.kf{font-size:14px;padding:6px 16px;border-radius:20px;border:0.5px solid var(--rule);color:var(--ash);background:transparent;cursor:pointer;transition:all 0.2s;white-space:nowrap}
.kf:hover{border-color:var(--ink);color:var(--ink)}
.kf.on{background:var(--carbon);color:var(--parchment);border-color:var(--carbon)}

/* DOC AREA */
.doc-area{flex:1;overflow-y:auto;display:flex;justify-content:center;padding:40px 36px;background:var(--canvas)}
.doc-area::-webkit-scrollbar{width:4px}
.doc-area::-webkit-scrollbar-track{background:var(--canvas)}
.doc-area::-webkit-scrollbar-thumb{background:var(--rule);border-radius:2px}
.doc-column{width:100%;max-width:780px}

/* PRIMER */
.primer{
  background:var(--pitch);border-radius:12px;
  padding:28px 32px;margin-bottom:32px;
  border:0.5px solid var(--edge);
}
.primer-label{font-family:var(--mono);font-size:12px;letter-spacing:0.1em;text-transform:uppercase;color:var(--ember);margin-bottom:12px}
.primer-text{font-size:16px;color:var(--stone);line-height:1.75;max-width:640px}
.primer-text strong{color:var(--parchment);font-weight:500}

/* SECTION HEADER */
.section-header{
  display:flex;align-items:center;gap:14px;
  margin:36px 0 14px;
}
.sh-label{font-size:12px;font-weight:600;letter-spacing:0.12em;text-transform:uppercase;color:var(--ash)}
.sh-line{flex:1;height:0.5px;background:var(--rule)}
.sh-count{font-size:12px;color:var(--ash);font-family:var(--mono)}

/* ENTRY */
.entry{
  background:var(--paper);border:0.5px solid var(--rule);
  border-radius:12px;margin-bottom:10px;overflow:hidden;
  transition:box-shadow 0.2s;
}
.entry:hover{box-shadow:0 4px 20px rgba(0,0,0,0.06)}
.entry-header{
  padding:22px 28px 18px;cursor:pointer;
  display:flex;align-items:flex-start;justify-content:space-between;gap:16px;
}
.entry-section-tag{
  font-size:12px;color:var(--ash);letter-spacing:0.02em;
  margin-bottom:6px;
}
.entry-title{
  font-family:var(--serif);font-size:24px;font-weight:500;
  color:var(--carbon);letter-spacing:-0.01em;line-height:1.15;margin-bottom:12px;
}
.entry-meta{display:flex;align-items:center;gap:8px;flex-wrap:wrap}
.entry-toggle{font-size:18px;color:var(--ash);opacity:0.5;transition:all 0.2s;flex-shrink:0;margin-top:6px;background:none;border:none;cursor:pointer}
.entry.open .entry-toggle{transform:rotate(180deg);opacity:1}

/* TAGS — all lowercase, consistent pills */
.stag{display:inline-flex;align-items:center;gap:5px;font-size:13px;padding:4px 12px;border-radius:20px;letter-spacing:0.01em;white-space:nowrap;text-transform:lowercase}
.stag-dot{width:6px;height:6px;border-radius:50%;flex-shrink:0}
.st-current{background:var(--fern-g);color:#0A6644;border:0.5px solid rgba(29,158,117,0.3)}
.st-flagged{background:rgba(196,43,43,0.08);color:#C42B2B;border:0.5px solid rgba(196,43,43,0.3)}
.st-in-review{background:rgba(212,160,23,0.08);color:#7A4E08;border:0.5px solid rgba(212,160,23,0.3)}
.st-needs-update{background:#FDE8E8;color:#901818;border:0.5px solid rgba(144,24,24,0.3)}
.vtag{font-family:var(--mono);font-size:13px;color:var(--ember-d);padding:4px 10px;border:0.5px solid rgba(232,98,10,0.3);border-radius:20px;text-transform:lowercase}
.atag{font-size:13px;color:var(--ash);padding:4px 12px;border:0.5px solid var(--rule);border-radius:20px;text-transform:lowercase}

/* ENTRY BODY */
.entry-body{display:none;padding:0 28px 26px}
.entry.open .entry-body{display:block}

.field{margin-top:20px}
.field-label{font-size:12px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:var(--ash);margin-bottom:8px}
.field-value{font-size:15px;color:var(--carbon);line-height:1.8}
.field-mono{font-family:var(--mono);font-size:14px;color:var(--ink);line-height:1.7}
.field-divider{height:0.5px;background:var(--rule);margin:22px 0}

/* TRANSCLUSION */
.transcluded{
  background:var(--eng-g);border:0.5px solid var(--eng-border);
  border-left:3px solid var(--eng);border-radius:0 8px 8px 0;padding:16px 20px;margin:10px 0;
}
.trans-header{display:flex;align-items:center;gap:10px;margin-bottom:10px;flex-wrap:wrap}
.trans-badge{
  font-family:var(--sans);font-size:12px;font-weight:500;
  color:var(--eng);background:rgba(59,91,219,0.08);
  border:0.5px solid var(--eng-border);padding:3px 10px;border-radius:3px;
}
.trans-source{font-size:13px;color:var(--ash)}
.trans-updated{font-size:13px;color:var(--ash);margin-left:auto}
.trans-value{font-size:15px;color:var(--carbon);line-height:1.75;font-style:italic}

/* AUTHOR CONTROLS */
.author-controls{
  margin-top:22px;padding-top:18px;border-top:0.5px solid var(--rule);
  display:flex;align-items:center;gap:10px;flex-wrap:wrap;
}
.ac-label{font-size:14px;color:var(--ash)}
.ac-select{
  font-family:var(--sans);font-size:14px;color:var(--ink);
  background:var(--canvas);border:0.5px solid var(--rule);
  padding:5px 28px 5px 12px;border-radius:6px;cursor:pointer;
  appearance:none;-webkit-appearance:none;
  background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%239B948C'/%3E%3C/svg%3E");
  background-repeat:no-repeat;background-position:right 10px center;
  outline:none;transition:border-color 0.2s;
}
.ac-select:focus{border-color:var(--ember)}
.ac-reviewed{font-size:14px;color:var(--ash);margin-left:auto}
.ac-reviewed span{color:var(--fern);font-weight:500}
.author-badge{
  display:inline-flex;align-items:center;gap:5px;
  font-size:13px;color:var(--ember-d);
  background:var(--ember-g);border:0.5px solid rgba(232,98,10,0.2);
  padding:4px 12px;border-radius:3px;margin-top:18px;
}

/* APPEARS IN */
.appears-in{display:flex;gap:6px;flex-wrap:wrap;margin-top:10px}
.ai-link{
  font-size:14px;font-weight:500;color:var(--ink);
  background:var(--canvas);border:0.5px solid var(--rule);
  padding:6px 14px;border-radius:6px;cursor:pointer;
  transition:all 0.2s;text-decoration:none;
}
.ai-link:hover{border-color:var(--ember-d);color:var(--ember-d)}

/* READ VIEW */
#page-current.read-view .author-controls{display:none}
#page-current.read-view .author-badge{display:none}
#page-current.read-view .entry-section-tag{display:none}
#page-current.read-view .appears-in-section{display:none}
#page-current.read-view .entry-title{font-size:26px}
#page-current.read-view .field-value{font-size:16px;line-height:1.85}
#page-current.read-view .entry-body{padding-bottom:30px}

/* LINK POPUP */
.link-popup{
  position:fixed;background:var(--carbon);color:var(--parchment);
  padding:12px 18px;border-radius:8px;font-size:14px;line-height:1.55;
  max-width:300px;z-index:300;opacity:0;
  transform:translateY(6px) scale(0.96);
  transition:opacity 0.18s,transform 0.18s;pointer-events:none;
  box-shadow:0 8px 24px rgba(0,0,0,0.25);
}
.link-popup.show{opacity:1;transform:translateY(0) scale(1)}

/* EMPTY */
.empty{text-align:center;padding:80px 20px}
.empty-title{font-size:20px;font-weight:500;color:var(--carbon);margin-bottom:8px}
.empty-sub{font-size:15px;color:var(--ash)}

/* PAGE TRANSITIONS */


/* MOBILE NAV */
.hamburger{display:none;flex-direction:column;gap:5px;cursor:pointer;background:none;border:none;padding:4px}
.hamburger span{display:block;width:22px;height:1.5px;background:var(--stone);transition:all 0.2s}
.mobile-nav{position:fixed;top:0;right:0;bottom:0;width:260px;background:var(--pitch);border-left:0.5px solid var(--edge);z-index:200;transform:translateX(100%);transition:transform 0.3s ease;display:flex;flex-direction:column;padding:60px 32px 32px}
.mobile-nav.open{transform:translateX(0)}
.mobile-nav-close{position:absolute;top:16px;right:16px;background:none;border:none;color:var(--ash);font-size:20px;cursor:pointer;padding:4px}
.mobile-nav-overlay{position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:199;opacity:0;pointer-events:none;transition:opacity 0.3s}
.mobile-nav-overlay.open{opacity:1;pointer-events:all}
.mobile-nav-links{display:flex;flex-direction:column;gap:8px}
.mobile-nav-link{font-family:var(--sans);font-size:18px;font-weight:500;color:var(--ash);text-decoration:none;padding:10px 0;border-bottom:0.5px solid var(--edge);transition:color 0.2s}
.mobile-nav-link:hover,.mobile-nav-link.active{color:var(--parchment)}
.mobile-nav-label{font-size:11px;font-family:var(--mono);letter-spacing:0.1em;text-transform:uppercase;color:var(--ash);margin-bottom:16px}

/* MOBILE */


:root{
  --pitch:#141210;--surface:#191714;--edge:#2C2926;
  --ash:#9B948C;--stone:#B8B0A8;--parchment:#F5F0E8;
  --canvas:#EDEAE4;--paper:#FEFCF9;--rule:#D6D1C8;
  --ink:#4A4540;--carbon:#1E1C19;
  --ember:#E8620A;--ember-d:#C44E04;--ember-g:rgba(232,98,10,0.08);
  --fern:#1D9E75;--fern-g:rgba(29,158,117,0.08);
  --signal:#C42B2B;--signal-g:rgba(196,43,43,0.08);
  --straw:#D4A017;--straw-g:rgba(212,160,23,0.08);
  --cobalt:#2251CC;--cobalt-g:rgba(34,81,204,0.08);
  --sans:'DM Sans',sans-serif;--mono:'DM Mono',monospace;
}
*{box-sizing:border-box;margin:0;padding:0}



/* NAV */
nav{height:54px;display:flex;align-items:center;padding:0 36px;background:var(--pitch);border-bottom:0.5px solid var(--edge);flex-shrink:0;gap:14px;z-index:10}
.wm{font-size:20px;font-weight:500;letter-spacing:-0.05em;color:var(--parchment);text-decoration:none}
.wm span{color:var(--ember)}
.nav-div{width:0.5px;height:18px;background:var(--edge)}
.nav-links{display:flex;gap:24px}
.nl{font-family:var(--sans);font-size:14px;color:var(--ash);cursor:pointer;transition:color 0.2s;background:none;border:none;padding:0;text-decoration:none}
.nl:hover{color:var(--stone)}
.nl.active{color:var(--parchment);font-weight:500}
.nav-r{margin-left:auto;display:flex;align-items:center;gap:12px}
.sync-btn{font-family:var(--sans);font-size:14px;color:var(--ember);border:0.5px solid rgba(232,98,10,0.5);padding:7px 18px;border-radius:3px;cursor:pointer;background:transparent;transition:all 0.2s;display:flex;align-items:center;gap:7px}
.sync-btn:hover{background:var(--ember-g)}

/* PAGE HEADER */
.page-header{background:var(--pitch);border-bottom:0.5px solid var(--edge);padding:22px 36px;flex-shrink:0;display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:16px}
.ph-title{font-size:22px;font-weight:500;color:var(--parchment);letter-spacing:-0.03em;margin-bottom:5px}
.ph-desc{font-size:15px;color:var(--stone);line-height:1.6;max-width:520px}
.view-select-wrap{display:flex;align-items:center;gap:10px;flex-shrink:0}
.view-label{font-size:13px;color:var(--ash)}
.view-select{font-family:var(--sans);font-size:14px;font-weight:500;color:var(--parchment);background:var(--surface);border:0.5px solid var(--edge);padding:8px 32px 8px 14px;border-radius:6px;cursor:pointer;appearance:none;-webkit-appearance:none;background-image:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%239B948C'/%3E%3C/svg%3E");background-repeat:no-repeat;background-position:right 12px center;outline:none;transition:border-color 0.2s}
.view-select:focus{border-color:var(--ember)}

/* DASHBOARD AREA */
.dash{flex:1;overflow-y:auto;padding:28px 36px}
.dash::-webkit-scrollbar{width:4px}
.dash::-webkit-scrollbar-track{background:var(--canvas)}
.dash::-webkit-scrollbar-thumb{background:var(--rule);border-radius:2px}

/* GRID LAYOUTS */
.row{display:grid;gap:14px;margin-bottom:14px}
.row-4{grid-template-columns:repeat(4,1fr)}
.row-3{grid-template-columns:repeat(3,1fr)}
.row-2{grid-template-columns:1fr 1fr}
.row-2-1{grid-template-columns:2fr 1fr}
.row-1-2{grid-template-columns:1fr 2fr}

/* CARDS */
.card{background:var(--paper);border:0.5px solid var(--rule);border-radius:12px;padding:22px 24px;position:relative;overflow:hidden}
.card-dark{background:var(--pitch);border:0.5px solid var(--edge);border-radius:12px;padding:22px 24px}
.card-label{font-size:12px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:var(--ash);margin-bottom:12px}
.card-label-light{font-size:12px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#8A8480;margin-bottom:12px}

/* FRESHNESS SCORE — hero metric */
.freshness-card{background:var(--pitch);border:0.5px solid var(--edge);border-radius:12px;padding:28px 28px;display:flex;flex-direction:column;justify-content:space-between;min-height:160px;position:relative;overflow:hidden}
.freshness-glow{position:absolute;width:200px;height:200px;border-radius:50%;background:radial-gradient(circle,rgba(29,158,117,0.15) 0%,transparent 70%);top:-40px;right:-40px;pointer-events:none}
.freshness-score{font-size:64px;font-weight:600;letter-spacing:-0.04em;line-height:1;color:var(--parchment);margin-bottom:4px}
.freshness-score span{color:var(--fern)}
.freshness-label{font-size:12px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:#8A8480;margin-bottom:16px}
.freshness-sub{font-size:13px;color:var(--stone);line-height:1.5}
.freshness-trend{display:flex;align-items:center;gap:6px;margin-top:12px}
.trend-up{font-size:13px;color:var(--fern);font-weight:500}
.trend-label{font-size:13px;color:var(--ash)}

/* STAT CARDS */
.stat-value{font-size:36px;font-weight:600;letter-spacing:-0.03em;color:var(--carbon);line-height:1;margin-bottom:6px}
.stat-sub{font-size:13px;color:var(--ash);line-height:1.5}
.stat-pill{display:inline-flex;align-items:center;gap:5px;font-size:12px;padding:3px 10px;border-radius:20px;margin-top:8px;text-transform:lowercase}
.sp-green{background:var(--fern-g);color:#0A6644;border:0.5px solid rgba(29,158,117,0.3)}
.sp-red{background:var(--signal-g);color:var(--signal);border:0.5px solid rgba(196,43,43,0.3)}
.sp-amber{background:var(--straw-g);color:#7A4E08;border:0.5px solid rgba(212,160,23,0.3)}
.sp-blue{background:var(--cobalt-g);color:var(--cobalt);border:0.5px solid rgba(34,81,204,0.3)}
.stat-dot{width:6px;height:6px;border-radius:50%}

/* STATUS BREAKDOWN */
.status-bars{display:flex;flex-direction:column;gap:10px}
.sb-row{display:flex;align-items:center;gap:12px}
.sb-label{font-size:13px;color:var(--ink);width:100px;flex-shrink:0;text-transform:lowercase}
.sb-bar-wrap{flex:1;height:8px;background:var(--canvas);border-radius:4px;overflow:hidden}
.sb-bar{height:100%;border-radius:4px;transition:width 0.8s ease}
.sb-count{font-size:13px;color:var(--ash);width:24px;text-align:right;flex-shrink:0;font-family:var(--mono)}

/* CHANNEL CHART */
.channel-chart{display:flex;flex-direction:column;gap:10px}
.cc-row{display:flex;align-items:center;gap:12px}
.cc-label{font-size:13px;color:var(--ink);width:130px;flex-shrink:0}
.cc-bar-wrap{flex:1;height:10px;background:var(--canvas);border-radius:5px;overflow:hidden;cursor:pointer}
.cc-bar{height:100%;border-radius:5px;background:var(--ember);transition:width 0.9s ease;opacity:0.85}
.cc-bar:hover{opacity:1}
.cc-val{font-size:13px;color:var(--ash);width:40px;text-align:right;font-family:var(--mono);flex-shrink:0}

/* TICKET QUEUE */
.ticket-list{display:flex;flex-direction:column;gap:8px}
.ticket{background:var(--canvas);border:0.5px solid var(--rule);border-radius:8px;padding:12px 16px;display:flex;align-items:center;gap:12px;cursor:pointer;transition:all 0.2s}
.ticket:hover{border-color:var(--ember-d);background:rgba(232,98,10,0.03)}
.ticket-priority{width:8px;height:8px;border-radius:50%;flex-shrink:0}
.tp-high{background:var(--signal)}
.tp-med{background:var(--straw)}
.tp-low{background:var(--fern)}
.ticket-content{flex:1;min-width:0}
.ticket-title{font-size:14px;font-weight:500;color:var(--carbon);letter-spacing:-0.01em;margin-bottom:2px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.ticket-meta{font-size:12px;color:var(--ash)}
.ticket-age{font-size:12px;color:var(--ash);flex-shrink:0;font-family:var(--mono)}
.ticket-tool{font-size:11px;font-weight:500;color:var(--ember-d);background:var(--ember-g);border:0.5px solid rgba(232,98,10,0.2);padding:2px 8px;border-radius:3px;flex-shrink:0}

/* ACTIVITY FEED */
.activity-list{display:flex;flex-direction:column;gap:0}
.activity-item{display:flex;align-items:flex-start;gap:12px;padding:12px 0;border-bottom:0.5px solid var(--rule)}
.activity-item:last-child{border-bottom:none}
.activity-dot{width:8px;height:8px;border-radius:50%;flex-shrink:0;margin-top:5px}
.ad-green{background:var(--fern)}
.ad-red{background:var(--signal)}
.ad-amber{background:var(--straw)}
.ad-blue{background:var(--cobalt)}
.activity-text{font-size:14px;color:var(--carbon);line-height:1.5;flex:1}
.activity-text span{color:var(--ash);font-size:13px;display:block;margin-top:2px}
.activity-time{font-size:12px;color:var(--ash);flex-shrink:0;font-family:var(--mono);margin-top:3px}

/* CYCLE TIME */
.cycle-viz{display:flex;align-items:flex-end;gap:8px;height:80px;margin-top:8px}
.cv-bar-wrap{flex:1;display:flex;flex-direction:column;align-items:center;gap:4px;height:100%;justify-content:flex-end}
.cv-bar{width:100%;border-radius:4px 4px 0 0;background:var(--ember);opacity:0.7;transition:height 0.8s ease;min-height:4px}
.cv-label{font-size:10px;color:var(--ash);text-align:center;font-family:var(--mono)}

/* CHANNEL HEALTH GRID */
.health-grid{display:grid;grid-template-columns:1fr 1fr;gap:8px}
.health-item{background:var(--canvas);border-radius:8px;padding:12px 14px;border:0.5px solid var(--rule)}
.health-item.healthy{border-color:rgba(29,158,117,0.25);background:rgba(29,158,117,0.04)}
.health-item.warning{border-color:rgba(212,160,23,0.25);background:rgba(212,160,23,0.04)}
.health-item.critical{border-color:rgba(196,43,43,0.25);background:rgba(196,43,43,0.04)}
.hi-name{font-size:13px;font-weight:500;color:var(--carbon);margin-bottom:4px}
.hi-stat{font-size:12px;color:var(--ash)}
.hi-dot{width:8px;height:8px;border-radius:50%;display:inline-block;margin-right:6px}

/* LEADERSHIP VIEW EXTRAS */
.kpi-row{display:grid;grid-template-columns:repeat(3,1fr);gap:14px;margin-bottom:14px}
.kpi-card{background:var(--paper);border:0.5px solid var(--rule);border-radius:12px;padding:20px 22px}
.kpi-value{font-size:28px;font-weight:600;letter-spacing:-0.03em;color:var(--carbon);line-height:1;margin-bottom:4px}
.kpi-label{font-size:13px;color:var(--ash);line-height:1.4}
.kpi-change{font-size:12px;margin-top:6px;display:flex;align-items:center;gap:4px}
.kc-up{color:var(--fern)}
.kc-down{color:var(--signal)}

/* POST-RELEASE VIEW */
.release-header{background:rgba(34,81,204,0.08);border:0.5px solid rgba(34,81,204,0.25);border-radius:10px;padding:16px 20px;margin-bottom:14px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px}
.rh-title{font-size:16px;font-weight:500;color:var(--carbon)}
.rh-meta{font-size:13px;color:var(--ash)}
.rh-badge{font-size:12px;font-weight:500;color:var(--cobalt);background:var(--cobalt-g);border:0.5px solid rgba(34,81,204,0.3);padding:4px 12px;border-radius:20px}

/* LINK POPUP */
.link-popup{position:fixed;background:var(--carbon);color:var(--parchment);padding:12px 18px;border-radius:8px;font-size:14px;line-height:1.55;max-width:300px;z-index:300;opacity:0;transform:translateY(6px) scale(0.96);transition:opacity 0.18s,transform 0.18s;pointer-events:none;box-shadow:0 8px 24px rgba(0,0,0,0.25)}
.link-popup.show{opacity:1;transform:translateY(0) scale(1)}

/* PAGE TRANSITIONS */


/* MOBILE NAV */
.hamburger{display:none;flex-direction:column;gap:5px;cursor:pointer;background:none;border:none;padding:4px}
.hamburger span{display:block;width:22px;height:1.5px;background:var(--stone);transition:all 0.2s}
.mobile-nav{position:fixed;top:0;right:0;bottom:0;width:260px;background:var(--pitch);border-left:0.5px solid var(--edge);z-index:200;transform:translateX(100%);transition:transform 0.3s ease;display:flex;flex-direction:column;padding:60px 32px 32px}
.mobile-nav.open{transform:translateX(0)}
.mobile-nav-close{position:absolute;top:16px;right:16px;background:none;border:none;color:var(--ash);font-size:20px;cursor:pointer;padding:4px}
.mobile-nav-overlay{position:fixed;inset:0;background:rgba(0,0,0,0.5);z-index:199;opacity:0;pointer-events:none;transition:opacity 0.3s}
.mobile-nav-overlay.open{opacity:1;pointer-events:all}
.mobile-nav-links{display:flex;flex-direction:column;gap:8px}
.mobile-nav-link{font-family:var(--sans);font-size:18px;font-weight:500;color:var(--ash);text-decoration:none;padding:10px 0;border-bottom:0.5px solid var(--edge);transition:color 0.2s}
.mobile-nav-link:hover,.mobile-nav-link.active{color:var(--parchment)}
.mobile-nav-label{font-size:11px;font-family:var(--mono);letter-spacing:0.1em;text-transform:uppercase;color:var(--ash);margin-bottom:16px}

/* MOBILE */


@media(max-width:768px){
  html,body{height:auto!important;overflow-y:auto!important;overflow-x:hidden!important}
  .page{height:auto!important;min-height:100vh;overflow:visible!important}
  .page.active{display:flex!important;flex-direction:column}
  /* Homepage */
  .main{grid-template-columns:1fr!important;height:auto!important;overflow:visible!important}
  .left{padding:32px 24px;border-right:none;border-bottom:0.5px solid var(--edge);min-height:auto}
  .left-glow{display:none}
  .hero-title{font-size:clamp(36px,10vw,56px)}
  .right{padding:28px 24px;overflow-y:visible;height:auto}
  .sources{grid-template-columns:1fr}
  .prod-modes{grid-template-columns:1fr;gap:8px}
  .prod-divider{display:none}
  .prod-mode{padding:8px 0}
  .pulse-grid{grid-template-columns:1fr}
  .dist-pair{flex-direction:column;align-items:flex-start;gap:6px}
  .dist-pair-label{text-align:left;width:auto}
  .dist-pair-row{grid-template-columns:1fr;width:100%}
  .layers{gap:6px}
  .ltag{font-size:13px;padding:6px 12px}
  .cta{flex-direction:column;align-items:flex-start}
  .btn-t,.btn-e{width:100%;text-align:center}
  .tour-card{padding:28px 24px}
  .t-title{font-size:20px}
  /* Shared nav */
  nav{padding:0 20px!important;gap:10px}
  .hamburger{display:flex}
  .nav-links{display:none!important}
  .nav-r{margin-left:auto}
  .nav-div{display:none!important}
  /* Grid */
  .toolbar{padding:12px 20px;gap:6px;flex-wrap:wrap}
  select{font-size:12px;padding:5px 24px 5px 10px}
  .grid-area{padding:16px 20px}
  .card-grid{grid-template-columns:1fr}
  .stats-bar{padding:8px 20px}
  .modal-overlay{padding:16px 0 0;align-items:flex-start}
  .modal{border-radius:16px;margin:0 8px}
  .modal-header{padding:24px 24px 18px;border-radius:16px 16px 0 0}
  .modal-title{font-size:22px}
  .modal-body{padding:20px 24px 32px}
  .vh-item{grid-template-columns:40px 80px 1fr}
  .lc-date{display:none}
  /* Current */
  .page-header{padding:16px 20px;flex-wrap:wrap}
  .search-bar{padding:12px 20px}
  .kfilters{margin-left:0;width:100%}
  .doc-area{padding:20px 16px}
  .entry-header{padding:18px 20px 14px}
  .entry-body{padding:0 20px 20px}
  .entry-title{font-size:20px}
  .primer{padding:20px 22px}
  /* Pulse */
  .dash{padding:16px 20px}
  .row-4,.row-3,.row-2,.row-2-1,.row-1-2,.kpi-row{grid-template-columns:1fr!important}
  .health-grid{grid-template-columns:1fr}
  /* Toast */
  #globalToast{bottom:0;right:0;left:0;max-width:none;border-radius:10px 10px 0 0}
}</style>
</head>
<body>

<div class="mobile-nav-overlay" id="mobileOverlay" onclick="closeMobileNav()"></div>
<div class="mobile-nav" id="mobileNav">
  <button class="mobile-nav-close" onclick="closeMobileNav()">×</button>
  <div class="mobile-nav-label">flu<span style="color:#E8620A">x</span></div>
  <div class="mobile-nav-links">
    <button class="mobile-nav-btn" id="mnav-current" onclick="navigate('current');closeMobileNav()">the current</button>
    <button class="mobile-nav-btn" id="mnav-grid" onclick="navigate('grid');closeMobileNav()">the grid</button>
    <button class="mobile-nav-btn" id="mnav-pulse" onclick="navigate('pulse');closeMobileNav()">the pulse</button>
  </div>
</div>

<!-- GLOBAL TOAST -->
<div id="globalToast" style="position:fixed;bottom:28px;right:28px;background:#141210;border:0.5px solid #2C2926;border-radius:10px;padding:16px 20px;z-index:500;transform:translateY(80px);opacity:0;transition:all 0.3s;max-width:300px;min-width:220px;pointer-events:none">
  <div id="gToastTitle" style="font-size:14px;font-weight:600;color:#E8620A;margin-bottom:4px"></div>
  <div id="gToastBody" style="font-family:'DM Mono',monospace;font-size:13px;color:#B8B0A8;line-height:1.55"></div>
</div>

<div class="page" id="page-home">


<nav>
  <div class="wm">flu<span>x</span></div>
  <div class="nav-tag">internal knowledge system</div>
</nav>

<div class="main">

  <!-- LEFT -->
  <div class="left">
    <div class="left-glow"></div>
    <div>
      
      <div class="hero-title">Knowledge<br>infrastructure<br>for <span>flux.</span></div>
      <div class="hero-sub" style="margin-bottom:28px">One system connecting every source of knowledge at flux. Translated, modular, distributed everywhere it needs to go and tracked from source to screen.</div>
    </div>
    <div class="layers" style="margin-bottom:12px">
      <div class="ltag" data-layer="current"><span class="n">01</span>the current</div>
      <div class="ltag" data-layer="grid"><span class="n">02</span>the grid</div>
      <div class="ltag" data-layer="pulse"><span class="n">03</span>the pulse</div>
    </div>
    <div style="margin-bottom:24px;height:22px;display:flex;align-items:center">
      <div id="layerDesc" style="font-family:var(--mono);font-size:15px;color:var(--ember);letter-spacing:0.04em;transition:opacity 0.15s"></div>
    </div>
    <div class="cta">
      <button class="btn-t" onclick="startTour()">take the tour →</button>
      <button class="btn-e" onclick="navigate('grid')">explore freely</button>
      <button class="btn-r" id="resetBtn" onclick="doReset()" title="Reset simulation">↺</button>
    </div>
  </div>

  <!-- RIGHT -->
  <div class="right">
    <div class="map-label">system architecture</div>

    <!-- sources + current share one tool -->
    <div class="same-tool-wrapper">
      <div class="same-tool-label">lives in one tool · confluence or notion</div>
      <div class="sources">
        <div class="src"><div class="src-t">Company wiki</div><div class="src-s">how the company works</div></div>
        <div class="src"><div class="src-t">Release notes</div><div class="src-s">changelogs · shipped updates</div></div>
        <div class="src"><div class="src-t">Product docs</div><div class="src-s">API · technical · versioned</div></div>
      </div>
      <div class="conn"><div class="conn-arrow">↓</div></div>
      <div class="lnode lnode-dark" onclick="navigate('current')" style="cursor:pointer">
        <div class="lnode-ey">layer 01 · owned by learning</div>
        <div class="lnode-t">The Current</div>
        <div class="lnode-d">human-authored source of truth · translated · contextualized</div>
        <div class="lnode-arr">→</div>
      </div>
    </div>

    <div class="conn"><div class="conn-arrow">↓</div></div>

    <div class="prod-zone">
      <div class="prod-label">content production</div>
      <div class="prod-modes">
        <div class="prod-mode">
          <div class="prod-mode-title">AI-generated</div>
          <div class="prod-mode-sub">drafted from The Current automatically</div>
        </div>
        <div class="prod-divider"></div>
        <div class="prod-mode">
          <div class="prod-mode-title">Human-authored</div>
          <div class="prod-mode-sub">ID, eLearning developer, or learning team</div>
        </div>
        <div class="prod-divider"></div>
        <div class="prod-mode">
          <div class="prod-mode-title">Hybrid</div>
          <div class="prod-mode-sub">AI drafts, human refines</div>
        </div>
      </div>
    </div>

    <div class="conn"><div class="conn-arrow">↓</div></div>

    <div class="lnode lnode-mid" onclick="navigate('grid')" style="cursor:pointer">
      <div class="lnode-ey">layer 02</div>
      <div class="lnode-t">The Grid</div>
      <div class="lnode-d">modular block library · tagged · versioned · distributed</div>
      <div class="lnode-arr">→</div>
    </div>

    <div class="conn"><div class="conn-arrow">↓</div></div>

    <!-- Distribution channels — paired rows -->
    <div class="dist-section">
      <div class="dist-section-label">distributed to</div>
      <div class="dist-pair">
        <div class="dist-pair-label">learn</div>
        <div class="dist-pair-row">
          <div class="gc"><div class="gc-t">WorkRamp</div><div class="gc-s">internal learning paths</div></div>
          <div class="gc"><div class="gc-t">WorkRamp</div><div class="gc-s">customer academy</div></div>
        </div>
      </div>
      <div class="dist-pair">
        <div class="dist-pair-label">comms</div>
        <div class="dist-pair-row">
          <div class="gc"><div class="gc-t">Loops</div><div class="gc-s">customer release email</div></div>
          <div class="gc"><div class="gc-t">Slack</div><div class="gc-s">internal announcements</div></div>
        </div>
      </div>
      <div class="dist-pair">
        <div class="dist-pair-label">docs</div>
        <div class="dist-pair-row">
          <div class="gc"><div class="gc-t">Notion</div><div class="gc-s">runbooks · internal docs</div></div>
          <div class="gc gc-kb"><div class="gc-t">GitBook</div><div class="gc-s">external docs · self-maintains</div></div>
        </div>
      </div>
    </div>

    <div class="conn"><div class="conn-arrow">↓</div></div>

    <div class="pulse-node" onclick="navigate('pulse')" style="cursor:pointer">
      <div class="lnode-ey">layer 03</div>
      <div class="lnode-t">The Pulse</div>
      <div class="lnode-d" style="margin-bottom:14px">analytics and tracking for the whole system</div>
      <div class="pulse-grid">
        <div class="pulse-item">
          <div class="pulse-item-title">Content freshness</div>
          <div class="pulse-item-sub">tracks how current every block is and flags it automatically when something goes stale</div>
        </div>
        <div class="pulse-item">
          <div class="pulse-item-title">Click tracking</div>
          <div class="pulse-item-sub">engagement data across every channel — LMS, newsletter, runbooks, and more</div>
        </div>
        <div class="pulse-item">
          <div class="pulse-item-title">Ticket creation</div>
          <div class="pulse-item-sub">tickets opened in Monday or Linear automatically, assigned, and closed on resolve</div>
        </div>
        <div class="pulse-item">
          <div class="pulse-item-title">Update cycle time</div>
          <div class="pulse-item-sub">measures how fast the team responds to flags and keeps the system current</div>
        </div>
      </div>
      <div class="lnode-arr">→</div>
    </div>


  </div>
</div>

<!-- TOUR -->
<div class="tour" id="tour">
  <div class="tour-card">
    <button class="t-close" onclick="closeTour()">×</button>
    <div class="t-ey" id="tLabel">step 01 of 04</div>
    <div class="t-title" id="tTitle">Welcome to the flux knowledge system.</div>
    <div class="t-body" id="tBody">A live demo of a fully connected knowledge infrastructure built for flux — a fast-moving AI code review company. Everything here is designed to keep every team current, all the time.</div>
    <div class="t-actions">
      <button class="t-next" id="tNext" onclick="nextStep()">next →</button>
      <button class="t-skip" onclick="closeTour()">skip</button>
      <div class="t-dots" id="tDots"></div>
    </div>
  </div>
</div>



</div>

<div class="page" id="page-grid">


<nav>
  <a href="#" onclick="navigate('home');return false" class="wm" title="back to overview">flu<span>x</span></a>
  <button class="hamburger" onclick="openMobileNav()"><span></span><span></span><span></span></button>
  <div class="nav-div"></div>
  <div class="nav-links">
    <a class="nl" href="#" onclick="navigate('current');return false">the current</a>
    <a class="nl active" href="#">the grid</a>
    <a class="nl" href="#" onclick="navigate('pulse');return false">the pulse</a>
  </div>

  <div style="margin-left:auto"><button class="sync-btn" onclick="handleGlobalSync()">↻ sync</button></div>
</nav>

<div class="page-framing">
  <div class="page-framing-inner">
    <div class="pf-title">The Grid</div>
    <div class="pf-desc">The block library that feeds every learning channel at flux. Manage content, track status, and sync updates from one place.</div>
  </div>
</div>

<div class="tabs">
  <button class="tab active" id="tab-blocks" onclick="setTab('blocks')">blocks</button>
  <button class="tab" id="tab-outputs" onclick="setTab('outputs')">outputs</button>
</div>

<div class="toolbar" id="toolbar-blocks">
  <div class="toolbar-left">
    <select id="f-status" onchange="applyFilters()">
      <option value="">all status</option>
      <option value="current">current</option>
      <option value="flagged">flagged</option>
      <option value="in review">in review</option>
      <option value="needs update">needs update</option>
    </select>
    <select id="f-tier" onchange="applyFilters()">
      <option value="">all tiers</option>
      <option value="passthrough">passthrough</option>
      <option value="review">review</option>
      <option value="rebuild">rebuild</option>
    </select>
    <select id="f-audience" onchange="applyFilters()">
      <option value="">all audiences</option>
      <option value="internal">internal</option>
      <option value="external">external</option>
      <option value="both">both</option>
    </select>
    <select id="f-format" onchange="applyFilters()">
      <option value="">all formats</option>
      <option value="article">article</option>
      <option value="tutorial">tutorial</option>
      <option value="template">template</option>
      <option value="deprecated">deprecated</option>
    </select>
    <select id="f-knowledge" onchange="applyFilters()">
      <option value="">all knowledge types</option>
      <option value="concept">concept</option>
      <option value="process">process</option>
      <option value="reference">reference</option>
      <option value="policy">policy</option>
      <option value="template">template</option>
      <option value="deprecated">deprecated</option>
    </select>
  </div>
  <div class="toolbar-right">
    <select id="f-sort" onchange="applyFilters()">
      <option value="dateModified">date modified</option>
      <option value="dateCreated">date created</option>
      <option value="alpha">alphabetical</option>
      <option value="status">status</option>
    </select>
    <div class="view-toggle">
      <button class="vt-btn on" id="vt-grid" onclick="setView('grid')">⊞</button>
      <button class="vt-btn" id="vt-list" onclick="setView('list')">☰</button>
    </div>
  </div>
</div>

<div class="outputs-view" id="outputs-view" style="display:none">
  <div class="ov-grid" id="ovGrid"></div>
</div>

<div class="stats-bar" id="stats-bar">
  <div class="stats-count" id="statsCount"><strong>15</strong> blocks</div>
  <div class="stats-pills" id="statsPills"></div>
  <button class="clear-btn" id="clearBtn" onclick="clearFilters()">clear filters ×</button>
</div>

<div class="grid-area">
  <div id="blockContainer" class="card-grid"></div>
</div>

<!-- MODAL -->
<div class="modal-overlay" id="modalOverlay" onclick="closeModalOutside(event)">
  <div class="modal" id="modal">
    <div class="modal-header">
      <div class="modal-eyebrow" id="mEyebrow"></div>
      <div class="modal-title" id="mTitle"></div>
      <div class="modal-meta" id="mMeta"></div>
      <button class="modal-close" onclick="closeModal()">×</button>
    </div>
    <div class="modal-body" id="mBody"></div>
  </div>
</div>

<!-- LINK POPUP -->
<div class="link-popup" id="linkPopup">
  <div class="lp-text" id="lpText"></div>
</div>

<!-- SYNC NUDGE -->
<div class="sync-nudge" id="syncNudge">
  <button class="sn-close" onclick="dismissNudge()">×</button>
  <div class="sn-arrow">↑</div>
  <div class="sn-title">Try syncing</div>
  <div class="sn-body">Simulate what happens when a new release drops at flux. Watch the system catch what changed.</div>
  <button class="sn-cta" onclick="dismissNudge();runSync()">run sync now</button>
</div>

<!-- TOAST -->
<div class="toast" id="toast">
  <div class="toast-title" id="toastTitle">scanning blocks...</div>
  <div class="toast-body" id="toastBody"></div>
</div>



</div>

<div class="page" id="page-current">


<nav>
  <a href="#" onclick="navigate('home');return false" class="wm">flu<span>x</span></a>
  <button class="hamburger" onclick="openMobileNav()"><span></span><span></span><span></span></button>
  <div class="nav-div"></div>
  <div class="nav-links">
    <a class="nl active" href="#">the current</a>
    <a class="nl" href="#" onclick="navigate('grid');return false">the grid</a>
    <a class="nl" href="#" onclick="navigate('pulse');return false">the pulse</a>
  </div>

  <div style="margin-left:auto"><button class="sync-btn" onclick="handleGlobalSync()">↻ sync</button></div>
</nav>

<div class="page-header">
  <div>
    <div class="ph-title">The Current</div>
    <div class="ph-desc">The human-authored knowledge layer for flux. Lives alongside engineering's sources. Everything in The Grid starts here.</div>
  </div>
  <div class="view-toggle">
    <button class="vt on" id="vt-author" onclick="setView('author')">Author view</button>
    <button class="vt" id="vt-read" onclick="setView('read')">Read view</button>
  </div>
</div>

<div class="search-bar">
  <div class="search-wrap">
    <span class="search-icon">⌕</span>
    <input class="search-input" id="searchInput" type="text" placeholder="Search knowledge..." oninput="render()">
  </div>
  <div class="search-count" id="searchCount"></div>
  <div class="kfilters">
    <button class="kf on" onclick="setKtype('all',this)">All</button>
    <button class="kf" onclick="setKtype('concept',this)">Concept</button>
    <button class="kf" onclick="setKtype('process',this)">Process</button>
    <button class="kf" onclick="setKtype('reference',this)">Reference</button>
    <button class="kf" onclick="setKtype('policy',this)">Policy</button>
    <button class="kf" onclick="setKtype('template',this)">Template</button>
    <button class="kf" onclick="setKtype('deprecated',this)">Deprecated</button>
  </div>
</div>

<div class="doc-area">
  <div class="doc-column" id="docColumn"></div>
</div>

<div class="link-popup" id="cuLinkPopup"></div>



</div>

<div class="page" id="page-pulse">


<nav>
  <a href="#" onclick="navigate('home');return false" class="wm">flu<span>x</span></a>
  <button class="hamburger" onclick="openMobileNav()"><span></span><span></span><span></span></button>
  <div class="nav-div"></div>
  <div class="nav-links">
    <a class="nl" href="#" onclick="navigate('current');return false">the current</a>
    <a class="nl" href="#" onclick="navigate('grid');return false">the grid</a>
    <a class="nl active" href="#">the pulse</a>
  </div>

  <div style="margin-left:auto"><button class="sync-btn" onclick="handleGlobalSync()">↻ sync</button></div>
</nav>

<div class="page-header">
  <div>
    <div class="ph-title">The Pulse</div>
    <div class="ph-desc">Analytics and tracking for the whole system. Content freshness, click data, ticket queue, and channel health — all in one place.</div>
  </div>
  <div class="view-select-wrap">
    <span class="view-label">Viewing as</span>
    <select class="view-select" id="viewSelect" onchange="puSetView(this.value)">
      <option value="learning">Learning team</option>
      <option value="leadership">Leadership</option>
    </select>
  </div>
</div>

<div class="dash" id="dash"></div>

<div class="link-popup" id="puLinkPopup"></div>



</div>

<script>
// === ROUTER ===
var PAGES=['home','grid','current','pulse'];
var _pg='home';
var _gInit=false;
var _cInit=false;

function navigate(page){
  if(PAGES.indexOf(page)<0) page='home';
  PAGES.forEach(function(p){
    var el=document.getElementById('page-'+p);
    if(el) el.classList.remove('active');
  });
  var target=document.getElementById('page-'+page);
  if(target) target.classList.add('active');
  _pg=page;
  try{window.location.hash=page==='home'?'':page;}catch(e){}
  ['current','grid','pulse'].forEach(function(p){
    var btn=document.getElementById('mnav-'+p);
    if(btn) btn.classList.toggle('active',p===page);
  });
  if(page==='grid'){
    if(!_gInit){_gInit=true;initGrid();}
    else applyFilters();
  }
  if(page==='current'&&!_cInit){_cInit=true;initCurrent();}
  if(page==='pulse') initPulse();
  var sc=target&&target.querySelector('.grid-area,.doc-area,.dash');
  if(sc) sc.scrollTop=0;
  updateSyncBtns();
}

function navigateToBlock(id){
  navigate('grid');
  setTimeout(function(){if(typeof openModal==='function')openModal(id);},400);
}

function openMobileNav(){document.getElementById('mobileNav').classList.add('open');document.getElementById('mobileOverlay').classList.add('open');}
function closeMobileNav(){document.getElementById('mobileNav').classList.remove('open');document.getElementById('mobileOverlay').classList.remove('open');}

var _nudgeDismissed = false;
var _nudgeTimer = null;

window.addEventListener('load',function(){
  var hash=window.location.hash.replace('#','');
  navigate(PAGES.indexOf(hash)>=0?hash:'home');
  // Show nudge after 8s if sync hasn't run
  _nudgeTimer = setTimeout(function(){
    if(!_nudgeDismissed && !_syncRun){
      var modalOpen = document.getElementById('modalOverlay') &&
                      document.getElementById('modalOverlay').classList.contains('on');
      if(!modalOpen){
        document.getElementById('syncNudge').classList.add('show');
      }
    }
  }, 8000);
});
window.addEventListener('hashchange',function(){
  var hash=window.location.hash.replace('#','');
  if(PAGES.indexOf(hash)>=0&&hash!==_pg) navigate(hash);
});

// === GLOBAL SYNC ===
var _syncRun=false;
var _flagged=[];
var SYNC_TARGETS=['0010','0012'];

function updateSyncBtns(){
  var label=_syncRun?'↺ reset demo':'↻ sync';
  document.querySelectorAll('.sync-btn').forEach(function(btn){
    if(!btn.classList.contains('syncing')) btn.innerHTML=label;
  });
}

function handleGlobalSync(){
  if(_syncRun){doGlobalReset();}else{doGlobalSync();}
}

function doGlobalSync(){
  if(_syncRun) return;
  dismissNudge();
  // Save original statuses
  if(typeof BLOCKS!=='undefined') BLOCKS.forEach(function(b){b._orig=b.status;});
  // Animate all sync buttons
  document.querySelectorAll('.sync-btn').forEach(function(btn){
    btn.innerHTML='<span style="display:inline-block;animation:syncSpin 1s linear infinite">↻</span> syncing...';
    btn.classList.add('syncing');
  });
  showGToast('scanning blocks...','');
  // Animate grid cards if on grid
  if(_pg==='grid'){
    var cards=document.querySelectorAll('[id^="card-"]');
    var i=0;
    function scanNext(){
      if(i>=cards.length){doFlagBlocks();return;}
      cards[i].classList.add('scanning');
      var titleEl=cards[i].querySelector('.card-title,.lc-title');
      document.getElementById('gToastBody').textContent='checking '+(titleEl?titleEl.textContent:'')+'...';
      setTimeout(function(){cards[i].classList.remove('scanning');i++;setTimeout(scanNext,75);},110);
    }
    setTimeout(scanNext,300);
  } else {
    setTimeout(doFlagBlocks,1800);
  }
}

function doFlagBlocks(){
  if(typeof BLOCKS!=='undefined'){
    SYNC_TARGETS.forEach(function(id){
      var b=BLOCKS.find(function(x){return x.id===id;});
      if(b){
        b.status='flagged';
        // Update card visually if on grid
        var card=document.getElementById('card-'+id);
        if(card){
          card.className=card.className.replace(/s-\S+/,'').trim()+' s-flagged newly-flagged';
          var stRow=card.querySelector('.card-status-row,.lc-status');
          if(stRow){var stag=stRow.querySelector('.stag');if(stag){stag.className='stag st-flagged';stag.innerHTML='<span class="stag-dot" style="background:#C42B2B"></span>flagged';}}
        }
      }
    });
  }
  _syncRun=true;
  _flagged=SYNC_TARGETS.slice();
  document.querySelectorAll('.sync-btn').forEach(function(btn){btn.classList.remove('syncing');});
  updateSyncBtns();
  if(typeof updateStats==='function') updateStats();
  if(_pg==='pulse'&&typeof puRenderDash==='function') puRenderDash();
  showGToast('sync complete','2 blocks flagged · tickets opened in Notion');
  setTimeout(hideGToast,3500);
}

function doGlobalReset(){
  if(!_syncRun) return;
  if(typeof BLOCKS!=='undefined'){
    BLOCKS.forEach(function(b){
      if(b._orig){b.status=b._orig;delete b._orig;}
      // Reset card visually if on grid
      var card=document.getElementById('card-'+b.id);
      if(card&&card.classList.contains('s-flagged')&&SYNC_TARGETS.indexOf(b.id)>=0){
        card.className=card.className.replace(/s-flagged/,'s-current').replace('newly-flagged','').trim();
        var stRow=card.querySelector('.card-status-row,.lc-status');
        if(stRow){var stag=stRow.querySelector('.stag');if(stag){stag.className='stag st-current';stag.innerHTML='<span class="stag-dot" style="background:#1D9E75"></span>current';}}
      }
    });
  }
  _syncRun=false;_flagged=[];
  if(typeof hasSynced!=='undefined') hasSynced=false;
  updateSyncBtns();
  if(typeof updateStats==='function') updateStats();
  if(_pg==='pulse'&&typeof puRenderDash==='function') puRenderDash();
  showGToast('demo reset','blocks restored to starting state');
  setTimeout(hideGToast,2500);
}

function showGToast(title,body){
  var t=document.getElementById('globalToast');
  document.getElementById('gToastTitle').textContent=title;
  document.getElementById('gToastBody').textContent=body;
  if(t){t.style.transform='translateY(0)';t.style.opacity='1';}
}
function hideGToast(){
  var t=document.getElementById('globalToast');
  if(t){t.style.transform='translateY(80px)';t.style.opacity='0';}
}

// === HOMEPAGE ===

const steps=[
  {label:'step 01 of 04',title:'Welcome to the Flux knowledge system.',body:'This is a concept client built for Flux, a fictional fast-moving AI code review company. This knowledge system has been designed to keep every team member current, all the time.'},
  {label:'step 02 of 04',title:'The Current is the source of truth.',body:'Raw knowledge from engineering, product, and docs flows into The Current. From there, it is translated, contextualized, and organized into clear, usable content. The Current is human-authored and maintained — this is the layer that makes everything else possible.'},
  {label:'step 03 of 04',title:'The Grid is the content library.',body:'The Current feeds into The Grid, which is a modular block library for every piece of learning content. The Grid allows for tagging, versioning, and tracking. When one block is updated, the system identifies everywhere that block is used and flags what needs attention.'},
  {label:'step 04 of 04',title:'The Pulse tracks the health of the system.',body:'The Pulse tracks how fresh the content is and when something goes stale. This is done through click rates, tracking, and update tags. When content becomes out of date or incorrect, it is flagged and a ticket is opened automatically.'}
];
let step=0;
function startTour(){step=0;updateTour();document.getElementById('tour').classList.add('on')}
function closeTour(){document.getElementById('tour').classList.remove('on')}
function nextStep(){step++;if(step>=steps.length){closeTour();return}updateTour()}
function updateTour(){
  const s=steps[step];
  document.getElementById('tLabel').textContent=s.label;
  document.getElementById('tTitle').textContent=s.title;
  document.getElementById('tBody').textContent=s.body;
  const btn=document.querySelector('.t-next');if(btn){if(step===steps.length-1){btn.textContent='explore →';btn.onclick=finishTour;}else{btn.textContent='next →';btn.onclick=nextStep;}}
  document.getElementById('tDots').innerHTML=steps.map((_,i)=>`<div class="t-dot ${i===step?'on':''}"></div>`).join('');
}

function doReset(){
  // Reset tour
  step=0;

  // Reset layer interaction
  resetLayers();

  // Clear sessionStorage sync state
  try{
    sessionStorage.removeItem('flux_sync_run');
    sessionStorage.removeItem('flux_flagged');
  }catch(e){}

  // Visual confirmation
  const b=document.getElementById('resetBtn');
  b.textContent='reset';
  b.style.color='var(--fern)';
  b.style.borderColor='var(--fern)';
  setTimeout(()=>{
    b.textContent='↺';
    b.style.color='';
    b.style.borderColor='';
  },1200);
}
const layerDescs = {
  current: 'The Current — your layer, inside the same tool',
  grid: 'The Grid — where all content lives and gets distributed',
  pulse: 'The Pulse — analytics and tracking for the whole system'
};

let activeLayer = null;

function resetLayers() {
  activeLayer = null;
  document.querySelectorAll('.ltag').forEach(t => t.classList.remove('on'));
  const desc = document.getElementById('layerDesc');
  desc.style.opacity = '0';
  setTimeout(() => { desc.textContent = ''; desc.style.opacity = '1'; }, 150);
  const currentNode = document.querySelector('.lnode-dark');
  const gridNode = document.querySelector('.lnode-mid');
  const pulseNode = document.querySelector('.pulse-node');
  const srcNodes = document.querySelectorAll('.src');
  const dnNodes = document.querySelectorAll('.gc');
  const prodZone = document.querySelector('.prod-zone');
  [currentNode, gridNode, pulseNode].forEach(n => n.classList.remove('lit','dim'));
  [...srcNodes, ...dnNodes].forEach(n => n.classList.remove('lit','dim'));
  if (prodZone) { prodZone.style.borderColor = ''; }
}

function setLayer(layer) {
  // clicking the active layer resets to neutral
  if (activeLayer === layer) { resetLayers(); return; }
  activeLayer = layer;

  document.querySelectorAll('.ltag').forEach(t => {
    t.classList.toggle('on', t.dataset.layer === layer);
  });

  const desc = document.getElementById('layerDesc');
  desc.style.opacity = '0';
  setTimeout(() => {
    desc.textContent = layerDescs[layer];
    desc.style.opacity = '1';
  }, 150);

  const currentNode = document.querySelector('.lnode-dark');
  const gridNode = document.querySelector('.lnode-mid');
  const pulseNode = document.querySelector('.pulse-node');
  const srcNodes = document.querySelectorAll('.src');
  const dnNodes = document.querySelectorAll('.gc');
  const prodZone = document.querySelector('.prod-zone');

  [currentNode, gridNode, pulseNode].forEach(n => n.classList.remove('lit','dim'));
  [...srcNodes, ...dnNodes].forEach(n => n.classList.remove('lit','dim'));
  if (prodZone) prodZone.style.borderColor = '';

  if (layer === 'current') {
    currentNode.classList.add('lit');
    gridNode.classList.add('dim');
    pulseNode.classList.add('dim');
    srcNodes.forEach(n => n.classList.add('lit'));
    dnNodes.forEach(n => n.classList.add('dim'));
  } else if (layer === 'grid') {
    gridNode.classList.add('lit');
    currentNode.classList.add('dim');
    pulseNode.classList.add('dim');
    dnNodes.forEach(n => n.classList.add('lit'));
    srcNodes.forEach(n => n.classList.add('dim'));
    if (prodZone) prodZone.style.borderColor = 'var(--ember)';
  } else if (layer === 'pulse') {
    pulseNode.classList.add('lit');
    currentNode.classList.add('dim');
    gridNode.classList.add('dim');
    srcNodes.forEach(n => n.classList.add('dim'));
    dnNodes.forEach(n => n.classList.add('dim'));
  }
}

document.querySelectorAll('.ltag').forEach(t => {
  t.addEventListener('click', function() {
    setLayer(this.dataset.layer);
  });
});



// no default — neutral state on load
updateTour();




// === GRID ===
function initGrid(){
  if(typeof applyFilters==='function') applyFilters();
  if(window.innerWidth<768&&typeof setView==='function') setView('list');
}

const BLOCKS=[
  // PR DIGEST — 3 blocks from 1 Current entry
  {id:'0001',title:'PR Digest — concept',status:'current',tier:'passthrough',audience:'external',format:'article',tool:'LMS native',knowledgeType:'concept',version:'v2.4',dateCreated:'2026-01-12',dateModified:'2026-03-15',what:'PR Digest generates a plain-language summary of any pull request for non-technical reviewers. It appears automatically on every PR and requires no configuration.',alsoKnownAs:'auto-summary (legacy, pre-v2.4) · "the digest" (informal internal) · diff summary · PR summary',context:'Renamed from Auto-Summary in v2.4. This block is written for customers and non-technical stakeholders who encounter PR Digest in the product or documentation.',scope:'External',visual:{type:'Scribe embed',source:'scribe.rip/flux/pr-digest'},outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0001/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0001/gitbook'},{channel:'Loops',shareLink:'flux.to/b/0001/loops'}]},
  {id:'0001b',title:'PR Digest — walkthrough',status:'current',tier:'review',audience:'internal',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.4',dateCreated:'2026-01-20',dateModified:'2026-03-15',what:'A step-by-step walkthrough of PR Digest for internal teams — how to read it, how to share it with stakeholders, and how to use it in code review workflows.',alsoKnownAs:'PR digest walkthrough · digest tutorial',context:'Written for internal teams who use PR Digest daily. Covers how to interpret the digest, escalate based on its content, and share it with non-technical stakeholders.',scope:'Internal',visual:{type:'Scribe embed',source:'scribe.rip/flux/pr-digest-walkthrough'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0001b/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0001b/notion'}]},
  {id:'0001c',title:'PR Digest — release announcement',status:'current',tier:'passthrough',audience:'both',format:'article',tool:null,knowledgeType:'concept',version:'v2.4',dateCreated:'2026-03-10',dateModified:'2026-03-15',what:'A short announcement block explaining the PR Digest rename from Auto-Summary and what expanded in v2.4. Written for release communication channels.',alsoKnownAs:'PR digest announcement · auto-summary rename notice',context:'Used in the v2.4 release communication. Short, direct, written for both internal and external audiences. Links to the full PR Digest concept block for detail.',scope:'Internal · External · Both',visual:null,outputs:[{channel:'Loops',shareLink:'flux.to/b/0001c/loops'},{channel:'Slack',shareLink:'flux.to/b/0001c/slack'}]},
  // CI PIPELINE — 2 blocks from 1 Current entry
  {id:'0007',title:'CI Pipeline — internal',status:'current',tier:'review',audience:'internal',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.4',dateCreated:'2025-10-18',dateModified:'2026-03-20',what:'The CI Pipeline runs automated checks on every pull request before it can be merged. Covers configuration, required checks, failure handling, and how to interpret pipeline output.',alsoKnownAs:'build pipeline (proposed rename for v2.5) · automated checks · CI/CD pipeline',context:'Technical version for internal engineering and ops teams. Covers flux.yaml configuration, check types, and escalation when checks fail. Under review for v2.5 rename.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/ci-pipeline'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0007/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0007/notion'}]},
  {id:'0007b',title:'CI Pipeline — plain language',status:'current',tier:'passthrough',audience:'external',format:'article',tool:null,knowledgeType:'concept',version:'v2.4',dateCreated:'2026-01-15',dateModified:'2026-03-20',what:'A plain-language explanation of what the CI Pipeline does and what it means for product quality — written for customers and non-technical stakeholders who see CI status in PR Digest.',alsoKnownAs:'automated checks · build checks · CI status',context:'Customer-facing version. Avoids technical configuration detail. Focuses on what the pipeline guarantees — that code has been tested before it ships.',scope:'External',visual:null,outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0007b/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0007b/gitbook'}]},
  // PR COMMENTS — 2 blocks from 1 Current entry
  {id:'0006',title:'PR Comments — internal',status:'current',tier:'passthrough',audience:'internal',format:'article',tool:null,knowledgeType:'concept',version:'v2.0',dateCreated:'2025-07-10',dateModified:'2025-12-05',what:'PR Comments let reviewers leave inline feedback on specific lines of code. Covers blocking vs non-blocking comments and review etiquette for internal teams.',alsoKnownAs:'review comments · inline comments · code annotations',context:'Internal version. Focuses on how to use comments effectively in review, when to block, and how to resolve blocking comments.',scope:'Internal',visual:{type:'Scribe embed',source:'scribe.rip/flux/pr-comments-internal'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0006/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0006/notion'}]},
  {id:'0006b',title:'PR Comments — customer-facing',status:'current',tier:'passthrough',audience:'external',format:'article',tool:null,knowledgeType:'concept',version:'v2.0',dateCreated:'2026-01-08',dateModified:'2025-12-05',what:'An explanation of PR Comments for customers — what they are, how they appear in PR Digest, and what blocking comments mean for merge timelines.',alsoKnownAs:'review comments · PR feedback · inline feedback',context:'Customer-facing version. Explains how reviewer comments surface in the product from a customer perspective — not how to leave them.',scope:'External',visual:null,outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0006b/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0006b/gitbook'}]},
  // INCIDENT RESPONSE — 2 blocks from 1 Current entry
  {id:'0014',title:'Incident Response — internal runbook',status:'in review',tier:'review',audience:'internal',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.3',dateCreated:'2025-11-14',dateModified:'2026-03-18',what:'The operational runbook for production incidents. Covers severity classification, on-call responsibilities, escalation paths, and post-mortem requirements.',alsoKnownAs:'incident management · on-call process · incident runbook',context:'Internal operational version. Under review following March 2026 on-call rotation update.',scope:'Internal',visual:{type:'Scribe embed',source:'scribe.rip/flux/incident-response'},outputs:[{channel:'Notion',shareLink:'flux.to/b/0014/notion'},{channel:'WorkRamp internal',shareLink:'flux.to/b/0014/workramp-int'}]},
  {id:'0014b',title:'Incident Response — customer comms',status:'in review',tier:'review',audience:'external',format:'template',tool:null,knowledgeType:'template',version:'v2.3',dateCreated:'2026-01-20',dateModified:'2026-03-18',what:'Communication templates for customer-facing incident updates. Covers what to say at each severity level, timing expectations, and how to reference the Status Page.',alsoKnownAs:'incident communication · customer update templates · outage communication',context:'Separate from the internal runbook — this block is focused entirely on external communication. Written for the CSM and comms team who handle customer-facing updates during incidents.',scope:'External',visual:null,outputs:[{channel:'Loops',shareLink:'flux.to/b/0014b/loops'},{channel:'Notion',shareLink:'flux.to/b/0014b/notion'}]},
  // SYNTHESIS BLOCKS — no single Current entry
  {id:'S001',title:'Code Review Overview — CSM',status:'current',tier:'review',audience:'internal',format:'article',tool:null,knowledgeType:'process',version:'v2.4',dateCreated:'2026-02-01',dateModified:'2026-03-10',what:'A synthesized overview of how code gets reviewed and shipped at Flux — written for CSMs who need to explain the process to customers or handle questions about review timelines and merge behavior.',alsoKnownAs:'code review process · how PRs work at Flux · CSM code review guide',context:'Synthesis block. Draws from: Branch Protection, PR Comments, Code Review Rules, and Merge Queue entries in The Current. Written specifically for the CSM audience — focused on what they need to know to speak confidently about the product.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/code-review-overview'},outputs:[{channel:'Notion',shareLink:'flux.to/b/S001/notion'},{channel:'WorkRamp internal',shareLink:'flux.to/b/S001/workramp-int'}]},
  {id:'S002',title:'Getting Started with Flux API',status:'current',tier:'review',audience:'external',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.4',dateCreated:'2026-02-15',dateModified:'2026-03-12',what:'A synthesized getting-started guide for customers connecting to the Flux API — covering rate limits, webhook setup, and authentication in one structured flow.',alsoKnownAs:'API quickstart · Flux API guide · developer onboarding',context:'Synthesis block. Draws from: API Rate Limits and Webhook Setup entries in The Current. Written for developers who are new to Flux integrations. Combines what would otherwise be two separate reference articles into one practical guide.',scope:'External',visual:{type:'Scribe embed',source:'scribe.rip/flux/api-getting-started'},outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/S002/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/S002/gitbook'}]},
  // STANDARD 1:1 BLOCKS
  {id:'0002',title:'Merge Queue',status:'current',tier:'review',audience:'internal',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.3',dateCreated:'2025-11-04',dateModified:'2026-02-28',what:'Merge Queue controls the order in which pull requests are merged. It prevents conflicts by testing each PR against the current state of the branch before merging.',alsoKnownAs:'merge train (industry equivalent) · PR queue (informal internal) · merge pipeline',context:'Introduced in v2.3. The queue is configurable — concurrency limits, required checks, and priority rules can be set per repository.',scope:'Internal',visual:{type:'Scribe embed',source:'scribe.rip/flux/merge-queue'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0002/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0002/notion'}]},
  {id:'0003',title:'Auto-Summary',status:'flagged',tier:'rebuild',audience:'both',format:'article',tool:'LMS native',knowledgeType:'concept',version:'v2.3',dateCreated:'2025-09-20',dateModified:'2026-01-10',what:'Auto-Summary was the previous name for PR Digest. This block exists to support customers who onboarded before v2.4.',alsoKnownAs:'PR Digest (current name, v2.4+) · diff summary · change narrative',context:'Flagged for rebuild following the v2.4 rename. All references should update to PR Digest.',scope:'Internal · External · Both',visual:null,outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0003/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0003/gitbook'}]},
  {id:'0004',title:'Branch Protection',status:'current',tier:'passthrough',audience:'internal',format:'article',tool:null,knowledgeType:'policy',version:'v2.1',dateCreated:'2025-08-15',dateModified:'2026-01-22',what:'Branch protection rules prevent direct pushes to protected branches. All changes must come through a reviewed and approved pull request.',alsoKnownAs:'branch rules · protected branches · merge requirements',context:'Available since v2.1 and stable.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/branch-protection'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0004/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0004/notion'}]},
  {id:'0005',title:'Code Review Rules',status:'current',tier:'review',audience:'internal',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.2',dateCreated:'2025-09-01',dateModified:'2026-02-14',what:'Code review rules define the standards for reviewing pull requests at Flux — approvals required, turnaround time, and what makes a comment blocking.',alsoKnownAs:'review standards · PR review guidelines · code review policy',context:'Established in v2.2. Enforced culturally rather than technically.',scope:'Internal',visual:{type:'Scribe embed',source:'scribe.rip/flux/code-review-rules'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0005/workramp-int'},{channel:'Slack',shareLink:'flux.to/b/0005/slack'}]},
  {id:'0008',title:'Deployment Checklist',status:'current',tier:'passthrough',audience:'internal',format:'template',tool:null,knowledgeType:'template',version:'v2.2',dateCreated:'2025-09-12',dateModified:'2026-01-30',what:'A required checklist for every production deployment. Covers pre-deploy verification, monitoring setup, rollback preparation, and post-deploy confirmation.',alsoKnownAs:'deploy checklist · release checklist · go-live checklist',context:'Introduced in v2.2 after two production incidents. Required for all deployments.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/deployment-checklist'},outputs:[{channel:'Notion',shareLink:'flux.to/b/0008/notion'},{channel:'Slack',shareLink:'flux.to/b/0008/slack'}]},
  {id:'0009',title:'Release Notes Template',status:'current',tier:'review',audience:'both',format:'template',tool:null,knowledgeType:'template',version:'v2.3',dateCreated:'2025-11-22',dateModified:'2026-03-01',what:'A standardized format for every Flux release communication. Covers new features, improvements, bug fixes, deprecations, and known issues.',alsoKnownAs:'changelog template · release communication template · version notes format',context:'Standardized in v2.3. One template serves internal and customer-facing audiences.',scope:'Internal · External · Both',visual:{type:'Figma embed',source:'figma.com/flux/release-notes-template'},outputs:[{channel:'Loops',shareLink:'flux.to/b/0009/loops'},{channel:'Slack',shareLink:'flux.to/b/0009/slack'},{channel:'GitBook',shareLink:'flux.to/b/0009/gitbook'}]},
  {id:'0010',title:'API Rate Limits',status:'current',tier:'review',audience:'external',format:'article',tool:null,knowledgeType:'reference',version:'v2.3',dateCreated:'2025-10-05',dateModified:'2026-02-10',what:'API Rate Limits define the maximum number of requests a customer can make to the Flux API within a given time window. Limits vary by plan tier.',alsoKnownAs:'rate limiting · API throttling · request limits · API quotas',context:'Flagged in The Current — v2.5 limits not yet reflected in authored content. Restored to current in Grid pending Current update.',scope:'External',visual:{type:'Figma embed',source:'figma.com/flux/api-rate-limits'},outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0010/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0010/gitbook'},{channel:'Loops',shareLink:'flux.to/b/0010/loops'}]},
  {id:'0011',title:'Webhook Setup',status:'current',tier:'passthrough',audience:'external',format:'tutorial',tool:'Scribe',knowledgeType:'process',version:'v2.1',dateCreated:'2025-08-28',dateModified:'2026-01-15',what:'Walks through configuring webhooks to receive real-time event notifications from Flux.',alsoKnownAs:'webhook configuration · event notifications · outbound webhooks',context:'Available since v2.1. Setup process stable. Part of the Getting Started with Flux API synthesis block.',scope:'External',visual:{type:'Scribe embed',source:'scribe.rip/flux/webhook-setup'},outputs:[{channel:'WorkRamp external',shareLink:'flux.to/b/0011/workramp-ext'},{channel:'GitBook',shareLink:'flux.to/b/0011/gitbook'}]},
  {id:'0012',title:'Team Permissions',status:'needs update',tier:'rebuild',audience:'internal',format:'article',tool:null,knowledgeType:'policy',version:'v2.2',dateCreated:'2025-09-08',dateModified:'2025-12-20',what:'Defines the access control model for Flux — what each role can see, do, and configure.',alsoKnownAs:'access control · role-based access · RBAC · user permissions · team roles',context:'Needs full rebuild. v2.5 introduced Admin role and split Editor into Reviewer and Editor.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/team-permissions'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0012/workramp-int'},{channel:'Notion',shareLink:'flux.to/b/0012/notion'},{channel:'Slack',shareLink:'flux.to/b/0012/slack'}]},
  {id:'0013',title:'Status Page',status:'current',tier:'passthrough',audience:'external',format:'article',tool:null,knowledgeType:'reference',version:'v2.0',dateCreated:'2025-07-22',dateModified:'2025-11-30',what:'The Flux Status Page shows real-time system health, active incidents, and scheduled maintenance.',alsoKnownAs:'system status · service health · uptime page · incident dashboard',context:'Available since v2.0. Stable.',scope:'External',visual:null,outputs:[{channel:'GitBook',shareLink:'flux.to/b/0013/gitbook'},{channel:'Loops',shareLink:'flux.to/b/0013/loops'}]},
  {id:'0015',title:'Onboarding Checklist',status:'current',tier:'passthrough',audience:'internal',format:'template',tool:null,knowledgeType:'template',version:'v2.4',dateCreated:'2026-01-05',dateModified:'2026-03-10',what:'Covers everything a new Flux team member needs in their first 30 days — access setup, tool configuration, required learning, and key introductions.',alsoKnownAs:'new hire checklist · 30-day plan · onboarding guide',context:'Updated in v2.4. Synthesizes knowledge from across The Current into one practical checklist.',scope:'Internal',visual:{type:'Figma embed',source:'figma.com/flux/onboarding-checklist'},outputs:[{channel:'WorkRamp internal',shareLink:'flux.to/b/0015/workramp-int'},{channel:'Slack',shareLink:'flux.to/b/0015/slack'}]}
];

const VERSION_HISTORY={
  '0001':[{v:'v2.4',date:'Mar 2026',note:'Renamed from Auto-Summary. Expanded to include reviewer comments and CI status.',current:true},{v:'v2.3',date:'Nov 2025',note:'Added screenshot walkthrough for stakeholder view.'},{v:'v2.0',date:'Jul 2025',note:'Initial block created as Auto-Summary.'}],
  '0003':[{v:'v2.3',date:'Jan 2026',note:'Flagged for rebuild following v2.4 rename.',current:true},{v:'v2.2',date:'Oct 2025',note:'Minor copy edits.'},{v:'v2.0',date:'Sep 2025',note:'Initial block created.'}],
  '0007':[{v:'v2.4',date:'Mar 2026',note:'Under review — rename to Build Pipeline pending v2.5.',current:true},{v:'v2.3',date:'Dec 2025',note:'Added Figma diagram of pipeline stages.'},{v:'v2.1',date:'Oct 2025',note:'Initial block created.'}],
  '0010':[{v:'v2.3',date:'Feb 2026',note:'Flagged — rate limit values reflect v2.3, not v2.5.',current:true},{v:'v2.3',date:'Oct 2025',note:'Initial block created.'}],
  '0012':[{v:'v2.2',date:'Dec 2025',note:'Needs full rebuild — v2.5 permissions model not reflected.',current:true},{v:'v2.2',date:'Sep 2025',note:'Initial block created.'}],
};

let currentView = window.innerWidth < 768 ? 'list' : 'grid';
let filteredBlocks = [...BLOCKS];

function statusClass(s){ return 's-'+s.replace(' ','-') }
function statusTagClass(s){ return 'st-'+s.replace(' ','-') }
function statusColor(s){
  return {current:'#1D9E75',flagged:'#C42B2B','in review':'#D4A017','needs update':'#901818'}[s]||'#9B948C';
}
function tierClass(t){
  return {passthrough:'tt-pass',review:'tt-review',rebuild:'tt-rebuild'}[t]||'tt-review';
}
function fmtDate(d){
  return new Date(d).toLocaleDateString('en-US',{month:'short',day:'numeric',year:'numeric'});
}

function renderBlocks(){
  const c = document.getElementById('blockContainer');
  c.className = currentView==='grid' ? 'card-grid' : 'card-list';
  if(!filteredBlocks.length){
    c.innerHTML='<div class="empty"><div class="empty-title">No blocks match these filters</div><div class="empty-sub">Try adjusting or clearing your filters</div></div>';
    updateStats(); return;
  }
  c.innerHTML = filteredBlocks.map(b => {
    const sc = statusClass(b.status);
    const stag = `<span class="stag ${statusTagClass(b.status)}"><span class="stag-dot" style="background:${statusColor(b.status)}"></span>${b.status}</span>`;
    if(currentView==='grid'){
      return `<div class="block-card ${sc}" id="card-${b.id}" onclick="openModal('${b.id}')">
        <div class="card-eyebrow">block-${b.id} · ${b.format}</div>
        <div class="card-title">${b.title}</div>
        <div class="card-status-row">
          ${stag}
          <span class="card-audience">${b.audience}</span>
        </div>
        <div class="card-footer">
          <div class="card-date">modified ${fmtDate(b.dateModified)}</div>
          <span class="ttag ${tierClass(b.tier)}">${b.tier}</span>
        </div>
      </div>`;
    } else {
      return `<div class="list-card ${sc}" id="card-${b.id}" onclick="openModal('${b.id}')">
        <div class="lc-id">${b.id}</div>
        <div class="lc-title">${b.title}</div>
        <div class="lc-status">${stag}</div>
        <div class="lc-audience">${b.audience}</div>
        <div class="lc-date">${fmtDate(b.dateModified)}</div>
      </div>`;
    }
  }).join('');
  updateStats();
}

function updateStats(){
  const all=BLOCKS;
  const cnt={current:0,flagged:0,'in review':0,'needs update':0};
  all.forEach(b=>{ if(cnt[b.status]!==undefined) cnt[b.status]++ });
  const active=document.getElementById('f-status').value;
  document.getElementById('statsCount').innerHTML=`<strong>${filteredBlocks.length}</strong> of <strong>${BLOCKS.length}</strong> block${BLOCKS.length!==1?'s':''}`;
  document.getElementById('statsPills').innerHTML=[
    cnt.current?`<span class="sp sp-current ${active==='current'?'active':''}" onclick="togglePillFilter('current')">${cnt.current} current</span>`:'',
    cnt['in review']?`<span class="sp sp-review ${active==='in review'?'active':''}" onclick="togglePillFilter('in review')">${cnt['in review']} in review</span>`:'',
    cnt.flagged?`<span class="sp sp-flagged ${active==='flagged'?'active':''}" onclick="togglePillFilter('flagged')">${cnt.flagged} flagged</span>`:'',
    cnt['needs update']?`<span class="sp sp-needs ${active==='needs update'?'active':''}" onclick="togglePillFilter('needs update')">${cnt['needs update']} needs update</span>`:'',
  ].join('');
}

function togglePillFilter(status){
  const sel=document.getElementById('f-status');
  if(sel.value===status){
    sel.value='';
  } else {
    sel.value=status;
  }
  applyFilters();
}

function applyFilters(){
  const st=document.getElementById('f-status').value;
  const ti=document.getElementById('f-tier').value;
  const au=document.getElementById('f-audience').value;
  const fo=document.getElementById('f-format').value;
  const kn=document.getElementById('f-knowledge').value;
  const so=document.getElementById('f-sort').value;
  const has=st||ti||au||fo||kn;
  document.getElementById('clearBtn').classList.toggle('show',!!has);
  ['f-status','f-tier','f-audience','f-format','f-knowledge'].forEach(id=>{
    document.getElementById(id).classList.toggle('active',!!document.getElementById(id).value);
  });
  filteredBlocks=BLOCKS.filter(b=>{
    if(st&&b.status!==st)return false;
    if(ti&&b.tier!==ti)return false;
    if(au&&b.audience!==au)return false;
    if(fo&&b.format!==fo)return false;
    if(kn&&b.knowledgeType!==kn)return false;
    return true;
  });
  filteredBlocks.sort((a,b)=>{
    if(so==='dateModified')return new Date(b.dateModified)-new Date(a.dateModified);
    if(so==='dateCreated')return new Date(b.dateCreated)-new Date(a.dateCreated);
    if(so==='alpha')return a.title.localeCompare(b.title);
    if(so==='status'){const o=['needs update','flagged','in review','current'];return o.indexOf(a.status)-o.indexOf(b.status)}
    return 0;
  });
  renderBlocks();
}

function clearFilters(){
  ['f-status','f-tier','f-audience','f-format','f-knowledge'].forEach(id=>{
    document.getElementById(id).value='';
    document.getElementById(id).classList.remove('active');
  });
  document.getElementById('clearBtn').classList.remove('show');
  filteredBlocks=[...BLOCKS];
  applyFilters();
}

function setView(v){
  currentView=v;
  document.getElementById('vt-grid').classList.toggle('on',v==='grid');
  document.getElementById('vt-list').classList.toggle('on',v==='list');
  renderBlocks();
}

let hasSynced = false;
// SYNC_TARGETS defined globally above
const ORIGINAL_STATUS = {};
BLOCKS.forEach(b => { ORIGINAL_STATUS[b.id] = b.status; });

function runSync(){
  const btn=document.getElementById('syncBtn');
  if(btn.classList.contains('syncing'))return;

  if(hasSynced){
    resetSync();
    return;
  }

  dismissNudge();
  btn.classList.add('syncing');
  btn.innerHTML='<span class="sync-icon">↻</span> syncing...';
  const toast=document.getElementById('toast');
  const toastTitle=document.getElementById('toastTitle');
  const toastBody=document.getElementById('toastBody');
  toast.classList.add('show');
  toastTitle.textContent='scanning blocks...';
  toastBody.textContent='';
  const cards=Array.from(document.querySelectorAll('[id^="card-"]'));
  let i=0;
  function next(){
    if(i>=cards.length){
      setTimeout(()=>{
        toastTitle.textContent='sync complete';
        toastBody.innerHTML='2 blocks flagged for review<br>tickets opened in Notion';
        SYNC_TARGETS.forEach(id=>{
          const card=document.getElementById('card-'+id);
          if(!card)return;
          const block=BLOCKS.find(b=>b.id===id);
          if(block)block.status='flagged';
          card.className=card.className.replace(/s-\S+/,'').replace('newly-flagged','').trim()+' s-flagged newly-flagged';
          const stRow=card.querySelector('.card-status-row,.lc-status');
          if(stRow){
            const stag=stRow.querySelector('.stag');
            if(stag){stag.className='stag st-flagged';stag.innerHTML=`<span class="stag-dot" style="background:#C42B2B"></span>flagged`}
          }
        });
        hasSynced = true;
        btn.classList.remove('syncing');
        btn.innerHTML='<span class="sync-icon">↺</span> reset demo';
        updateStats();
        setTimeout(()=>toast.classList.remove('show'),3500);
      },500);
      return;
    }
    const card=cards[i];
    card.classList.add('scanning');
    const titleEl=card.querySelector('.card-title,.lc-title');
    toastBody.textContent=`checking ${titleEl?.textContent||''}...`;
    setTimeout(()=>{card.classList.remove('scanning');i++;setTimeout(next,75)},110);
  }
  setTimeout(next,300);
}

function resetSync(){
  SYNC_TARGETS.forEach(id=>{
    const block=BLOCKS.find(b=>b.id===id);
    if(block) block.status = ORIGINAL_STATUS[id];
    const card=document.getElementById('card-'+id);
    if(card){
      card.className=card.className.replace(/s-\S+/,'').replace('newly-flagged','').trim()+' s-current';
      const stRow=card.querySelector('.card-status-row,.lc-status');
      if(stRow){
        const stag=stRow.querySelector('.stag');
        if(stag){stag.className='stag st-current';stag.innerHTML=`<span class="stag-dot" style="background:#1D9E75"></span>current`}
      }
    }
  });
  hasSynced = false;
  try{sessionStorage.removeItem('flux_sync_run');sessionStorage.removeItem('flux_flagged');}catch(e){}
  const btn=document.getElementById('syncBtn');
  btn.innerHTML='<span class="sync-icon">↻</span> sync';
  updateStats();

  const toast=document.getElementById('toast');
  document.getElementById('toastTitle').textContent='demo reset';
  document.getElementById('toastBody').textContent='blocks restored to starting state';
  toast.classList.add('show');
  setTimeout(()=>toast.classList.remove('show'),2500);
}

function openModal(id){
  if(typeof dismissNudge==="function") dismissNudge();
  const b=BLOCKS.find(x=>x.id===id);if(!b)return;
  document.getElementById('mEyebrow').textContent=`block-${b.id} · ${b.format} · ${b.knowledgeType}`;
  document.getElementById('mTitle').textContent=b.title;
  const stag=`<span class="stag ${statusTagClass(b.status)}" style="font-size:13px;padding:4px 12px"><span class="stag-dot" style="background:${statusColor(b.status)}"></span>${b.status}</span>`;
  const ttag=`<span class="ttag ${tierClass(b.tier)}" style="font-size:12px">${b.tier}</span>`;
  const vtag=`<span class="vtag">${b.version}</span>`;
  const aud=`<span style="font-size:13px;color:var(--ash);text-transform:lowercase">${b.audience}</span>`;
  document.getElementById('mMeta').innerHTML=stag+ttag+vtag+aud;
  const hist=VERSION_HISTORY[b.id]||[{v:b.version,date:'current',note:'Current version.',current:true}];
  document.getElementById('mBody').innerHTML=`
    <div class="ms">
      <div class="ms-label">What it is</div>
      <div class="ms-value">${b.what}</div>
    </div>
    <div class="ms">
      <div class="ms-label">Also known as</div>
      <div class="ms-mono">${b.alsoKnownAs}</div>
    </div>
    <div class="ms">
      <div class="ms-label">Context</div>
      <div class="ms-value">${b.context}</div>
    </div>
    <div class="ms">
      <div class="ms-label">Scope</div>
      <div class="ms-mono">${b.scope}</div>
    </div>
    ${b.visual?`<div class="ms"><div class="ms-label">Visual</div><div class="ms-mono">${b.visual.type} <span style="color:var(--ash)">·</span> <span style="color:var(--ember-d)">${b.visual.source}</span></div></div>`:''}
    <div class="ms-divider"></div>
    <div class="ms">
      <div class="ms-label">Version history</div>
      <div class="vh">
        ${hist.map(h=>`<div class="vh-item ${h.current?'current':''}">
          <div class="vh-v">${h.v}</div>
          <div class="vh-date">${h.date}</div>
          <div class="vh-note">${h.note}</div>
        </div>`).join('')}
      </div>
    </div>
    <div class="ms-divider"></div>
    <div class="ms">
      <div class="ms-label">Connected outputs</div>
      <div class="outputs">
        ${b.outputs.map(o=>{
          const slug = {'WorkRamp internal':'workramp-int','WorkRamp external':'workramp-ext','Notion':'notion','GitBook':'gitbook','Slack':'slack','Loops':'loops'}[o.channel]||'channel';
          const shareUrl = o.shareLink.replace('/b/','/b/') + '/' + slug;
          return `<div class="output-row">
            <div class="or-channel">${o.channel}</div>
            <div class="or-links">
              <a class="or-link" href="#" onclick="showLinkPopup(event,'edit','${o.channel}')">edit ↗</a>
              <a class="or-link share" href="#" onclick="showLinkPopup(event,'share','${o.channel}','${shareUrl}')">share ↗</a>
            </div>
          </div>`;
        }).join('')}
      </div>
    </div>
    <div class="ms" style="margin-top:20px">
      <div class="ms-label">Tracking</div>
      <div class="sb-note" style="background:var(--canvas);padding:12px 14px;border-radius:8px;border:0.5px solid var(--rule)">Each output has its own share link. Click data flows back to The Pulse and is attributed per channel. Total clicks, time of access, and device are recorded for each link.</div>
    </div>
  `;
  document.getElementById('modalOverlay').classList.add('on');
  document.body.style.overflow='hidden';
}

function closeModal(){
  document.getElementById('modalOverlay').classList.remove('on');
  document.body.style.overflow='';
}
function closeModalOutside(e){
  if(e.target===document.getElementById('modalOverlay'))closeModal();
}
function copyLink(url,btn){
  navigator.clipboard.writeText(url).then(()=>{
    btn.textContent='copied!';setTimeout(()=>btn.textContent='copy',1500);
  }).catch(()=>{btn.textContent='copied!';setTimeout(()=>btn.textContent='copy',1500)});
}
document.addEventListener('keydown',e=>{if(e.key==='Escape')closeModal()});

function showLinkPopup(e, type, channel, shareUrl){
  e.preventDefault();
  e.stopPropagation();
  const popup = document.getElementById('linkPopup');
  const text = document.getElementById('lpText');

  const channelEditMessages = {
    'WorkRamp internal': 'This would open the WorkRamp course editor where this block is published for internal learners.',
    'WorkRamp external': 'This would open the WorkRamp academy editor where this block is published for customers.',
    'Notion': 'This would open the Notion page where this block lives as a runbook or internal doc.',
    'GitBook': 'This would open the GitBook doc where this content is published externally.',
    'Slack': 'This would open the Slack workflow where this announcement is drafted and queued for approval.',
    'Loops': 'This would open the Loops email template where this block appears in the customer release email.',
  };
  const channelShareMessages = {
    'WorkRamp internal': `This is the tracked share link for WorkRamp internal.\n\nflux.to/b/xxxx/workramp-int\n\nClicks are recorded and flow back to The Pulse.`,
    'WorkRamp external': `This is the tracked share link for WorkRamp external.\n\nflux.to/b/xxxx/workramp-ext\n\nClicks are recorded and flow back to The Pulse.`,
    'Notion': `This is the tracked share link for Notion.\n\nflux.to/b/xxxx/notion\n\nClicks are recorded and flow back to The Pulse.`,
    'GitBook': `This is the tracked share link for GitBook.\n\nflux.to/b/xxxx/gitbook\n\nClicks are recorded and flow back to The Pulse.`,
    'Slack': `This is the tracked share link for Slack.\n\nflux.to/b/xxxx/slack\n\nClicks are recorded and flow back to The Pulse.`,
    'Loops': `This is the tracked share link for Loops.\n\nflux.to/b/xxxx/loops\n\nClicks are recorded and flow back to The Pulse.`,
  };
  const messages = {
    edit: channelEditMessages[channel] || `This would open ${channel} to update the content published there.`,
    share: channelShareMessages[channel] || `This is the tracked share link for ${channel}. Clicks flow back to The Pulse.`,
    nav: `${channel} is part of the case study — coming soon in this build.`
  };
  text.textContent = messages[type] || 'This would link out in the live version.';

  const rect = e.currentTarget.getBoundingClientRect();
  popup.style.left = Math.max(16, rect.left) + 'px';
  popup.style.top = (rect.bottom + 10) + 'px';
  popup.classList.add('show');

  clearTimeout(popup._hideTimer);
  popup._hideTimer = setTimeout(() => popup.classList.remove('show'), 2800);
}

document.addEventListener('click', (e) => {
  if(!e.target.closest('.link-popup') && !e.target.closest('.or-link')){
    document.getElementById('linkPopup').classList.remove('show');
  }
});

// called by initGrid()





// open block from URL hash — e.g. #block-0001 from The Current
if(window.location.hash){
  const match = window.location.hash.match(/#block-(\d+)/);
  if(match){
    const id = match[1];
    setTimeout(() => {
      openModal(id);
      // scroll card into view
      const card = document.getElementById('card-' + id);
      if(card) card.scrollIntoView({behavior:'smooth', block:'center'});
    }, 200);
  }
}

// nudge timer moved to global router

function dismissNudge(){
  _nudgeDismissed = true;
  if(_nudgeTimer){ clearTimeout(_nudgeTimer); _nudgeTimer = null; }
  document.getElementById('syncNudge').classList.remove('show');
}

function setTab(tab){
  document.getElementById('tab-blocks').classList.toggle('active', tab==='blocks');
  document.getElementById('tab-outputs').classList.toggle('active', tab==='outputs');
  document.getElementById('toolbar-blocks').style.display = tab==='blocks' ? '' : 'none';
  document.getElementById('stats-bar').style.display = tab==='blocks' ? '' : 'none';
  document.getElementById('blockContainer').parentElement.style.display = tab==='blocks' ? '' : 'none';
  document.getElementById('outputs-view').style.display = tab==='outputs' ? '' : 'none';
  if(tab==='outputs') buildOutputsView();
}

const TOOLS = [
  {key:'WorkRamp internal', name:'WorkRamp', sub:'internal learning paths', cls:'ov-workreamp'},
  {key:'WorkRamp external', name:'WorkRamp', sub:'customer academy', cls:'ov-workreamp'},
  {key:'Notion', name:'Notion', sub:'runbooks · internal docs', cls:'ov-notion'},
  {key:'GitBook', name:'GitBook', sub:'external docs · self-maintains', cls:'ov-gitbook'},
  {key:'Slack', name:'Slack', sub:'internal announcements', cls:'ov-slack'},
  {key:'Loops', name:'Loops', sub:'customer release email', cls:'ov-loops'},
];

// Note: S001, S002 are synthesis blocks — drawn from multiple Current entries

function ovCardHtml(tool){
  const blocks = BLOCKS.filter(b => b.outputs.some(o => o.channel === tool.key));
  const flagged = blocks.filter(b => b.status==='flagged'||b.status==='needs update').length;
  const inreview = blocks.filter(b => b.status==='in review').length;
  return `<div class="ov-card ${tool.cls}">
    <div class="ov-tool">
      <div>
        <div class="ov-tool-name">${tool.name}</div>
        <div class="ov-tool-type">${tool.sub}</div>
      </div>
      ${flagged ? `<span class="stag st-flagged" style="margin-left:auto;font-size:11px;padding:2px 8px"><span class="stag-dot" style="background:#C42B2B"></span>${flagged} flagged</span>` : ''}
      ${!flagged && inreview ? `<span class="stag st-in-review" style="margin-left:auto;font-size:11px;padding:2px 8px"><span class="stag-dot" style="background:#D4A017"></span>${inreview} in review</span>` : ''}
    </div>
    <div class="ov-blocks">
      ${blocks.map(b => `<div class="ov-block-row" onclick="openModal('${b.id}')">
        <div class="ov-block-title">${b.title}</div>
        <span class="stag ${statusTagClass(b.status)}" style="font-size:10px;padding:2px 7px"><span class="stag-dot" style="background:${statusColor(b.status)}"></span>${b.status}</span>
      </div>`).join('')}
    </div>
    <div class="ov-block-count">${blocks.length} block${blocks.length!==1?'s':''} feeding this channel</div>
  </div>`;
}

function buildOutputsView(){
  const grid = document.getElementById('ovGrid');
  const pairs = [
    {label:'learning', tools:['WorkRamp internal','WorkRamp external']},
    {label:'docs', tools:['Notion','GitBook']},
    {label:'comms', tools:['Slack','Loops']},
  ];
  grid.innerHTML = pairs.map(pair => {
    const toolObjs = pair.tools.map(key => TOOLS.find(t => t.key===key)).filter(Boolean);
    return `<div>
      <div class="ov-pair-label">${pair.label}</div>
      <div class="ov-pair">
        ${toolObjs.map(t => ovCardHtml(t)).join('')}
      </div>
    </div>`;
  }).join('');
}


// === CURRENT ===
function initCurrent(){if(typeof cuRender==='function')cuRender();}

const SECTIONS = [
  {
    key:'foundations',
    label:'Foundations',
    desc:'Start here if you are new to Flux or to code review workflows.'
  },
  {
    key:'workflow',
    label:'Workflow',
    desc:'How code moves from idea to merge at Flux.'
  },
  {
    key:'deployment',
    label:'Deployment & Operations',
    desc:'What happens after code is merged and when things go wrong.'
  },
  {
    key:'access',
    label:'Permissions & Access',
    desc:'Who can do what across Flux repositories and settings.'
  },
  {
    key:'customer',
    label:'Customer Facing',
    desc:'What customers see, use, and experience from Flux.'
  },
  {
    key:'templates',
    label:'Templates & Process',
    desc:'Reusable formats and checklists the team follows.'
  },
  {
    key:'deprecated',
    label:'Legacy & Deprecated',
    desc:'Content that has been superseded. Kept for historical reference.'
  }
];

const ENTRIES = [
  // FOUNDATIONS — no direct Grid blocks, pure knowledge context
  {
    id:'what-is-a-repository',section:'foundations',
    title:'What is a repository',
    status:'current',version:'v2.0',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Git fundamentals',
      updated:'Jan 10, 2026',
      text:'A repository (repo) is a directory that contains all of the files and history for a project. At Flux, every product, service, and tool lives in its own repository. Repositories are the containers that everything else — branches, commits, pull requests — lives inside.'
    },
    what:'A repository is the home for a codebase. Think of it as a folder that contains not just the current code but the entire history of every change ever made to it. At Flux, understanding repositories is the starting point for understanding how anything gets built.',
    alsoKnownAs:'repo · codebase · project',
    context:'This is foundational context that informs how all other concepts in this document connect. It does not map directly to a Grid block — instead it colors how every workflow block is written and understood.',
    scope:'internal · external · both',
    appearsIn:['(foundational — informs all blocks)']
  },
  {
    id:'what-is-a-branch',section:'foundations',
    title:'What is a branch',
    status:'current',version:'v2.0',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Git fundamentals',
      updated:'Jan 10, 2026',
      text:'A branch is a parallel version of a repository. Changes made on a branch do not affect the main codebase until the branch is merged. Branches allow multiple engineers to work simultaneously without interfering with each other.'
    },
    what:'A branch is a safe copy of the codebase where an engineer can make changes without affecting the live product. When the work is ready, the branch gets merged back in through a pull request. Every piece of work at Flux starts on its own branch.',
    alsoKnownAs:'feature branch · working branch · dev branch',
    context:'Foundational context. Branches are the prerequisite for understanding pull requests, merge queues, and branch protection. Does not map to a Grid block directly — it is assumed knowledge in every workflow block.',
    scope:'internal · external · both',
    appearsIn:['(foundational — informs all blocks)']
  },
  {
    id:'what-is-a-commit',section:'foundations',
    title:'What is a commit',
    status:'current',version:'v2.0',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Git fundamentals',
      updated:'Jan 10, 2026',
      text:'A commit is a saved snapshot of changes to files in a repository. Each commit has a unique identifier, a timestamp, and a message describing the change. Commits are the atomic units of change history in Git.'
    },
    what:'A commit is a saved checkpoint — a snapshot of what the code looked like at a specific moment. Engineers make commits throughout their work to save progress. When a pull request is opened, reviewers can see each commit and what changed in it.',
    alsoKnownAs:'changeset · snapshot · save point',
    context:'Foundational context. Commits are how code changes accumulate inside a branch before a pull request is opened. Does not map to a Grid block directly.',
    scope:'internal · external · both',
    appearsIn:['(foundational — informs all blocks)']
  },
  {
    id:'what-is-a-pull-request',section:'foundations',
    title:'What is a pull request',
    status:'current',version:'v2.0',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Git fundamentals',
      updated:'Jan 10, 2026',
      text:'A pull request (PR) is a proposal to merge a set of changes from one branch into another. Pull requests are the primary mechanism for code review and collaboration at Flux. Every change to the main codebase goes through a pull request.'
    },
    what:'A pull request is how engineers at Flux propose a code change for review before it becomes part of the product. Think of it as a structured conversation around a change — where the code lives, who reviews it, and what has to happen before it ships.',
    alsoKnownAs:'PR · merge request (MR, used in GitLab) · change request',
    context:'Understanding pull requests is the foundation for almost everything else in this document. Every feature, fix, and improvement at Flux starts as a pull request. This foundational concept informs PR Digest, PR Comments, Merge Queue, CI Pipeline, and Branch Protection.',
    scope:'internal · external · both',
    appearsIn:['(foundational — informs PR Digest, PR Comments, Merge Queue, CI Pipeline, Branch Protection)']
  },
  {
    id:'how-flux-uses-ai',section:'foundations',
    title:'How Flux uses AI',
    status:'current',version:'v2.4',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 20, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · AI features · Product overview',
      updated:'Mar 15, 2026',
      text:'Flux uses large language models to analyze pull request diffs, generate natural language summaries, surface potential issues, and suggest improvements. AI features are applied automatically and do not require configuration from end users. Model outputs are clearly labeled as AI-generated throughout the product.'
    },
    what:'Flux is an AI-powered code review tool. AI runs automatically on every pull request — generating PR Digest summaries, flagging potential issues in code, and surfacing context that helps reviewers and non-technical stakeholders understand what changed and why.',
    alsoKnownAs:'AI features · LLM integration · automated analysis · AI code review',
    context:'This entry provides the product context that makes PR Digest intelligible to non-technical audiences. It does not map to a single Grid block — it colors the framing of all customer-facing content at Flux. Customer-facing copy should reference AI naturally without over-explaining the technology.',
    scope:'internal · external · both',
    appearsIn:['(context — colors all customer-facing blocks, especially PR Digest)']
  },
  {
    id:'terminology-guide',section:'foundations',
    title:'Terminology guide',
    status:'current',version:'v2.4',knowledgeType:'reference',audience:'both',
    lastReviewed:'Mar 22, 2026',reviewedBy:'J. Cellitti',
    transcluded:null,
    what:'A reference for how Flux uses language — internally and externally. When terms differ between what engineering uses, what customers hear, and what the industry standard is, this entry is the source of truth for which term to use and when.',
    alsoKnownAs:'language guide · terminology reference · word list · style terms',
    context:'This entry does not map to a Grid block. It is a living reference for the learning team and anyone writing at Flux. Every block in The Grid should be checked against this entry for terminology consistency. Key distinctions: PR Digest (not Auto-Summary), Build Pipeline (not CI Pipeline, post-v2.5), Reviewer role (not Editor, post-v2.5).',
    scope:'internal',
    appearsIn:['(reference — informs all blocks, especially customer-facing copy)']
  },
  {
    id:'flux-release-cycle',section:'foundations',
    title:'The Flux release cycle',
    status:'current',version:'v2.4',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 10, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Release process · Versioning',
      updated:'Mar 1, 2026',
      text:'Flux follows semantic versioning (major.minor.patch). Minor releases ship on a two-week cadence. Patch releases ship as needed. Major releases are planned quarterly. Each release includes a changelog, internal release notes, and customer-facing communications.'
    },
    what:'Understanding how Flux ships is essential context for everyone who communicates about the product. Flux releases frequently — minor versions every two weeks. This cadence is why The Current and The Grid exist: to keep knowledge current at the pace the product moves.',
    alsoKnownAs:'release cadence · versioning · ship cycle · release process',
    context:'This entry informs the Release Notes Template block and all release-adjacent communication blocks. It explains why content freshness is a real operational challenge at Flux — not a theoretical one.',
    scope:'internal · external · both',
    appearsIn:['Release Notes Template','(also informs: all versioned blocks)']
  },
  // WORKFLOW
  {
    id:'branch-protection',section:'workflow',
    title:'Branch protection',
    status:'current',version:'v2.1',knowledgeType:'policy',audience:'internal',
    lastReviewed:'Jan 22, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Repository settings · Branch rules',
      updated:'Jan 5, 2026',
      text:'Branch protection rules are configured at the repository level and prevent direct pushes to protected branches. Required status checks, required reviewer approvals, and linear history enforcement are the primary configurable options.'
    },
    what:'Branch protection rules prevent anyone from pushing directly to protected branches. All changes must come through a reviewed and approved pull request. This keeps the main codebase stable and every change traceable.',
    alsoKnownAs:'branch rules · protected branches · merge requirements',
    context:'Available since v2.1 and stable. This policy feeds the internal Branch Protection block in The Grid and contributes to the Code Review Overview synthesis block used in CSM runbooks.',
    scope:'internal',
    appearsIn:['Branch Protection (internal)','Code Review Overview — CSM (synthesis)']
  },
  {
    id:'pr-comments',section:'workflow',
    title:'PR comments',
    status:'current',version:'v2.0',knowledgeType:'concept',audience:'both',
    lastReviewed:'Dec 5, 2025',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · PR Comments feature page',
      updated:'Nov 20, 2025',
      text:'PR Comments are inline annotations attached to specific lines of changed code within a pull request. Comments can be marked as blocking, which prevents the PR from being merged until the comment is resolved.'
    },
    what:'PR comments let reviewers leave feedback directly on specific lines of code. A comment can be informational or blocking. Blocking comments must be resolved before the PR can merge.',
    alsoKnownAs:'review comments · inline comments · code annotations · PR feedback',
    context:'Core feature since v2.0. This knowledge feeds two Grid blocks — one for internal teams and one customer-facing. It also contributes to the Code Review Overview synthesis block.',
    scope:'internal · external · both',
    appearsIn:['PR Comments — internal','PR Comments — customer-facing','Code Review Overview — CSM (synthesis)']
  },
  {
    id:'code-review-rules',section:'workflow',
    title:'Code review rules',
    status:'current',version:'v2.2',knowledgeType:'process',audience:'internal',
    lastReviewed:'Feb 14, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering handbook · Code review standards',
      updated:'Feb 1, 2026',
      text:'All pull requests require a minimum of one approved review before merge. Reviews should be completed within one business day of request. Blocking comments must be resolved before approval can be granted.'
    },
    what:'Code review rules define how the Flux team reviews pull requests — who needs to approve, how quickly, and what counts as a blocking issue versus a suggestion.',
    alsoKnownAs:'review standards · PR review guidelines · code review policy',
    context:'Established in v2.2. Feeds the internal Code Review Rules block and contributes to the Code Review Overview synthesis block for CSM runbooks.',
    scope:'internal',
    appearsIn:['Code Review Rules (internal)','Code Review Overview — CSM (synthesis)']
  },
  {
    id:'merge-queue',section:'workflow',
    title:'Merge Queue',
    status:'current',version:'v2.3',knowledgeType:'process',audience:'internal',
    lastReviewed:'Feb 28, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Merge Queue feature page',
      updated:'Feb 20, 2026',
      text:'Merge Queue is a managed queue system that serializes pull request merges into the main branch. Each PR is tested against the current head of the target branch before being merged, ensuring CI passes in the actual merge context.'
    },
    what:'Merge Queue controls the order in which pull requests are merged. It prevents conflicts by testing each PR against the real current state of the branch before it goes in.',
    alsoKnownAs:'merge train (industry equivalent) · PR queue (informal internal) · merge pipeline',
    context:'Introduced in v2.3. Feeds the Merge Queue internal block and contributes to the Code Review Overview synthesis block.',
    scope:'internal',
    appearsIn:['Merge Queue (internal)','Code Review Overview — CSM (synthesis)','Onboarding Checklist']
  },
  {
    id:'ci-pipeline',section:'workflow',
    title:'CI Pipeline',
    status:'current',version:'v2.4',knowledgeType:'process',audience:'internal',
    lastReviewed:'Mar 20, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · CI/CD documentation',
      updated:'Mar 18, 2026',
      text:'The CI Pipeline runs on every pull request and executes unit tests, integration tests, static analysis, and security scans. All checks must pass before a pull request is eligible for merge. Pipeline configuration is defined per repository in flux.yaml.'
    },
    what:'The CI Pipeline runs automated checks on every pull request before it can merge. Every check must pass. Failure blocks the merge. This knowledge feeds two Grid blocks — a technical internal version and a plain-language version for customers and non-technical stakeholders.',
    alsoKnownAs:'build pipeline (proposed rename for v2.5) · automated checks · CI/CD pipeline · continuous integration',
    context:'Under review ahead of v2.5 rename to Build Pipeline. One knowledge entry, two blocks — the internal block is technical and process-focused, the customer-facing block explains what it means for product stability without referencing configuration details.',
    scope:'internal · external · both',
    appearsIn:['CI Pipeline — internal (technical)','CI Pipeline — plain language (customer-facing)']
  },
  // DEPLOYMENT
  {
    id:'deployment-checklist',section:'deployment',
    title:'Deployment checklist',
    status:'current',version:'v2.2',knowledgeType:'template',audience:'internal',
    lastReviewed:'Jan 30, 2026',reviewedBy:'J. Cellitti',
    transcluded:null,
    what:'A required checklist for every production deployment at Flux. Covers pre-deploy verification, monitoring setup, rollback preparation, and post-deploy confirmation.',
    alsoKnownAs:'deploy checklist · release checklist · go-live checklist · deployment runbook',
    context:'Created in v2.2 after two production incidents. Required for all production deployments. Maps 1:1 to its Grid block — this is an operational template that does not need audience splitting.',
    scope:'internal',
    appearsIn:['Deployment Checklist']
  },
  {
    id:'incident-response',section:'deployment',
    title:'Incident response',
    status:'in review',version:'v2.3',knowledgeType:'process',audience:'internal',
    lastReviewed:'Mar 18, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering handbook · On-call and incident management',
      updated:'Mar 10, 2026',
      text:'On-call rotation updated March 2026. Primary on-call engineer is responsible for initial response within 15 minutes. Secondary on-call escalation after 30 minutes of no resolution. Severity levels: P0 (customer-impacting outage), P1 (degraded service), P2 (minor issue), P3 (no immediate impact).'
    },
    what:'Incident response defines how Flux detects, escalates, resolves, and communicates production incidents. This knowledge feeds two blocks — an internal operational runbook and a customer communications version focused on what to say externally during an incident.',
    alsoKnownAs:'incident management · on-call process · incident runbook · production incident protocol',
    context:'Under review following March 2026 on-call rotation update. The internal block is operational. The customer comms block focuses on the communication templates and what customers need to hear — not the internal escalation mechanics.',
    scope:'internal · external · both',
    appearsIn:['Incident Response (internal runbook)','Incident Response — customer comms']
  },
  {
    id:'status-page',section:'deployment',
    title:'Status page',
    status:'current',version:'v2.0',knowledgeType:'reference',audience:'external',
    lastReviewed:'Nov 30, 2025',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Infrastructure · Status page',
      updated:'Oct 15, 2025',
      text:'The Flux status page is hosted at status.flux.io and powered by an external provider. System health metrics update automatically. Incident communications are posted manually by the on-call engineer. SLA reports are published on the first of each month.'
    },
    what:'The Flux status page shows customers real-time system health, active incidents, and scheduled maintenance. It is the official external source of truth during any service disruption.',
    alsoKnownAs:'system status · service health · uptime page · incident dashboard',
    context:'Stable since v2.0. Maps 1:1 to its Grid block. Referenced in the Incident Response customer comms block.',
    scope:'external',
    appearsIn:['Status Page']
  },
  // ACCESS
  {
    id:'team-permissions',section:'access',
    title:'Team permissions',
    status:'needs update',version:'v2.2',knowledgeType:'policy',audience:'internal',
    lastReviewed:'Dec 20, 2025',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Access control · Roles',
      updated:'Apr 5, 2026',
      text:'As of v2.5, Flux supports four roles: Viewer (read-only), Reviewer (comment and approve PRs), Editor (create and merge PRs), and Admin (full repository and settings access). The previous Editor role has been split into Reviewer and Editor.'
    },
    what:'Team permissions defines what each role can see and do across Flux repositories, settings, and integrations.',
    alsoKnownAs:'access control · role-based access · RBAC · user permissions · team roles',
    context:'Needs full rebuild. v2.5 model in sourced section above is current. This entry still reflects v2.2. Maps 1:1 to its Grid block.',
    scope:'internal',
    appearsIn:['Team Permissions']
  },
  // CUSTOMER FACING
  {
    id:'pr-digest',section:'customer',
    title:'PR Digest',
    status:'current',version:'v2.4',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · PR Digest feature page',
      updated:'Mar 12, 2026',
      text:'PR Digest is an AI-generated summary attached to every pull request. It is produced automatically on PR creation and updated on each new commit. The summary includes a description of code changes, affected files, CI status, and reviewer comments.'
    },
    what:'PR Digest generates a plain-language summary of any pull request for non-technical reviewers. It is the primary way Flux makes engineering changes understandable to the whole team and to customers. One knowledge entry — three Grid blocks, each shaped for a different audience and channel.',
    alsoKnownAs:'auto-summary (legacy, pre-v2.4) · "the digest" (informal internal) · diff summary · PR summary',
    context:'Renamed from Auto-Summary in v2.4. This is the most audience-split knowledge entry in The Current. The concept is the same for everyone but what each audience needs to know about it is different enough to warrant three distinct blocks in The Grid.',
    scope:'internal · external · both',
    appearsIn:['PR Digest — concept (customer-facing)','PR Digest — walkthrough (internal)','PR Digest — release announcement (Loops/Slack)']
  },
  {
    id:'api-rate-limits',section:'customer',
    title:'API rate limits',
    status:'flagged',version:'v2.3',knowledgeType:'reference',audience:'external',
    lastReviewed:'Feb 10, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · API documentation · Rate limiting',
      updated:'Apr 2, 2026',
      text:'Rate limits as of v2.5: Free tier — 500 requests per hour per API key. Pro tier — 25,000 requests per hour per API key. Enterprise tier — configurable. Limits reset on a rolling 60-minute window.'
    },
    what:'API Rate Limits define the maximum number of requests a customer can make to the Flux API within a given time window. Limits vary by plan tier and are applied per API key.',
    alsoKnownAs:'rate limiting · API throttling · request limits · API quotas',
    context:'Flagged. Sourced section reflects v2.5 limits. Authored content still reflects v2.3. Must be updated before distribution. Maps 1:1 to its Grid block — this is reference content that does not need audience splitting.',
    scope:'external',
    appearsIn:['API Rate Limits','Getting Started with Flux API (synthesis)']
  },
  {
    id:'webhook-setup',section:'customer',
    title:'Webhook setup',
    status:'current',version:'v2.1',knowledgeType:'process',audience:'external',
    lastReviewed:'Jan 15, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Webhook configuration',
      updated:'Dec 10, 2025',
      text:'Webhooks are configured at the repository or organization level. Supported events include pull_request, push, merge, ci_complete, and deployment. Payloads are sent as HTTP POST requests to the configured endpoint with HMAC signature verification.'
    },
    what:'Webhook setup guides customers through configuring webhooks to receive real-time event notifications from Flux. Webhooks fire when things happen — a PR opens, code merges, a deployment completes.',
    alsoKnownAs:'webhook configuration · event notifications · webhook integration · outbound webhooks',
    context:'Stable since v2.1. Feeds its own Grid block and contributes to the Getting Started with Flux API synthesis block.',
    scope:'external',
    appearsIn:['Webhook Setup','Getting Started with Flux API (synthesis)']
  },
  // TEMPLATES
  {
    id:'release-notes-template',section:'templates',
    title:'Release notes template',
    status:'current',version:'v2.3',knowledgeType:'template',audience:'both',
    lastReviewed:'Mar 1, 2026',reviewedBy:'J. Cellitti',
    transcluded:null,
    what:'A standardized format for every Flux release communication. One template serves internal and customer-facing versions — the structure is the same, the language and depth differ.',
    alsoKnownAs:'changelog template · release communication template · version notes format',
    context:'Standardized in v2.3. Informed by the Flux release cycle entry. Maps 1:1 to its Grid block.',
    scope:'internal · external · both',
    appearsIn:['Release Notes Template']
  },
  {
    id:'onboarding-checklist',section:'templates',
    title:'Onboarding checklist',
    status:'current',version:'v2.4',knowledgeType:'template',audience:'internal',
    lastReviewed:'Mar 10, 2026',reviewedBy:'J. Cellitti',
    transcluded:null,
    what:'A complete checklist for every new Flux team member covering the first 30 days. Draws from multiple areas of The Current — branch protection, merge queue, code review rules — to give new hires a complete picture of how work moves through Flux.',
    alsoKnownAs:'new hire checklist · 30-day plan · onboarding guide · new employee checklist',
    context:'Updated in v2.4. This template synthesizes knowledge from across The Current into one practical checklist. It is the one Grid block that touches the most Current entries indirectly.',
    scope:'internal',
    appearsIn:['Onboarding Checklist']
  },

  // WORKFLOW — additional entries
  {
    id:'code-owners',section:'workflow',
    title:'Code owners',
    status:'current',version:'v2.2',knowledgeType:'policy',audience:'internal',
    lastReviewed:'Feb 20, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · CODEOWNERS documentation',
      updated:'Feb 10, 2026',
      text:'Code owners are defined in a CODEOWNERS file at the root of each repository. When a pull request modifies files in a directory with a defined owner, that owner is automatically added as a required reviewer. Code ownership can be assigned to individuals or teams.'
    },
    what:'Code owners are the people automatically assigned to review pull requests that touch specific parts of the codebase. At Flux, ownership is defined per directory — so the right expert is always in the loop when their area changes.',
    alsoKnownAs:'CODEOWNERS · required reviewers · automatic reviewers · file owners',
    context:'Introduced in v2.2 alongside Code Review Rules to give the review process more structure. Code owners cannot be bypassed — their approval is required for merge on the files they own. Teams are reviewed and updated quarterly.',
    scope:'internal',
    appearsIn:['Code Review Rules (internal)','Code Review Overview — CSM (synthesis)']
  },
  {
    id:'draft-prs',section:'workflow',
    title:'Draft PRs',
    status:'current',version:'v2.1',knowledgeType:'concept',audience:'internal',
    lastReviewed:'Jan 18, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Pull request states',
      updated:'Dec 15, 2025',
      text:'A draft pull request signals that the work is in progress and not ready for formal review. Draft PRs can be opened at any time and converted to ready-for-review when the author is satisfied. CI checks run on draft PRs but required reviewers are not notified.'
    },
    what:'A draft PR is a work-in-progress pull request that is not ready for review. Engineers use drafts to share early work, get early feedback, or keep track of in-progress changes without triggering a formal review cycle.',
    alsoKnownAs:'WIP PR · work in progress · draft pull request',
    context:'Available since v2.1. Draft PRs are a common practice for large or complex changes. Converting a draft to ready-for-review notifies code owners and required reviewers for the first time.',
    scope:'internal',
    appearsIn:['(informs PR workflow blocks)']
  },
  {
    id:'pr-templates',section:'workflow',
    title:'PR description templates',
    status:'current',version:'v2.3',knowledgeType:'template',audience:'internal',
    lastReviewed:'Mar 5, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering handbook · Pull request standards',
      updated:'Feb 28, 2026',
      text:'Flux uses a standardized PR description template stored in .github/PULL_REQUEST_TEMPLATE.md. The template includes sections for: summary of changes, motivation and context, how to test, screenshots if applicable, and related issues or tickets.'
    },
    what:'PR description templates give every pull request a consistent structure. At Flux, every PR opens with a pre-filled template that prompts the author to explain what changed, why, and how to verify it. This is what makes PR Digest summaries accurate and useful.',
    alsoKnownAs:'PR template · pull request template · description template',
    context:'Standardized in v2.3. The template directly feeds the quality of PR Digest output — a well-filled template produces a better AI summary. Teams that skip the template produce less useful digests.',
    scope:'internal',
    appearsIn:['PR Description Template','PR Digest — concept']
  },
  // DEPLOYMENT — additional entries
  {
    id:'rollback-process',section:'deployment',
    title:'Rollback process',
    status:'current',version:'v2.2',knowledgeType:'process',audience:'internal',
    lastReviewed:'Feb 5, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering handbook · Deployment and rollback',
      updated:'Jan 28, 2026',
      text:'Rollbacks at Flux are executed by reverting the merge commit and deploying the previous known-good state. Rollback decisions are made by the on-call engineer in coordination with the engineering lead. All rollbacks are logged and trigger a P1 post-mortem regardless of customer impact.'
    },
    what:'A rollback is what happens when a deployment needs to be undone. At Flux, rollbacks are fast, deliberate, and always followed by a post-mortem. Understanding the rollback process is essential for anyone communicating about incidents or deployment timelines.',
    alsoKnownAs:'revert · rollback deployment · undo deploy · deploy revert',
    context:'Process established in v2.2 after an incident where rollback decision-making was unclear. The on-call engineer has authority to call a rollback without escalation. Rollback triggers a post-mortem regardless of severity.',
    scope:'internal',
    appearsIn:['Incident Response (internal runbook)','Deployment Checklist','Post-mortem Template']
  },
  {
    id:'feature-flags',section:'deployment',
    title:'Feature flags',
    status:'current',version:'v2.3',knowledgeType:'concept',audience:'both',
    lastReviewed:'Mar 8, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Feature flags · LaunchDarkly integration',
      updated:'Mar 1, 2026',
      text:'Flux uses LaunchDarkly for feature flag management. Flags can be toggled per environment, per organization, or per user. All new features ship behind a flag before being enabled for general availability. Flag cleanup is required within 30 days of full rollout.'
    },
    what:'Feature flags let Flux ship code to production before enabling a feature for users. A feature can be deployed, tested with internal users, gradually rolled out, and then fully released — all without a new deployment. This is how Flux ships safely at speed.',
    alsoKnownAs:'feature toggles · LaunchDarkly flags · feature gates · dark launches',
    context:'Used since v2.3. Feature flags are why some customers see features before others. CSMs should be aware of flag-gated features when discussing timelines with customers. Flags are always cleaned up within 30 days of full GA.',
    scope:'internal · external · both',
    appearsIn:['Feature Flags (internal)','(informs release communication blocks)']
  },
  // ACCESS — additional entries
  {
    id:'sso-authentication',section:'access',
    title:'SSO and authentication',
    status:'current',version:'v2.2',knowledgeType:'policy',audience:'internal',
    lastReviewed:'Jan 30, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Authentication · SSO configuration',
      updated:'Jan 20, 2026',
      text:'Flux supports SAML 2.0 and OIDC for SSO integration. Supported identity providers include Okta, Google Workspace, and Azure AD. SSO is available on Pro and Enterprise plans. Organizations can enforce SSO and disable password-based login for all members.'
    },
    what:'SSO lets teams log into Flux using their existing company identity provider rather than a separate password. At Flux, SSO enforcement means all access goes through the company security infrastructure, which simplifies offboarding and audit compliance.',
    alsoKnownAs:'single sign-on · SAML · OIDC · Okta integration · identity provider',
    context:'Available since v2.2. SSO enforcement is a common requirement for Enterprise customers. When SSO is enforced, revoking access in the identity provider immediately removes Flux access — no manual offboarding required.',
    scope:'internal · external · both',
    appearsIn:['SSO and Authentication','Team Permissions']
  },
  {
    id:'api-keys',section:'access',
    title:'API keys',
    status:'current',version:'v2.0',knowledgeType:'reference',audience:'external',
    lastReviewed:'Feb 8, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · API documentation · Authentication',
      updated:'Jan 25, 2026',
      text:'API keys are generated per organization and scoped to specific permissions. Keys can be created, rotated, and revoked in the organization settings. All API requests must include a valid key in the Authorization header. Keys do not expire but should be rotated regularly as a security best practice.'
    },
    what:'API keys are how customers authenticate programmatic access to Flux. Each key is tied to an organization and has defined permissions. Customers manage their own keys — creating them for integrations and revoking them when access is no longer needed.',
    alsoKnownAs:'API token · auth token · secret key · personal access token',
    context:'Available since v2.0. API keys are the primary authentication method for the Flux API. They feed into both the Getting Started with Flux API synthesis block and the API Rate Limits block — keys and limits are always explained together.',
    scope:'external',
    appearsIn:['API Keys','Getting Started with Flux API (synthesis)']
  },
  {
    id:'audit-logs',section:'access',
    title:'Audit logs',
    status:'current',version:'v2.3',knowledgeType:'reference',audience:'internal',
    lastReviewed:'Feb 25, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Security · Audit logging',
      updated:'Feb 15, 2026',
      text:'Audit logs capture all administrative actions taken within a Flux organization — including member additions and removals, permission changes, SSO configuration updates, and API key creation and revocation. Logs are retained for 90 days on Pro and 12 months on Enterprise. Logs can be exported via API or streamed to a SIEM.'
    },
    what:'Audit logs give organizations a complete record of who did what and when inside Flux. They are essential for security reviews, compliance requirements, and investigating incidents. Enterprise customers often require audit log access as part of vendor security assessments.',
    alsoKnownAs:'activity log · security log · admin log · access log',
    context:'Introduced in v2.3 in response to Enterprise customer security requirements. Commonly asked about during procurement and security reviews. CSMs should know retention periods and export options.',
    scope:'internal',
    appearsIn:['Audit Logs','Team Permissions']
  },
  // CUSTOMER FACING — additional entries
  {
    id:'customer-onboarding',section:'customer',
    title:'Customer onboarding',
    status:'current',version:'v2.4',knowledgeType:'process',audience:'external',
    lastReviewed:'Mar 12, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Customer success · Onboarding flow',
      updated:'Mar 5, 2026',
      text:'New Flux organizations go through a guided setup flow covering: repository connection, team member invitation, branch protection defaults, CI pipeline configuration, and PR Digest activation. Estimated setup time is 20-30 minutes for a standard engineering team.'
    },
    what:'Customer onboarding is the journey a new organization takes from signing up to having Flux running on their first repository. Understanding the onboarding flow is essential for CSMs setting customer expectations and for learning content that guides new customers through setup.',
    alsoKnownAs:'customer setup · new org setup · getting started · implementation',
    context:'Updated in v2.4 to reflect the Merge Queue setup step added to the guided flow. Onboarding completion rate is a key CSM metric. Content in this area should always reflect the current setup flow exactly.',
    scope:'external',
    appearsIn:['Customer Onboarding Guide','Getting Started with Flux API (synthesis)']
  },
  {
    id:'sla-uptime',section:'customer',
    title:'SLA and uptime',
    status:'current',version:'v2.0',knowledgeType:'reference',audience:'external',
    lastReviewed:'Dec 10, 2025',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Infrastructure · SLA commitments',
      updated:'Nov 30, 2025',
      text:'Flux commits to 99.9% uptime for Pro plans and 99.95% for Enterprise. Uptime is measured monthly and excludes scheduled maintenance windows. SLA credits are issued automatically for any month where uptime falls below the committed level. Historical uptime is published on the status page.'
    },
    what:'The SLA defines what uptime Flux commits to and what happens if it falls short. CSMs reference SLA terms during sales conversations, renewal discussions, and incident follow-ups. Customers on Enterprise plans have enhanced commitments and automatic credit issuance.',
    alsoKnownAs:'service level agreement · uptime commitment · availability · SLA credits',
    context:'Stable since v2.0. SLA terms are a frequent topic in enterprise sales and renewal conversations. Any incident that risks SLA breach triggers enhanced communication protocols — referenced in the Incident Response customer comms block.',
    scope:'external',
    appearsIn:['SLA and Uptime','Status Page','Incident Response — customer comms']
  },
  // TEMPLATES — additional entries
  {
    id:'postmortem-template',section:'templates',
    title:'Post-mortem template',
    status:'current',version:'v2.2',knowledgeType:'template',audience:'internal',
    lastReviewed:'Feb 18, 2026',reviewedBy:'J. Cellitti',
    transcluded:null,
    what:'A structured format for reviewing production incidents after resolution. Covers timeline, root cause, contributing factors, customer impact, and action items. Every P0 and P1 incident at Flux requires a post-mortem within 48 hours of resolution.',
    alsoKnownAs:'incident review · retrospective · post-incident review · PIR',
    context:'Required for all P0 and P1 incidents since v2.2. The template is blameless by design — it focuses on systems and processes, not individuals. Post-mortem action items are tracked in Notion and reviewed in the weekly engineering sync.',
    scope:'internal',
    appearsIn:['Post-mortem Template','Incident Response (internal runbook)','Rollback Process']
  },
  {
    id:'pr-description-template',section:'templates',
    title:'PR description template',
    status:'current',version:'v2.3',knowledgeType:'template',audience:'internal',
    lastReviewed:'Mar 5, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering handbook · .github/PULL_REQUEST_TEMPLATE.md',
      updated:'Feb 28, 2026',
      text:'## Summary\nBriefly describe the changes in this PR.\n\n## Motivation\nWhy is this change needed? What problem does it solve?\n\n## How to test\nSteps to verify the changes work as expected.\n\n## Screenshots\nIf applicable, add screenshots or recordings.\n\n## Related\nLink any related issues, tickets, or PRs.'
    },
    what:'The PR description template is what every engineer sees when they open a new pull request at Flux. It structures how changes are communicated — which directly affects the quality of PR Digest summaries and the ease of code review.',
    alsoKnownAs:'PR template · description format · pull request template',
    context:'Standardized in v2.3. The connection between this template and PR Digest is direct — a well-completed template produces a better AI summary. The template is stored in the repository and automatically pre-fills new PRs.',
    scope:'internal',
    appearsIn:['PR Description Template','PR Digest — concept','PR Digest — walkthrough']
  },
  // DEPRECATED — additional entry
  {
    id:'legacy-webhook-format',section:'deprecated',
    title:'Legacy webhook payload format',
    status:'flagged',version:'v2.2',knowledgeType:'deprecated',audience:'external',
    lastReviewed:'Nov 15, 2025',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Webhook configuration (archived) · v2.2 payload schema',
      updated:'Oct 30, 2025',
      text:'The v2.2 webhook payload did not include the metadata field, the ci_status object, or the reviewer_comments array. Customers using webhooks configured before v2.3 will receive the legacy payload format unless they opt into the updated schema in organization settings.'
    },
    what:'The legacy webhook payload format is the pre-v2.3 schema used by customers who set up webhooks before the October 2025 update. This entry exists to support CSMs and customers troubleshooting webhook integrations that were built against the old format.',
    alsoKnownAs:'v2.2 webhook schema · old webhook format · legacy payload',
    context:'Deprecated in v2.3. Customers on the legacy format should be migrated to the current schema. Migration requires updating their payload parsing to handle the new metadata, ci_status, and reviewer_comments fields. This entry should be referenced when troubleshooting webhook issues with older customers.',
    scope:'external',
    appearsIn:['Webhook Setup','(legacy reference — CSM support)']
  },
  // DEPRECATED — existing entry
  {
    id:'auto-summary',section:'deprecated',
    title:'Auto-Summary',
    status:'flagged',version:'v2.3',knowledgeType:'deprecated',audience:'both',
    lastReviewed:'Jan 10, 2026',reviewedBy:'J. Cellitti',
    transcluded:{
      source:'Engineering wiki · Auto-Summary (archived)',
      updated:'Mar 12, 2026',
      text:'Auto-Summary has been deprecated and replaced by PR Digest as of v2.4. See PR Digest for current documentation.'
    },
    what:'Auto-Summary was the previous name for PR Digest. This entry exists only to support customers and team members who onboarded before v2.4 and still reference the old name.',
    alsoKnownAs:'PR Digest (current name, v2.4+)',
    context:'Deprecated in v2.4. All references should direct to PR Digest. The feature is unchanged — only the name and scope expanded.',
    scope:'internal · external · both',
    appearsIn:['Auto-Summary (flagged Grid block)']
  }
];

let cuViewMode = 'author';
let currentKtype = 'all';

function statusClass(s){ return 'st-'+s.replace(/\s/g,'-') }
function statusColor(s){
  return {current:'#1D9E75',flagged:'#C42B2B','in review':'#D4A017','needs update':'#901818'}[s]||'#9B948C';
}

function entryHtml(e){
  const stag = `<span class="stag ${statusClass(e.status)}"><span class="stag-dot" style="background:${statusColor(e.status)}"></span>${e.status}</span>`;
  const vtag = `<span class="vtag">${e.version}</span>`;
  const atag = `<span class="atag">${e.audience}</span>`;

  const trans = e.transcluded ? `
    <div class="field">
      <div class="field-label">Sourced from engineering</div>
      <div class="transcluded">
        <div class="trans-header">
          <span class="trans-badge">transcluded</span>
          <span class="trans-source">${e.transcluded.source}</span>
          <span class="trans-updated">updated ${e.transcluded.updated}</span>
        </div>
        <div class="trans-value">${e.transcluded.text}</div>
      </div>
    </div>` : '';

  const authorControls = `
    <div class="author-controls">
      <span class="ac-label">Status</span>
      <select class="ac-select">
        <option ${e.status==='current'?'selected':''}>current</option>
        <option ${e.status==='in review'?'selected':''}>in review</option>
        <option ${e.status==='flagged'?'selected':''}>flagged</option>
        <option ${e.status==='needs update'?'selected':''}>needs update</option>
      </select>
      <span class="ac-label">Tier</span>
      <select class="ac-select">
        <option>passthrough</option>
        <option>review</option>
        <option>rebuild</option>
      </select>
      <span class="ac-reviewed">Last reviewed <span>${e.lastReviewed} · ${e.reviewedBy}</span></span>
    </div>`;

  const appearsIn = `
    <div class="field appears-in-section">
      <div class="field-label">Appears in The Grid as</div>
      <div class="appears-in">
        ${e.appearsIn.map(function(name){
          if(name.startsWith('(')){return '<span style="font-size:13px;color:var(--ash);font-style:italic">'+name+'</span>';}
          var BMAP={'PR Digest — concept':'0001','PR Digest — walkthrough':'0001b','PR Digest — release announcement':'0001c','Merge Queue':'0002','Auto-Summary':'0003','Branch Protection (internal)':'0004','Branch Protection':'0004','Code Review Rules (internal)':'0005','Code Review Rules':'0005','PR Comments — internal':'0006','PR Comments — customer-facing':'0006b','CI Pipeline — internal (technical)':'0007','CI Pipeline — internal':'0007','CI Pipeline — plain language (customer-facing)':'0007b','CI Pipeline — plain language':'0007b','Deployment Checklist':'0008','Release Notes Template':'0009','API Rate Limits':'0010','Webhook Setup':'0011','Team Permissions':'0012','Status Page':'0013','Incident Response (internal runbook)':'0014','Incident Response — customer comms':'0014b','Onboarding Checklist':'0015','Code Review Overview — CSM (synthesis)':'S001','Getting Started with Flux API (synthesis)':'S002','Auto-Summary (flagged Grid block)':'0003','SSO and Authentication':'0012','API Keys':'0010','Audit Logs':'0012','Post-mortem Template':'0008','PR Description Template':'0001b'};
          var bid=BMAP[name];
          if(bid) return '<a class="ai-link" href="#" onclick="navigateToBlock(\''+bid+'\');return false">'+name+' ↗</a>';
          return '<span class="ai-link" style="opacity:0.6;cursor:default;border-style:dashed">'+name+'</span>';
        }).join('')}
      </div>
    </div>`;

  return `<div class="entry" id="entry-${e.id}" data-section="${e.section}" data-ktype="${e.knowledgeType}" data-search="${e.title.toLowerCase()} ${e.what.toLowerCase()} ${e.alsoKnownAs.toLowerCase()}">
    <div class="entry-header" onclick="toggleEntry('${e.id}')">
      <div>
        <div class="entry-section-tag">${SECTIONS.find(s=>s.key===e.section)?.label||''}</div>
        <div class="entry-title">${e.title}</div>
        <div class="entry-meta">${stag}${vtag}${atag}</div>
      </div>
      <button class="entry-toggle" onclick="event.stopPropagation();toggleEntry('${e.id}')">↓</button>
    </div>
    <div class="entry-body">
      <div class="author-badge">✎ author layer · learning team</div>
      ${trans}
      <div class="field">
        <div class="field-label">What it is</div>
        <div class="field-value">${e.what}</div>
      </div>
      <div class="field">
        <div class="field-label">Also known as</div>
        <div class="field-mono">${e.alsoKnownAs}</div>
      </div>
      <div class="field">
        <div class="field-label">Context</div>
        <div class="field-value">${e.context}</div>
      </div>
      <div class="field">
        <div class="field-label">Scope</div>
        <div class="field-mono" style="text-transform:lowercase">${e.scope}</div>
      </div>
      <div class="field-divider"></div>
      ${appearsIn}
      ${authorControls}
    </div>
  </div>`;
}

function sectionHtml(section, entries){
  if(!entries.length) return '';
  return `
    <div class="section-header" data-section="${section.key}">
      <div class="sh-label">${section.label}</div>
      <div class="sh-line"></div>
      <div class="sh-count">${entries.length}</div>
    </div>
    ${entries.map(entryHtml).join('')}
  `;
}

function cuRender(){
  const col = document.getElementById('docColumn');
  const search = document.getElementById('searchInput').value.toLowerCase();

  const filtered = ENTRIES.filter(e => {
    const matchKtype = currentKtype==='all' || e.knowledgeType===currentKtype || e.section===currentKtype || (currentKtype==='deprecated'&&(e.section==='deprecated'||e.knowledgeType==='deprecated'));
    const matchSearch = !search || e.title.toLowerCase().includes(search)||e.what.toLowerCase().includes(search)||e.alsoKnownAs.toLowerCase().includes(search)||e.context.toLowerCase().includes(search);
    return matchKtype && matchSearch;
  });

  const count = filtered.length;
  document.getElementById('searchCount').textContent = `${count} entr${count===1?'y':'ies'}`;

  if(!count){
    col.innerHTML = `<div class="empty"><div class="empty-title">No entries match</div><div class="empty-sub">Try adjusting your search or filter</div></div>`;
    return;
  }

  // Primer only when showing all
  const primerHtml = (!search && currentKtype==='all') ? `
    <div class="primer">
      <div class="primer-label">About this document</div>
      <div class="primer-text">
        This is The Current — the <strong>human-authored knowledge layer</strong> for Flux. It lives alongside engineering's documentation and translates technical information into something every team can use. Start with Foundations if you are new to Flux or to code review workflows. Each entry connects to content in The Grid, which distributes it across WorkRamp, Notion, GitBook, Slack, and Loops.
      </div>
    </div>` : '';

  const sectionsHtml = SECTIONS.map(s => {
    const entries = filtered.filter(e => e.section===s.key);
    return sectionHtml(s, entries);
  }).join('');

  col.innerHTML = primerHtml + sectionsHtml;
}

function toggleEntry(id){
  document.getElementById('entry-'+id)?.classList.toggle('open');
}

function setView(v){
  cuViewMode = v;
  document.getElementById('vt-author').classList.toggle('on',v==='author');
  document.getElementById('vt-read').classList.toggle('on',v==='read');
  document.getElementById('page-current').classList.toggle('read-view',v==='read');
}

function setKtype(type,btn){
  currentKtype = type;
  document.querySelectorAll('.kf').forEach(b=>b.classList.remove('on'));
  btn.classList.add('on');
  cuRender();
}

function showPopup(e,msg){
  e.preventDefault();
  const popup = document.getElementById('cuLinkPopup');
  popup.textContent = msg;
  const rect = e.currentTarget.getBoundingClientRect();
  popup.style.left = Math.max(16,rect.left)+'px';
  popup.style.top = (rect.bottom+10)+'px';
  popup.classList.add('show');
  clearTimeout(popup._t);
  popup._t = setTimeout(()=>popup.classList.remove('show'),2800);
}

document.addEventListener('click',e=>{
  if(!e.target.closest('.link-popup')&&!e.target.closest('.ai-link')&&!e.target.closest('.nl')){
    document.getElementById('cuLinkPopup').classList.remove('show');
  }
});

const BLOCK_ID_MAP = {"PR Digest — concept": "0001", "PR Digest — walkthrough": "0001b", "PR Digest — release announcement": "0001c", "Merge Queue": "0002", "Auto-Summary": "0003", "Branch Protection": "0004", "Code Review Rules": "0005", "PR Comments — internal": "0006", "PR Comments — customer-facing": "0006b", "CI Pipeline — internal": "0007", "CI Pipeline — plain language": "0007b", "Deployment Checklist": "0008", "Release Notes Template": "0009", "API Rate Limits": "0010", "Webhook Setup": "0011", "Team Permissions": "0012", "Status Page": "0013", "Incident Response (internal runbook)": "0014", "Incident Response — customer comms": "0014b", "Onboarding Checklist": "0015", "Code Review Overview — CSM (synthesis)": "S001", "Getting Started with Flux API (synthesis)": "S002", "PR Description Template": "0001", "Branch Protection (internal)": "0004", "Auto-Summary (flagged Grid block)": "0003", "SSO and Authentication": "0012", "API Keys": "0010", "Audit Logs": "0012", "Feature Flags (internal)": "0008", "Post-mortem Template": "0008"};

// called by initCurrent()


// === PULSE ===
function initPulse(){
  if(_syncRun) _flagged.forEach(function(id){
    var b=typeof BLOCKS!=='undefined'?BLOCKS.find(function(x){return x.id===id;}):null;
    if(b) b.status='flagged';
  });
  if(typeof puRenderDash==='function') puRenderDash();
}

// BLOCKS from Grid

const CHANNEL_CLICKS = [
  {name:'WorkRamp external',clicks:3240,change:12},
  {name:'WorkRamp internal',clicks:2180,change:8},
  {name:'GitBook',clicks:1860,change:22},
  {name:'Notion',clicks:1420,change:5},
  {name:'Loops',clicks:980,change:31},
  {name:'Slack',clicks:740,change:18},
];

const TICKETS_BASE = [
  {id:'TKT-041',title:'Auto-Summary — rebuild for v2.4 rename',block:'0003',priority:'high',age:'18d',trigger:'v2.4 release · terminology change',tool:'Notion'},
  {id:'TKT-044',title:'Team Permissions — rebuild for v2.5 role model',block:'0012',priority:'high',age:'12d',trigger:'v2.5 release · permissions redesign',tool:'Notion'},
  {id:'TKT-046',title:'Incident Response — update on-call rotation',block:'0014',priority:'med',age:'8d',trigger:'org change · March 2026',tool:'Notion'},
  {id:'TKT-047',title:'CI Pipeline — pending v2.5 rename to Build Pipeline',block:'0007',priority:'med',age:'6d',trigger:'v2.5 upcoming · rename confirmed',tool:'Notion'},
];

const TICKETS_SYNC = [
  {id:'TKT-049',title:'API Rate Limits — v2.5 values not reflected',block:'0010',priority:'high',age:'just now',trigger:'sync detected · v2.5 rate limit change',tool:'Notion'},
  {id:'TKT-050',title:'Team Permissions — v2.5 role model not reflected',block:'0012',priority:'high',age:'just now',trigger:'sync detected · v2.5 permissions redesign',tool:'Notion'},
];

function getTickets(){
  return _syncRun ? TICKETS_BASE.concat(TICKETS_SYNC) : TICKETS_BASE;
}

const ACTIVITY_BASE = [
  {color:'ad-green',text:'PR Digest — concept marked current after v2.4 update',time:'2h ago'},
  {color:'ad-green',text:'PR Digest — walkthrough published to WorkRamp internal',time:'2h ago'},
  {color:'ad-red',text:'API Rate Limits flagged — v2.5 values detected in source',time:'4h ago'},
  {color:'ad-blue',text:'Getting Started with Flux API — synthesis block created',time:'1d ago'},
  {color:'ad-green',text:'Onboarding Checklist updated for v2.4',time:'2d ago'},
  {color:'ad-amber',text:'Incident Response moved to in review — on-call update',time:'3d ago'},
  {color:'ad-green',text:'CI Pipeline — plain language block published to GitBook',time:'4d ago'},
  {color:'ad-red',text:'Team Permissions flagged — v2.5 role model change detected',time:'5d ago'},
];

const ACTIVITY_SYNC = [
  {color:'ad-red',text:'API Rate Limits flagged — v2.5 rate limit values detected in source',time:'just now'},
  {color:'ad-red',text:'Team Permissions flagged — v2.5 role model change detected',time:'just now'},
  {color:'ad-amber',text:'2 tickets opened in Notion automatically',time:'just now'},
];

function getActivity(){
  return _syncRun ? ACTIVITY_SYNC.concat(ACTIVITY_BASE) : ACTIVITY_BASE;
}

const CYCLE_DATA = [4.2, 3.8, 5.1, 2.9, 3.4, 4.8, 3.1];
const CYCLE_LABELS = ['Oct','Nov','Dec','Jan','Feb','Mar','Apr'];

function statusColor(s){
  return {current:'#1D9E75',flagged:'#C42B2B','in review':'#D4A017','needs update':'#901818'}[s]||'#9B948C';
}
function statusBarColor(s){
  return {current:'var(--fern)',flagged:'var(--signal)','in review':'var(--straw)','needs update':'#901818'}[s]||'var(--ash)';
}

// compute live stats from blocks
function getStats(){
  const counts = {current:0,flagged:0,'in review':0,'needs update':0};
  BLOCKS.forEach(b=>{ if(counts[b.status]!==undefined) counts[b.status]++; });
  const total = BLOCKS.length;
  const healthy = counts.current;
  const score = Math.round((healthy/total)*100);
  return {counts,total,score,healthy};
}

let puView = 'learning';

function puSetView(v){
  puView = v;
  puRenderDash();
}

function puRenderDash(){
  const dash = document.getElementById('dash');
  const {counts,total,score} = getStats();
  const maxClicks = Math.max(...CHANNEL_CLICKS.map(c=>c.clicks));
  const maxCycle = Math.max(...CYCLE_DATA);
  const TICKETS = getTickets();
  const openTickets = TICKETS.length;

  if(puView === 'learning') dash.innerHTML = learningView(counts,total,score,maxClicks,maxCycle,openTickets);
  if(puView === 'leadership') dash.innerHTML = leadershipView(counts,total,score,maxClicks);
  if(puView === 'release') dash.innerHTML = releaseView(counts,total,score);

  // animate bars after render
  requestAnimationFrame(()=>{
    document.querySelectorAll('.sb-bar, .cc-bar, .cv-bar').forEach(b=>{
      b.style.width = b.dataset.w || b.style.width;
      b.style.height = b.dataset.h || b.style.height;
    });
  });
}

function learningView(counts,total,score,maxClicks,maxCycle,openTickets){
  const TICKETS = getTickets();
  const scoreColor = score >= 80 ? 'var(--fern)' : score >= 60 ? 'var(--straw)' : 'var(--signal)';
  return `
  <div class="row row-4">
    <div class="freshness-card" style="grid-column:span 1">
      <div class="freshness-glow"></div>
      <div>
        <div class="freshness-label">Content freshness</div>
        <div class="freshness-score"><span style="color:${scoreColor}">${score}</span><span style="font-size:28px;color:var(--stone)">%</span></div>
      </div>
      <div>
        <div class="freshness-sub">${counts.current} of ${total} blocks confirmed current</div>
        <div class="freshness-trend">
          <span class="trend-up">↑ 4%</span>
          <span class="trend-label">vs last month</span>
        </div>
      </div>
    </div>
    <div class="card">
      <div class="card-label">Open tickets</div>
      <div class="stat-value" style="color:${openTickets>3?'var(--signal)':'var(--carbon)'}">${openTickets}</div>
      <div class="stat-sub">blocks awaiting update</div>
      <div class="stat-pill sp-red"><span class="stat-dot" style="background:var(--signal)"></span>${TICKETS.filter(t=>t.priority==='high').length} high priority</div>
    </div>
    <div class="card">
      <div class="card-label">Avg cycle time</div>
      <div class="stat-value">3.8<span style="font-size:18px;color:var(--ash)">d</span></div>
      <div class="stat-sub">flag to resolution</div>
      <div class="stat-pill sp-green"><span class="stat-dot" style="background:var(--fern)"></span>↓ 0.6d vs last month</div>
    </div>
    <div class="card">
      <div class="card-label">Total blocks</div>
      <div class="stat-value">${total}</div>
      <div class="stat-sub">across ${['WorkRamp','Notion','GitBook','Slack','Loops'].length} channels</div>
      <div class="stat-pill sp-blue"><span class="stat-dot" style="background:var(--cobalt)"></span>2 synthesis blocks</div>
    </div>
  </div>

  <div class="row row-2-1">
    <div class="card">
      <div class="card-label">Ticket queue</div>
      <div class="ticket-list">
        ${TICKETS.map(t=>`
          <div class="ticket" onclick="showPopup(event,'This ticket is open in Notion. Block: ${t.title}. Triggered by: ${t.trigger}. Age: ${t.age}.')">
            <div class="ticket-priority tp-${t.priority}"></div>
            <div class="ticket-content">
              <div class="ticket-title">${t.title}</div>
              <div class="ticket-meta">${t.trigger}</div>
            </div>
            <div class="ticket-age">${t.age}</div>
            <div class="ticket-tool">${t.tool} ↗</div>
          </div>`).join('')}
      </div>
    </div>
    <div class="card">
      <div class="card-label">Status breakdown</div>
      <div class="status-bars">
        ${Object.entries(counts).map(([status,count])=>`
          <div class="sb-row">
            <div class="sb-label">${status}</div>
            <div class="sb-bar-wrap">
              <div class="sb-bar" style="width:${Math.round((count/total)*100)}%;background:${statusBarColor(status)}"></div>
            </div>
            <div class="sb-count">${count}</div>
          </div>`).join('')}
      </div>
      <div style="margin-top:20px">
        <div class="card-label">Update cycle time</div>
        <div class="cycle-viz">
          ${CYCLE_DATA.map((v,i)=>`
            <div class="cv-bar-wrap">
              <div class="cv-bar" style="height:${Math.round((v/maxCycle)*72)}px;${v===Math.max(...CYCLE_DATA)?'opacity:1;background:var(--signal)':v===Math.min(...CYCLE_DATA)?'opacity:1;background:var(--fern)':''}"></div>
              <div class="cv-label">${CYCLE_LABELS[i]}</div>
            </div>`).join('')}
        </div>
      </div>
    </div>
  </div>

  <div class="row row-2">
    <div class="card">
      <div class="card-label">Click tracking by channel</div>
      <div class="channel-chart">
        ${CHANNEL_CLICKS.map(c=>`
          <div class="cc-row">
            <div class="cc-label">${c.name}</div>
            <div class="cc-bar-wrap">
              <div class="cc-bar" style="width:${Math.round((c.clicks/maxClicks)*100)}%"></div>
            </div>
            <div class="cc-val">${(c.clicks/1000).toFixed(1)}k</div>
          </div>`).join('')}
      </div>
    </div>
    <div class="card">
      <div class="card-label">Recent activity</div>
      <div class="activity-list">
        ${getActivity().slice(0,6).map(a=>`
          <div class="activity-item">
            <div class="activity-dot ${a.color}"></div>
            <div class="activity-text">${a.text}<span>${a.time}</span></div>
          </div>`).join('')}
      </div>
    </div>
  </div>

  <!-- LAST RELEASE SECTION -->
  <div style="margin-bottom:14px">
    <div style="display:flex;align-items:center;gap:14px;margin-bottom:14px">
      <div style="font-size:12px;font-weight:600;letter-spacing:0.08em;text-transform:uppercase;color:var(--ash)">${_syncRun ? 'in progress' : 'last release'}</div>
      <div style="flex:1;height:0.5px;background:var(--rule)"></div>
      <span style="font-size:12px;color:var(--ash)">${_syncRun ? 'v2.5 · 2 blocks flagged so far' : 'v2.4 · March 15, 2026 · complete'}</span>
    </div>
    <div class="row row-3" style="margin-bottom:14px">
      <div class="card" style="padding:18px 20px">
        <div class="card-label">${_syncRun ? 'Blocks flagged' : 'Blocks updated'}</div>
        <div class="stat-value" style="font-size:28px">${_syncRun ? '2' : '6'}</div>
        <div class="stat-sub">${_syncRun ? 'detected in this sync' : 'for this release'}</div>
        <div class="stat-pill ${_syncRun ? 'sp-red' : 'sp-green'}" style="margin-top:8px"><span class="stat-dot" style="background:${_syncRun ? 'var(--signal)' : 'var(--fern)'}"></span>${_syncRun ? 'update cycle starting' : 'all confirmed current'}</div>
      </div>
      <div class="card" style="padding:18px 20px">
        <div class="card-label">${_syncRun ? 'Channels affected' : 'Channels refreshed'}</div>
        <div class="stat-value" style="font-size:28px">${_syncRun ? '3' : '5'}</div>
        <div class="stat-sub">${_syncRun ? 'of 6 need attention' : 'of 6 channels updated'}</div>
        <div class="stat-pill ${_syncRun ? 'sp-red' : 'sp-amber'}" style="margin-top:8px"><span class="stat-dot" style="background:${_syncRun ? 'var(--signal)' : 'var(--straw)'}"></span>${_syncRun ? 'WorkRamp · GitBook · Loops' : 'Loops pending'}</div>
      </div>
      <div class="card" style="padding:18px 20px">
        <div class="card-label">${_syncRun ? 'Cycle time so far' : 'Time to update'}</div>
        <div class="stat-value" style="font-size:28px">${_syncRun ? '0' : '2.4'}<span style="font-size:16px;color:var(--ash)">d</span></div>
        <div class="stat-sub">${_syncRun ? 'just detected · not yet assigned' : 'release to all blocks current'}</div>
        <div class="stat-pill ${_syncRun ? 'sp-amber' : 'sp-green'}" style="margin-top:8px"><span class="stat-dot" style="background:${_syncRun ? 'var(--straw)' : 'var(--fern)'}"></span>${_syncRun ? 'tickets just opened' : 'fastest this quarter'}</div>
      </div>
    </div>
    <div class="row row-2">
      <div class="card">
        <div class="card-label">${_syncRun ? 'Blocks flagged in v2.5 sync' : 'Blocks updated for v2.4'}</div>
        <div class="activity-list">
          ${(_syncRun ? [
            {block:'API Rate Limits',date:'just now',color:'ad-red'},
            {block:'Team Permissions',date:'just now',color:'ad-red'},
          ] : [
            {block:'PR Digest — concept',date:'Mar 13, 2026',color:'ad-green'},
            {block:'PR Digest — walkthrough',date:'Mar 14, 2026',color:'ad-green'},
            {block:'PR Digest — release announcement',date:'Mar 15, 2026',color:'ad-green'},
            {block:'CI Pipeline — internal',date:'Mar 16, 2026',color:'ad-green'},
            {block:'CI Pipeline — plain language',date:'Mar 17, 2026',color:'ad-green'},
            {block:'Onboarding Checklist',date:'Mar 18, 2026',color:'ad-green'},
          ]).map(b=>`
            <div class="activity-item">
              <div class="activity-dot ${b.color}"></div>
              <div class="activity-text">${b.block}<span>${_syncRun ? 'flagged' : 'updated'} · ${b.date}</span></div>
            </div>`).join('')}
        </div>
      </div>
      <div class="card">
        <div class="card-label">Engagement — first 12 days</div>
        <div class="channel-chart" style="margin-top:8px">
          ${[
            {name:'WorkRamp external',clicks:842},
            {name:'GitBook',clicks:621},
            {name:'Loops',clicks:408},
            {name:'WorkRamp internal',clicks:394},
            {name:'Slack',clicks:287},
          ].map(c=>`
            <div class="cc-row">
              <div class="cc-label">${c.name}</div>
              <div class="cc-bar-wrap">
                <div class="cc-bar" style="width:${Math.round((c.clicks/842)*100)}%"></div>
              </div>
              <div class="cc-val">${c.clicks}</div>
            </div>`).join('')}
        </div>
        <div style="margin-top:16px;padding-top:16px;border-top:0.5px solid var(--rule)">
          <div class="card-label">Remaining work</div>
          <div class="ticket-list" style="margin-top:10px">
            <div class="ticket" onclick="showPopup(event,'TKT-041 is open in Notion. Auto-Summary rebuild is the last outstanding item from v2.4.')">
              <div class="ticket-priority tp-high"></div>
              <div class="ticket-content">
                <div class="ticket-title">Auto-Summary rebuild</div>
                <div class="ticket-meta">v2.4 rename · 18 days open</div>
              </div>
              <div class="ticket-tool">Notion ↗</div>
            </div>
            ${_syncRun ? `
            <div class="ticket" onclick="showPopup(event,'TKT-049: API Rate Limits flagged. v2.5 rate limit values need updating.')">
              <div class="ticket-priority tp-high"></div>
              <div class="ticket-content">
                <div class="ticket-title">API Rate Limits — v2.5 values</div>
                <div class="ticket-meta">sync detected · just opened</div>
              </div>
              <div class="ticket-tool">Notion ↗</div>
            </div>
            <div class="ticket" onclick="showPopup(event,'TKT-050: Team Permissions flagged. v2.5 role model not reflected.')">
              <div class="ticket-priority tp-high"></div>
              <div class="ticket-content">
                <div class="ticket-title">Team Permissions — v2.5 roles</div>
                <div class="ticket-meta">sync detected · just opened</div>
              </div>
              <div class="ticket-tool">Notion ↗</div>
            </div>` : ''}
          </div>
        </div>
      </div>
    </div>
  </div>`;
}

function leadershipView(counts,total,score,maxClicks){
  const scoreColor = score >= 80 ? 'var(--fern)' : score >= 60 ? 'var(--straw)' : 'var(--signal)';
  return `
  <div class="kpi-row">
    <div class="kpi-card">
      <div class="card-label">Content freshness score</div>
      <div class="kpi-value" style="color:${scoreColor}">${score}%</div>
      <div class="kpi-label">of all blocks confirmed current</div>
      <div class="kpi-change"><span class="kc-up">↑ 4%</span> vs last month</div>
    </div>
    <div class="kpi-card">
      <div class="card-label">Avg time to update</div>
      <div class="kpi-value">3.8<span style="font-size:18px;color:var(--ash)">d</span></div>
      <div class="kpi-label">from flag to block confirmed current</div>
      <div class="kpi-change"><span class="kc-up">↓ 0.6d</span> improvement this quarter</div>
    </div>
    <div class="kpi-card">
      <div class="card-label">Total reach</div>
      <div class="kpi-value">10.4<span style="font-size:18px;color:var(--ash)">k</span></div>
      <div class="kpi-label">clicks across all channels this month</div>
      <div class="kpi-change"><span class="kc-up">↑ 18%</span> vs last month</div>
    </div>
  </div>

  <div class="row row-2">
    <div class="card">
      <div class="card-label">Knowledge coverage by area</div>
      <div class="status-bars" style="gap:14px">
        ${(function(){
          return [
            {label:'Workflow',score:94,color:'var(--fern)'},
            {label:'Customer facing',score:_syncRun?62:78,color:_syncRun?'var(--signal)':'var(--straw)'},
            {label:'Operations',score:82,color:'var(--fern)'},
            {label:'Access & permissions',score:_syncRun?28:45,color:'var(--signal)'},
            {label:'Templates',score:100,color:'var(--fern)'},
          ];
        })().map(a=>`
          <div class="sb-row">
            <div class="sb-label">${a.label}</div>
            <div class="sb-bar-wrap" style="height:10px">
              <div class="sb-bar" style="width:${a.score}%;background:${a.color}"></div>
            </div>
            <div class="sb-count">${a.score}%</div>
          </div>`).join('')}
      </div>
    </div>
    <div class="card">
      <div class="card-label">Channel health</div>
      <div class="health-grid">
        ${(function(){
          var syncExtra = _syncRun ? 1 : 0;
          return [
            {name:'WorkRamp internal',status:'healthy',stat:'all blocks current'},
            {name:'WorkRamp external',status:_syncRun?'critical':'warning',stat:_syncRun?'2 blocks flagged':'1 block flagged'},
            {name:'GitBook',status:_syncRun?'warning':'healthy',stat:_syncRun?'1 block flagged':'all blocks current'},
            {name:'Notion',status:'healthy',stat:'all blocks current'},
            {name:'Loops',status:'warning',stat:'1 block needs update'},
            {name:'Slack',status:'healthy',stat:'all blocks current'},
          ];
        })().map(h=>`
          <div class="health-item ${h.status}">
            <div class="hi-name"><span class="hi-dot" style="background:${h.status==='healthy'?'var(--fern)':h.status==='warning'?'var(--straw)':'var(--signal)'}"></span>${h.name}</div>
            <div class="hi-stat">${h.stat}</div>
          </div>`).join('')}
      </div>
    </div>
  </div>

  <div class="row">
    <div class="card">
      <div class="card-label">Click engagement by channel</div>
      <div class="channel-chart">
        ${CHANNEL_CLICKS.map(c=>`
          <div class="cc-row">
            <div class="cc-label">${c.name}</div>
            <div class="cc-bar-wrap">
              <div class="cc-bar" style="width:${Math.round((c.clicks/Math.max(...CHANNEL_CLICKS.map(x=>x.clicks)))*100)}%"></div>
            </div>
            <div class="cc-val">${(c.clicks/1000).toFixed(1)}k</div>
            <div style="font-size:12px;color:var(--fern);width:36px;text-align:right;flex-shrink:0">+${c.change}%</div>
          </div>`).join('')}
      </div>
    </div>
  </div>`;
}

function releaseView(counts,total,score){
  const v24Blocks = ['PR Digest — concept','PR Digest — walkthrough','PR Digest — release announcement','CI Pipeline — internal','CI Pipeline — plain language','Onboarding Checklist'];
  return `
  <div class="release-header">
    <div>
      <div class="rh-title">v2.4 release — March 15, 2026</div>
      <div class="rh-meta">PR Digest rename · CI Pipeline updates · Onboarding refresh</div>
    </div>
    <div class="rh-badge">post-release · day 12</div>
  </div>

  <div class="row row-3">
    <div class="card">
      <div class="card-label">Blocks updated</div>
      <div class="stat-value">${v24Blocks.length}</div>
      <div class="stat-sub">for this release</div>
      <div class="stat-pill sp-green"><span class="stat-dot" style="background:var(--fern)"></span>all confirmed current</div>
    </div>
    <div class="card">
      <div class="card-label">Channels refreshed</div>
      <div class="stat-value">5</div>
      <div class="stat-sub">of 6 channels updated</div>
      <div class="stat-pill sp-amber"><span class="stat-dot" style="background:var(--straw)"></span>Loops pending</div>
    </div>
    <div class="card">
      <div class="card-label">Time to update</div>
      <div class="stat-value">2.4<span style="font-size:18px;color:var(--ash)">d</span></div>
      <div class="stat-sub">from release to all blocks current</div>
      <div class="stat-pill sp-green"><span class="stat-dot" style="background:var(--fern)"></span>fastest this quarter</div>
    </div>
  </div>

  <div class="row row-2">
    <div class="card">
      <div class="card-label">Blocks updated for v2.4</div>
      <div class="activity-list">
        ${v24Blocks.map((b,i)=>`
          <div class="activity-item">
            <div class="activity-dot ad-green"></div>
            <div class="activity-text">${b}<span>updated · Mar ${13+i}, 2026</span></div>
          </div>`).join('')}
      </div>
    </div>
    <div class="card">
      <div class="card-label">Engagement — first 12 days</div>
      <div class="channel-chart" style="margin-top:8px">
        ${[
          {name:'WorkRamp external',clicks:842},
          {name:'GitBook',clicks:621},
          {name:'Loops',clicks:408},
          {name:'WorkRamp internal',clicks:394},
          {name:'Slack',clicks:287},
        ].map(c=>`
          <div class="cc-row">
            <div class="cc-label">${c.name}</div>
            <div class="cc-bar-wrap">
              <div class="cc-bar" style="width:${Math.round((c.clicks/842)*100)}%"></div>
            </div>
            <div class="cc-val">${c.clicks}</div>
          </div>`).join('')}
      </div>
      <div style="margin-top:16px;padding-top:16px;border-top:0.5px solid var(--rule)">
        <div class="card-label">Remaining work</div>
        <div class="ticket-list">
          <div class="ticket" onclick="showPopup(event,'Auto-Summary rebuild is the highest priority remaining task from v2.4. Ticket open in Notion.')">
            <div class="ticket-priority tp-high"></div>
            <div class="ticket-content">
              <div class="ticket-title">Auto-Summary rebuild</div>
              <div class="ticket-meta">v2.4 rename · 18 days open</div>
            </div>
            <div class="ticket-tool">Notion ↗</div>
          </div>
        </div>
      </div>
    </div>
  </div>`;
}

function showPopup(e,msg){
  e.preventDefault();e.stopPropagation();
  const popup = document.getElementById('puLinkPopup');
  popup.textContent = msg;
  const rect = e.currentTarget.getBoundingClientRect();
  popup.style.left = Math.min(rect.left, window.innerWidth-320)+'px';
  popup.style.top = (rect.bottom+10)+'px';
  popup.classList.add('show');
  clearTimeout(popup._t);
  popup._t = setTimeout(()=>popup.classList.remove('show'),3000);
}

document.addEventListener('click',e=>{
  if(!e.target.closest('.link-popup')&&!e.target.closest('.ticket')&&!e.target.closest('.sync-btn'))
    document.getElementById('puLinkPopup').classList.remove('show');
});

// Check if sync was run on The Grid and update block statuses
try{
  if(sessionStorage.getItem('flux_sync_run')){
    const flagged = JSON.parse(sessionStorage.getItem('flux_flagged')||'[]');
    flagged.forEach(id=>{
      const block = BLOCKS.find(b=>b.id===id);
      if(block) block.status='flagged';
    });
  }
}catch(e){}

// called by initPulse()

</script>
</body>
</html>