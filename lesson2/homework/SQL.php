<?php

namespace lesson2;

use Exception;

require_once 'config.php';

class SQL extends config {
    private $connection = null;
    public  $errors     = [];
    public function __construct() {
        $this->connect();
    }
    public function __destruct() {
        $this->disconnect();
    }
    public function request($sql) {
        if ($this->connection) {
            $query = mysqli_query($this->connection, $sql);
            if (stripos($sql, 'select') !== false) {
                return $query->fetch_all(MYSQLI_ASSOC);
            } else {
                echo 'QUERY: '; print_r($query); echo "\n";
                return ['data' => ['response' => (int) $query]];
            }
        } else {
            $this->err("Отсутствует соединение с БД, request: $sql");
        }
    }
    private function connect() :void {
        try {
            error_reporting(E_ERROR);
            $this->connection = mysqli_connect(...$this->getDataConnect())
            or $this->err(mysqli_connect_error(), mysqli_connect_errno());
        } catch (Exception $e) {
            $this->err($e->getMessage(), $e->getCode());
        }
    }
    private function disconnect() :void {
        mysqli_close($this->connection);
    }
    private function getDataConnect() :array {
        $conDB = array_flip(['host', 'user', 'pass', 'base', 'port']);
        foreach ($conDB as $key => &$value) {
            $value = $this->db[$key];
        }
        return array_values($conDB);
    }
    private function err($message, $code = 0) :void {
        $this->errors[] = ['code' => $code, 'message' => $message];
    }
}