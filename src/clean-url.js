import * as r from "ramda";

export default x => {
  const url = new URL(r.identity(x));
  if (url.hostname.indexOf("amazon") > -1) {
    const pathSegments = url.pathname.split("/");

    const indexOfDp = pathSegments.indexOf("dp");
    pathSegments.splice(0, indexOfDp);

    pathSegments.splice(2);

    url.pathname = "/" + pathSegments.join("/");
    url.search = "";
    return url.toString();
  }
  return x;
};
