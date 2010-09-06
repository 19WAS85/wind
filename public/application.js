$(function() {
	$('input:hidden[value=delete][name=_method]').parent('form').submit(function() {
		return confirm('Tem certeza que deseja remover este registro?');
	});
});