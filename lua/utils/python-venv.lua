local M = {}

--- Find the virtual environment path for a project root
---@param root string project root directory
---@return string|nil venv path
function M.find_venv(root)
  -- 1. Active venv from environment
  local active = vim.env.VIRTUAL_ENV
  if active then return active end

  -- 2. .venv in project root
  local dot_venv = vim.fs.joinpath(root, '.venv')
  if vim.uv.fs_stat(dot_venv) then return dot_venv end

  -- 3. venv/ in project root
  local venv = vim.fs.joinpath(root, 'venv')
  if vim.uv.fs_stat(venv) then return venv end

  return nil
end

--- Get python executable path for a project root
---@param root string project root directory
---@return string python path
function M.python_path(root)
  local venv = M.find_venv(root)
  if venv then return vim.fs.joinpath(venv, 'bin', 'python') end
  return vim.fn.exepath('python3') or 'python3'
end

return M
