from nomad.config.models.north import NORTHTool
from nomad.config.models.plugins import NorthToolEntryPoint

tool = NORTHTool(
    short_description='Jupyter Notebook server in NOMAD NORTH.',
    image='ghcr.io/rubelmozumder/test-north/jupyter:pr-1',
)

north_tool = NorthToolEntryPoint(id='jupyter', north_tool=tool)
