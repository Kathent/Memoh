-- 0034_subagent_model_id (rollback)
-- Remove model_id column from subagents.

ALTER TABLE subagents
  DROP COLUMN IF EXISTS model_id;
