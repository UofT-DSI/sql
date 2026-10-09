import sqlite3
import pytest
from pathlib import Path

@pytest.fixture
def sqlite_db():
    """Provide each test with an in-memory copy of the course database."""
    source_db = Path("05_src/sql/farmersmarket.db")
    # Create in-memory DB
    conn = sqlite3.connect(":memory:")

    # Load schema.db into memory
    disk_db = sqlite3.connect(f"file:{source_db}?mode=ro", uri=True)
    conn.row_factory = sqlite3.Row
    disk_db.backup(conn)
    disk_db.close()

    yield conn
    conn.close()

def pytest_addoption(parser):
    """Add the command-line option that selects the Assignment 2 SQL file."""
    parser.addoption("--report_path", action="store", default="test-results.json")
    parser.addoption("--file_path", action="store", default="02_activities/assignments/DC_Cohort/assignment2.sql")

def pytest_generate_tests(metafunc):
    """Pass the selected assignment path into tests that request file_path."""
    option_value = metafunc.config.option.file_path
    if 'file_path' in metafunc.fixturenames and option_value is not None:
        metafunc.parametrize("file_path", [option_value])

@pytest.fixture
def report_path(request):
    return request.config.getoption("--report_path")
