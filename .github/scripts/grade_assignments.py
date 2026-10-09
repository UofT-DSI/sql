"""Run each changed A2 submission and always produce a fresh combined report."""
import json
from pathlib import Path
import subprocess
import sys
import tempfile


def grade_files(files, output):
    """Grade exactly one changed Assignment 2 SQL file and write its report."""
    if len(files) != 1:
        if files:
            error = "More than one assignment2.sql file changed. Submit only your cohort's file."
        else:
            error = "No changed assignment2.sql file was found."
        reports = [{"file": "Submission selection", "results": [], "runner_error": error}]
        Path(output).write_text(json.dumps(reports, indent=2))
        return 1

    file_path = files[0]
    with tempfile.TemporaryDirectory(prefix="a2-reports-") as folder:
        report = Path(folder) / "report.json"
        error = None
        try:
            result = subprocess.run(
                [sys.executable, "-m", "pytest", "03_instructional_team/tests/test_assignment.py",
                 f"--file_path={file_path}", f"--report_path={report}",
                 "--tb=short", "--disable-warnings"], timeout=120, check=False,
            )
            if result.returncode:
                error = f"Grading runner exited with status {result.returncode}."
            answers = json.loads(report.read_text()) if report.exists() else []
            if not isinstance(answers, list) or len(answers) != 12:
                raise ValueError("Grading runner did not produce a complete 12-question report.")
        except Exception as exception:
            answers = []
            error = str(exception)

    reports = [{"file": file_path, "results": answers, "runner_error": error}]
    Path(output).write_text(json.dumps(reports, indent=2))
    return int(error is not None)


if __name__ == "__main__":
    changed = Path(sys.argv[1]).read_bytes().decode().split("\0")
    files = sorted({path for path in changed if Path(path).name == "assignment2.sql"})
    sys.exit(grade_files(files, sys.argv[2]))
