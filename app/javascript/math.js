console.log("カード情報トークン化のためのJavaScript");
window.addEventListener('turbo:load', function () {

  const priceInput = document.getElementById('item-price');
  const taxPrice = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');

  if (priceInput && taxPrice && profit) {
    priceInput.addEventListener('input', function() {
      const price = parseInt(priceInput.value) || 0; // nilの時は0として扱う
      const fee = Math.floor(price * 0.1);  // 販売手数料は10%
      const earnings = price - fee;
      taxPrice.textContent = fee.toLocaleString();
      profit.textContent = earnings.toLocaleString();
    });
  }
});