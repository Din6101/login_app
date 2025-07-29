// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
// assets/js/app.js

import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"

let Hooks = {}

// ✅ Custom hook for profile dropdown
Hooks.ProfileDropdown = {
  mounted() {
    const button = this.el.querySelector("#profile-dropdown-button")
    const menu = this.el.querySelector("#profile-dropdown-menu")

    button.addEventListener("click", (e) => {
      e.stopPropagation()
      menu.classList.toggle("hidden")
    })

    document.addEventListener("click", () => {
      menu.classList.add("hidden")
    })
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

// ✅ Attach hooks properly here
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
  longPollFallbackMs: 2500
})

// ✅ Topbar progress indicator
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", () => topbar.show(300))
window.addEventListener("phx:page-loading-stop", () => topbar.hide())

// ✅ Connect LiveSocket
liveSocket.connect()

// ✅ Optional debug tools
window.liveSocket = liveSocket


