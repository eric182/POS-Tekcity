<?php require('fpdf.php'); ?>
<?php $this->load->view("partial/header"); ?>
<?php
if (isset($error_message))
{
	echo '<h1 style="text-align: center;">'.$error_message.'</h1>';
	exit;
}
?>
<div id="receipt_wrapper">
	<div id="receipt_header">
		<?php 
		$dt = new DateTime($transaction_time);
		$date = $dt->format('d/m/Y');
		$transaction_time = $date;
		?>
		<div id="sale_time"><?php echo $transaction_time ?></div>
		<div id="account_number"><?php  echo $account_number; ?></div>
		<div id="customer"><?php  echo $customer; ?></div>
		<div id="address"><?php  echo $address; ?></div>
	</div>

	<table id="receipt_items">
	<tr>	
	<th></th>
	<th></th>
	<th></th>
	</tr>
	<?php
	foreach(array_reverse($cart, true) as $line=>$item)
	{
	?>
		<tr>
		<td style='text-align:center;'><?php echo $item['quantity']; ?></td>
		<td><span class='long_name'><?php echo $item['name']; ?></span><span class='short_name'><?php echo character_limiter($item['name'],10); ?></span></td>						
		<td style='text-align:right;'><?php echo to_currency($item['price']*$item['quantity']-$item['price']*$item['quantity']*$item['discount']/100); ?></td>
		</tr>

	<?php
	}
	?>

	<tr>
	<td></td>
	<td></td>	
	<td colspan="2" style='text-align:right'><?php echo to_currency($total); ?></td>
	</tr>
</div>

<?php if ($this->Appconfig->get('print_after_sale'))
{
?>
<script type="text/javascript">
$(window).load(function()
{
	window.print();
});
</script>
<?php
}
?>