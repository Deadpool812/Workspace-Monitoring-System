// Call the dataTables jQuery plugin
$(document).ready(function() {
  $('#dataTableOne').DataTable({
	"columns": [
    null,
    null,
    { "orderable": false },
    { "orderable": false },
    { "orderable": false },
	{ "orderable": false },
	null,
	{ "orderable": false },
	{ "orderable": false }
  ]
  });
});
