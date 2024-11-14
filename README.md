# Hugo S3 Action

GitHub action to run `hugo deploy` provided there is an S3 target configured in your Hugo repo.

## Usage

```
name: Hugo S3

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
          
      - name: Deploy site
        uses: plopcas/hugo-s3-action@v1.4.1
        env:
          AWS_REGION: 'eu-west-2'
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          MINIFY: 'true'
          HUGO_VERSION:'latest'
```

## Configuration

Set the following properties as secrets in your repository under `Settings / Secrets`.

Name | Required | Description
----- | --------- | -----------
AWS_REGION | Yes | AWS region
AWS_ACCESS_KEY_ID | Yes | Access key with permissions to execute your deployment
AWS_SECRET_ACCESS_KEY | Yes | Secret key
MINIFY | No | Applies asset minification
HUGO_VERSION | No | Installs the provided version of Hugo. If not passed or passed as `latest` it will install the latest version. The leading `v` is optional.

Information about how to configure a deployment to S3 in Hugo can be found here https://gohugo.io/hosting-and-deployment/hugo-deploy/.

You can optionally include a CloudFront distribution ID in your `config.toml` file. Make sure the key you use can grant permission to invalidate it as well as deploy to S3 in that case.

## License

This project is distributed under the [MIT license](LICENSE.md).
