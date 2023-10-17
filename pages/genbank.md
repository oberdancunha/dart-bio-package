### Genbank

Leitura do [arquivo de anotação do genbank](https://widdowquinn.github.io/2018-03-06-ibioic/01-introduction/02-annotation.html) de um genoma de interesse.

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
  result.join(
    (genbankError) => genbankError.failure.join(
      (fileNotFound) => print('Arquivo não encontrado'),
      (fileParseError) => print('Houve um erro desconhecido na leitura do arquivo: ${fileParseError.error.toString()}'), 
      (fileEmpty) => print('O arquivo está vazio'),
      (fileFormatIncorrect) => print('O arquivo não está no formato do genbank'),
      (fileDataFormatIncorrect) => print('Há um erro em algum dado do arquivo genbank'),
    ),
    (genbank) => print(genbank.data.toString()),
  );
}
```