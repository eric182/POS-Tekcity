<?php
require_once ("secure_area.php");
class Registers extends Secure_area
{
	function __construct()
	{
		parent::__construct('registers');		
	}
	function index()
	{						
		$config['base_url'] = site_url('/registers/index');
		$from = date('Y/m/d');
		$to = date('Y/m/d');
		$data['manage_table']= $this->Register->get_all($from, $to);			
		$this->load->view('registers/manage',$data);				
	}	
}
?>