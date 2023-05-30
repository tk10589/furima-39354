window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price");
    const addTaxPrice = Math.floor(inputValue * 0.1);
    addTaxDom.innerHTML = addTaxPrice;

    const profit = document.getElementById('profit');
    const profitValue = Math.floor(inputValue - addTaxPrice);
    profit.innerHTML = profitValue;
  })
})