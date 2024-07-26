DATA_PATH=/DATA/users/magnitov/tacl

for SAMPLE in haarhuis_2017.WT sanborn_2015.WT T-MAU2 T-MAU2_Dox_1H T-mCherry
do
	coolpup.py ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::/resolutions/10000 \
		${DATA_PATH}/insulation/haarhuis_2017.WT.insulation_boundaries_200kb.bed \
		--expected ${DATA_PATH}/expected/${SAMPLE}_oe_cis_10K.tsv \
		--pad 500 --local --n_proc 16 --outdir ${DATA_PATH}/insulation/ --outname average_insulation_borders_${SAMPLE}.txt
done
