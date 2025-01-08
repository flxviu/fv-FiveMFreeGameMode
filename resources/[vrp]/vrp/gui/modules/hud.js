const initialDiagTitle = "CONFIRMARE NECESARĂ";
const requestManager = new Vue({
	el: "#all-requests",
	data: {
		promptData: {
			active: false,
			title: "",
			description: "",
			response: "",
		},
		dialogData: {
			active: false,
			identifier: false,
			title: initialDiagTitle,
			text: "",
		},
	},
	methods: {
		async post(url, data = {}) {
			const response = await fetch(`https://${GetParentResourceName()}/${url}`, {
			    method: 'POST',
			    headers: { 'Content-Type': 'application/json' },
			    body: JSON.stringify(data)
			});
			
			return await response.json();
		},


		createDialog(id, title, text) {
			$(".request-container").fadeIn();
			this.dialogData.active = true;
	        this.dialogData.identifier = id;
	        this.dialogData.title = title || initialDiagTitle;
	        this.dialogData.text = text;
		},

		createPrompt(title, description, response) {
	        this.promptData.active = true;
			$(".prompt-layout").show();
			$(".prompt-layout > .prompt-menu > .wrapper > input").focus();
	        this.promptData.title = title || 'Prompt Menu';
			this.promptData.description = description || 'Introdu raspunsul dorit in caseta de mai jos si apoi apasa pe butonul pentru confirmare.';

			if (response)
	        	this.promptData.response = response;
		},

		useDialog(response) {
			if (!this.dialogData.active) return;
			
			this.post("request", {id: this.dialogData.identifier, ok: response || false});
			this.hideDialog();
		},

		usePrompt(ok) {
			var response = this.promptData.response;

			if (!ok){
				response = ok;
			}

			if (((typeof(response) == "string" ? response : "fakestring") || "").trim().length == 0){
				response = false;
			}

			this.post("prompt", [response]);
			this.hidePrompt();
	    },

		hideDialog() {
			this.dialogData.active = false;
			$(".request-container").fadeOut();
			this.dialogData.identifier = false;
		},

		hidePrompt() {
			$(".prompt-layout").hide();
			this.promptData.active = false
			this.promptData.response = "";
		},
	},
})

const bottomRightHud = new Vue({
    el: ".hud-bottom-right",
    data: {
        zoom: 0,
        show: true,
    },
    mounted() {
        window.addEventListener("resize", this.handleResize)
        window.addEventListener("message", this.onMessage)
    },
    methods: {
        
        async post(url, data = {}) {
			const response = await fetch(`https://${GetParentResourceName()}/${url}`, {
			    method: 'POST',
			    headers: { 'Content-Type': 'application/json' },
			    body: JSON.stringify(data)
			});
			
			return await response.json();
		},


        handleResize() {
            var zoomCountOne = $(window).width() / 1920;
            var zoomCountTwo = $(window).height() / 1080;

            if (zoomCountOne < zoomCountTwo) this.zoom = zoomCountOne;else this.zoom = zoomCountTwo;
        },

    }
})