$('#btn-save-product-type').on("click", function() {

  if (sessionStorage.getItem("editMode") === 'add') {
    $('#form-product-type').submit();
  }
  if (sessionStorage.getItem("editMode") === 'edit') {
    sessionStorage.getItem("idEditing");

    $('#form-product-type').children()[0].value = sessionStorage.getItem("idEditing");
    $('#form-product-type').submit();
  }
})

$('#btn-save-cooking-type').on("click", function() {
  // console.log("cooking type");
  if (sessionStorage.getItem("editMode") === 'add') {
    $('#form-cooking-type').submit();
  }
  if (sessionStorage.getItem("editMode") === 'edit') {
    sessionStorage.getItem("idEditing");

    $('#form-cooking-type').children()[0].value = sessionStorage.getItem("idEditing");
    $('#form-cooking-type').submit();
  }
  
})

$('#btn-save-product').on("click", function() {
  

  if (sessionStorage.getItem("editMode") === 'add') {
    $('#form-product').submit();
  }
  if (sessionStorage.getItem("editMode") === 'edit') {
    console.log(sessionStorage.getItem("idEditing"));
    sessionStorage.getItem("idEditing");
    console.log("acb")

    $('#form-product').children()[0].value = sessionStorage.getItem("idEditing");
    $('#form-product').submit();
  }
})

