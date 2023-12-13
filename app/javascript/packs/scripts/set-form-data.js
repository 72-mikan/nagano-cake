$('#myModal').on('show.bs.modal', function (event) {
    var button = $(event.relatedTarget);
    var sampledata = button.data('sample');
    var modal = $(this);
    modal.find('.modal-title').val(sampledata);
  })