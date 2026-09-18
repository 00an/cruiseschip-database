CREATE SCHEMA IF NOT EXISTS cruise_db;

CREATE  TABLE cruise_db.activiteit ( 
	id                   smallint  NOT NULL  ,
	tijdsduur            varchar(5)  NOT NULL  ,
	datum                date  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	prijs                money    ,
	tijdstip             time  NOT NULL  ,
	capaciteit           smallint  NOT NULL  ,
	omschrijving         text    ,
	CONSTRAINT pk_activiteit PRIMARY KEY ( id )
 );

CREATE  TABLE cruise_db.activiteit_benodigdheid ( 
	activiteit_id        smallint  NOT NULL  ,
	benodigdheid         varchar(30)  NOT NULL  ,
	CONSTRAINT pk_activiteit_benodigdheid PRIMARY KEY ( activiteit_id, benodigdheid ),
	CONSTRAINT fk_activiteit_benodigdheid_activiteit FOREIGN KEY ( activiteit_id ) REFERENCES cruise_db.activiteit( id )   
 );

CREATE  TABLE cruise_db.activiteit_type ( 
	activiteit_id        smallint  NOT NULL  ,
	activiteit_type      varchar(25)  NOT NULL  ,
	CONSTRAINT pk_activiteit_type PRIMARY KEY ( activiteit_id, activiteit_type ),
	CONSTRAINT fk_activiteit_type_activiteit FOREIGN KEY ( activiteit_id ) REFERENCES cruise_db.activiteit( id )   
 );

CREATE  TABLE cruise_db.boeker ( 
	id                   numeric(10,0)  NOT NULL  ,
	factuuradres         varchar(100)  NOT NULL  ,
	email                varchar(100)  NOT NULL  ,
	telefoonnummer       varchar(15)    ,
	naam                 varchar(50)  NOT NULL  ,
	voornaam             varchar(50)  NOT NULL  ,
	klantstatus          boolean  NOT NULL  ,
	CONSTRAINT pk_boeker PRIMARY KEY ( id )
 );

CREATE  TABLE cruise_db.haven ( 
	id                   smallint  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	diepte               numeric(5,2)  NOT NULL  ,
	aanlegplaats		 smallint NOT NULL,
	CONSTRAINT pk_haven PRIMARY KEY ( id )
 );

CREATE  TABLE cruise_db.havenactiviteit ( 
	activiteit_id        smallint  NOT NULL  ,
	haven_id             smallint  NOT NULL  ,
	adres                varchar(100)  NOT NULL  ,
	bustijd              varchar(4)  NOT NULL  ,
	CONSTRAINT pk_havenactiviteit PRIMARY KEY ( activiteit_id, haven_id ),
	CONSTRAINT fk_havenactiviteit_activiteit FOREIGN KEY ( activiteit_id ) REFERENCES cruise_db.activiteit( id )   ,
	CONSTRAINT fk_havenactiviteit_haven FOREIGN KEY ( haven_id ) REFERENCES cruise_db.haven( id )   
 );

CREATE  TABLE cruise_db.schip ( 
	id                   smallint  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	capaciteit           smallint  NOT NULL  ,
	diepgang             numeric(4,2)  NOT NULL  ,
	beschikbaarheid      boolean  NOT NULL  ,
	CONSTRAINT pk_schip PRIMARY KEY ( id )
 );

CREATE  TABLE cruise_db.schip_faciliteit ( 
	schip_id             smallint  NOT NULL  ,
	faciliteit           varchar(50)  NOT NULL  ,
	CONSTRAINT pk_schip_faciliteit PRIMARY KEY ( schip_id, faciliteit ),
	CONSTRAINT fk_schip_faciliteit_schip FOREIGN KEY ( schip_id ) REFERENCES cruise_db.schip( id )   
 );

CREATE  TABLE cruise_db.schipactiviteit ( 
	activiteit_id        smallint  NOT NULL  ,
	schip_id             smallint  NOT NULL  ,
	dek                  smallint  NOT NULL  ,
	ruimte               smallint  NOT NULL  ,
	CONSTRAINT pk_schipactiviteit PRIMARY KEY ( activiteit_id, schip_id ),
	CONSTRAINT fk_schipactiviteit_activiteit FOREIGN KEY ( activiteit_id ) REFERENCES cruise_db.activiteit( id )   ,
	CONSTRAINT fk_schipactiviteit_schip FOREIGN KEY ( schip_id ) REFERENCES cruise_db.schip( id )   
 );

