-- name: CreateSubagent :one
INSERT INTO subagents (name, description, model_id, bot_id, messages, metadata, skills)
VALUES ($1, $2, $3, $4, $5, $6, $7)
RETURNING id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage;

-- name: GetSubagentByID :one
SELECT id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage
FROM subagents
WHERE id = $1 AND deleted = false;

-- name: GetSubagentByBotAndName :one
SELECT id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage
FROM subagents
WHERE bot_id = $1 AND name = $2 AND deleted = false;

-- name: ListSubagentsByBot :many
SELECT id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage
FROM subagents
WHERE bot_id = $1 AND deleted = false
ORDER BY created_at DESC;

-- name: UpdateSubagent :one
UPDATE subagents
SET name = $2,
    description = $3,
    model_id = $4,
    metadata = $5,
    updated_at = now()
WHERE id = $1 AND deleted = false
RETURNING id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage;

-- name: UpdateSubagentMessages :one
UPDATE subagents
SET messages = $2,
    updated_at = now()
WHERE id = $1 AND deleted = false
RETURNING id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage;

-- name: UpdateSubagentMessagesAndUsage :one
UPDATE subagents
SET messages = $2,
    usage = $3,
    updated_at = now()
WHERE id = $1 AND deleted = false
RETURNING id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage;

-- name: UpdateSubagentSkills :one
UPDATE subagents
SET skills = $2,
    updated_at = now()
WHERE id = $1 AND deleted = false
RETURNING id, name, description, model_id, created_at, updated_at, deleted, deleted_at, bot_id, messages, metadata, skills, usage;

-- name: SoftDeleteSubagent :exec
UPDATE subagents
SET deleted = true,
    deleted_at = now(),
    updated_at = now()
WHERE id = $1 AND deleted = false;
