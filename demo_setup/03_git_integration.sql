USE ROLE ACCOUNTADMIN;



-- API integration is needed for GitHub integration
CREATE OR REPLACE API INTEGRATION git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/sfc-gh-mkobel')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY DEVOPS_DEMO_COMMON.public.demo_repo
  API_INTEGRATION = git_api_integration
  ORIGIN = 'https://github.com/sfc-gh-mkobel/devops_demo';



SHOW API INTEGRATIONS;

SHOW GIT REPOSITORIES;