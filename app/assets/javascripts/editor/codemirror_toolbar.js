// Because sometimes you need to style the cursor's line.
//
// Adds an option 'styleActiveLine' which, when enabled, gives the
// active line's wrapping <div> the CSS class "CodeMirror-activeline",
// and gives its background <div> the class "CodeMirror-activeline-background".

(function() {
  "use strict";
  var FIRST_LINE = 0;
  var FIRST_LINE_CLASS = "CodeMirror-titleline";

  CodeMirror.defineOption("setFirstLineAsTitleLine", false, function(cm, val, old) {
    var prev = old && old != CodeMirror.Init;
    if (val && !prev) {
      updateFirstLine(cm);
      cm.on("cursorActivity", updateFirstLine);
    } else if (!val && prev) {
      cm.off("cursorActivity", updateFirstLine);
      clearFirstLine(cm);
      delete cm.state.firstLineAsTitleLine;
    }
  });

  function clearFirstLine(cm) {
    if ("firstLineAsTitleLine" in cm.state) {
      cm.removeLineClass(FIRST_LINE, "wrap", FIRST_LINE_CLASS);
    }
  }

  function updateFirstLine(cm) {
    clearFirstLine(cm);
    cm.addLineClass(FIRST_LINE, "wrap", FIRST_LINE_CLASS);
    cm.state.firstLineAsTitleLine = true;
  }
})();
