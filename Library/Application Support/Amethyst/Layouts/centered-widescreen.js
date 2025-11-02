function layout() {
  return {
    name: "Centered Widescreen",
    getFrameAssignments: (windows, screenFrame) => {
      const oneWindowWidthRatio = 0.75;
      const splitMainRatio = 0.55;

      if (windows.length === 1) {
        // Centered 75% width for single window
        const mainWidth = screenFrame.width * oneWindowWidthRatio;
        const mainX = screenFrame.x + (screenFrame.width - mainWidth) / 2;

        const mainFrame = {
          x: mainX,
          y: screenFrame.y,
          width: mainWidth,
          height: screenFrame.height,
        };

        return { [windows[0].id]: mainFrame };
      } else {
        // 60/40 horizontal split
        const mainWidth = screenFrame.width * splitMainRatio;
        const sideWidth = screenFrame.width - mainWidth;

        const mainFrame = {
          x: screenFrame.x,
          y: screenFrame.y,
          width: mainWidth,
          height: screenFrame.height,
        };

        const secondaryWindows = windows.slice(1);
        const sideHeight = screenFrame.height / secondaryWindows.length;

        const sideFrames = secondaryWindows.map((win, index) => ({
          [win.id]: {
            x: screenFrame.x + mainWidth,
            y: screenFrame.y + index * sideHeight,
            width: sideWidth,
            height: sideHeight,
          },
        }));

        return [
          { [windows[0].id]: mainFrame },
          ...sideFrames,
        ].reduce((acc, frame) => ({ ...acc, ...frame }), {});
      }
    },
  };
}
