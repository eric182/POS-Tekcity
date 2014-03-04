<?php 
class Register extends CI_Model
{
	
	function get_all($from, $to)
	{
		$query = $this->db->query("SELECT ospos_sales_payments.payment_type , SUM(payment_amount) AS payment_amount, '1' AS transaction_type 
			FROM tekcity.ospos_sales_payments 
			LEFT JOIN tekcity.ospos_sales ON tekcity.ospos_sales.sale_id = tekcity.ospos_sales_payments.sale_id 
			WHERE DATE(ospos_sales.sale_time) BETWEEN '$from' AND '$to' 
			GROUP BY ospos_sales_payments.payment_type 
			UNION ALL 
			SELECT 'Expenses', SUM(amount), '0' AS expenses_amount 
			FROM tekcity.ospos_expenses 
			WHERE expense_date BETWEEN '$from' AND '$to'");
			
			return $query->result();		
	}

}
?>