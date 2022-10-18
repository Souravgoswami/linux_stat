const footerGlowAnim = document.querySelectorAll('.footer-glow-anim')
const topButton = document.getElementById('buttonTop')

topButton.style.opacity = window.scrollY > 100 ? 1 : 0

let observer = new IntersectionObserver(e => {
	if(e[0].isIntersecting) {
		footerGlowAnim.forEach(_fga => _fga.style.animation = `lighting${_fga.getAttribute('anim') || 1} 1.25s linear forwards ${_fga.getAttribute('delay') || 0}ms`)
	} else {
		footerGlowAnim.forEach(_fga =>  _fga.style.animation = 'none')
	}
})

footerGlowAnim.forEach(_i => observer.observe(_i))

const footer = document.getElementById('footer')

for(let i of document.querySelectorAll('pre'))
	i.innerHTML = i.innerHTML.split('\n').map(x => {
		return (x.slice(0, 2) === "\t\t") ? x.slice(2) + "\n" : (x.trim() + "\n")
	}).join('').trim()

window.onscroll = () => {
	let top = footer.getBoundingClientRect().top

	if (top < window.innerHeight) {
		topButton.style.bottom = `${window.innerHeight - top + 24}px`
	} else {
		topButton.style.bottom = `24px`
	}

	topButton.style.opacity = window.scrollY > 300 ? 1 : 0
}
