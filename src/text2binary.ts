const padLeftZeros = (str: string, len: number): string =>
    str.length < len
        ? ("0").repeat(len - str.length) + str
        : str;

const text2dec = (char: string): number =>
    char.charCodeAt(0);

const dec2hex = (dec: number): string =>
    dec.toString(16).toUpperCase();

const dec2bin = (dec: number): string =>
    padLeftZeros(dec.toString(2), 8);

const safeQuerySelector = (query: string): Element => {
    const element = document.querySelector(query);
    if (element !== null) {
        return element;
    }
    else {
        throw new Error("No element to match '" + query + "'");
    }
};


const main = () => {
    const inputText = <HTMLTextAreaElement>safeQuerySelector("#input textarea");
    const outputDec = <HTMLTextAreaElement>safeQuerySelector("#output_decimal textarea");
    const outputHex = <HTMLTextAreaElement>safeQuerySelector("#output_hexadecimal textarea");
    const outputBin = <HTMLTextAreaElement>safeQuerySelector("#output_binary textarea");

    inputText.value = "";
    outputDec.value = "";
    outputHex.value = "";
    outputBin.value = "";

    inputText.addEventListener(
        "keyup",
        (event) => {
            const codes = (<HTMLInputElement>event.target).value.split("").map(text2dec);
            outputDec.value = codes.join(" ");
            outputHex.value = codes.map(dec2hex).join(" ");
            outputBin.value = codes.map(dec2bin).join(" ");
        }
    );
}
/*
document.querySelector("#go button")
    .addEventListener("click", () => {
        const txt = document.querySelector("#input input").value;
        if (txt.length > 0) {
            let list = txt.split("").map(v => v.charCodeAt(0));
            document.querySelector("#output_decimal input").value = list.join(" ");
            document.querySelector("#output_hexadecimal input").value = list.map(v => v.toString(16).toUpperCase()).join(" ");
            document.querySelector("#output_binary textarea").value = list.map(v => (v).toString(2)).join(" ");
        }
        else {
            document.querySelector("#input input").value = "";
            document.querySelector("#output_decimal input").value = "";
            document.querySelector("#output_hexadecimal input").value = "";
            document.querySelector("#output_binary textarea").value = "";
        }
    });
*/
main();