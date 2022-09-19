-- Criação do banco de dados para o cenário de e-commerce
create database ecommerce;

use ecommerce;

-- criação das tabelas
--  cliente
create table cliente(
    idCliente int auto_increment primary key,
    nome varchar(10),
    nomeDoMeio char(3),
    sobrenome varchar(20),
    cpf char(11) null,
    endereco varchar(100),
    constraint unique_cpf_client unique (cpf)
)

--  produto
create table produto(
    idProduto int auto_increment primary key,
    nome varchar(45) not null,
    descricao varchar(45),
    categoria enum('Eletrônico', 'Brinquedos', 'Moda Adulta', 'Moda Infantil', 'Móveis', 'Livros', 'Outros') not null,
    valor float,
    dimensao varchar(10),
    avaliacao float default 0
)

-- pagamentos
create table payments(
    idCliente int,
    idPayment int,
    typePayment enum('Dinheiro', 'Boleto', 'Pix', 'Cartão'),
    limit float,
    primary key (idCliente, idPayment)
)

--  pedidos
create table produto(
    idPedido int auto_increment primary key,
    idPedidoCliente int,
    statusPedido enum('cancelado', 'confirmado', 'em processamento') default 'em processamento',
    descricaoPedido varchar(255),
    frete float default 10,
    paymentsCash bool default false,
    constraint fk_produto_cliente foreing key (idPedidoCliente) references cliente(idCliente)
)

-- estoque
create table estoque(
    idEstoque int auto_increment primary key,
    localEstoque varchar(255),
    quantidadeEstoque int default 0
)

-- fornecedor
create table fornecedor(
    idFornecedor int auto_increment primary key,
    nomeFornecedor varchar(45) not null,
    cnpj char(15) not null,
    contato char(11) not null,
    constraint unique_fornecedor unique (cnpj)
)

-- vendedor
create table vendedor(
    idVendedor int auto_increment primary key,
    nomeVendedor varchar(45) not null,
    nomeEmpresa varchar(45),
    cnpj char(15),
    cpf char(11),
    localVendedor varchar(255),
    contato char(11) not null,
    constraint unique_cnpj_vendedor unique (cnpj)
    constraint unique_cpf_vendedor unique (cpf)
)

-- produtos_vendedor
create table produtos_vendedor(
    Vendedor_idTerceiro int,
    idProduto int,
    quantidadeProdutos int default 1,
    primary key (Vendedor_idTerceiro, idProduto),
    constraint fk_produto_vendedor foreing key (Vendedor_idTerceiro) references vendedor(idVendedor),
    constraint fk_produto_produto foreing key (idProduto) references produto(idProduto)
)

-- produto_pedido
create table produto_pedido(
    idPP_Produto int,
    idPP_Pedido int,
    pp_quantidade int default 1,
    pp_status enum('Disponivel', 'Sem estoque') default 'Disponivel',

    primary key (idPP_Produto, idPP_Pedido),
    constraint fk_produto_vendedor foreing key (idPP_Produto) references vendedor(idProduto),
    constraint fk_produto_pedido foreing key (idPP_Pedido) references produto(idPedido)
)