CREATE  TABLE cruise_db.bezienswaardigheid ( 
	haven_id             smallint  NOT NULL  ,
	bezienswaardigheid_beschrijving varchar(100)  NOT NULL  ,
	CONSTRAINT pk_bezienswaardigheid PRIMARY KEY ( haven_id, bezienswaardigheid_beschrijving ),
	CONSTRAINT fk_bezienswaardigheid_haven FOREIGN KEY ( haven_id ) REFERENCES cruise_db.haven( id )   
 );

CREATE  TABLE cruise_db.cruise_reis ( 
	id                   smallint  NOT NULL  ,
	schip_id             smallint  NOT NULL  ,
	vertrekdatum         date  NOT NULL  ,
	aankomstdatum        date    ,
	vertrekplaats        varchar(50)  NOT NULL  ,
	aankomstplaats       varchar(50)  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	prijs                money  NOT NULL  ,
	CONSTRAINT pk_cruise PRIMARY KEY ( id ),
	CONSTRAINT fk_cruise_schip FOREIGN KEY ( schip_id ) REFERENCES cruise_db.schip( id )   
 );

CREATE  TABLE cruise_db.kamer ( 
	id                   smallint  NOT NULL  ,
	schip_id             smallint  NOT NULL  ,
	kamertype            char(50)    ,
	prijs                money  NOT NULL  ,
	capaciteit           smallint  NOT NULL  ,
	oppervlakte          numeric(5,2)  NOT NULL  ,
	beschikbaarheid      boolean  NOT NULL  ,
	CONSTRAINT pk_kamer PRIMARY KEY ( id ),
	CONSTRAINT fk_kamer_schip FOREIGN KEY ( schip_id ) REFERENCES cruise_db.schip( id )   
 );

CREATE  TABLE cruise_db.kamer_faciliteit ( 
	kamer_id             smallint  NOT NULL  ,
	kamertype            char(50)  NOT NULL  ,
	faciliteit           varchar(50)  NOT NULL  ,
	CONSTRAINT pk_kamer_faciliteit PRIMARY KEY ( kamer_id, faciliteit ),
	CONSTRAINT fk_kamer_faciliteit_kamer FOREIGN KEY ( kamer_id ) REFERENCES cruise_db.kamer( id )   
 );

CREATE  TABLE cruise_db.passagier ( 
	id                   smallint  NOT NULL  ,
	telefoonnummer       varchar(15)    ,
	email                varchar(100)  NOT NULL  ,
	noodcontact          varchar(15)  NOT NULL  ,
	nationaliteit        varchar(25)  NOT NULL  ,
	geboortedatum        date  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	voornaam             varchar(50)  NOT NULL  ,
	CONSTRAINT pk_passagier PRIMARY KEY ( id )  
 );

CREATE  TABLE cruise_db.passagier_neemt_deel_aan_activiteit ( 
	activiteit_id        smallint  NOT NULL  ,
	passagier_id         smallint  NOT NULL  ,
	CONSTRAINT pk_passagier_neem_deel_aan_activiteit PRIMARY KEY ( passagier_id, activiteit_id ),
	CONSTRAINT fk_passagier_neem_deel_aan_activiteit_passagier FOREIGN KEY ( passagier_id ) REFERENCES cruise_db.passagier( id )   ,
	CONSTRAINT fk_passagier_neem_deel_aan_activiteit_activiteit FOREIGN KEY ( activiteit_id ) REFERENCES cruise_db.activiteit( id )   
 );

