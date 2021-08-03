import 'package:bio/src/seqio/domain/genbank/entities/genbank.dart';
import 'package:kt_dart/kt.dart';

import 'KX189121/KX189121_genbank_data.dart' as KX189121;
import 'SCU49845/SCU49845_genbank_data.dart' as SCU49845;

KtList<Genbank> getGenbankMultiDataEntity() => KtList.of(
      Genbank(
        locus: SCU49845.getLocus(),
        locusDetails: SCU49845.getLocusDetails(),
        features: SCU49845.getLocusFeatures(),
      ),
      Genbank(
        locus: KX189121.getLocus(),
        locusDetails: KX189121.getLocusDetails(),
        features: KX189121.getLocusFeatures(),
      ),
    );
