// Edit at dotfiles-mac/BetterTouchTool/getDateCode.js
// and paste from that file into BetterTouchTool
async (clipboardContentString) => {  // eslint-disable-line no-unused-vars
  const d = new Date();
  const YYYY = d.getFullYear().toString();
  const MM = (d.getMonth() + 1).toString().padStart(2, '0');
  const DD = d.getDate().toString().padStart(2, '0');
  return `${YYYY}${MM}${DD}`;
};
// vim: set ts=2 sw=2 sta sts=2 sr et si:
