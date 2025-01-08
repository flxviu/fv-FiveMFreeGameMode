const Survival = new Vue({
    el: ".cont_hud",
    data: {
        Health: 100,
        Armor: 0,
        Food: 0,
        Water: 0,
        Pipi: 0,
        Caca: 0,
        Jeg: 0
    },

    mounted() {
        window.addEventListener("message", this.onMessage);
    },

    methods: {
        animateStat(stat, endValue) {
            const startValue = this.$data[stat];
            const duration = ((Math.abs(startValue - endValue) / 100) * 3000).toFixed(2);
            const startTime = performance.now();
            
            const updateStat = (timestamp) => {
                const progress = Math.min(1, (timestamp - startTime) / duration);
                const currentValue = Math.round(startValue + progress * (endValue - startValue));
                this.$data[stat] = currentValue;

                if (progress < 1) {
                    requestAnimationFrame(updateStat);
                }
            };
            requestAnimationFrame(updateStat);
        },

        onMessage() {
            var data = event.data
            
            switch(data.act) {
                case "updateStats":
                    switch(data.stat) {
                        case "Health":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.Health = Math.floor(Number(data.value))
                            } else {
                                this.animateStat('Health', 0)
                                this.Health = 0
                            }
                        break

                        case "Armor":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.Armor = Math.floor(Number(data.value))
                            } else {
                                this.Armor = 0
                            }
                        break

                        case "Food":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.animateStat('Food', Math.floor(Number(data.value)))
                            } else {
                                this.animateStat('Food', 0)
                            }
                        break

                        case "Water":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.animateStat('Water', Math.floor(Number(data.value)))
                            } else {
                                this.animateStat('Water', 0)
                            }
                        break

                        case "Pipi":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.animateStat('Pipi', Math.floor(Number(data.value)))
                            } else {
                                this.animateStat('Pipi', 0)
                            }
                        break

                        case "Caca":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.animateStat('Caca', Math.floor(Number(data.value)))
                            } else {
                                this.animateStat('Caca', 0)
                            }
                        break

                        case "Jeg":
                            if (Math.floor(Number(data.value)) > 0 ) {
                                this.animateStat('Jeg', Math.floor(Number(data.value)))
                            } else {
                                this.animateStat('Jeg', 0)
                            }
                        break
                    }
                break
            }
        }
    }
})