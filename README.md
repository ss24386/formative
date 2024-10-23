This is a repository for my formative assessment.
It contains code to do the following

1. Check the data being used
2. Clean the data and add new files to a derived folder
3. Create a subset of participants for use in analysis
4. Merge the datasets together for the sample of participants and their data

There is a yml file included in the repository. The correct environment for this 
project can be set up by following the steps below.
1. Install conda if needed
2. create a new conda environment using the following code
	conda env create -f formative_env.yml
3. check that this has worked using
	conda env list
4. activate the new environment using
	conda activate formative
5. check this has worked by checking the text in front of your username in the 
terminal and check which packages were included in the environment using
	conda list
