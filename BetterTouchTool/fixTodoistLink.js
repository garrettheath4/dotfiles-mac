// Edit at dotfiles-mac/BetterTouchTool/fixTodoistLink.js
// and paste from that file into BetterTouchTool
async (clipboardContentString) => {
  // Before: [https://github.com/jimeh/git-aware-prompt (GitHub)]
  // After:  [GitHub](https://github.com/jimeh/git-aware-prompt)
  const linkRegex = /\[(?<url>[a-z]+:\/\/[\w-_./?&=+#@]+) \((?<text>[\w-]+)\)\]/;
  var textToSearch = clipboardContentString;
  var match = linkRegex.exec(textToSearch);
  while (match !== null) {
    textToSearch = textToSearch.replace(linkRegex,
      `[|${match.groups.text}|](${match.groups.url})`);
    match = linkRegex.exec(textToSearch);
  }
  return textToSearch;
};
// vim: set ts=2 sw=2 sta sts=2 sr et si:
