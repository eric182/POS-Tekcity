<?php
require_once ("secure_area.php");
require_once ("interfaces/idata_controller.php");
// require_once ('FirePHPCore/fb.PHP');
class Expenses extends Secure_area implements iData_controller
{
	function __construct()
	{
		parent::__construct('expenses');
	}
	
	function index()
	{						
		$config['base_url'] = site_url('/expenses/index');
		$config['total_rows'] = $this->Expense->count_all();
		$config['per_page'] = '20';
		$config['uri_segment'] = 3;
		$this->pagination->initialize($config);
		
		$data['controller_name']=strtolower(get_class());
		$data['form_width']=$this->get_form_width();
		$data['manage_table']=get_expenses_manage_table( $this->Expense->get_all( $config['per_page'], $this->uri->segment( $config['uri_segment'] ) ), $this );
		$this->load->view('expenses/manage',$data);				
	}
	
	/*
	Returns employee table data rows. This will be called with AJAX.
	*/
	function search()
	{		
		$search=$this->input->post('search');
		$data_rows=get_expenses_manage_table_data_rows($this->Expense->search($search),$this);
		echo $data_rows;
	}
	
	/*
	Gives search suggestions based on what is being searched for
	*/
	function suggest()
	{				
		$suggestions = $this->Expense->get_search_suggestions($this->input->post('q'),$this->input->post('limit'));
		echo implode("\n",$suggestions);
	}
	
	/*
	Loads the customer edit form
	*/
	function view($expense_id=-1)
	{	
		$data['expense_info']=$this->Expense->get_info($expense_id);
		$this->load->view("expenses/form",$data);
	}
	
	
	/*
	Inserts/updates an employee
	*/
	function save($expense_id=-1)
	{			
		$expenses_data = array(		
		'expense_date'=>$this->input->post('expense_date'),			
		'description'=>$this->input->post('description'),
		'amount'=>$this->input->post('amount')
		);		
					
		if($this->Expense->save($expenses_data,$expense_id))
		{
			//New employee
			if($expense_id==-1)
			{
				echo json_encode(array('success'=>true,'message'=>$this->lang->line('expenses_successful_adding').' '.
				$expenses_data['description'].' '.$expenses_data['amount'],'expense_id'=>$expenses_data['expense_id']));
			}
			else //previous employee
			{
				echo json_encode(array('success'=>true,'message'=>$this->lang->line('expenses_successful_updating').' '.
				$expenses_data['description'].' '.$expenses_data['amount'],'expense_id'=>$expense_id));
			}
		}
		else//failure
		{	
			echo json_encode(array('success'=>false,'message'=>$this->lang->line('expenses_error_adding_updating').' '.
			$expenses_data['description'].' '.$expenses_data['amount'],'expense_id'=>-1));
		}
	}
	
	/*
	This deletes employees from the employees table
	*/
	function delete()
	{			
		$expenses_to_delete=$this->input->post('ids');

		if($this->Expense->delete_list($expenses_to_delete))			
		{			
			echo json_encode(array('success'=>true,'message'=>$this->lang->line('expenses_successful_deleted').' '.
			count($expenses_to_delete).' '.$this->lang->line('expenses_one_or_multiple')));
		}
		else
		{
			echo json_encode(array('success'=>false,'message'=>$this->lang->line('expenses_cannot_be_deleted')));
		}
	}
	/*
	get the width for the add/edit form
	*/
	function get_form_width()
	{
		return 650;
	}
	/*
	Gets one row for a person manage table. This is called using AJAX to update one row.
	*/
	function get_row()
	{		
		$expense_id = $this->input->post('row_id');
		$data_row=get_expense_data_row($this->Expense->get_info($expense_id),$this);
		echo $data_row;
	}	
}
?>