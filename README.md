# file-upload-action
Upload files to the qbee.io file manager within GitHub runners.

# Usage
To use this action make sure to use our [authentication action](https://github.com/qbee-io/authenticate-action) before the file upload.

A sample GitHub action file in your repository would look like this

```yaml
name: qbee.io upload
on:
 push:
    branches: [ main ]

jobs:
 build:
    runs-on: ubuntu-latest
    env:
        TARNAME: repo.tar

    steps:
    - uses: actions/checkout@v4

    - name: create tarball
      run: |
        mkdir ./tar
        tar --exclude='./.git' --exclude='./.github' --exclude='./tar' -czvf ./tar/$TARNAME .


    - name: qbee.io authentication
      uses: qbee-io/authenticate-action@main
      id: qbee-auth
      with:
          login: ${{ secrets.USERNAME_KEY }}
          password: ${{ secrets.PASSWORD_KEY }}

    - name: qbee.io file upload
      uses: qbee-io/file-upload-action@main
      with:
          source: './tar/${{ env.TARNAME }}'
          destination: '/github_actions_upload'
```

The usage of [qbee-io/authenticate-action](https://github.com/qbee-io/authenticate-action) is explained on its documentation page.

# Input variables
* `source`: path to source file
* `destination`: path to the directory in the qbee file manager where the file should be uploaded
* `action`: type of action. Supported actions are `upload` (single files) and `sync` for directories
