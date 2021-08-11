import 'package:bio/src/seqio/domain/entities/genbank/feature.dart';
import 'package:bio/src/seqio/domain/entities/genbank/genbank.dart';
import 'package:bio/src/seqio/domain/entities/genbank/locus.dart';
import 'package:bio/src/seqio/domain/entities/genbank/locus_details.dart';
import 'package:bio/src/seqio/domain/entities/genbank/reference.dart';
import 'package:kt_dart/kt.dart';

KtList<Genbank> getGenbankDataEntity() => KtList.of(
      Genbank(
        locus: getLocus(),
        locusDetails: getLocusDetails(),
        features: getLocusFeatures(),
      ),
    );

Locus getLocus() => Locus(
      name: 'KX189121',
      length: 684,
      type: 'DNA',
      shape: 'linear',
      taxonomicDivision: 'PLN',
      releaseDate: '22-MAY-2017',
      sequence: getLocusSequenceFormatted(),
    );

LocusDetails getLocusDetails() => LocusDetails(
      definition: 'Saccharomyces cerevisiae strain C1 Flo11p (FLO11) gene, partial cds.',
      accession: 'KX189121',
      version: 1,
      source: "Saccharomyces cerevisiae (baker's yeast)",
      organism:
          'Saccharomyces cerevisiae; Eukaryota; Fungi; Dikarya; Ascomycota; Saccharomycotina; Saccharomycetes; Saccharomycetales; Saccharomycetaceae; Saccharomyces.',
      keywords: '.',
      references: KtList.of(
        const Reference(
          description: '1  (bases 1 to 684)',
          authors: 'Brueckner,S. and Moesch,H.-U.',
          title:
              'Evidence for adhesion-mediated self-nonself recognition within the same and between different fungal species',
          journal: 'Unpublished',
        ),
        const Reference(
          description: '2  (bases 1 to 684)',
          authors: 'Brueckner,S. and Moesch,H.-U.',
          title: 'Direct Submission',
          journal:
              'Submitted (29-APR-2016) Molecular Genetics, Philipps-Universitaet Marburg, Karl-von-Frisch-Str. 8, Marburg 35043, Germany',
        ),
      ),
    );

KtList<Feature> getLocusFeatures() => KtList.of(
      Feature(
        start: 1,
        end: 684,
        type: 'source',
        strand: 0,
        features: KtList.of(
          {'organism': 'Saccharomyces cerevisiae'},
          {'mol_type': 'genomic DNA'},
          {'strain': 'C1'},
          {'db_xref': 'taxon:4932'},
        ),
      ),
      const Feature(
        start: 1,
        end: 684,
        type: 'gene',
        strand: 0,
        name: 'FLO11',
      ),
      const Feature(
        start: 1,
        end: 684,
        type: 'mRNA',
        strand: 0,
        name: 'FLO11',
        product: 'Flo11p',
      ),
      Feature(
        start: 1,
        end: 684,
        type: 'CDS',
        strand: 0,
        name: 'FLO11',
        product: 'Flo11p',
        note:
            'cell wall protein involved in adhesive cell-cell interactions during yeast cell-substrate adhesion, haploid invasive growth, flocculation, diploid pseudohyphae formation and biofilm (flor) development',
        features: KtList.of(
          {'codon_start': 1},
          {'protein_id': 'ANX99850.1'},
        ),
        aminoacids:
            'MQRPFLLAYLVLSLLFNSALGFPTALVPRCFEETSCNSIVNGCPNLDFNWHMNQQNIMQYTLDVTSVSWVQYNTYQITIHVKGKENIDLKYLSSLKIIGLTGPKDTVQLYGCNENTYLIDNPTDFTATFEVYATQDVNSCQVWMPNFQIQFKYLQGRAAQYASSWKWGTTSFDLSTGCNNYDSQGHSQTDFPGFYWNIYCDNNCGGTKSSTTTSTSTSESFTTTSSTS',
        nucleotides:
            'ATGCAAAGACCATTTCTACTCGCTTATTTGGTCCTTTCGCTTCTATTTAACTCAGCTTTGGGTTTTCCAACTGCACTAGTTCCTAGATGCTTCGAAGAAACTAGCTGTAATTCTATCGTTAATGGCTGTCCCAACTTAGACTTCAATTGGCACATGAACCAACAAAATATCATGCAGTATACTTTGGATGTGACTTCCGTTTCTTGGGTTCAATACAACACATACCAAATCACTATTCATGTCAAAGGTAAAGAAAACATTGACCTAAAATATCTATCGTCTTTGAAAATCATTGGTCTCACTGGTCCAAAAGATACCGTCCAACTATACGGTTGCAACGAAAATACCTATTTGATTGACAACCCAACTGATTTCACAGCCACTTTTGAAGTCTATGCCACACAAGATGTCAACAGCTGTCAGGTGTGGATGCCTAACTTCCAAATTCAATTCAAGTATTTGCAAGGTAGGGCCGCTCAATATGCAAGCTCTTGGAAATGGGGAACTACATCTTTTGATTTGTCTACTGGTTGTAACAACTATGACAGTCAAGGCCACTCTCAAACAGATTTCCCAGGCTTCTATTGGAACATATATTGTGACAACAATTGTGGCGGTACGAAGTCATCTACCACTACATCAACTAGTACTTCCGAGTCATTTACCACTACATCTAGCACTTCT',
      ),
    );

String getLocusSequenceFormatted() =>
    'atgcaaagaccatttctactcgcttatttggtcctttcgcttctatttaactcagctttgggttttccaactgcactagttcctagatgcttcgaagaaactagctgtaattctatcgttaatggctgtcccaacttagacttcaattggcacatgaaccaacaaaatatcatgcagtatactttggatgtgacttccgtttcttgggttcaatacaacacataccaaatcactattcatgtcaaaggtaaagaaaacattgacctaaaatatctatcgtctttgaaaatcattggtctcactggtccaaaagataccgtccaactatacggttgcaacgaaaatacctatttgattgacaacccaactgatttcacagccacttttgaagtctatgccacacaagatgtcaacagctgtcaggtgtggatgcctaacttccaaattcaattcaagtatttgcaaggtagggccgctcaatatgcaagctcttggaaatggggaactacatcttttgatttgtctactggttgtaacaactatgacagtcaaggccactctcaaacagatttcccaggcttctattggaacatatattgtgacaacaattgtggcggtacgaagtcatctaccactacatcaactagtacttccgagtcatttaccactacatctagcacttct';
