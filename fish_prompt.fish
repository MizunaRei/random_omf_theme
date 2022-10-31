while true
set theme $(omf.index.query --type=theme | shuf -n 1)
	if test "random" != $theme
	break
	end
end
omf install $theme
omf theme $theme


function fish_prompt
## theme could not used by source command
## source $OMF_PATH/themes/$theme/functions/fish_prompt.fish
printf " $theme is enabled. "
end