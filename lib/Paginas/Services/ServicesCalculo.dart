import 'package:flutter/cupertino.dart';
import 'package:leilocompre/Paginas/Metodo/Calculo.dart';
import 'package:leilocompre/Paginas/Metodo/Matrix2.dart';
import 'package:leilocompre/Paginas/Metodo/Matrix9.dart';

class ServicesCalculo extends ChangeNotifier{
  int erro;
  double peso_compra,peso_abate,rendimento_carcaca,gmd,desembolso_mensal,pesoA,desempenho_operacional,tempo_dias,tempo_mes,ganho_geral;
  List<Matrix2> valor_inicial;
  int carregando1,carregando2,carregando3,compra,venda;
  Matrix9 calculo1,calculo2,calculo3,calculo4;
  Calculo calculo1_medio,calculo2_medio,calculo3_medio,calculo4_medio;

  ServicesCalculo()
  {
    this.limpar_campos();
    notifyListeners();
  }

  void setCompra(int compra)
  {
    this.compra=compra;
  }

  void setVenda(int venda)
  {
    this.venda=venda;
  }

  void iniciar_valor(int compra,int venda)
  {
    int valor_linha = venda -(5*4);
    int valor_coluna = compra -(5*4);
    for(int i=0;i<10;i++)
    {
      this.valor_inicial.add(new Matrix2(valor_linha,valor_coluna));
      valor_linha= valor_linha+5;
      valor_coluna= valor_coluna+5;
    }
  }

  void calculoIniciar()
  {
    this.pesoA=(this.peso_abate*30)*((this.rendimento_carcaca/100))/15;
    this.ganho_geral=this.peso_abate-this.peso_compra;
    this.tempo_dias=(this.ganho_geral*30)/gmd;
    this.tempo_mes=this.tempo_dias/30.4;
    this.desempenho_operacional=this.desembolso_mensal*this.tempo_mes;
    this.iniciar_valor(this.compra,this.venda);
  }

  void limpar_campos()
  {
    this.peso_abate=-1;
    this.peso_compra=-1;
    this.rendimento_carcaca=-1;
    this.gmd=-1;
    this.desembolso_mensal=-1;
    this.pesoA=-1;
    this.valor_inicial=new List<Matrix2>();
    this.calculo1 = new Matrix9();
    this.calculo2 = new Matrix9();
    this.calculo3 = new Matrix9();
    this.calculo4 = new Matrix9();
    this.calculo1_medio = new Calculo();
    this.calculo2_medio = new Calculo();
    this.calculo3_medio = new Calculo();
    this.calculo4_medio = new Calculo();
    this.carregando1=-1;
    this.carregando2=-1;
    this.carregando3=-1;
    this.compra=-1;
    this.venda=-1;
  }

  bool valorValido()
  {
    return (this.peso_compra > 0 && this.peso_abate > 0 &&
            this.rendimento_carcaca > 0 && this.gmd > 0 &&
            this.desembolso_mensal > 0
            );
  }

  // calculos
  void calcular()
  {
    this.carregando1=0;
    notifyListeners();
    if(this.valorValido())
      {
        for(int i=0;i<10;i++)
        {
          for(int j=0;j<10;j++)
          {

            double valor1 = formula_redimento_animal(j,i);
            print(i.toString()+' '+j.toString()+' valor1 => '+valor1.toString());
            calculo1.setLinhas(i,j,valor1);

            double valor2 = formular_receita_animal(i,j);
            print(i.toString()+' '+j.toString()+' valor2 => '+valor2.toString());
            calculo2.setLinhas(i,j,valor2);

            double valor3 = formular_taxa_lucro(j,i);
            print(i.toString()+' '+j.toString()+' valor3 => '+valor3.toString());
            calculo3.setLinhas(i,j,valor3);

            double valor4 = formular_taxa_rendimento(j,i);
            print(i.toString()+' '+j.toString()+' valor4 => '+valor4.toString());
            calculo4.setLinhas(i,j,valor4);

          }
          print('Linha ok ');
        }
        this.carregando1=1;
        print(' Calculo 1 Tamanho Coluna => '+calculo1.getColunas().length.toString()+" Tamanho Linha => "+calculo1.getLinhas(0).length.toString());
        print(' Calculo 2 Tamanho Coluna => '+calculo2.getColunas().length.toString()+" Tamanho Linha => "+calculo2.getLinhas(0).length.toString());
        print(' Calculo 3 Tamanho Coluna => '+calculo3.getColunas().length.toString()+" Tamanho Linha => "+calculo3.getLinhas(0).length.toString());
        print(' Calculo 4 Tamanho Coluna => '+calculo4.getColunas().length.toString()+" Tamanho Linha => "+calculo4.getLinhas(0).length.toString());
        notifyListeners();
      }
    else
      {
        this.carregando1=-1;
      }
      notifyListeners();
  }

