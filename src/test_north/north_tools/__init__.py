from nomad.config.models.north import NORTHTool
from nomad.config.models.plugins import NorthToolEntryPoint

test_jupyter = NORTHTool(
    short_description='Jupyter Notebook server in NOMAD NORTH for NOMAD plugin test-north.',
    image='ghcr.io/fairmat-nfdi/test-north:main',
    description='Jupyter Notebook server in NOMAD NORTH for NOMAD plugin test-north.',
    external_mounts=[],
    file_extensions=['ipynb'],
    icon='logo/jupyter.svg',
    image_pull_policy='Always',
    default_url='/lab',
    maintainer=[{'email': 'john.doe@physik.hu-berlin.de', 'name': 'John Doe'}],
    mount_path='/home/jovyan',
    path_prefix='lab/tree',
    privileged=False,
    with_path=True,
    display_name='test_jupyter',
)

north_entry_point = NorthToolEntryPoint(
    id_url_safe='test-north-test-jupyter',
    north_tool=test_jupyter,
)
