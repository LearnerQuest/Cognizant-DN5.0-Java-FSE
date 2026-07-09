
# Git Hands-On Lab

## HOL-1: Git Setup and First Commit
Commands used:
git --version
git config --global user.name "Aashi Garg"
git config --global user.email "aashigarg825@gmail.com"
git init
echo "Welcome to the version control" > welcome.txt
git add welcome.txt
git commit -m "Initial commit"
git push -u origin main

Output:
Repository initialized, welcome.txt committed and pushed to GitHub.

## HOL-2: Branching and Merging
Commands used:
git checkout -b GitNewBranch
git branch -a
echo "This file is created in GitNewBranch" > branchfile.txt
git add branchfile.txt
git commit -m "Added branch file in GitNewBranch"
git checkout main
git diff main GitNewBranch
git merge GitNewBranch
git branch -d GitNewBranch

Output:
GitNewBranch created, changes committed, merged into main, and branch deleted.

## HOL-3: Merge Conflict Resolution
Commands used:
git checkout -b GitWork
echo "<message>Hello from GitWork branch</message>" > hello.xml
git add hello.xml
git commit -m "Added hello.xml in GitWork"
git checkout main
echo "<message>Hello from main branch</message>" > hello.xml
git add hello.xml
git commit -m "Added hello.xml in main"
git merge GitWork

Conflict resolved in hello.xml:
<message>Hello from main branch and GitWork branch</message>

git add hello.xml
git commit -m "Resolved merge conflict in hello.xml"
git branch -d GitWork

Output:
Merge conflict was created, resolved manually, committed, and branch deleted.

## HOL-4: Clean Up and Push
Commands used:
git status
git branch -a
git pull origin main
git push origin main

Output:
All pending commits pushed to GitHub.

## HOL-5: Git Ignore
Commands used:
echo "Error log" > app.log
mkdir log
echo "test log file" > log/test.txt
echo "*.log" >> .gitignore
echo "log/" >> .gitignore
git status
git add .gitignore
git commit -m "Updated gitignore for log files"
git push origin main

Output:
.log files and log folder ignored successfully.