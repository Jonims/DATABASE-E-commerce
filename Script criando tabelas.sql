-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criando tabela cliente
create table clients(
	idclient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Adress varchar(30),
    constraint unique_cpf_client unique(CPF)
    
);

alter table clients auto_increment=1;

-- criando tabela produto
-- size = dimensão do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos', 'Móveis') not null,
    avaliation float default 0,
    size varchar(10)
    
);


-- criando tabela pedido
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum("Cancelado", "Confirmado","Em processamento", "Enviado", "Entregue") default "Em processamento",
    orderDescripition varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references clients (idclient)

);

-- criando tabela estoque
create table productStorage(
	idproductStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
    );
    
-- criadno tabela fornecedor
create table supplier(
	idsupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique(CNPJ)
    );
    

-- criando tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar (255),
    CNPJ char(15) not null,
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique(CNPJ),
    constraint unique_cpf_seller unique(CPF)
    );

    
-- criando tabela relção produto vendedor
create table productSeller (
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key(idPseller, idPproduct),
    constraint fk_product_seller_1 foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product_1 foreign key (idPproduct) references product(idProduct)
);

desc productSeller;
create table productOrder (
	idPOproduct int,
	idPOorder int,
    prodQuantity int default 1,
    poStatus enum("Disponível", "Sem estoque") default "Disponível",
    primary key(idPOproduct, IdPOorder),
    constraint fk_product_seller_2 foreign key(idPOproduct) references product(idProduct),
    constraint fk_product_product_2 foreign key(IdPOorder) references orders(idOrder)
);

create table storageLocation (
	idLproduct int,
	idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, IdLstorage),
    constraint fk_storage_location_product_3 foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage_3 foreign key (IdLstorage) references productStorage(idproductStorage)
);


create table productSupplier (
	idPsSupplier int,
	idPsProduct int,
    quantity int not null,
    primary key(idPsSupplier, idPsProduct),
    constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idsupplier),
    constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct)
);

