# devops_demo



## Create and Connect a Git Repository

```sql
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-mkobel')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY quickstart_common.public.quickstart_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/sfc-gh-mkobel/devops_demo';
```

  