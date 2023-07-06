return [[
# ${version}

> local function render_changelog_entry(entry)
- ${entry.message}
>   if entry.pr then
  [#${entry.pr.id}](${entry.pr.link})
>   end
>   if entry.jiras then
>     for _, jira in ipairs(entry.jiras or {}) do
  [${jira.id}](${jira.link})
>     end
>   end
>   if #(entry.issues or {}) > 0 then
(issue:
>     for _, issue in ipairs(entry.issues or {}) do
 [#${issue.id}](${issue.link})
>     end
)
>   end
> end


> local function render_changelog_entries(entries)
>   for _, entry in ipairs(entries or {}) do
>     render_changelog_entry(entry)
>   end
> end



## Kong

### Breaking Changes

> for scope, entries in pairs(kong.breaking_changes or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end

### Deprecations

> for scope, entries in pairs(kong.deprecations or {}) do
>   render_changelog_entries(entries)
> end


### Dependencies

> for scope, entries in pairs(kong.dependencies or {}) do
>   render_changelog_entries(entries)
> end


### Features

> for scope, entries in pairs(kong.features or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end


### Fixes

> for scope, entries in pairs(kong.bugfixes or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end

## Kong Manager


### Breaking Changes

> for scope, entries in pairs(km.breaking_changes or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end


### Deprecations

> for scope, entries in pairs(km.deprecations or {}) do
>   render_changelog_entries(entries)
> end


### Dependencies

> for scope, entries in pairs(km.dependencies or {}) do
>   render_changelog_entries(entries)
> end


### Features

> for scope, entries in pairs(km.features or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end


### Fixes

> for scope, entries in pairs(km.bugfixes or {}) do
#### ${scope}
>   render_changelog_entries(entries)
> end

]]
