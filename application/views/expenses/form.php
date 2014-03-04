<div id="required_fields_message"><?php echo $this->lang->line('common_fields_required_message'); ?></div>
<ul id="error_message_box"></ul>
<?php
echo form_open('expenses/save/'.$expense_info->expense_id,array('id'=>'expense_form'));
?>
<fieldset id="expense_basic_info">
<legend><?php echo $this->lang->line("expenses_basic_information"); ?></legend>

<div class="field_row clearfix">
<?php echo form_label($this->lang->line('expenses_date').':', 'date',array('class'=>'required wide')); ?>
	<div class='form_field'>
	<?php echo form_input(array(
		'name'=>'expense_date',
		'id'=>'expense_date',
		'value'=>$expense_info->expense_date)
	);?>
	</div>
</div>

<div class="field_row clearfix">
<?php echo form_label($this->lang->line('expenses_description').':', 'description',array('class'=>'required wide')); ?>
	<div class='form_field'>
	<?php echo form_input(array(
		'name'=>'description',
		'id'=>'description',
		'value'=>$expense_info->description)
	);?>
	</div>
</div>

<div class="field_row clearfix">
<?php echo form_label($this->lang->line('expenses_amount').':', 'amount',array('class'=>'required wide')); ?>
	<div class='form_field'>
	<?php echo form_input(array(
		'name'=>'amount',
		'size'=>'8',
		'id'=>'amount',
		'value'=>$expense_info->amount)
	);?>
	</div>
</div>
<?php
echo form_submit(array(
	'name'=>'submit',
	'id'=>'submit',
	'value'=>$this->lang->line('common_submit'),
	'class'=>'submit_button float_right')
);
?>

</fieldset>
<?php
echo form_close();
?>
<script type='text/javascript'>

//validation and submit handling
$(document).ready(function()
{
	Date.format = 'yyyy/mm/dd';		
	$('#expense_date').datePicker({startDate:'2014/01/01'});
	$('#expense_form').validate({
		submitHandler:function(form)
		{			
			$(form).ajaxSubmit({
			success:function(response)
			{
				tb_remove();
				post_expenses_form_submit(response);
			},
			dataType:'json'			
		});

		},
		errorLabelContainer: "#error_message_box",
 		wrapper: "li",
		rules:
		{
			expense_date:
			{
				required:true,
				date:true
			},
			description:"required",			
			amount:
			{
				required:true,
				number:true
			}			
   		}
	});
});
</script>