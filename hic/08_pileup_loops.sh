DATA_PATH=/DATA/users/magnitov/tacl

for SAMPLE in haarhuis_2017.WT sanborn_2015.WT T-MAU2 T-MAU2_Dox_1H T-mCherry
do
	coolpup.py ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::/resolutions/10000 \
		${DATA_PATH}/loops/haarhuis_2017.WT_loops_chromosight_pearson_0.4.bed \
		--expected ${DATA_PATH}/expected/${SAMPLE}_oe_cis_10K.tsv \
		--mindist 0 --pad 200 --n_proc 16 --outdir ${DATA_PATH}/loops --outname average_loops_${SAMPLE}.txt
done

