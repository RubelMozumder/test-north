from nomad.config.models.north import NORTHTool
from nomad.config.models.plugins import NorthToolEntryPoint

tool = NORTHTool(
    short_description='ghcr.io/rubelmozumder/test-north/jupyter:latest',
    # image='gitlab-registry.mpcdf.mpg.de/nomad-lab/north/xps:master',
    image='ghcr.io/rubelmozumder/test-north/jupyter:latest',
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
    display_name='SPM',
)

north_tool = NorthToolEntryPoint(id='spm-jupyter', north_tool=tool)


tool2 = NORTHTool(
    short_description='quay.io/jupyter/scipy-notebook:2025-10-20.',
    image='quay.io/jupyter/scipy-notebook:2025-10-20',
    description='Test entry-point with XPS image.',
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
    display_name='SPM-jupyter',
)

north_tool2 = NorthToolEntryPoint(id='spm-jupyter-xps', north_tool=tool2)


tool3 = NORTHTool(
    short_description='gitlab-registry.mpcdf.mpg.de/nomad-lab/north/xps:master',
    image='gitlab-registry.mpcdf.mpg.de/nomad-lab/north/xps:master',
    description='Test entry-point with XPS image.',
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
    display_name='SPM-xps',
)

north_tool3 = NorthToolEntryPoint(id='spm-jupyter-xps', north_tool=tool3)
