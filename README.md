# SonarScanner CLI Version Tester

Utility to reproduce/test behaviors of different SonarScanner CLI versions

## How to use

1. Clone this repository.
2. Run `bash setup.sh`.
3. Fill the required values in `.env`:
   - the user ID and GID to use within the container
   - the SonarScanner CLI version you want to use.
   - your Sonar token, project key (and organization if using SonarCloud).
3. Set up the desired source code in `src/`.
5. Run `docker compose up --build`.

## More customization

### Pass more Sonar properties

- Use `sonar-project.properties` to pass custom sonar properties.
- Additionally, any environment value in `.env` will be made available to the SonarScanner CLI.

### Scan custom code

- The scanned code is in `src/`. Put anything you want to scanned inside.
