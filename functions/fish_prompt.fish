#!/usr/bin/env fish


function fish_prompt
	## themes in omf could not used by source command
	## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


	## workaround for priority of fish_prompt.fish . It cause omf theme command fail. 
	## calling omf theme this script file will not call rm command to fix the issue.
	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
	end


	## pickup a theme_to_enable from omf official repo
	while true
	set theme_to_enable (random choice (omf.index.query --type=theme))
	if test -z "$theme_to_enable"
	set theme_to_enable (random choice (omf.packages.list --theme))
	end
	if test "random" != $theme_to_enable
		if test "random_omf_theme" != $theme_to_enable
		break
		end
	end
	end


	## install remote theme if not available locally
	if not contains   "$theme_to_enable"  $(omf.packages.list --theme)
	omf.cli.install $theme_to_enable
	## call low level omf function instead of high level function
	## omf install $theme_to_enable
	end


	## enable the new theme
	omf.theme.set $theme_to_enable
	

	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	printf "random_omf_theme" > $OMF_CONFIG/theme
	
	
	## pwd command makes a new prompt line that fix prompt line disappeared after enabling new theme.
	pwd
	## omf reload command will cause dead loop because the command source this script endlessly.
	##omf.cli.reload

	
## function fish_prompt end	
end


## source this script directly in fish instead of using omf theme command to fix fish_prompt.fish priority issue
## chmod +x  $OMF_PATH/themes/random_omf_theme/functions/fish_prompt.fish


## holding too many themes and plugins might cause issues.
function omf.theme.remove_all_themes
	rm -rf $OMF_PATH/themes/*
end


## source this script file to fix fish_prompt.fish priority issue.
fish_prompt
