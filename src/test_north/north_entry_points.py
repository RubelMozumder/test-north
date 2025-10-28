from nomad.config.models.north import NORTHTool
from nomad.config.models.plugins import NorthToolEntryPoint

tool = NORTHTool(
    short_description='Jupyter Notebook server in NOMAD NORTH.',
    image='ghcr.io/rubelmozumder/test-north/jupyter:pr-1',
    description='Test SPM: Scanning Probe Microscopy Jupyter Notebook',
    external_mounts=[],
    file_extensions=['ipynb', 'nxs', 'h5', 'hdf5'],
    icon='logo/jupyter.svg',
    image_pull_policy='Always',
    default_url='/lab',
    maintainer=[
        {'email': 'rubel.mozumder@physik.hu-berlin.de', 'name': 'Rubel Mozumder'}
    ],
    mount_path='/home/jovyan',
    path_prefix='lab/tree',
    privileged=False,
    with_path=True,
)

north_tool = NorthToolEntryPoint(id='spm-jupyter', north_tool=tool)
