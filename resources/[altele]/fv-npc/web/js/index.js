let call = function(numeEvent, dataEvent) {
    return $.post("https://fv-npc/" + numeEvent, JSON.stringify(dataEvent));
};
let sound = new Audio('js/sound.mp3');
sound.volume = 0.5;
let listen = window.addEventListener;

var MeniuSelector = new Vue({
    el: "#defselector",
    data: {
        idMeniu: 'sala',
        active: false,
        numele_npcului: "Cosmin Dinu",
        rolul_npcului: "Vanzari ilegale",
        text_npc: "🍃 Salut!",
        tableNpc: {
            'jobs': [
                { Text: 'Angajeaza-te ca Gunoier (INCEPUT)', Event: 'sxint:angajeazaGunoier' },
                { Text: 'Angajeaza-te ca Miner', Event: 'sxint:angajeazaMiner' },
                { Text: 'Angajeaza-te ca Pescar', Event: 'sxint:angajeazaPescar' },
                { Text: 'Angajeaza-te ca Santierist', Event: 'sxint:angajeazaSantierist' },
                { Text: 'Angajeaza-te ca Sofer de Autobuz (INCEPUT)', Event: 'sxint:angajeazaAutobuz' },
                { Text: 'Angajeaza-te ca Taietor De Lemne', Event: 'sxint:angajeazaLemne' },
                { Text: 'Demisioneaza ( Devin-o SOMER )', Event: 'sxint:devinoSomer' },
                
            ],
            'showroom': [
                { Text: 'Intra in Showroom!', Event: 'ples-dealership:requestCategory' },
                { Text: 'Cat costa masinile?', Event: 'ples-dealership:catCosta' },
            ],
            // Joburi Legale
            'soferautobuz': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:startBusDriver' },
                { Text: 'Vreau sa ies din tura', Event: 'sxint:stopBusDriver' },
            ],
            'pescar': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateFisherMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopPescar' },
                { Text: "Vreau sa imi cumpar undita", Event: "sxint:cumparaUndita"},
            ],
            'santierist': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:startSantieristJob' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopSantieristJob' },
                { Text: "Vreau sa cumpar o Trusa de Scule", Event: 'sxint:cumparaScule' },
            ],
            'miner': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateMinerMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopMiner' },
                { Text: 'Vreau sa cumpar un Tarnacop', Event: 'sxint:cumparaTarnacop' },
            ],
            'electrician': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateElectricianMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopElectrician' },
            ],
            'gradinar': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateGradinarMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopGradinar' },
            ],
            'taietorlemne': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateTaietorLemneMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopTLemne' },
                { Text: 'Vreau sa cumpar un Topor', Event: 'sxint:cumparaTopor' },
            ],
            'gunoier': [
                { Text: 'Vreau sa intru in Tura', Event: 'sxint:generateGunoierMission' },
                { Text: 'Vreau sa ies din Tura', Event: 'sxint:stopGunoier' },
            ],
        },
    },
    methods: {
        inchide: function() {
            this.active = false;
            call("inchideMeniul", { inchidereNpc: true });
        },
        postInClient: function(numeCallback) {
            this.inchide();
            let action = numeCallback;
            call("actionData", action);
        },
    },
});

listen("message", e => {
    let data = e.data;
    switch (data.action) {
        case 'createSelector':
            sound.play();
            MeniuSelector.idMeniu = data.meniu;
            MeniuSelector.text_npc = data.descriere;
            MeniuSelector.numele_npcului = data.numeNPC;
            MeniuSelector.rolul_npcului = data.rolNPC;
            MeniuSelector.active = true;
            break
    }
});

listen("keyup", e => {
    if (e.key === "Escape") {
        if (MeniuSelector.active) {
            MeniuSelector.inchide();
        }
    }
});