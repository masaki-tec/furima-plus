document.addEventListener("turbo:load", () => {
  const form = document.getElementById("comment-form")
  if (!form) return

  form.addEventListener("submit", function(e){
    e.preventDefault()
    
    const formData = new FormData(form)
    const itemId = location.pathname.match(/\d+/)[0]

    fetch(`/items/${itemId}/comments`, {
      method: "POST",
      body: formData,
      headers: { "Accept": "application/json" }
    })
    .then(response => {
      if (!response.ok) throw response
      return response.json()
    })
    .then(() => {
      // 成功時はActionCableで自動反映されるので何もしない
      form.reset()
      const errorDiv = document.getElementById("comment-error")
      if (errorDiv) errorDiv.remove()
    })
    .catch(async (error) => {
      const data = await error.json()
      let errorDiv = document.getElementById("comment-error")
      if (!errorDiv) {
        errorDiv = document.createElement("div")
        errorDiv.id = "comment-error"
        errorDiv.className = "comment-error"
        form.appendChild(errorDiv)
      }
      errorDiv.textContent = data.errors.join(", ")
    })
  })
})