﻿/* DDL de Creacion de Tablas */


CREATE TABLE ESTADO_CLIENTE (ID_ESTADO_CLIENTE int PRIMARY KEY NOT NULL,
							DESC_ESTADO_CLIENTE varchar(15) NOT NULL)	


CREATE TABLE CLIENTES (TIPO_DOCUMENTO varchar(15) NOT NULL,
                     NRO_DOCUMENTO varchar(15) NOT NULL,
                     NOMBRE varchar(15)NOT NULL,
                     APELLIDO varchar (15) NOT NULL,
                     FECHA_NACIMIENTO date, 
                     EMAIL varchar (25),
					 ESTADO_CLIENTE int NOT NULL FOREIGN KEY REFERENCES ESTADO_CLIENTE(ID_ESTADO_CLIENTE),  
					 CONSTRAINT ID_CLIENTE PRIMARY KEY (TIPO_DOCUMENTO,NRO_DOCUMENTO))
	

CREATE TABLE TIPO_SERVICIO (TIPO_SERVICIO int PRIMARY KEY NOT NULL,
							DESC_TIPO_SERVICIO varchar(15) NOT NULL)	


CREATE TABLE ESTADO_SERVICIO (ID_ESTADO_SERVICIO int PRIMARY KEY NOT NULL,
							DESC_ESTADO_SERVICIO varchar(15) NOT NULL)	


CREATE TABLE SERVICIOS (ID_SERVICIO int identity (1,1) PRIMARY KEY NOT NULL,
						TIPO_SERVICIO int NOT NULL FOREIGN KEY REFERENCES TIPO_SERVICIO(TIPO_SERVICIO),
						TIPO_DOCUMENTO varchar(15) NOT NULL,
						NRO_DOCUMENTO varchar(15) NOT NULL,
					    TELEFONO varchar(22),
                        DIRECCION varchar(30) NOT NULL,
                        FECHA_INICIO datetime,
						ID_ESTADO_SERVICIO int NOT NULL FOREIGN KEY REFERENCES ESTADO_SERVICIO(ID_ESTADO_SERVICIO),
						CONSTRAINT ID_CLIENTE FOREIGN KEY(TIPO_DOCUMENTO,NRO_DOCUMENTO)  REFERENCES CLIENTES(TIPO_DOCUMENTO,NRO_DOCUMENTO))


CREATE TABLE TIPO_TICKET (TIPO_TICKET varchar (15) PRIMARY KEY NOT NULL,
						  DESC_TIPO varchar (15) NOT NULL,
						  SLA_HORAS int NOT NULL,
						  TIPO_SERVICIO int NOT NULL FOREIGN KEY REFERENCES TIPO_SERVICIO(TIPO_SERVICIO))


CREATE TABLE ESTADO_TICKET (ID_ESTADO_TICKET int PRIMARY KEY NOT NULL,
							DESC_ESTADO_TICKET varchar(15) NOT NULL)	


CREATE TABLE TICKETS (ID_TICKET int identity (1,1) PRIMARY KEY NOT NULL,
					TIPO_TICKET varchar (15) NOT NULL FOREIGN KEY REFERENCES TIPO_TICKET(TIPO_TICKET), 
                    ESTADO_TICKET int NOT NULL FOREIGN KEY REFERENCES ESTADO_TICKET(ID_ESTADO_TICKET),
					ID_SERVICIO int FOREIGN KEY REFERENCES SERVICIOS(ID_SERVICIO),
                    FECHA_APERTURA datetime NOT NULL,
                    FECHA_RESOLUCION datetime,
					TIPO_DOCUMENTO varchar(15) NOT NULL,
					NRO_DOCUMENTO varchar(15) NOT NULL,
				    CONSTRAINT ID_CLIENTE FOREIGN KEY(TIPO_DOCUMENTO,NRO_DOCUMENTO) REFERENCES CLIENTES(TIPO_DOCUMENTO,NRO_DOCUMENTO))


CREATE TABLE RESOLUCIONES (ID_RESOLUCION int identity (1,1) PRIMARY KEY NOT NULL,
                    ESTADO_TICKET int NOT NULL FOREIGN KEY REFERENCES ESTADO_TICKET(ID_ESTADO_TICKET),
					ID_TICKET int FOREIGN KEY REFERENCES TICKETS(ID_TICKET),
                    FECHA_INICIO datetime NOT NULL,
                    FECHA_FIN datetime)


