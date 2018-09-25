## track versions of a project with git

#### create repository

```
cd /Users/srikanth/stat992/exercises/notes
ls -lR
git init # initialize repo: creates .git/
git status
git add readme.md data/readme # git now tracks these files
git status
echo "track course notes" >> readme.md
cat readme.md
git status # readme.md is tracked, previous version in staging area, new version not
```

### commits, staging area, working directory

```
git diff # differences between new version and staged area (if present) or last commit
git add readme.md # adding new edits to staging area
git status        # readme.md only in staging area
git diff          # no differences btw working dir and staging area
git diff --staged # diff between staging area and last commit
```

#### commits

```
git commit -m "initial commit, main readme only"
```

- first line: title
    - informative: helps to recover old versions
    - 50 of fewer characters is strongly recommended
- forbidden: “update”, “continued”, “new code”, “misc”, “edits”
- if more explanations are needed: add one blank line then your explanation paragraph

##### example: commit messages

```
bootsnaq: bug fixes for gene trees

also:
- removed output files from individual boot reps (except if DEBUG)
- argument change in optTopRunsBoot: runs, prcnet -> runs1, runs2
- separate seeds for data simulation and analysis
- new sampleBootstrapTrees! to save memory and gc time
- new calculateObsCFAll! to save gc time during bootstrap
```

```
git commit -m "initial commit, main readme only"
```

- `git commit` only, open editor to edit commit message.
    - default: `vim`
    - quit without saving: `:q!`
    - change git configuration to use nano: `git config --global core.editor nano`

### looking at history

- `git log` uses `less` to view git history
- option `-a` to add all changes in tracked file to the commit

`git log --abbrev-commit --graph --pretty=oneline --all --decorate`

```
git show   # shows last commit: title, paragraph, diffs: change "hunks"
git status # nothing in staging area, but some files not tracked
git log
git log --pretty=oneline
```

```
echo "Project started 2018-09-24" >> readme.md
git diff
git commit -a -m "added project info to main readme"
git log
git log --pretty=oneline --abbrev-commit
```

##### example: git log

```
Srikanths-MacBook-Pro:hw1-aravamu2 srikanth$ git log --abbrev-commit --graph --pretty=oneline --all --decorate
* dc9b355 (HEAD -> master, origin/master, origin/HEAD) doc in readme, and script to summarize SNaQ results
* a97caec Graded 09-19-2018 11:53:43
* 61c994a (tag: v1.1) doc in readme, and script to normalize file names
* 8047805 typos
* 82ea698 data and instructions
Srikanths-MacBook-Pro:hw1-aravamu2 srikanth$ git log --pretty=oneline --abbrev-commit
dc9b355 doc in readme, and script to summarize SNaQ results
a97caec Graded 09-19-2018 11:53:43
61c994a doc in readme, and script to normalize file names
8047805 typos
82ea698 data and instructions
```

### use git to move or delete tracked files

```
git mv data/readme data/readme.md
git status
git commit -m "added markdown extension to data readme"
git log
```

### what files (not) to track / commit

#### track

- scripts
- text documentation with metadata: explain where the data are archived, how to reproduce result files
- notebooks (code + explanations + interpretations) in text format (md or html): but preferably only final version of ‘compiled’/knitted version.

#### do not track

- large files that can be reproduced by the pipeline
- large data files: if can be obtained from outside archive
- binary files: document where they were obtained or how to recompile
- pdf and figures: document how they can be reproduced
- MS Word documents: they are not plain text files

##### example: ignore files to not track

```
touch .gitignore
echo "data/seqs/*.fastq" >> .gitignore
cat .gitignore
git status # fastq files not listed anymore. but need to track .gitignore
git commit -a -m "added .gitignore, to ignore large fastq data files"
git status # all good
```
