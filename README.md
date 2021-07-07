# Bio Dart Package

O <b> Bio Dart Package </b> é um pacote desenvolvido em dart para auxiliar na solução de problemas relacionados a bioinformática.

A bioinformática, por sua vez, é o uso de técnicas computacionais voltadas para a resolução de problemas encontrados na Biologia.

A inclusão do dart no universo da bioinformática ainda é muito discreta. O [pub.dev](https://pub.dev), repositório com blibliotecas do dart/flutter, possui o pacote [bio](https://pub.dev/packages/bio), basicamente para a conversão de arquivo do formato [fastq](https://en.wikipedia.org/wiki/FASTQ_format) para [fasta](https://en.wikipedia.org/wiki/FASTA_format), além da manipulação de sequências, como, por exemplo, obter seu [reverso e complementar](https://www.bx.psu.edu/old/courses/bx-fall08/definitions.html). Olhando seu repositório no github, percebe-se que há algo relacionado a [filogenia](https://www.britannica.com/science/phylogeny) e a [árvores filogenéticas](https://www.khanacademy.org/science/high-school-biology/hs-evolution/hs-phylogeny/a/phylogenetic-trees), no entanto, aparentemente ainda não implementadas. 

## O pacote

O bio dart package foi concebido para satisfazer as necessidades do programa [fluttemis](https://github.com/oberdancunha/flutter-fluttemis-app), não sendo possível ter a mínima comparação com o que há disponível para outras linguagens como o [perl](https://bioperl.org), o [python](https://biopython.org) e até mesmo o [java](https://biojava.org). Além de possuírem um pacote completo de soluções, contam também com uma vasta comunidade que contribuem sistematicamente para a sua maturidade.

### Leitura do arquivo do genbank

Por enquanto a única funcionalidade implementada é a leitura do [arquivo de anotação do genbank](https://widdowquinn.github.io/2018-03-06-ibioic/01-introduction/02-annotation.html) de um genoma de interesse.

#### Exemplo

Primeiramente é necessário incluir seu pacote no pubspec.yaml, em dependencies.

```dart
bio:
    git: https://github.com/oberdancunha/dart-bio-package.git
```

O pacote não está disponível no pub.dev, somente no github.

Para usar a biblioteca, basta seguir o seguinte exemplo:

```dart
import 'package:bio/seqio/genbank.dart';

final genbank = Genbank();

Future<void> main() async {
  final locus = await genbank.open('test/data/SCU49845/SCU49845.gb');
  locus.when(
    failure: (failure) => failure.when(
      fileNotFound: () => print('Arquivo não encontrado'),
      fileParseError: (error) =>
          print('Houve um erro desconhecido na leitura do arquivo: ${error.toString()}'),
      fileEmpty: () => print('O arquivo está vazio'),
      fileFormatIncorrect: () => print('O arquivo não está no formato do genbank'),
    ),
    data: (genbankData) => print(genbankData.toString()),
  );
}
```

## Lista de tarefas

 - (Genbank): obter as sequências de nucleotideos das features, a partir da subsequência de seu respectivo locus, com base no start, end e strand.
 - Implementar a leitura de dados de arquivos [GFF 2/GTF](https://www.ensembl.org/info/website/upload/gff.html) e [GFF 3](https://m.ensembl.org/info/website/upload/gff3.html).