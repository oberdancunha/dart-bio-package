# Bio Dart Package

O <b> Bio Dart Package </b> é um pacote desenvolvido em dart para auxiliar na solução de problemas relacionados a bioinformática.

A bioinformática, por sua vez, é o uso de técnicas computacionais voltadas para a resolução de problemas encontrados na Biologia.

A inclusão do dart no universo da bioinformática ainda é muito discreta. O [pub.dev](https://pub.dev), repositório com blibliotecas do dart/flutter, possui o pacote [bio](https://pub.dev/packages/bio), basicamente para a conversão de arquivo do formato [fastq](https://en.wikipedia.org/wiki/FASTQ_format) para [fasta](https://en.wikipedia.org/wiki/FASTA_format), além da manipulação de sequências, como, por exemplo, obter seu [reverso e complementar](https://www.bx.psu.edu/old/courses/bx-fall08/definitions.html). Olhando seu repositório no github, percebe-se que há algo relacionado a [filogenia](https://www.britannica.com/science/phylogeny) e a [árvores filogenéticas](https://www.khanacademy.org/science/high-school-biology/hs-evolution/hs-phylogeny/a/phylogenetic-trees), no entanto, aparentemente ainda não implementadas. 

## O pacote

O bio dart package foi concebido para satisfazer as necessidades do programa [fluttemis](https://github.com/oberdancunha/flutter-fluttemis-app), não sendo possível ter a mínima comparação com o que há disponível para outras linguagens como o [perl](https://bioperl.org), o [python](https://biopython.org) e até mesmo o [java](https://biojava.org). Além de possuírem um pacote completo de soluções, contam também com uma vasta comunidade que contribuem sistematicamente para a sua maturidade.

## Pacotes
 - [Genbank](pages/genbank.md)

## Lista de tarefas

 - (Genbank): obter as sequências de nucleotideos das features, a partir da subsequência de seu respectivo locus, com base no start, end e strand. :heavy_check_mark:
 - Formatar e escrever sequências fasta em um arquivo
 - Implementar a leitura de dados de arquivos [GFF 2/GTF](https://www.ensembl.org/info/website/upload/gff.html) e [GFF 3](https://m.ensembl.org/info/website/upload/gff3.html).