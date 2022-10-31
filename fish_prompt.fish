while true
set theme_to_enable $(omf.index.query --type=theme | shuf -n 1)
	if test "random" != $theme_to_enable
	and test "random_omf_theme" != $theme_to_enable
		if not contains   "$theme_to_enable"  $(omf.packages.list --theme)
		omf install $theme_to_enable
		end
	break
	end
end


omf theme $theme_to_enable


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish
echo " $theme_to_enable is enabled. "
end