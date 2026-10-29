# Assignment 1 execution feedback

Assignment 1 runs separately in `sql_assignment1_runner.yml`. The existing
`sql_assignment_runner.yml`, `grade_assignments.py`, and Assignment 2 tests are
unchanged. A1 uses `a1-test-results.json` / `a1-grading-results`, so it cannot
replace A2's report or artifact.

## Historical source and scope

The implementation restores the behavior of `tests/test_assignment.py` immediately
before `3fe0023c0af279b275f746948ad08134a631a25f` (October 9, 2026).
The March 24 runner (`cf333a0`) evolved through the March 27 parser changes
(`0349f73`) and April 1 multistatement support (`3445382`). By April 5
(`f7e32c2`, `ae700d8`), the workflow was manual-only with an explicit PR number.
The old workflow selected A2 in preference to A1 when both changed. The restoration
runs A1 independently, so an A2 submission no longer suppresses A1 feedback.

The historical runner only executed SQL and displayed up to three rows. This
restoration likewise does **not** judge answer correctness or award marks.
Feedback explicitly distinguishes executed SQL, missing answers, and SQL errors.
All 12 A1 questions are represented. Instructors still mark answers and written work.

The restored parser accepts `--QUERY 1` and `-- QUERY 1`, and closes blocks with
`--END QUERY` or the historical `--END STATEMENT`. It rejects malformed, duplicate,
unclosed, and out-of-range markers. Multistatement SQL uses SQLite statement
boundaries, preserving semicolons in strings and comments. Queries share a disposable
in-memory copy, preserving temporary tables between blocks; the course database is
opened read-only, external database attachment is denied, and queries have a
10-second execution limit plus a five-minute workflow limit.

## Automatic and manual use

On student repositories (owner other than `UofT-DSI`), A1 runs for PRs targeting
`main` from `assignment-one`, `assignment-1`, `assignment-two`, or `assignment-2`
when an `assignment1.sql` file changes. A mixed A1/A2 PR on an A2 branch runs both
workflows. Each runner selects its own assignment file and rejects multiple cohorts'
files rather than guessing. Existing A2 branch and owner rules remain unchanged:
A2 does not automatically run on an A1 branch.

For the upstream `UofT-DSI` repository, or when automatic PR commenting is restricted
by GitHub token permissions, use the A1 workflow's **Run workflow** action. Choose
a workflow ref containing this restoration, enter the submission branch and target
PR number. The submission branch must also contain the restored runner and tests.
The workflow compares the branch against `origin/main`; exactly one changed
`assignment1.sql` is required. A branch already merged into main has no changed
submission to select. The JSON artifact is retained even if posting feedback fails.

Use **SQL Unit Tests** for A2's existing manual workflow. No privileged
`pull_request_target` trigger is added.

## Local validation

From the repository root, after installing `.github/scripts/requirements.txt`:

```sh
python -m pytest 03_instructional_team/tests/test_assignment1_regressions.py 03_instructional_team/tests/test_grader_regressions.py -q
```

The new tests exercise SQL execution (including an intentionally wrong but executable
answer), missing/invalid submissions, multi-statement state, bounded result previews,
database isolation, query timeout, and CLI selection from mixed A1/A2 changes.
A2's existing private-rubric tests require `A2_SOLUTION_RUBRIC`; without that input
pytest reports them as skipped.
