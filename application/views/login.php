<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" rev="stylesheet" href="<?php echo base_url();?>css/login.css" />
<title>Open Source Point Of Sale <?php echo $this->lang->line('login_login'); ?></title>
<script src="<?php echo base_url();?>js/jquery-1.2.6.min.js" type="text/javascript" language="javascript" charset="UTF-8"></script>
<script type="text/javascript">
$(document).ready(function()
{
	$("#login_form input:first").focus();
});
</script>
</head>
<body>
	<div align="center">
		<?php echo img('images/tekcity.png'); ?>
		<p class="text">Open Source Point Of Sale Version 2.1.1.</p>		
	</div>	
	<?php echo form_open('login','class="login"') ?>		
		<p>
			<label for="login">Usuario:</label>
			<?php echo form_input(array('name'=>'username')); ?>
		</p>

		<p>
			<label for="login">Contraseña:</label>
			<?php echo form_password(array('name'=>'password')); ?>		
		</p>
		
		<p class="login-submit">
			<button type="submit" class="login-button">Login</button>
		</p>
		<p>			
			<?php echo validation_errors(); ?>	
		</p>
	<?php echo form_close(); ?>	
</body>
</html>
