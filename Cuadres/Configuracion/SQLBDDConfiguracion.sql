alter table CO_CORREO_APLICACION
   drop constraint FK_CO_CORRE_REF_CO_APLIC
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CO_APLICACION')
            and    type = 'U')
   drop table CO_APLICACION
go

/*==============================================================*/
/* Table: CO_APLICACION                                         */
/*==============================================================*/
create table CO_APLICACION (
   AP_CODIGO            varchar(6)                     not null,
   AP_NOMBRE            varchar(30)                    null,
   AP_DESCRIPCION       varchar(255)                   null,
   AP_ESTADO            char(1)                        null,
   constraint PK_CO_APLICACION primary key (AP_CODIGO)
)
go


alter table CO_CORREO_APLICACION
   drop constraint FK_CO_CORRE_REF_CO_APLIC
go

if exists (select 1
            from  sysobjects
            where  id = object_id('CO_CORREO_APLICACION')
            and    type = 'U')
   drop table CO_CORREO_APLICACION
go

/*==============================================================*/
/* Table: CO_CORREO_APLICACION                                  */
/*==============================================================*/
create table CO_CORREO_APLICACION (
   CA_CODIGO            int                            not null,
   CA_CODIGO_APLICACION varchar(6)                     null,
   CA_USER_ORIGEN       varchar(128)                   null,
   CA_CLAVE_ORIGEN      varchar(255)                   null,
   CA_SMTP_SERVER       varchar(128)                   null,
   CA_SMTP_SERVER_PORT  int                            null,
   CA_SMTP_SERVER_SSL   char(1)                        null,
   CA_PLANTILLAHTML		VARCHAR(255)				   null,
   CA_LOGOTIPO			VARCHAR(255)				   null,
   CA_FIRMA				VARCHAR(255)				   null,
   CA_DESTINO           VARCHAR(255)				   null,
   constraint PK_CO_CORREO_APLICACION primary key (CA_CODIGO)
)
go

alter table CO_CORREO_APLICACION
   add constraint FK_CO_CORRE_REF_CO_APLIC foreign key (CA_CODIGO_APLICACION)
      references CO_APLICACION (AP_CODIGO)
go

