<?php

require('../vendor/fpdf182/fpdf.php');

$pdf=new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial','B',11);
$pdf->Cell(40,10,'¡Mi primera página pdf con FPDF!');
$pdf->Output();


function TablaBasica($header){
    //Cabecera
    foreach($header as $col){
    $this->Cell(40,7,$col,1);
    $this->Ln();
   
      $this->Cell(40,5,"hola",1);
      $this->Cell(40,5,"hola2",1);
      $this->Cell(40,5,"hola3",1);
      $this->Cell(40,5,"hola4",1);
      $this->Ln();
      $this->Cell(40,5,"linea ",1);
      $this->Cell(40,5,"linea 2",1);
      $this->Cell(40,5,"linea 3",1);
      $this->Cell(40,5,"linea 4",1);
   }

//Títulos de las columnas
$header=array('Columna 1','Columna 2','Columna 3','Columna 4');
$pdf->AliasNbPages();
//Primera página
$pdf->AddPage();
$pdf->SetY(65);
//$pdf->AddPage();
$pdf->TablaBasica($header);
?>