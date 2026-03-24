import sqlite3
import pytest
from pathlib import Path

@pytest.fixture
def sqlite_db():
    source_db = Path("05_src/sql/farmersmarket.db")
    # Create in-memory DB
    conn = sqlite3.connect(":memory:")

    # Load schema.db into memory
    disk_db = sqlite3.connect(source_db)
    conn.row_factory = sqlite3.Row
    disk_db.backup(conn)
    disk_db.close()

    yield conn
    conn.close()

def pytest_addoption(parser):
    parser.addoption("--file_path", action="store", default="02_activities/assignments/DC_Cohort/assignment1.sql")

def pytest_generate_tests(metafunc):
    option_value = metafunc.config.option.file_path
    if 'file_path' in metafunc.fixturenames and option_value is not None:
        metafunc.parametrize("file_path", [option_value])
