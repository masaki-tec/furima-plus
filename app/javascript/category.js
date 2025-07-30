window.addEventListener('turbo:load', function () {
  const parentCategory = document.getElementById('parent-category');
  const selectWrap = document.getElementById('select-wrap');

  if (!parentCategory || !selectWrap) return; // 安全チェック

  // 子・孫セレクトフォームを削除する
  const selectChildElement = (selectFormId) => {
    const existingElement = document.getElementById(selectFormId);
    if (existingElement !== null) {
      existingElement.remove();
    }
  };

  // hidden_field に category_id をセット
  const setCategoryId = (value) => {
    const hiddenCategoryInput = document.getElementById('selected-category-id');
    if (hiddenCategoryInput) {
      hiddenCategoryInput.value = value;
    }
  };

  // Ajax通信
  const XHR = new XMLHttpRequest();
  const categoryXHR = (id) => {
    XHR.open("GET", `/category/${id}`, true);
    XHR.responseType = "json";
    XHR.send();
  };

  // 子カテゴリ取得
  const getChildCategoryData = () => {
    const parentValue = parentCategory.value;
    categoryXHR(parentValue);

    XHR.onload = () => {
      const items = XHR.response.item;
      appendChildSelect(items);
    };
  };

  // 子カテゴリ select を生成
  const appendChildSelect = (items) => {
    selectChildElement('child-select-wrap');
    selectChildElement('grand-child-select-wrap');

    const childWrap = document.createElement('div');
    const childSelect = document.createElement('select');

    childWrap.setAttribute('id', 'child-select-wrap');
    childSelect.setAttribute('id', 'child-select');
    childSelect.classList.add('select-box');

    const defaultOption = document.createElement('option');
    defaultOption.innerHTML = '選択してください';
    defaultOption.setAttribute('value', '');
    childSelect.appendChild(defaultOption);

    items.forEach(item => {
      const option = document.createElement('option');
      option.innerHTML = item.name;
      option.setAttribute('value', item.id);
      childSelect.appendChild(option);
    });

    childWrap.appendChild(childSelect);
    selectWrap.appendChild(childWrap);

    handleChildCategoryChange(childSelect);
  };

  // 子カテゴリ選択時の処理
  const handleChildCategoryChange = (childSelect) => {
    childSelect.addEventListener('change', () => {
      const childValue = childSelect.value;
      setCategoryId(childValue); // まず子IDをhiddenにセット

      selectChildElement('grand-child-select-wrap');

      categoryXHR(childValue);

      XHR.onload = () => {
        const grandchildItems = XHR.response.item;
        if (grandchildItems.length > 0) {
          appendGrandChildSelect(grandchildItems);
        }
      };
    });
  };

  // 孫カテゴリ select を生成
  const appendGrandChildSelect = (items) => {
    const childWrap = document.getElementById('child-select-wrap');
    const grandchildWrap = document.createElement('div');
    const grandchildSelect = document.createElement('select');

    grandchildWrap.setAttribute('id', 'grand-child-select-wrap');
    grandchildSelect.setAttribute('id', 'grand-child-select');
    grandchildSelect.classList.add('select-box');

    const defaultOption = document.createElement('option');
    defaultOption.innerHTML = '選択してください';
    defaultOption.setAttribute('value', '');
    grandchildSelect.appendChild(defaultOption);

    items.forEach(item => {
      const option = document.createElement('option');
      option.innerHTML = item.name;
      option.setAttribute('value', item.id);
      grandchildSelect.appendChild(option);
    });

    grandchildWrap.appendChild(grandchildSelect);
    childWrap.appendChild(grandchildWrap);

    // 孫が選択されたときに category_id を上書き
    grandchildSelect.addEventListener('change', () => {
      setCategoryId(grandchildSelect.value);
    });
  };

  // 親カテゴリ選択時の処理
  parentCategory.addEventListener('change', function () {
    setCategoryId(""); // 初期化
    selectChildElement('child-select-wrap');
    selectChildElement('grand-child-select-wrap');
    getChildCategoryData();
  });
});