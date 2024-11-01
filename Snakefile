rule all:
	input: "logs/log6.log"	

rule checking:
	"check the data"
	input: "data/original/BMX_D.csv",
		"data/original/accel"
	output: "logs/log1.txt"
	shell: """
	cd code
	mkdir logs
	bash 1-checkdata.sh > ../logs/log1.txt
	"""

rule cleaning:
	"clean data and save new files in derived folder"
	input: "data/original/accel"
	output: "logs/log2.txt"
	shell: """
	cd code
	bash 2-clean-data.sh > ../logs/log2.txt
	"""

rule pids_list:
	"create a list of PIDs to include in sample"
	input: "data/derived/accel"
	output: "data/derived/accel_PIDs.csv"
	shell: """
	cd code
	bash 3-PIDs-list.sh 
	"""

rule sample:
	"create sample file for the analysis"
	input: "data/derived/accel_PIDs.csv",
		"data/original/BMX_D.csv"
	output: "data/derived/sample.csv"
	shell: """
	cd code
	Rscript 4-create_samp.R
	"""
rule demodata:
	"merge in demographics data"
	input: "data/original/DEMO_D.XPT"
	output: "data/derived/bmx_demo_data.csv"
	shell: """
	cd code
	Rscript 5-demo-bmx-merge.R
	"""

rule analyse:
	"analyse data from sample"
	input: "data/derived/bmx_demo_data.csv"
	output: "logs/log6.log"
	shell: """
	cd code
	Rscript 6-analyse-data.r > ../logs/log6.log
	"""

rule clean:
	shell:"""
	if [ -d logs ]; then
	 rm -r logs
	fi
	"""
