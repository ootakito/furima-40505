window.onload = function() {
    const priceInput = document.getElementById("item-price");
    const addTaxPrice = document.getElementById("add-tax-price");
    const profitElement = document.getElementById("profit");
    
    priceInput.addEventListener("input", () => {
      const price = parseFloat(priceInput.value);
      if (!isNaN(price)) {
          const tax = price * 0.1; 
          const profit = price - tax; 
          addTaxPrice.textContent = Math.floor(tax); 
          profitElement.textContent = Math.floor(profit); 
      } else {
          addTaxPrice.textContent = "0"; 
          profitElement.textContent = "0"; 
      }
  });
};