# file-upload-action
Upload files to the qbee.io file manager within GitHub runners.

# Usage
To use this action make sure to use our [authentication action](https://github.com/qbee-io/authenticate-action) before the file upload such that the authorization token can be passed.

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
          token: ${{ steps.qbee-auth.outputs.token }}
          filename: ${{ env.TARNAME }}
          qbee_directory: 'github_actions_upload'
          local_directory: 'tar'
```

The usage of [qbee-io/authenticate-action](https://github.com/qbee-io/authenticate-action) is explained on its documentation page.

# Input variables

* `token`: authentication token obtained from the previous step
* `filename`: filename to upload **without** path
* `qbee_directory`: path to the directory in the qbee file manager where the file should be uploaded
* `local_directory`: path to the local (GitHub) directory in which the file is located - default: ./
* `run`: set to 0 if the upload action should not be performed (default 1: performing file upload)
