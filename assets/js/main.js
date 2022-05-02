// sticky navbar
window.addEventListener("scroll", () => {
    let header = document.getElementById("sticky-header");
    if (window.pageYOffset > header.offsetHeight * 1.3) {
        header.style.position = "fixed";
    } else {
        header.style.position = "relative";
    }
});