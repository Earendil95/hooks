# git hooks

Предполагаемое использование - дать положить в `.git/hooks` с правильными названиями и правами доступа.

```sh
cp prepare-commit-msg.rb YOUR_REPO/.git/hooks
cp post-checkout.rb YOUR_REPO/.git/hooks
cd YOUR_REPO
chmod u+x .git/hooks/prepare-commit-msg.rb
chmod u+x .git/hooks/post-checkout.rb
```
