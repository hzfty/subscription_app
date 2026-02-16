# Commit Message Template

## Format

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

## Types

| Type | Description |
|------|-------------|
| feat | Новая функциональность |
| fix | Исправление бага |
| docs | Документация |
| style | Форматирование (не влияет на код) |
| refactor | Рефакторинг (не feat и не fix) |
| test | Добавление тестов |
| chore | Обслуживание (build, deps) |

## Scope (optional)

Модуль или область: `auth`, `profile`, `api`, `ui`

## Examples

```
feat(auth): add biometric authentication

fix(profile): resolve crash on empty avatar

docs: update README with setup instructions

refactor(api): extract common error handling

test(auth): add login flow tests

chore: update dependencies
```

## Rules

1. Описание в imperative mood ("add" not "added")
2. Первая буква строчная
3. Без точки в конце
4. Максимум 72 символа в первой строке
5. Body через пустую строку от subject