CREATE  TABLE cruise_db.boekt ( 
	boeker_id            bigint  NOT NULL  ,
	passagier_id         smallint  NOT NULL  ,
	cruise_id            smallint  NOT NULL  ,
	kamer_id             smallint  NOT NULL  ,
	korting              smallint  NOT NULL  ,
	annuleringsverzekering boolean  NOT NULL  ,
	reisverzekering      boolean  NOT NULL  ,
	boekingsdatum        date  NOT NULL  ,
	CONSTRAINT pk_boekt PRIMARY KEY ( boeker_id, passagier_id, cruise_id, kamer_id ),
	CONSTRAINT fk_boekt_passagier FOREIGN KEY ( passagier_id ) REFERENCES cruise_db.passagier( id )   ,
	CONSTRAINT fk_boekt_boeker FOREIGN KEY ( boeker_id ) REFERENCES cruise_db.boeker( id )   ,
	CONSTRAINT fk_boekt_cruise FOREIGN KEY ( cruise_id ) REFERENCES cruise_db.cruise_reis( id )   ,
	CONSTRAINT fk_boekt_kamer FOREIGN KEY ( kamer_id ) REFERENCES cruise_db.kamer( id )   
 );

CREATE  TABLE cruise_db.crew ( 
	id                   smallint  NOT NULL  ,
	voornaam             varchar(50)  NOT NULL  ,
	naam                 varchar(50)  NOT NULL  ,
	email                varchar(100)  NOT NULL  ,
	loon                 money  NOT NULL  ,
	jobomschrijving      varchar(100)  NOT NULL  ,
	statuut              varchar(100)  NOT NULL  ,
	telefoonnummer       varchar(15)    ,
	CONSTRAINT pk_crew PRIMARY KEY ( id )
 );

CREATE  TABLE cruise_db.crew_werkt_op_cruise_reis ( 
	crew_id              smallint  NOT NULL  ,
	cruise_id            smallint  NOT NULL  ,
	startdatum           date  NOT NULL  ,
	einddatum            date    ,
	CONSTRAINT pk_crew_werkt_op_cruise_reis PRIMARY KEY ( crew_id, cruise_id, startdatum ),
	CONSTRAINT fk_crew_werkt_op_cruise_reis_crew FOREIGN KEY ( crew_id ) REFERENCES cruise_db.crew( id )   ,
	CONSTRAINT fk_crew_werkt_op_cruise_reis_cruise FOREIGN KEY ( cruise_id ) REFERENCES cruise_db.cruise_reis( id )   
 );

CREATE  TABLE cruise_db.cruise_parkeert_in_haven ( 
	cruise_id            smallint  NOT NULL  ,
	haven_id             smallint  NOT NULL  ,
	aankomstdatum        date  NOT NULL  ,
	vertrekdatum         date    ,
	aanlegplaats         smallint    ,
	CONSTRAINT pk_schip_parkeert_in_haven PRIMARY KEY ( cruise_id, haven_id, aankomstdatum ),
	CONSTRAINT fk_schip_parkeert_in_haven_haven FOREIGN KEY ( haven_id ) REFERENCES cruise_db.haven( id )   ,
	CONSTRAINT fk_schip_parkeert_in_haven_cruise FOREIGN KEY ( cruise_id ) REFERENCES cruise_db.cruise_reis( id )   
 );

CREATE  TABLE cruise_db.crew_verblijft_in_kamer ( 
	crew_id              smallint  NOT NULL  ,
	kamer_id             smallint  NOT NULL  , 
	startdatum			 date NOT NULL,
	einddatum			 date,
	CONSTRAINT pk_crew_verblijft_in_kamer PRIMARY KEY ( crew_id, kamer_id, startdatum ),
	CONSTRAINT fk_crew_verblijft_in_kamer_crew FOREIGN KEY ( crew_id ) REFERENCES cruise_db.crew( id )   ,
	CONSTRAINT fk_crew_verblijft_in_kamer_kamer FOREIGN KEY ( kamer_id ) REFERENCES cruise_db.kamer( id )
 );

CREATE  TABLE cruise_db.passagier_verblijft_in_kamer ( 
	passagier_id              smallint  NOT NULL  ,
	kamer_id            smallint  NOT NULL  ,
	startdatum			 date NOT NULL,
	einddatum			 date, 
		CONSTRAINT pk_passagier_verblijft_in_kamer PRIMARY KEY ( passagier_id, kamer_id, startdatum ),
	CONSTRAINT fk_passagier_verblijft_in_kamer_passagier FOREIGN KEY ( passagier_id ) REFERENCES cruise_db.passagier( id )   ,
	CONSTRAINT fk_passagier_verblijft_in_kamer_kamer FOREIGN KEY ( kamer_id ) REFERENCES cruise_db.kamer( id )
 );
