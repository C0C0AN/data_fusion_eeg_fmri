# Generate Dockerfile.
docker run --rm kaczmarj/neurodocker:master generate -b neurodebian:stretch-non-free -p apt \
--install tree  nano less ncdu tig \
--fsl version=5.0.10 \
--instruction "RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -" \
--install nodejs build-essential \
--instruction "ENV LC_ALL=C.UTF-8" \
--instruction "RUN apt-get update && apt-get install -yq xvfb mesa-utils" \
--user=neuro \
--miniconda env_name=neuro \
            conda_opts="--channel vida-nyu" \
            conda_install="python=2.7 jupyter jupyterlab pandas matplotlib scikit-learn seaborn numpy scipy traitsui apptools configobj reprozip reprounzip vtk" \
            pip_install="nilearn datalad mayavi pysurfer mne" \
            activate=true \
--instruction "RUN bash -c \"source activate neuro && pip install --pre --upgrade ipywidgets pythreejs \" " \
--instruction "RUN bash -c \"source activate neuro && pip install  --upgrade https://github.com/maartenbreddels/ipyvolume/archive/23eb91685dfcf200ee82f89ab6f7294f9214db8c.zip && jupyter nbextension install --py --sys-prefix ipyvolume && jupyter nbextension enable --py --sys-prefix ipyvolume \" " \
--instruction "RUN bash -c \"source activate neuro && conda install jupyter_contrib_nbextensions \" " \
--instruction "RUN bash -c \"source activate neuro && pip install --upgrade https://github.com/nipy/nibabel/archive/master.zip \" " \
--instruction "USER root" \
--install graphviz \
--instruction "USER neuro" \
--instruction "RUN bash -c \"source activate neuro && jupyter nbextension enable --py --sys-prefix widgetsnbextension && jupyter nbextension enable --py --sys-prefix ipyvolume && conda install -yq bokeh scikit-image traits \" " \
--instruction "RUN bash -c \"source activate neuro && pip install --upgrade https://github.com/nipy/nipype/tarball/master https://github.com/INCF/pybids/archive/master.zip nipy duecredit \" " \
--workdir /home/neuro \
--no-check-urls > /Users/peerherholz/google_drive/Github/data_fusion_eeg_fmri/docker_files/generated.Dockerfile

cd /Users/peerherholz/google_drive/Github/data_fusion_eeg_fmri/docker_files/

# Build Docker image using the saved Dockerfile.
docker build -t eeg_fmri_fusion -f generated.Dockerfile /Users/peerherholz/google_drive/Github/data_fusion_eeg_fmri/docker_files/
