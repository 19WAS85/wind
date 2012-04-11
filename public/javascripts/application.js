$(function() {
	$('input:hidden[value=delete][name=_method]').parent('form').submit(function() {
		return confirm('Are you sure?');
	});
});