DATA_PATH=/DATA/users/magnitov/tacl

mkdir -p ${DATA_PATH}/loops

chromosight detect --threads 24 -m 50000 -M 5000000 --pearson 0.4 -P loops --smooth-trend \
	${DATA_PATH}/coolers/haarhuis_2017.WT.hg38.mapq_30.1000.mcool::/resolutions/10000 ${DATA_PATH}/loops/loops_haarhuis.WT