  void calcular_medio()
  {
      for(int i=0;i<10;i++)
        {
          for(int j=0;j<10;j++)
            {
              print("Calculo1 => "+i.toString()+" "+j.toString()+" => "+calculo1.getColunas().elementAt(i).elementAt(j).toString());
              print("Calculo2 => "+i.toString()+" "+j.toString()+" => "+calculo2.getColunas().elementAt(i).elementAt(j).toString());
              print("Calculo3 => "+i.toString()+" "+j.toString()+" => "+calculo3.getColunas().elementAt(i).elementAt(j).toString());
              print("Calculo4 => "+i.toString()+" "+j.toString()+" => "+calculo4.getColunas().elementAt(i).elementAt(j).toString());
              // valor minimo
              if(calculo1_medio.min > calculo1.getColunas().elementAt(i).elementAt(j))
                {
                  calculo1_medio.min = calculo1.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo2_medio.min > calculo2.getColunas().elementAt(i).elementAt(j))
                {
                  calculo2_medio.min = calculo2.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo3_medio.min > calculo3.getColunas().elementAt(i).elementAt(j))
                {
                  calculo3_medio.min = calculo3.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo4_medio.min > calculo4.getColunas().elementAt(i).elementAt(j))
                {
                  calculo4_medio.min = calculo4.getColunas().elementAt(i).elementAt(j);
                }

              // valor maximo
              if(calculo1_medio.max < calculo1.getColunas().elementAt(i).elementAt(j))
                {
                  calculo1_medio.max = calculo1.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo2_medio.max < calculo2.getColunas().elementAt(i).elementAt(j))
                {
                  calculo2_medio.max = calculo2.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo3_medio.max < calculo3.getColunas().elementAt(i).elementAt(j))
                {
                  calculo3_medio.max = calculo3.getColunas().elementAt(i).elementAt(j);
                }
              if(calculo4_medio.max < calculo4.getColunas().elementAt(i).elementAt(j))
                {
                  calculo4_medio.max = calculo4.getColunas().elementAt(i).elementAt(j);
                }
            }
        }
  }

  // formular calculos
  double formula_redimento_animal(int linha,int coluna)
  {
    print('VAlor rendimento '+coluna.toString()+" "+linha.toString()+" => (("+valor_inicial.elementAt(linha).getLinha().toString()
    +"*"+pesoA.toString()+" )-("+valor_inicial.elementAt(coluna).getColuna().toString()+"* "+peso_compra.toString()+") - "+desempenho_operacional.toString());
      return double.parse(((valor_inicial.elementAt(linha).getLinha()*pesoA)-(valor_inicial.elementAt(coluna).getColuna() * peso_compra) - desempenho_operacional).toStringAsFixed(2));
  }

  double formular_receita_animal(int linha,int coluna)
  {
    return double.parse((valor_inicial.elementAt(coluna).getLinha() * pesoA).toStringAsFixed(2));
  }

  double formular_taxa_lucro(int linha,int coluna)
  {
    double resultado_animal = calculo1.getColunas().elementAt(coluna).elementAt(linha);
    double rendimento_animal = calculo2.getColunas().elementAt(coluna).elementAt(linha);
    return ((resultado_animal/rendimento_animal) * 100).round().toDouble();
  }

  double formular_taxa_rendimento(int linha,int coluna)
  {
    double resultado_animal = calculo1.getColunas().elementAt(coluna).elementAt(linha);
    return double.parse((((resultado_animal/(desempenho_operacional+(valor_inicial.elementAt(coluna).coluna*peso_compra)))/tempo_mes)* 100).toStringAsFixed(2));
  }

}