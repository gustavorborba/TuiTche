﻿CREATE TABLE [dbo].[Sexo] (
    [Id] [int] NOT NULL,
    [Sexo] [nvarchar](max) NOT NULL,
    CONSTRAINT [PK_dbo.Sexo] PRIMARY KEY ([Id])
)
INSERT INTO Sexo (Id, Sexo) values (1, 'MASCULINO')
INSERT INTO Sexo (Id, Sexo) values (2, 'FEMININO')
CREATE TABLE [dbo].[Usuario] (
    [Id] [int] NOT NULL IDENTITY,
    [Username] [nvarchar](50) NOT NULL,
    [NomeCompleto] [nvarchar](128) NOT NULL,
    [Email] [nvarchar](128) NOT NULL,
    [Senha] [nvarchar](64) NOT NULL,
    [IdSexoUsuario] [int] NOT NULL,
    [Foto] [nvarchar](128),
    CONSTRAINT [PK_dbo.Usuario] PRIMARY KEY ([Id])
)
CREATE UNIQUE INDEX [UK_Usuario_Username] ON [dbo].[Usuario]([Username])
CREATE UNIQUE INDEX [UK_Usuario_Email] ON [dbo].[Usuario]([Email])
CREATE INDEX [UK_Usuario_NomeCompleto] ON [dbo].[Usuario]([NomeCompleto])
CREATE TABLE [dbo].[Seguidores] (
    [IdSeguidores] [int] NOT NULL IDENTITY,
    [IdSeguidor] [int] NOT NULL,
    [IdSeguindo] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Seguidores] PRIMARY KEY ([IdSeguidores])
)
CREATE INDEX [IX_IdSeguidor] ON [dbo].[Seguidores]([IdSeguidor])
CREATE INDEX [IX_IdSeguindo] ON [dbo].[Seguidores]([IdSeguindo])
CREATE UNIQUE INDEX [UK_Seguidores_IdSeguidor_IdSeguindo] ON [dbo].[Seguidores]([IdSeguidor], [IdSeguindo])
CREATE TABLE [dbo].[Compartilhar] (
    [Id] [int] NOT NULL IDENTITY,
    [DataCompartilhamento] [datetime] NOT NULL,
    [IdPublicacao] [int] NOT NULL,
    [IdUsuario] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Compartilhar] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_IdPublicacao] ON [dbo].[Compartilhar]([IdPublicacao])
CREATE INDEX [IX_IdUsuario] ON [dbo].[Compartilhar]([IdUsuario])
CREATE TABLE [dbo].[Publicacao] (
    [Id] [int] NOT NULL IDENTITY,
    [Descricao] [nvarchar](288) NOT NULL,
    [DataPublicacao] [datetime] NOT NULL,
    [IdUsuario] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Publicacao] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_IdUsuario] ON [dbo].[Publicacao]([IdUsuario])
CREATE TABLE [dbo].[Pontuacao] (
    [Id] [int] NOT NULL,
    [PontuacaoTotal] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Pontuacao] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Id] ON [dbo].[Pontuacao]([Id])
CREATE TABLE [dbo].[Curtir] (
    [Id] [int] NOT NULL IDENTITY,
    [IDPublicacao] [int] NOT NULL,
    [IDUsuario] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Curtir] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_IDPublicacao] ON [dbo].[Curtir]([IDPublicacao])
CREATE INDEX [IX_IDUsuario] ON [dbo].[Curtir]([IDUsuario])
CREATE TABLE [dbo].[Hashtag] (
    [Id] [int] NOT NULL IDENTITY,
    [Palavra] [nvarchar](max) NOT NULL,
    CONSTRAINT [PK_dbo.Hashtag] PRIMARY KEY ([Id])
)
CREATE TABLE [dbo].[PalavraGauderia] (
    [Id] [int] NOT NULL IDENTITY,
    [IDHashtag] [int] NOT NULL,
    [QtdUtilizacao] [int],
    CONSTRAINT [PK_dbo.PalavraGauderia] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_IDHashtag] ON [dbo].[PalavraGauderia]([IDHashtag])
