// Sunet deschidere meniu
let sound = new Audio('js/sound.mp3');
sound.volume = 0.5;

var Diag = new Vue({
    el: "#defselector",
    data: {
		idMeniu: 'protv',
		active: false,
		numele_npcului: "Andreea Esca",
		rolul_npcului: "Anunturi CNN",
		text_npc: "🖐🏼 Bine ai venit in studioul nostru, cu ce te putem ajuta?",
		tableNpc: {
			'protv': [
				{Text: '📡 Vreau sa pun un anunt comercial', Event: '__anunt:comercial__'},
				{Text: '🎉 Vreau sa anunt un eveniment', Event: '__anunt:eveniment__'},
			],
		},
    },
    methods: {
		closemenu: function() {
			this.active = false;
			$.post("https://fr_selector/inchideMeniul", JSON.stringify());
		},
		postInClient: function(numeCallback) {
			this.closemenu();
			$.post("https://fr_selector/" + numeCallback, JSON.stringify());
		},
	},
});

window.addEventListener("message", e => {
	let data = e.data;
	switch(data.action){
		case 'createSelector':
			sound.play();
			Diag.idMeniu = data.meniu;
			Diag.text_npc = data.descriere;
			Diag.numele_npcului = data.numeNPC;
			Diag.rolul_npcului = data.rolNPC;
			Diag.active = true;
		break
	}
})

window.addEventListener("keyup", e => {
	if (e.key === "Escape") {
		Diag.closemenu()
	}
});