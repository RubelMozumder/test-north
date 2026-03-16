def test_importing_north_tool():
    # this will raise an exception if pydantic model validation fails
    from test_north.north_tools import north_entry_point

    expected_id = 'test-north-test-jupyter'
    assert (
        north_entry_point.id_url_safe == expected_id
        or north_entry_point.id == 'nomad-north-test-north'
    ), 'NORTHTool entry point has incorrect id or id_url_safe'
