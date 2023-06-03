<?php

namespace lesson2;

require_once 'SQL.php';

$sql = new SQL();

$requests = [
    'SELECT' => 'SELECT * FROM sales',
    'INSERT' => 'INSERT INTO sales(id, order_date, count_product) VALUES (250, "2023-02-01", 64)',
    'SELECT2' => 'SELECT * FROM sales',
    'UPDATE' => 'UPDATE sales SET count_product=256 WHERE id=250',
    'SELECT3' => 'SELECT * FROM sales',
    'DELETE' => 'DELETE FROM sales WHERE id=250',
];

foreach ($requests as $key => $request) {
    echo "$key: ";
    $result = $sql->request($request);
    echo "Array (\n";
    foreach ($result as $key => $value) {
        $fields = [];
        foreach ($value as $k => $v) {
            $fields[] = "$k => $v";
        }
        echo "\t[$key] => [" . implode("][", $fields) . "]\n";
    }
    echo ");\n";
}

echo "\nErrors:\n";
print_r($sql->errors);
