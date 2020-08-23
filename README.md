# Hugo S3 Action

GitHub action to run `hugo deploy` provided there is an S3 target configured in your Hugo repo.

## Usage

```
name: Hugo S3

# Controls when the action will run. Triggers the workflow on push or pull request
# events but only for the master branch
on:
  push:
    branches: [ master ]
  pull_request:
    branches: [ master ]

jobs:
  build:
    
    runs-on: ubuntu-latest

    steps:
      - name: Check out master
        uses: actions/checkout@master

      - name: Install curl and jq
        run: sudo apt install curl jq
        
      - name: Install Hugo
        run: |
          HUGO_VERSION=$(curl -s https://api.github.com/repos/gohugoio/hugo/releases/latest | jq -r '.tag_name')
          mkdir tmp/ && cd tmp/
          curl -sSL https://github.com/gohugoio/hugo/releases/download/${HUGO_VERSION}/hugo_extended_${HUGO_VERSION: -6}_Linux-64bit.tar.gz | tar -xvzf-
          sudo mv hugo /usr/local/bin/
          cd .. && rm -rf tmp/
          hugo version
          
      - name: Deploy site
        uses: plopcas/hugo-s3@master
```

## Configuration

Set the following properties as secrets in your repository under `Settings / Secrets`.

Name | Required | Description
----- | --------- | -----------
AWS_REGION | Yes | AWS region
AWS_ACCESS_KEY_ID | Yes | Access key with permissions to execute your deployment
AWS_SECRET_ACCESS_KEY | Yes | Secret key

Information about how to configure a deployment to S3 in Hugo can be found here https://gohugo.io/hosting-and-deployment/hugo-deploy/.

You can optionally include a CloudFront distribution ID in your `config.toml` file. Make sure the key you use can grant permission to invalidate it as well as deploy to S3 in that case.

## License

This project is distributed under the [MIT license](LICENSE.md).