CREATE TABLE ACTIVIDADES (ID_ACTIVIDAD char (1) PRIMARY KEY NOT NULL,
                    DESC_ACTIVIDAD varchar(30) NOT NULL ,
					ID_TICKET int FOREIGN KEY REFERENCES TICKETS(ID_TICKET))

					
CREATE TABLE MENSAJES (ID_MENSAJE int identity (1,1) PRIMARY KEY NOT NULL,
                    DESC_MENSAJE varchar (30) NOT NULL,
					FECHA_ENVIO date NOT NULL,
					ID_TICKET int FOREIGN KEY REFERENCES TICKETS(ID_TICKET))

					
/* DML de Carga de Datos */

/*Carga de estado del cliente */
INSERT INTO ESTADO_CLIENTE values ('1' ,'ACTIVO')
INSERT INTO ESTADO_CLIENTE values ('2' ,'INACTIVO')
INSERT INTO ESTADO_CLIENTE values ('3' ,'PROSPECTO')

/*Carga de Clientes*/
INSERT INTO CLIENTES VALUES ('DNI','95973277','JOSE','MARTINEZ','1990-06-12','josemartinez@gmail.com',1)
INSERT INTO CLIENTES VALUES ('LC','123456789','MARIA','SANCHEZ',NULL,NULL,3)
INSERT INTO CLIENTES VALUES ('DNI','95973278','DANIEL','CASTRO','1990-06-13','danielcastro@gmail.com',2)
INSERT INTO CLIENTES VALUES ('DNI','95973279','ROSA','PEREZ','1990-06-14','rosaperez@gmail.com',1)
INSERT INTO CLIENTES VALUES ('DNI','95973280','MATIAS','GONZALEZ','1990-06-15','matiasgonzalez',1)

/*Carga del Tipo del servicio*/
INSERT INTO TIPO_SERVICIO values (1 ,'TELEFONIA FIJA')
INSERT INTO TIPO_SERVICIO values (2 ,'INTERNET')
INSERT INTO TIPO_SERVICIO values (3 ,'VOIP')

/*Carga del Estado del servicio*/
INSERT INTO ESTADO_SERVICIO values (1 ,'ACTIVO')
INSERT INTO ESTADO_SERVICIO values (2 ,'INACTIVO')


/*Carga de Servicios*/
INSERT INTO SERVICIOS VALUES (1,'LC','123456789','12345','Arevalo 2116 2B','2022-01-01',1)
INSERT INTO SERVICIOS VALUES (2, 'DNI','95973278',NULL,'Guatemala 2116 3B','2022-01-01',1)
INSERT INTO SERVICIOS VALUES (3,'DNI','123456789','987654','Paraguay 2116 4B','2022-01-01',2)

/*Creacion de Tipo de Ticket y cantidad dias de resolucion por tipo de ticket*/
INSERT INTO TIPO_TICKET values ('I' ,'RECLAMO INTERNET', 24, 2)
INSERT INTO TIPO_TICKET values ('T' ,'RECLAMO TELEFONIA ',48,1)
INSERT INTO TIPO_TICKET values ('V' ,'RECLAMO VOIP',72,3)

/*Carga de estado de ticket*/
INSERT INTO ESTADO_TICKET values (1 ,'ABIERTO')
INSERT INTO ESTADO_TICKET values (2 ,'EN PROGRESO')
INSERT INTO ESTADO_TICKET values (3 ,'PENDIENTE CLIENTE')
INSERT INTO ESTADO_TICKET values (4 ,'RESUELTO')
INSERT INTO ESTADO_TICKET values (5 ,'CERRADO')


/*Carga de Tickets*/
INSERT INTO TICKETS VALUES ('I',1,'2022-06-01',NULL,'DNI','95973277')
INSERT INTO TICKETS VALUES ('T',2,'2022-06-02',NULL,'DNI','95973278')
INSERT INTO TICKETS VALUES ('V',3,'2022-06-03',NULL,'DNI','95973279')
INSERT INTO TICKETS VALUES ('I',4,'2022-06-01','02-06-2022','DNI','95973280')
INSERT INTO TICKETS VALUES ('T',1,'2022-06-01','03-06-2022','DNI','95973281')

