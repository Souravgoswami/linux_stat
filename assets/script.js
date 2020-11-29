const footerGlowAnim = document.querySelectorAll('.footer-glow-anim')

let observer = new IntersectionObserver(e => {
	if(e[0].isIntersecting)
		footerGlowAnim.forEach(_fga => _fga.style.animation = `lighting${_fga.getAttribute('anim') || 1} 1.25s linear forwards ${_fga.getAttribute('delay') || 0}ms`)
	else
		footerGlowAnim.forEach(_fga =>  _fga.style.animation = 'none')
})

footerGlowAnim.forEach(_i => observer.observe(_i))

for(let i of document.querySelectorAll('pre'))
	i.innerHTML = i.innerHTML.split('\n').map(x => x.trim() + "\n").join('').trim()
