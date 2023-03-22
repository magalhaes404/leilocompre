import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leilocompre/Paginas/Services/ServicesCalculo.dart';
import 'package:provider/provider.dart';

class Pagina_Inicial extends StatefulWidget{

  Pagina_InicialState createState() => Pagina_InicialState();
}

class Pagina_InicialState extends State<Pagina_Inicial>
{
  GlobalKey<FormState>_formKey1,_formKey2;
  TextEditingController pesoabate,pesocompra,rendimento,gmd,desembolsomensal,compra,venda;
  int tela;
  bool isDetalhes;
  double width,heigth;
  @override
  void initState() {
    this.isDetalhes=false;
    this._formKey1 = GlobalKey<FormState>();
    this._formKey2 = GlobalKey<FormState>();
    pesoabate = new TextEditingController();
    pesocompra = new TextEditingController();
    rendimento = new TextEditingController();
    gmd = new TextEditingController();
    desembolsomensal = new TextEditingController();
    compra = new TextEditingController();
    venda = new TextEditingController();
    tela=0;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    this.width = MediaQuery.of(context).size.width;
    this.heigth = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServicesCalculo()),
      ],
      child: WillPopScope(
        onWillPop: () {
          voltar(context);
        },
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          appBar: header(context),
          body: corpo(context),
        ),
      ),
    );
  }

  Widget header(BuildContext context)
  {
    return AppBar(
      backgroundColor: Colors.lightBlueAccent,
      title: Text('Leilocompre'),
    );
  }

  Widget corpo(BuildContext context)
  {
    return Center(
        child: Container(
          width: width * 0.80,
          height: heigth * 0.70,
          child: Card(
            child: Consumer<ServicesCalculo>(
              builder: (context, value, child) {
                print('Valor Carregando1 => '+value.carregando1.toString()+"Tela => "+this.tela.toString());
                if(value.carregando1 == -1)
                  {
                    if(this.tela == 1)
                    {
                      return Formulario2(context, value);
                    }
                    else if(this.tela==0)
                    {
                      return Formulario1(context, value);
                    }
                  }
                else if(value.carregando1 == 1)
                {
                  if(this.tela == 1)
                  {
                    return Formulario2(context, value);
                  }
                  else if(this.tela==0)
                  {
                    return Formulario1(context, value);
                  }
                  else if(this.tela == 2)
                    {
                      if(this.isDetalhes)
                      {
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Resultado por animal /Valor De Vendas",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.20,
                                      height: heigth * 0.45,
                                      child: Container(
                                        color: Colors.yellow,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: heigth * 0.05,
                                              color: Colors.yellow,
                                            ),
                                            Container(
                                              child: Column(
                                                  children:value.valor_inicial.map((e) {
                                                    return Container(
                                                      height: heigth * 0.04,
                                                      alignment: Alignment.center,
                                                      child: Text(e.getColuna().toString()),
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                            vertical: BorderSide.none,
                                                          )
                                                      ),
                                                    );
                                                  }).toList()
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                        headingRowHeight: heigth * 0.05,
                                        dataRowHeight: heigth * 0.04,
                                        columnSpacing: heigth * 0.04,
                                        columns: value.valor_inicial.map((e){
                                          return DataColumn(
                                            label: Center(
                                              child: Text(
                                                e.getLinha().toString(),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        rows: value.calculo1.getColunas().map((e){
                                          return DataRow(
                                              cells: e.map((x){
                                                return DataCell(
                                                    Text('R\$ '+x.toString().replaceAll(".",","))
                                                );
                                              }).toList()
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // espaco entre tabela 1 e 2
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 2
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Receita por animal /Valor De Vendas",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            // tabela2
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.20,
                                      height: heigth * 0.45,
                                      child: Container(
                                        color: Colors.yellow,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: heigth * 0.05,
                                              color: Colors.yellow,
                                            ),
                                            Container(
                                              child: Column(
                                                  children:value.valor_inicial.map((e) {
                                                    return Container(
                                                      height: heigth * 0.04,
                                                      alignment: Alignment.center,
                                                      child: Text(e.getColuna().toString()),
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                            vertical: BorderSide.none,
                                                          )
                                                      ),
                                                    );
                                                  }).toList()
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                        headingRowHeight: heigth * 0.05,
                                        dataRowHeight: heigth * 0.04,
                                        columnSpacing: heigth * 0.04,
                                        columns: value.valor_inicial.map((e){
                                          return DataColumn(
                                            label: Center(
                                              child: Text(
                                                e.getLinha().toString(),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        rows: value.calculo2.getColunas().map((e){
                                          return DataRow(
                                              cells: e.map((x){
                                                return DataCell(
                                                    Text('R\$ '+x.toString().replaceAll(".",","))
                                                );
                                              }).toList()
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // espaco entre tabela 1 e 2
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 2
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Taxa de lucratividade periodo /Valor de compra(R\$/@)",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            // tabela3
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.20,
                                      height: heigth * 0.45,
                                      child: Container(
                                        color: Colors.yellow,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: heigth * 0.05,
                                              color: Colors.yellow,
                                            ),
                                            Container(
                                              child: Column(
                                                  children:value.valor_inicial.map((e) {
                                                    return Container(
                                                      height: heigth * 0.04,
                                                      alignment: Alignment.center,
                                                      child: Text(e.getColuna().toString()),
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                            vertical: BorderSide.none,
                                                          )
                                                      ),
                                                    );
                                                  }).toList()
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                        headingRowHeight: heigth * 0.05,
                                        dataRowHeight: heigth * 0.04,
                                        columnSpacing: heigth * 0.04,
                                        columns: value.valor_inicial.map((e){
                                          return DataColumn(
                                            label: Center(
                                              child: Text(
                                                e.getLinha().toString(),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        rows: value.calculo3.getColunas().map((e){
                                          return DataRow(
                                              cells: e.map((x){
                                                return DataCell(
                                                    Text(x.toString().replaceAll(".",",")+"%")
                                                );
                                              }).toList()
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            // espaco entre tabela 3 e 4
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 4
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child:
                                Text("Taxa de rentabilidade /Valor de compra(R\$/@)",
                                  style: TextStyle(fontSize: 10,color: Colors.white),),),
                              ),
                            ),
                            // tabela4
                            SliverToBoxAdapter(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: width * 0.20,
                                      height: heigth * 0.45,
                                      child: Container(
                                        color: Colors.yellow,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: heigth * 0.05,
                                              color: Colors.yellow,
                                            ),
                                            Container(
                                              child: Column(
                                                  children:value.valor_inicial.map((e) {
                                                    return Container(
                                                      height: heigth * 0.04,
                                                      alignment: Alignment.center,
                                                      child: Text(e.getColuna().toString()),
                                                      decoration: BoxDecoration(
                                                          border: Border.symmetric(
                                                            vertical: BorderSide.none,
                                                          )
                                                      ),
                                                    );
                                                  }).toList()
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: DataTable(
                                        headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                        headingRowHeight: heigth * 0.05,
                                        dataRowHeight: heigth * 0.04,
                                        columnSpacing: heigth * 0.04,
                                        columns: value.valor_inicial.map((e){
                                          return DataColumn(
                                            label: Center(
                                              child: Text(
                                                e.getLinha().toString(),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        rows: value.calculo4.getColunas().map((e){
                                          return DataRow(
                                              cells: e.map((x){
                                                return DataCell(
                                                    Text(x.toString().replaceAll(".",",")+"%")
                                                );
                                              }).toList()
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      else
                      {
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Resultado por animal /Valor De Vendas",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: Container(
                                alignment: Alignment.center,
                                child: FlatButton(
                                  child: Text('Ver Detalhes'),
                                  onPressed: () {
                                    setState(() {
                                      this.isDetalhes=true;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SliverToBoxAdapter(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                headingRowHeight: heigth * 0.05,
                                dataRowHeight: heigth * 0.04,
                                columnSpacing: heigth * 0.04,
                                columns: [
                                  DataColumn(
                                    label: Text("Valor minimo"),
                                  ),
                                  DataColumn(
                                    label: Text("Valor maximo"),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                      cells: [
                                        DataCell(
                                          Text('R\$ '+value.calculo1_medio.min.toString().replaceAll(".",",")),
                                        ),
                                        DataCell(
                                          Text('R\$ '+value.calculo1_medio.max.toString().replaceAll(".",",")),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            ),
                            // espaco entre tabela 1 e 2
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 2
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Receita por animal /Valor De Vendas",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            // tabela2
                            SliverToBoxAdapter(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                headingRowHeight: heigth * 0.05,
                                dataRowHeight: heigth * 0.04,
                                columnSpacing: heigth * 0.04,
                                columns: [
                                  DataColumn(
                                    label: Text("Valor minimo"),
                                  ),
                                  DataColumn(
                                    label: Text("Valor maximo"),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                      cells: [
                                        DataCell(
                                          Text('R\$ '+value.calculo2_medio.min.toString().replaceAll(".",",")),
                                        ),
                                        DataCell(
                                          Text('R\$ '+value.calculo2_medio.max.toString().replaceAll(".",",")),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            ),
                            // espaco entre tabela 2 e 3
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 3
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child: Text("Taxa de lucratividade periodo /Valor de compra(R\$/@)",style: TextStyle(fontSize: 10,color: Colors.white)),),
                              ),
                            ),
                            // tabela3
                            SliverToBoxAdapter(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                headingRowHeight: heigth * 0.05,
                                dataRowHeight: heigth * 0.04,
                                columnSpacing: heigth * 0.04,
                                columns: [
                                  DataColumn(
                                    label: Text("Valor minimo"),
                                  ),
                                  DataColumn(
                                    label: Text("Valor maximo"),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                      cells: [
                                        DataCell(
                                          Text(value.calculo3_medio.min.toString().replaceAll(".",",")+"%"),
                                        ),
                                        DataCell(
                                          Text(value.calculo3_medio.max.toString().replaceAll(".",",")+"%"),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            ),
                            // espaco entre tabela 3 e 4
                            SliverToBoxAdapter(
                              child: SizedBox(
                                height: heigth * 0.05,
                              ),
                            ),
                            // titulo tabela 4
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.green,
                                height: heigth * 0.04,
                                child: Center(child:
                                Text("Taxa de rentabilidade /Valor de compra(R\$/@)",
                                  style: TextStyle(fontSize: 10,color: Colors.white),),),
                              ),
                            ),
                            // tabela4
                            SliverToBoxAdapter(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.yellow),
                                headingRowHeight: heigth * 0.05,
                                dataRowHeight: heigth * 0.04,
                                columnSpacing: heigth * 0.04,
                                columns: [
                                  DataColumn(
                                    label: Text("Valor minimo"),
                                  ),
                                  DataColumn(
                                    label: Text("Valor maximo"),
                                  ),
                                ],
                                rows: [
                                  DataRow(
                                      cells: [
                                        DataCell(
                                          Text(value.calculo4_medio.min.toString().replaceAll(".",",")+"%"),
                                        ),
                                        DataCell(
                                          Text(value.calculo4_medio.max.toString().replaceAll(".",",")+"%"),
                                        )
                                      ]
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                    }
                }
                else if(value.carregando1 == 0)
                {
                  if(this.tela == 1)
                  {
                    return Formulario2(context, value);
                  }
                  else if(this.tela==0)
                  {
                    return Formulario1(context, value);
                  }
                  else if(this.tela == 2)
                  {
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                }
              },
            ),
          ),
        ),
      );
  }

  Widget Formulario1(BuildContext context,ServicesCalculo value)
  {
    return Form(
      key: _formKey1,
      child: ListView(
        children: [
          ListTile(
            title: Text("Analise de sensibilidade"),
          ),
          ListTile(
            title: Center(child:Text('Peso de Compra @')),
            subtitle: SizedBox(
              height: heigth * 0.06,
              width:  width * 0.60,
              child: TextFormField(
                controller: pesocompra,
                validator: (value) {
                  if(double.parse(value.toString()) < 1)
                  {
                    return "Valor tem que ser maior que zero";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
              title: Center(child:Text('Peso de Abate @')),
              subtitle:
              SizedBox(
                height: heigth * 0.06,
                width:  width * 0.60,
                child: TextFormField(
                  controller: pesoabate,
                  validator: (value) {
                    if(double.parse(value.toString()) < 1)
                    {
                      return "Valor tem que ser maior que zero";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
          ),
          ListTile(
            title: Center(child:Text('Rendimento Carcaça (%)')),
            subtitle: SizedBox(
                height: heigth * 0.06,
                width:  width * 0.60,
                child:TextFormField(
                    controller: rendimento,
                    validator: (value) {
                      if(double.parse(value.toString()) < 1)
                      {
                        return "Valor tem que ser maior que zero";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    )
                )
            ),
          ),
          ListTile(
            title: Center(child:Text('GMD (KG/dia)')),
            subtitle: SizedBox(
                height: heigth * 0.06,
                width:  width * 0.60,
                child:TextFormField(
                    controller: gmd,
                    validator: (value) {
                      if(double.parse(value.toString()) < 0)
                      {
                        return "Valor tem que ser maior que zero";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    )
                )
            ),
          ),
          ListTile(
            title: Center(child:Text('Desembolso Mensal (R\$)')),
            subtitle: SizedBox(
                height: heigth * 0.06,
                width:  width * 0.60,
                child:  TextFormField(
                  controller: desembolsomensal,
                  validator: (value) {
                    if(double.parse(value.toString()) < 1)
                    {
                      return "Valor tem que ser maior que zero";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )),
          ),
          ListTile(
            title: FlatButton(
              color: Colors.lightGreen,
              onPressed: () {
                form2(value);
              },
              child: Row(
                children: [
                  Icon(Icons.calculate),
                  Text('Calcular')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget Formulario2(BuildContext context,ServicesCalculo value)
  {
    return Form(
      key: _formKey2,
      child: ListView(
        children: [
          ListTile(
            title: Text("Compra e Venda"),
            leading: Icon(Icons.monetization_on_outlined,color: Colors.yellow,),
          ),
          ListTile(
            title: Center(child:Text('Valor compra (R\$/@)')),
            subtitle: SizedBox(
              height: heigth * 0.06,
              width:  width * 0.60,
              child: TextFormField(
                controller: compra,
                validator: (value) {
                  if(double.parse(value.toString()) < 25)
                  {
                    return "Valor tem que ser maior que 25 reais ";
                  }
                  return null;
                },
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
              title: Center(child:Text('Valor venda (R\$/@)')),
              subtitle:
              SizedBox(
                height: heigth * 0.06,
                width:  width * 0.60,
                child: TextFormField(
                  controller: venda,
                  validator: (value) {
                    if(double.parse(value.toString()) < 25)
                    {
                      return "Valor tem que ser maior que 25 reais ";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              )
          ),
          ListTile(
            title: FlatButton(
              color: Colors.lightGreen,
              onPressed: () {
                calcular(value);
              },
              child: Row(
                children: [
                  Icon(Icons.calculate),
                  Text('Calcular')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void calcular(ServicesCalculo calculo)
  {
      if(_formKey2.currentState.validate())
        {
          print('Compra => '+compra.text.toString()+" Venda => "+venda.text.toString());
          calculo.limpar_campos();
          calculo.peso_compra = double.parse(pesocompra.text);
          calculo.peso_abate = double.parse(pesoabate.text);
          calculo.rendimento_carcaca = double.parse(rendimento.text);
          calculo.gmd = double.parse(gmd.text);
          calculo.desembolso_mensal = double.parse(desembolsomensal.text);
          calculo.compra=int.parse(compra.text.toString());
          calculo.venda=int.parse(venda.text.toString());
          calculo.calculoIniciar();
          calculo.notifyListeners();
          calculo.calcular();
          calculo.calcular_medio();
          setState(() {
            this.tela=2;
          });

        }
      else
        {
          Fluttertoast.showToast(
              msg: "Valores invalidos",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              textColor: Colors.red,
              backgroundColor: Colors.white,
              fontSize: 16.0
          );
          Future.delayed(Duration(seconds: 2)).then((_) {
            Fluttertoast.cancel();
          });

        }
  }

  void form2(ServicesCalculo value) {
    if(_formKey1.currentState.validate()) {
      print('Tela => ' + this.tela.toString());
      if(value.carregando1 == 1)
        {
          setState(() {
            this.tela=2;
          });
        }
      else
        {
          setState(() {
            this.tela=1;
          });
        }
      print('Tela => '+this.tela.toString());
    }
    else
    {
      Fluttertoast.showToast(
          msg: "Valores invalidos",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.red,
          backgroundColor: Colors.white,
          fontSize: 16.0
      );
      Future.delayed(Duration(seconds: 2)).then((_) {
        Fluttertoast.cancel();
      });

    }
  }

  void voltar(BuildContext context) {
    print('Tela => '+this.tela.toString());
    print('Destaques => '+this.isDetalhes.toString());
    double heigth = MediaQuery.of(context).size.height;
    if(this.tela == 0)
    {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            height: heigth * 0.10,
            child: Text("Tem certeza que deseja sair ?"),
            alignment: Alignment.center,
          ),
          actions: [
            ElevatedButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('Sair'),
              onPressed: () {
                exit(0);
              },
            )
          ],
        ),
      );
    }
    else if(this.tela == 1)
    {
      setState(() {
        this.tela=0;
      });
    }
    else if(this.tela == 2)
    {
      if(this.isDetalhes)
        {
          setState(() {
            this.isDetalhes=false;
          });
        }
      else
        {
          setState(() {
            this.tela=1;
          });
        }
    }
    else if(this.tela == 3)
    {
      setState(() {
        this.tela=0;
      });
    }

  }

}



