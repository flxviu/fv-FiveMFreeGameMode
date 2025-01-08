const registerContainerObj = document.getElementById("register-container");
const socialsContainerObj = document.getElementById("socials-container");

const registerInputs = {
    "name": document.getElementById("register-name"),
    "firstname": document.getElementById("register-firstname"),
    "age": document.getElementById("register-age")
}

let selectedSex = false;

const selectSex = (clickObj, sex) => {
    for (const key in registerInputs) {
        if (registerInputs[key].value.length == 0) return;
    }

    const selectors = document.getElementsByClassName("sex-selector");

    for (let i = 0; i < selectors.length; i++) {
        const obj = selectors[i];
        obj.classList.remove("selected");
    }

    clickObj.classList.add("selected");
    selectedSex = sex;

    socialsContainerObj.classList.add("hide");
}

const confirmRegister = () => {
    if (!selectedSex) return;
    let registerData = {
        sex: selectedSex
    }
    for (const key in registerInputs) {
        if (registerInputs[key].value.length == 0) return;
        registerData[key] = key == "age" ? parseInt(registerInputs[key].value) : registerInputs[key].value;
    }
    $.post('https://' + GetParentResourceName() + '/register', JSON.stringify(registerData));
}

const openRegisterUi = () => {
    registerContainerObj.style.display = "flex";
}

const closeRegisterUi = () => {
    registerContainerObj.style.display = "none";
}

window.addEventListener("message", (event) => {
    switch (event.data.action) {
        case "openRegisterUi":
            openRegisterUi();
            break;
        case "closeRegisterUi":
            closeRegisterUi();
            break;
        default:
            break;
    }
});