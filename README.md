# iac-github

```
# install pre-commit hook, to reduce some github actions cost
./setup.sh

gh auth login

gh auth refresh --scopes workflow

# format terraform workspace files
./tf.sh github/johnko fmt

./tf.sh github/johnko validate

./tf.sh github/johnko plan

./tf.sh github/johnko apply

# DANGER: this is an apply -auto-approve, no chance to review plan or cancel
./tf.sh github/johnko auto
```
