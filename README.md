# iac-github

```shell
# install pre-commit hook, to reduce some github actions cost
bash .github/setup-git-pre-commit-hooks.sh

gh auth login

gh auth refresh --scopes workflow

# load secrets
source .envrc

# format terraform workspace files
bash .github/tf.sh github/johnko/repos fmt

bash .github/tf.sh github/johnko/repos validate

bash .github/tf.sh github/johnko/repos plan

bash .github/tf.sh github/johnko/repos apply

# DANGER: this is an apply -auto-approve, no chance to review plan or cancel
bash .github/tf.sh github/johnko/repos auto

# if up one folder you have all github repos, can start worflow in each
cd ../
for i in $( find . -mindepth 1 -maxdepth 1 -type d ); do echo $i ; cd $i ; gh workflow run Renovate ; cd - ; done

# if you want to find all local tfstate backup files
find . -name 'terraform.tfstate*backup' -ls
```
