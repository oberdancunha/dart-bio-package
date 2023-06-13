// ignore_for_file: file_names
import 'package:dart_bio_dependency_module/dart_bio_dependency_module.dart';
import 'package:dart_bio_seqio/src/seqio/domain/entities/genbank/genbank.dart';

import 'KX189121/KX189121_genbank_data.dart' as kx189121;
import 'SCU49845/SCU49845_genbank_data.dart' as scu49845;

KtList<Genbank> getGenbankMultiDataEntity() => KtList.of(
      Genbank(
        locus: scu49845.getLocus(),
        locusDetails: scu49845.getLocusDetails(),
        features: scu49845.getLocusFeatures(),
      ),
      Genbank(
        locus: kx189121.getLocus(),
        locusDetails: kx189121.getLocusDetails(),
        features: kx189121.getLocusFeatures(),
      ),
    );
