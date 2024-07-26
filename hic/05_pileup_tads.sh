DATA_PATH=/DATA/users/magnitov/tacl

for SAMPLE in haarhuis_2017.WT sanborn_2015.WT T-MAU2 T-MAU2_Dox_1H T-mCherry
do
	coolpup.py ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::/resolutions/10000 \
		${DATA_PATH}/insulation/haarhuis_2017.WT.tads_200kb.bed \
		--expected ${DATA_PATH}/expected/${SAMPLE}_oe_cis_10K.tsv \
		--rescale --local --rescale_size 99 --minsize 0 --n_proc 16 \
		--outdir ${DATA_PATH}/insulation --outname average_tads_${SAMPLE}.txt
done
