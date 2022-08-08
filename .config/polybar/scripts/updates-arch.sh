arch_updates=$(checkupdates | wc -l)
aur_updates=$(yay --aur -Qu 2>/dev/null | wc -l)
updates=$((arch_updates + aur_updates))
echo "$updates" 
