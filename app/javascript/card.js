const pay = () => {
  // 特定のページのURLパスをチェックする
  // if (window.location.pathname.includes("/items/") && window.location.pathname.includes("/orders")) {
    console.log("pay 関数が呼び出されました!");
    // ここにJavaScriptコードを記述する
    let payjp = Payjp('pk_test_eeab61ea55a70c4c2234a937')// PAY.JPテスト公開鍵
    console.log("payjp が呼び出されました");
    const elements = payjp.elements();
    console.log("elementsが呼び出されました");
    const numberElement = elements.create('cardNumber');
    console.log("numberElementが呼び出されました");
    const expiryElement = elements.create('cardExpiry');
    console.log("expiryElementが呼び出されました");
    const cvcElement = elements.create('cardCvc');
    console.log("cvcElementが呼び出されました");

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');

    const form = document.getElementById('charge-form')
    console.log("formが呼び出されました");
    form.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          console.log("tokenが呼び出されました");
          const renderDom = document.getElementById("charge-form");
          console.log("renderDomが呼び出されました");
          const tokenObj = `<input value=${token} name='token' 
          console.log("tokenObjが呼び出されました");type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      });
      e.preventDefault();
    });
  // }
};

window.addEventListener("turbo:load", pay);