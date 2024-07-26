DATA_PATH=/DATA/users/magnitov/tacl

mkdir -p ${DATA_PATH}/expected

for SAMPLE in T-MAU2 T-MAU2_Dox_1H T-mCherry haarhuis_2017.WT sanborn_2015.WT
do
	for RESOLUTION in 1 5 10 20 100 200 500
	do
		cooltools compute-expected -p 16 --ignore-diags 0 ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::resolutions/${RESOLUTION}000 >\
		       	${DATA_PATH}/expected/${SAMPLE}_oe_cis_${RESOLUTION}K.tsv
	done
done

for SAMPLE in T-MAU2 T-MAU2_Dox_1H T-mCherry haarhuis_2017.WT sanborn_2015.WT
do
	for RESOLUTION in 1 5 10
	do
		cooltools compute-expected -p 16 --ignore-diags 0 --regions ${DATA_PATH}/tetO_integrations_1Mb.bed ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::resolutions/${RESOLUTION}000 > ${DATA_PATH}/expected/${SAMPLE}_tetO_1Mb_oe_cis_${RESOLUTION}K.tsv
		cooltools compute-expected -p 16 --ignore-diags 0 --regions ${DATA_PATH}/tetO_integrations_2Mb.bed ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::resolutions/${RESOLUTION}000 > ${DATA_PATH}/expected/${SAMPLE}_tetO_2Mb_oe_cis_${RESOLUTION}K.tsv
		cooltools compute-expected -p 16 --ignore-diags 0 --regions ${DATA_PATH}/tetO_integrations_4Mb.bed ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::resolutions/${RESOLUTION}000 > ${DATA_PATH}/expected/${SAMPLE}_tetO_4Mb_oe_cis_${RESOLUTION}K.tsv
	done
done
