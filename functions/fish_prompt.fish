#!/usr/bin/env fish


function fish_prompt
## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


## force omf to enable another theme
## printf "default" > $OMF_CONFIG/theme


## workaround for priority of fish_prompt.fish
 if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
 rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
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
omf.cli.install $theme_to_enable
## printf \n
## omf install $theme_to_enable
## printf " \n $theme_to_enable is installed. \n "
end


omf.cli.theme $theme_to_enable
## printf " \n $theme_to_enable is enabled. \n "
## prompt disappeared after enabling new theme. sometimes omf theme command failed.
## omf theme $theme_to_enable ; and omf reload
end


## execute this script directly in fish instead of using omf
## chmod +x  $OMF_PATH/themes/random_omf_theme/functions/fish_prompt.fish
fish_prompt