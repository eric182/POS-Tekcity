<?php $this->load->view("partial/header"); ?>

<div id="title_bar">
	<div id="title" class="float_left"><?php echo date('Y/m/d'); ?></div>
</div>
<?php echo $this->pagination->create_links();?>
<table border="0" cellspacing="10">
	<thead>
		<th>Payment Type</th>
		<th>Amount</th>
	</thead>
	<tbody>
	<?php $sum; $rest; ?>
	<?php foreach($manage_table as $account): ?>
		<?php if($account->transaction_type == '0'): ?>
		<tr style="color:red;">
			<td><?php echo $account->payment_type ?></td>
			<td><?php echo number_format($account->payment_amount,2) ?></td>
			<?php $rest = $rest + $account->payment_amount; ?>
		</tr>			
		<?php else: ?>		
		<tr>
			<td><?php echo $account->payment_type ?></td>
			<td><?php echo number_format($account->payment_amount,2) ?></td>
			<?php $sum = $sum + $account->payment_amount; ?>
		</tr>			
		<?php endif; ?>		
	<?php endforeach; ?>
	</tbody>
	<tfoot>
		<th>Total</th>
		<th><?php echo number_format($sum - $rest,2); ?></th>
	</tfoot>
</table>
<div id="feedback_bar"></div>
<?php $this->load->view("partial/footer"); ?>