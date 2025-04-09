--Creación de Base de datos de un Banco Ficticio:

CREATE DATABASE banco;
use banco;

CREATE TABLE cliente (
    cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    rut VARCHAR(12) UNIQUE NOT NULL, 
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    email VARCHAR(100),
    fecha_registro DATE
);

CREATE TABLE cuentas (
    cuenta_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    tipo_cuenta ENUM('corriente', 'vista', 'ahorro'),
    numero_cuenta VARCHAR(20) UNIQUE,
    saldo DECIMAL(15,2) DEFAULT 0,
    fecha_apertura DATE, 
    estado ENUM('activa', 'bloqueada', 'cerrada'),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE transacciones (
    transaccion_id INT PRIMARY KEY AUTO_INCREMENT,
    cuenta_origen INT,
    cuenta_destino INT,
    tipo ENUM('deposito', 'retiro', 'transferencia'),
    monto DECIMAL(15,2),
    fecha DATETIME,
    descripcion TEXT,
    FOREIGN KEY (cuenta_origen) REFERENCES cuentas(cuenta_id),
    FOREIGN KEY (cuenta_destino) REFERENCES cuentas(cuenta_id)
);

CREATE TABLE creditos (
    credito_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    monto_total DECIMAL(15,2),
    monto_pendiente DECIMAL(15,2),
    tasa_interes DECIMAL(15,2),
    fecha_otorgamiento DATE,
    plazo_meses INT,
    estado ENUM('activo', 'cancelado', 'moroso'),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE tarjetas (
    tarjeta_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    tipo ENUM('debito', 'credito'),
    numero_tarjeta VARCHAR(16) UNIQUE,
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado ENUM('activa', 'bloqueada', 'vencida'),
    FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);

CREATE TABLE pagos_credito (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    credito_id INT,
    fecha_pago DATE, 
    monto_pagado DECIMAL (15,2),
    medio_pago ENUM('transferencia', 'cuenta', 'efectivo'),
    FOREIGN KEY (credito_id) REFERENCES creditos(credito_id)
);

CREATE TABLE accesos (
    acceso_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT,
    fecha_acceso DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_origen VARCHAR(45),
    canal ENUM('web', 'app', 'sucursal'),
    exito BOOLEAN
)

CREATE TABLE empleados (
    empleado_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    cargo VARCHAR(100),
    sucursal_id INT,
    email VARCHAR(100)    
);

CREATE TABLE sucursal (
    sucursal_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    direccion VARCHAR(255),
    tipo ENUM('presencial', 'online', 'atm')
);

CREATE TABLE usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),
    rol ENUM('cliente', 'empleado', 'admin'),
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

