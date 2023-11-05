champarmor = document.querySelector(".sortable > tbody:nth-child(2)").children
baseStat = []
for (let i = 0; i < champarmor.length; i++)
	baseStat[i] = Number(champarmor[i].children[1].innerText) // change children[1] to children[2] to get growth

avg = 0
baseStat.forEach((v, i) => {
	avg += v
})
console.log(avg / baseStat.length)
