document.addEventListener("DOMContentLoaded", function(event) {
    safari.extension.dispatchMessage("Loading MacPass Extension Javascript");
});

document.addEventListener("contextmenu", handleContextMenu, false);
function handleContextMenu(event)
{
  var url = document.URL;
  safari.extension.setContextMenuEventUserInfo(event,
                                               { "url": url });
}
