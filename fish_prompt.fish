while true
set theme_to_enable $(omf.index.query --type=theme | shuf -n 1)
	if test "random" != $theme_to_enable
	and test "random_omf_theme" != $theme_to_enable
		
	break
	end
end

if not contains   "$theme_to_enable"  $(omf.packages.list --theme)
		omf install $theme_to_enable
		printf " $theme_to_enable is installed. "
		end

		
omf theme $theme_to_enable
printf " $theme_to_enable is enabled. "


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish
printf " $theme_to_enable is enabled. "
end