ALTER TABLE [dbo].[Usuario] ADD CONSTRAINT [FK_dbo.Usuario_dbo.Sexo_IdSexoUsuario] FOREIGN KEY ([IdSexoUsuario]) REFERENCES [dbo].[Sexo] ([Id])
ALTER TABLE [dbo].[Seguidores] ADD CONSTRAINT [FK_dbo.Seguidores_dbo.Usuario_IdSeguidor] FOREIGN KEY ([IdSeguidor]) REFERENCES [dbo].[Usuario] ([Id])
ALTER TABLE [dbo].[Seguidores] ADD CONSTRAINT [FK_dbo.Seguidores_dbo.Usuario_IdSeguindo] FOREIGN KEY ([IdSeguindo]) REFERENCES [dbo].[Usuario] ([Id])
ALTER TABLE [dbo].[Compartilhar] ADD CONSTRAINT [FK_dbo.Compartilhar_dbo.Publicacao_IdPublicacao] FOREIGN KEY ([IdPublicacao]) REFERENCES [dbo].[Publicacao] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Compartilhar] ADD CONSTRAINT [FK_dbo.Compartilhar_dbo.Usuario_IdUsuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuario] ([Id])
ALTER TABLE [dbo].[Publicacao] ADD CONSTRAINT [FK_dbo.Publicacao_dbo.Usuario_IdUsuario] FOREIGN KEY ([IdUsuario]) REFERENCES [dbo].[Usuario] ([Id])
ALTER TABLE [dbo].[Pontuacao] ADD CONSTRAINT [FK_dbo.Pontuacao_dbo.Usuario_Id] FOREIGN KEY ([Id]) REFERENCES [dbo].[Usuario] ([Id])
ALTER TABLE [dbo].[Curtir] ADD CONSTRAINT [FK_dbo.Curtir_dbo.Publicacao_IDPublicacao] FOREIGN KEY ([IDPublicacao]) REFERENCES [dbo].[Publicacao] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[Curtir] ADD CONSTRAINT [FK_dbo.Curtir_dbo.Usuario_IDUsuario] FOREIGN KEY ([IDUsuario]) REFERENCES [dbo].[Usuario] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[PalavraGauderia] ADD CONSTRAINT [FK_dbo.PalavraGauderia_dbo.Hashtag_IDHashtag] FOREIGN KEY ([IDHashtag]) REFERENCES [dbo].[Hashtag] ([Id]) ON DELETE CASCADE
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201512031522061_initial', N'TwiTche.Repositorio.EF.Migrations.Configuration',  0x1F8B0800000000000400ED5D596FE4B8117E0F90FF20E82987B7DBF624C1C468EFC2DB6D6F1A19DB13B7BDC8DB8096E8B6101DBD1265D809F2CBF2909F94BF10EAA2285E2275F46118F33296C862B1EAAB22596255FFEF3FFF9DFDF01AF8D60B8C132F0ACFED93C9B16DC1D0895C2F5C9FDB297AFAEEB3FDC3F7BFFED5ECD20D5EAD9FAB769FB276B867989CDBCF086DCEA6D3C4798601482681E7C451123DA189130553E046D3D3E3E33F4F4F4EA61093B0312DCB9ADDA521F20298FF81FF9C47A103372805FE75E4423F299FE337AB9CAA750302986C8003CFEDFBD4BBC70F27777013251E8A622F9A5C5ED9D685EF01CCCD0AFA4FB605C2304200615ECF1E12B8427114AE571BFC00F8F76F1B88DB3D013F81E51CCEEAE6BAD3393ECDA633AD3B56A49C3441516048F0E453299F29DBBD93946D223F2CC14B2C69F496CD3A97E2B93D8F820D8891E73F83D8B6D801CFE67E9C35AE05BD88022FC442A6FB1D59CCDB23820D0CA1ECDF91354F7D94C6F03C84298A817F647D4D1F7DCFF92B7CBB8FFE01C3F330F57D9A53CC2B7ED778801F7D8DA30D8CD1DB1D7C2AF95FBAB6356DF69BB21D4937AA4F31AB65883E9DDAD60D1E1C3CFA90008192C00A830AFE0443180304DDAF00211887190D988B921B9D196B0110A06415E05E51353A7E07EF31F0050CA8892EDD427AC00151DB54DA283D2429C0566348E606BC78EB5C400C419AB13BE8E74D92676F53D8620336DFE8B6577114DC453E8348AAC9B75594C60EE6E43E52B7BB07F11A227D8E8900DAD8250D25BC96EFD58C568D445CCEA6B5792A8D96169CBEC9D6BD3E0C5661B03071628F322CBC5EE0E5CFB6AEC1EB1718AED1F3B97DFAF9334681F70ADDEA49C9C643E8E1D5127742716A6ED699AFE00DBB879718D8B69B6BC5B0D65DD9439B7557C6358475536405B6CDBFE52C5BD0A4975D132EF48DBAECF261D1F2B1F09E2F0E4166405283FEE3F118F67C130530C3B10F91CA9B9C9C8EE24D2E03E0F9DB1F7605C367A018F64F7F1867D4D788F176B98967CF8D895D4583E86B1CB7AABB0B513A54D6A169EFEEA2109FCB649B3BF256E84ED9971C877C0B63F6D49B4F637FCF71285F1274595CC175EAB9D89F25421609D9AC59E8361864DF71EC710D3A31978FDA973576A594F2DE6DFF5BC3D060FB5B757A7F6BA5DA9D9189DF6319F9436D06951B2B3347C06DABA4AEA2135AE629767B66C18DBCC7FBC3C9707BAAE562B008C462CB11885CB7B2D309FB923FCC732D068D3714D4456B7CE38D8CAD41ECE52F207946606D623065970F8B918FF515F8E02556ED8CF17FFB6F8DF5D7D0829F9F40EAC2D803462B69B3EB87D655DE8D58531F27F937E43EE0ADBBF74F81BFD5F53B8411D182DDD4E837D2965AB6C54DF8C55BD2CECC25A50105D5E210B74CAE7CB0AE3FD618C7487E9FD1190CACD82AF104FD376CC5B43A9ACAB886C1238CCB695C5FACE60F5F9637B7B6F533F053FCE484D35EA3C3D5E5F5F2866E7FCA8BAF1014FDF0224922C7CB45C26E00C9C2D21CF43274ADD6435A7DA626ABD3359693B7C192C12A144D464597C0A6A64BEDEADB28630700E3CC02813FC740C65AF242C47B0B2F74BC0DF0DB26C774D4743499FCC910EC9B05DCC030F3116D02E83E361982717F6DB2994D2984A881C31DF964FA959FFF5A61F33B056CE4275E53B20693164409A4B0568488295C535B4DFDB9ABC2111D6CB19BC54879D886C94885AB373811CD4E4C47F62944A6EED6AF9EB5CE9BF1427D44B57E7AD181EC092BFDD96DB8803E44D0BA708A2B0E739038C0E5F73478B572070065CB34B680CC165DE971408B78F7086DF374EA0FDD03637367FE4EC5C5B67175883E8F0BAD48D52D8FB350582AE37606289206670EC5B7C926B00DF4C974A235F662F7FEAC193B6BC188CA8775C55D17BFB52788DB81B313EA410F6BBB7573B260897427DF1639A17C131B9433382FB4C45DA851487467DFC0D832876D1C3AD4BAD2832791EF16E05904D0701F847B90C8D18F2074A2055C00374A0491B2870496C1B2A40C2AB3A8CA88AE2012DE50A86376C24D1F87D0262D7A9DE028C917118E0EF1011C118977E039A9E34D3C23F5BB162AD56AC14BA57CD1D29F8085232081113F0FD669F0B3615B3014296C09C4537F8EA2DA49BFF4B290D7092E9219516AE56C47279A4811926B70DA9CAE8628F8AB0FBC24D4B132BD6899A11CA4E1B1763A1D8420BA3D2300444BF44C377E466B52B5B3D40A988D220FE965575E285AC120A37010352395F7358AFF6889BCAFA014D0690F48E887247ACB673B10E2EF2208C4A23E556B9EAB6981081726CD83F46820616E3E48E5A0010CF109AF9304B60203E9D757817BD5397B189D3E6885AAB70946C70D8AAC6C1F231754F55D986C6BC9BBD9B4C8012C1FCCA69264C1D935D86CBC704D250F964FAC55913938FF6E659E4E171434A64E22C8AA23DC92915014833564DE668EC685575E9CA02CE1E311641FB3E76EC0356B6CE2255BC06A28C13E9DD75DB52BAC3A65FF2F3A8AD328272A7AB544AFF024B3BCB67CBE50E679B9EE5696CF8951140BAE67CC233F0D42F9894EDE5B9C6F47D313B7D01FA119BA6F72AADAAAA828125FD22427DD0466C867A4CF1D35397D7347F62686B410A65C858CF125A7A6812E55E791B055A7863500553F36C3A90C47ECBB778924F93A6E0C2309290D0C497B8E03A03A1389A6513FD5A7D44C2DA2A935DFE8532CD3856852E5237D1A65EE0F4DA37C644283CAE4698ABAF14A9F6291CE43932A9EEC8D29D4A18A217CAA8C988E4B95F71DC720D8D4049A12FB6E6FD4559E1E86D85F0929E9ECAC241DC7D152F3E35E838EF2B39F8AA2D8C4E55F7676A66DF909CB58DD12521AFA96F61CC92CABBBEA0D7BAC1EEE8D6AD8F3EA10DE534D52C787B65118CB46C931BB6951D28F51725ACC6D739A1EF36AFB5068C60C845B4A2A4CAFBB75A4BA48B6888AB09338BF878BEEF3A2D2844195322AFA9E480DDF8133E9775513CE72A9E973C6867D782D73D11FB609C118890231D19E59197969AF1FC585628A26B685797FF1DC2C0CB37A4B100C265983C9EA177FEE7B18D575836B107A4F3041456A807D7A7C72CA949FDA9F5250D324717D41E44A560FAAA9B82D24E47899645B536E3A945591956072F11068A8124C39F7DCC7F665E8C2D773FB5F79C7336BF9F76F74DF23EB36C6283AB38EAD7FF7AFF0A2CF01A91BA23D7C97EA44EF04406C49A0F005C44E71C395290A3448C59F1EA0DC473C886FE41D2A18D86A32422C64F56406281623A49D971FE9530B6630AA8D522F42AA59B117630C0B6AB9E49AEC51C54567CA7CD1960EF5287683712D0BEFB5D2886B48B4ABC5B448C3FBF011A2EA08DA8A5A0CB539600B2BE87330E26220BE2C7BA88A6692FA2B37F39B00BCFE76AC44FDF721392E315E1F9DA4D8440FE31026D433EEACC782A00A1AE8AA4C71EC9736179CC575345D0F65BAA8543D7B1E639A111B630670CF017C559FC47951EDB93E79F27A89F1C793C940996FF24FA8E3A5C21F56EEBB308C373C0218CF21A0A69D47BFEF40504756CDBDE24E50210AA17EA06227A89004A2B79111A65F3262A885823B5F18979AD87720282F87ED61F2B361C107630D0E9A9E27BEF5DE2395BF677D916DA7D7BFCB220D03F9965D22628BFEA5031C0EA5BCC2DEF89632CFA24372FD21F813D9EDAD432E8F60E443DE0568B6E9724C107358450E9868DED6EA0C483392FAD555E88424F9FDBEB1EB141C4C61023EF58955678FCA03C5DD9D73DB7DCCFC5711FF1BA7368168A4616B17884618B8B0817012C3D53D106A63B09A0822EA23164C10CAAAA5AA8244EBADCA576280FEFD889D547160D8372FDAB0B52A0D24C5B5BD5883E48EE600D3162B5D74B374040154C9B81A02105F053D30018C50A2A233DCB9A564E4C20A4357A0309E8022864067AEA8D6E3BDA92DD155EB5B9BF6D085237A6ABBB117509458D86D6188CE5A1D717AA3D67E60F651AA6A0CEAA39422BF6594AA0EFCFD7D7C12A17E251A9F87126F5D93C87E333A844EE30C42DA2CC3A7A83A0D311C554D980B09D71001171F502EB0929F8083F06B072649FE831D6529FECBE011BACBF036459B14E129C3E0D16FFC1A4476A4528D9F97AE68F23CBBDDE4BFCB30C414309B5E768FF836FC31F57C97F07D25B80F2121919DD5CA1B3F992E5176F367FD4628DD44A126A1527CE488790F838D8F8925B7E10ABCC02EBC3D24F00B5C03E7AD4AC3901369574453ECB38507D63108929246DD1FFF8931EC06AFDFFF1F7E893B982C7D0000 , N'6.1.3-40302')

