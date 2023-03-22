class Matrix9
{
  List<List<double>> colunas;
  List<double> coluna_inicial;
  Matrix9()
  {
    this.colunas=new List<List<double>>();
    this.coluna_inicial = new List<double>();
    for(int i=0;i<10;i++)
      {
        colunas.add(new List<double>());
      }
  }

  void setLinhas(int coluna,int linha,double valor)
  {
    this.colunas.elementAt(coluna).insert(linha,valor);
  }

  void setColunas(List<List<double>> coluna)
  {
    this.colunas=coluna;
  }

  List<double> getLinhas(int coluna)
  {
    return this.colunas.elementAt(coluna);
  }

  List<List<double>> getColunas()
  {
    return this.colunas;
  }

}