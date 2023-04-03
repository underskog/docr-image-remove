TAGS=$(doctl registry repository lt $1 --format Tag,UpdatedAt | tail -n +2 | sort -rk2 | awk '{print $1}' | grep -v -E "$3" | tail -n +$2 | tr '\n' ' ')
[[ -n $TAGS ]] && doctl registry repository dt $1 $TAGS --force
echo Tags removed: $TAGS
