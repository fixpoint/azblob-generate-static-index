# azblob-generate-static-index

This generate `index.html` from your workflow to [Azure Blob Storage](https://azure.microsoft.com/ja-jp/services/storage/blobs/) for [Static website hosting in Azure Storage](https://docs.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website).

## Usage

Get [Azure Storage connection strings](https://docs.microsoft.com/en-us/azure/storage/common/storage-configure-connection-string) and specify it to `connection-string` through Github secrets like:

```yaml
steps:
  - uses: actions/checkout@v4

  - uses: fixpoint/azblob-generate-static-index@v1
    with:
      connection-string: ${{ secrets.AZURE_STORAGE_CONNECTION_STRING }}
      prefix: some/directory
      overwrite: true
```

See [action.yml](./action.yml) for more detail.

## License

This scripts and documentation in this project are released under the [MIT License](./LICENSE).
