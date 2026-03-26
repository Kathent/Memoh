-- 0034_subagent_model_id
-- Add model_id column to subagents for explicit per-subagent model selection.

ALTER TABLE subagents
  ADD COLUMN IF NOT EXISTS model_id UUID REFERENCES models(id) ON DELETE SET NULL;
