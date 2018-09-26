## install git

Check to see if it's already installed: `which git` (tells you where the git program is) or `git --version` (tells you which version you have) or `git --help` or `man git` to get help.

#### install git on Mac OSX:

get homebrew if you don't have it already. check with `which brew`
install git through homebrew: run `brew install git`

## configure git

run `git config -l` to list the current configuration for git. Most likely, git doesn't know about your name etc. Set it like this, but substitute my info with your own info:

```
git config --global user.name "Cecile Ane"
git config --global user.email "cecile.ane@wisc.edu"
git config --glabal github.user "cecileane"
git config --global color.ui true
```

The email above must be the email that you used to create your github account. The last line is to get colors in the terminal when git will to show changes (red for deletions, green for modifications).

Then run `git config -l` again to check that your git configuration is good.

##### Reference

<https://github.com/UWMadison-computingtools-master/general-info/blob/master/git.md>

## submit assignment

These steps are to broadcast your work to github, to submit it there.

- save all your homework files locally

- commit the files that you want to submit: run `git add filename` for every new file filename that you created. run `git commit -m "commit message here"`

##### example 

**you created a directory scripts/ in which you created a file `normalizeFileNames.sh`**
**you also modified the file readme.md that was already existing (and already tracked by git).**

1. commit new file and changes:

```
git status # gives useful info: read it!
git add scripts/normalizeFileNames.sh
git add readme.md
git status # read! you should see that your work is ready to be committed
git commit -m "doc in readme, and script to normalize file names"
git show   # just to check your latest commit. "q" to quit
run git status to double check: should be all clean
```

2. push the new commit(s) to your github repo: `run git push`

3. go online to visit your repo on github, refresh the browser and make sure it's all good: click on the files, on the last commit, visit the network page (in "Graphs", then hover on the dots)

After these steps, your work will be visible to the instructor and TA.

4. To submit your work: **open an issue**, **link to the latest commit**, and **tag** me and the TA (@coraallencoleman):

    - 0n github, **click on "Issues"**, **then "New Issue"**. **Name your issue "Mark homework xxx, exercise yyy of firstname-lastname"**, where xxx and yyy are 1, 2, etc. 

    - find the SHA of the latest commit. On github, above the file list, look for "latest commit" followed by 7 numbers/letters. **Right-click to copy the link to this last commit** with its SHA. For example, it might look like this: <https://github.com/UWMadison-computingtools-2018/xxx/commit/0962e0575d>

    - you can also get the SHA from the shell: `git log`, but the first option gives the full link to that particular commit on the github repository.

5. issue description:

- tag me and the TA by including the text @cecileane and @coraallencoleman anywhere in the message
- paste the revision SHA (link from first step)
- include comments to help me understand what you did
- use markdown syntax (this is very important: see grading rubric)
- click on "preview" to preview your issue (check the link and markdown syntax)
- submit "new issue". Anyone you tagged will receive an email automatically.

##### Reference

<https://github.com/UWMadison-computingtools-master/general-info#submit-your-assignment>

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
##### Reference

<http://cecileane.github.io/computingtools/pages/notes0927.html>