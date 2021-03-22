$(".add").on("click", () => {
  sessionStorage.setItem("editMode", "add");
});

$(".edit").each(function(index, editBtn) {
  $(this).on("click", () => {
    sessionStorage.setItem("editMode", "edit");
    sessionStorage.setItem("idEditing", $(this).parent().parent().children()[0].innerText);
  });
})

$(".delete").each(function (index, delBtn) {
  // product-type
  var type = $(this).data('type');
  
  $(this).on("click", function () {
    const that = this;
      $.ajax({
        type: 'DELETE',
        data: {
            type: type,
            id : $(this).parent().parent().children()[0].innerText,
          },
        success: function(result) {
          // console.log(result);
          $(that).parent().parent().remove();
        }
    });
  });
});
