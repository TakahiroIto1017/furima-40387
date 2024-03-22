window.addEventListener('turbo:load', () => {

  const price = document.getElementById("item-price");

  price.addEventListener("input", () => {

    const priceValue = price.value;

    const fee = document.getElementById("add-tax-price");
    const feeValue = Math.floor(priceValue*0.1);
    fee.innerHTML = feeValue;

    const profit = document.getElementById("profit");
    profit.innerHTML = priceValue-feeValue;

  })

});