DIGESTS=$(doctl registry repository lm $1 --format Digest,UpdatedAt,Tags | tail -n +2 | sort -rk2 | grep -v -E "$3" | awk '{print $1}' | tail -n +$(($2+1)))
for DIGEST in $DIGESTS; do
  doctl registry repository delete-manifest --force $1 $DIGEST
done
echo Manifest Digests removed: $DIGESTS

doctl registry garbage-collection start --include-untagged-manifests --force
