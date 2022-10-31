function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## force omf to enable new theme
printf "default" > $OMF_CONFIG/theme


## workaround for priority of fish_prompt.fish
 if test -e ~/.config/fish/functions/fish_prompt.fish
 rm ~/.config/fish/functions/fish_prompt.fish 
end


 ## pickup a theme_to_enable in omf official repo
while true
set theme_to_enable (random choice (omf.index.query --type=theme ))
	if test "random" != $theme_to_enable
		if test "random_omf_theme" != $theme_to_enable
		break
		end
	end
end


if not contains   "$theme_to_enable"  $(omf.packages.list --theme)
printf \n
omf install $theme_to_enable
## printf " \n $theme_to_enable is installed. \n "
printf \n
end


omf theme $theme_to_enable
## printf " \n $theme_to_enable is enabled. \n "
printf \n
## printf " \n $theme_to_enable is enabled. \n "
fish exit
printf \r
end
