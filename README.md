# DigitalOcean Image Remove
This action uses [doctl](https://github.com/digitalocean/action-doctl) to find and remove old images from Digital Ocean's Container Registry.

1) Gets the repository manifests using `doctl registry repository lm` and orders them by the `UpdatedAt` attribute. By default it will ignore the 10 most recent images 
2) Then deletes the older images using `doctl registry repository delete-manifest`
3) Lastly triggers garbage collection to reclaim space in the registry

PRs are welcome.

# Usage
Add this step to a job to automatically delete older images as part of a job:

```yaml
  steps:
    - name: Install doctl
      uses: digitalocean/action-doctl@v2
      with:
        token: ${{ secrets.DIGITALOCEAN_API_KEY }}
    - name: Remove old images from Container Registry
      uses: underskog/docr-image-remove@v1
      with:
        image_repository: image-repository # required
        buffer_size: 10
        exclude: ^(latest|tag1|tag2)$
```

# Inputs
- `image_repository` - (**Required**) Image repository name in the Container Registry
- `buffer_size` - (Optional) Number of recent images. Default is `10`
- `exclude` - (Optional) Regex expression to exclude in the tags to delete.

# History
Based on these efforts:

- Initial work: https://github.com/ripplr-io/docr-image-remove
- Digests instead of tags: https://github.com/martintomas/docr-image-remove
- Exclude filter: https://github.com/NearSeaTechnologies/docr-image-remove

## License

This GitHub Action and associated scripts and documentation in this project are released under the [MIT License](LICENSE).
