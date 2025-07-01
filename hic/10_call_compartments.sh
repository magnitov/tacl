DATA_PATH=/DATA/users/magnitov/tacl

mkdir -p ${DATA_PATH}/compartments

for SAMPLE in T-MAU2 T-mCherry T-MAU2_Dox_1H haarhuis_2017.WT sanborn_2015.WT
do
	cooltools call-compartments ${DATA_PATH}/coolers/${SAMPLE}.hg38.mapq_30.1000.mcool::resolutions/200000 \
		-o ${DATA_PATH}/compartments/eigs_${SAMPLE}
done

