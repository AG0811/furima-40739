function initializePriceCalculation() {
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
}

// ページロード時およびTurboナビゲーション時に初期化
document.addEventListener('DOMContentLoaded', initializePriceCalculation);
document.addEventListener('turbo:load', initializePriceCalculation);

// Turboエラーイベントのリスニング
document.addEventListener('turbo:render', (event) => {
  console.log("ページがロードされました");
  initializePriceCalculation(); // 再描画時に再初期化
});

document.addEventListener('turbo:submit-end', (event) => {
  if (event.detail.success) {
    console.log("Form submission succeeded");
  } else {
    console.log("Form submission failed");
    // エラーメッセージ表示のための処理などを追加可能
    initializePriceCalculation(); // エラー後に再初期化
  }
});