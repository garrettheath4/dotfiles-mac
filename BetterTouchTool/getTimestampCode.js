// Edit at dotfiles-mac/BetterTouchTool/getTimestampCode.js
// and paste from that file into BetterTouchTool
async (clipboardContentString) => {  // eslint-disable-line no-unused-vars
  const d = new Date();
  const YYYY = d.getFullYear().toString();
  const MM = (d.getMonth() + 1).toString().padStart(2, '0');
  const DD = d.getDate().toString().padStart(2, '0');
  const hh = d.getHours().toString().padStart(2, '0');
  const mn = d.getMinutes().toString().padStart(2, '0');
  const ss = d.getSeconds().toString().padStart(2, '0');
  return `${YYYY}${MM}${DD}T${hh}${mn}${ss}`;
};
