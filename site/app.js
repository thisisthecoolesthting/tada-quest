// Tada Quest site — loads missions.json and renders cards. No tracking, no cookies.
(function () {
  const grid = document.getElementById("mission-grid");
  if (!grid) return;

  fetch("missions.json")
    .then((r) => r.json())
    .then((data) => {
      const missions = (data.missions || []).sort((a, b) => a.number - b.number);
      grid.innerHTML = "";
      missions.forEach((m) => {
        const card = document.createElement("div");
        card.className = "card";
        const art = (m.asset || "").replace(/^assets\//, "assets/");
        const pills = [
          `<span class="pill">${m.timeMinutes} min</span>`,
          `<span class="pill">${m.skill}</span>`,
          m.needsAdult ? `<span class="pill adult">Grown-up helps</span>` : "",
        ].join("");
        card.innerHTML = `
          <img src="${art}" alt="" onerror="this.style.display='none'">
          <h3>${escapeHtml(m.title)}</h3>
          <p>${escapeHtml(m.subtitle || m.effect || "")}</p>
          <div class="pills">${pills}</div>
        `;
        grid.appendChild(card);
      });
    })
    .catch((e) => {
      grid.innerHTML =
        "<p>Could not load missions. Make sure missions.json is alongside this page.</p>";
      console.error(e);
    });

  function escapeHtml(s) {
    return String(s)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;");
  }
})();
