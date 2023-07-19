export const Logger = {
  mounted() {
    console.log("WOWOWOW");
  },
};

export const ACoolThing = {
  mounted() {
    this.el.innerHTML = "<h1>A cool thing</h1>";
  },
};
