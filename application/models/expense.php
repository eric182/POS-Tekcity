<?php
class Expense extends CI_Model 
{
	/*Determines whether the given person exists*/
	function exists($expense_id)
	{
		$this->db->from('expenses');	
		$this->db->where('expenses.expense_id',$expense_id);
		$query = $this->db->get();
		
		return ($query->num_rows()==1);
	}
	
	/*Gets all people*/
	function get_all($limit=10000, $offset=0)
	{
		$this->db->from('expenses');
		$this->db->where('deleted',$this->db->escape('0'));
		$this->db->order_by("expense_id", "asc");
		$this->db->limit($limit);
		$this->db->offset($offset);
		return $this->db->get();		
	}
	
	function count_all()
	{
		$this->db->from('expenses');
		$this->db->where('deleted',0);
		return $this->db->count_all_results();
	}
	
	/*
	Gets information about a person as an array.
	*/
	function get_info($expense_id)
	{
		$query = $this->db->get_where('expenses', array('expense_id' => $expense_id), 1);
		
		if($query->num_rows()==1)
		{
			return $query->row();
		}
		else
		{
			//create object with empty properties.
			$fields = $this->db->list_fields('expenses');
			$expenses_obj = new stdClass;
			
			foreach ($fields as $field)
			{
				$expenses_obj->$field='';
			}
			
			return $expenses_obj;
		}
	}
	
	/*
	Get people with specific ids
	*/
	function get_multiple_info($expense_ids)
	{
		$this->db->from('expenses');
		$this->db->where_in('expense_id',$expense_ids);
		$this->db->order_by("expense_id", "asc");
		return $this->db->get();		
	}
	
	/*
	Inserts or updates a person
	*/
	function save(&$expense_data,$expense_id=false)
	{		
		if (!$expense_id or !$this->exists($expense_id))
		{
			if ($this->db->insert('expenses',$expense_data))
			{
				$expense_data['expense_id']=$this->db->insert_id();
				return true;
			}
			
			return false;
		}
		
		$this->db->where('expense_id', $expense_id);
		return $this->db->update('expenses',$expense_data);
	}
 	/*
	Get search suggestions to find giftcards
	*/
	function get_search_suggestions($search,$limit=25)
	{
		$suggestions = array();

 		$this->db->from('expenses');		
		$this->db->like("description",$this->db->escape_like_str($search));		
		$this->db->where('deleted',$this->db->escape('0'));
		$this->db->order_by("description", "asc");
		$by_description = $this->db->get();
		
		foreach($by_description->result() as $row)
		{
			$suggestions[]=$row->description;
		}

		if(count($suggestions > $limit))
		{
			$suggestions = array_slice($suggestions, 0,$limit);
		}
		return $suggestions;
	}
	
	/*
	Deletes one customer
	*/
	function delete($expense_id)
	{		
		$this->db->where('expense_id', $expense_id);
		return $this->db->update('expenses', array('deleted' => 1));		
	}
	
	/*
	Deletes a list of customers
	*/
	function delete_list($expense_ids)
	{
		$this->db->where_in('expense_id',$expense_ids);
		return $this->db->update('expenses', array('deleted' => 1));
 	}
	
	function search($search)
	{
		$this->db->from('expenses');		
		$this->db->like("description",$this->db->escape_like_str($search));
		$this->db->where('deleted',$this->db->escape('0'));
		$this->db->order_by("description", "asc");
		return $this->db->get();
	}


}
?>
