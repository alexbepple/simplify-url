export default x => {
  if (x.indexOf("amazon") > -1) {
    const intermed = x.replace(new RegExp("(/dp/.+)/.*"), "$1");
    console.log("xxx", intermed);
    return intermed.replace(new RegExp("([^/]+)/[^/]+/dp"), "$1/dp");
  }
  return x;
};
