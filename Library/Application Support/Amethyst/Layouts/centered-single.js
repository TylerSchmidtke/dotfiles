function layout() {
  return {
    name: "Centered Single",
    getFrameAssignments: (windows, screenFrame) => {
      const widthRatio = 0.75;

      const width = screenFrame.width * widthRatio;
      const x = screenFrame.x + (screenFrame.width - width) / 2;

      const sharedFrame = {
        x: x,
        y: screenFrame.y,
        width: width,
        height: screenFrame.height,
      };

      // Assign the same centered frame to all windows
      return windows.reduce((acc, win) => {
        acc[win.id] = sharedFrame;
        return acc;
      }, {});
    },
  };
}
