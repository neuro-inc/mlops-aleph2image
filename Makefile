PATH_STORAGE := storage:aleph2image

upload:
	neuro cp -ru . -T $(PATH_STORAGE)

download:
	neuro cp -ru $(PATH_STORAGE) -T .

run:
	neuro run \
		-v $(PATH_STORAGE):/project:rw \
		-s gpu-small \
		--http 8888 \
		pytorch/pytorch:1.7.1-cuda11.0-cudnn8-devel \
		bash -c ' \
			pip install -Uq jupyter==1.0.0 \
			&& jupyter notebook \
				--no-browser \
				--ip=0.0.0.0 \
				--port=8888 \
				--allow-root \
				--NotebookApp.token= \
				--notebook-dir=/project \
				--NotebookApp.shutdown_no_activity_timeout=7200 \
				--MappingKernelManager.cull_idle_timeout=7200 \
		'

.PHONY: upload download run
