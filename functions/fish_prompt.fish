#!/usr/bin/env fish


## themes in omf could not used by source command
## source $OMF_PATH/themes/$theme_to_enable/functions/fish_prompt.fish


function fish_prompt
	## workaround for priority of fish_prompt.fish . It cause omf theme command failing. 
	## calling omf theme this script file will not call rm command to fix the issue.
	# if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	# rm (omf.xdg.config_home)/fish/functions/fish_prompt.fish 
	# end


	## workaround for priority of fish_prompt.fish . It blocks random theme enabling. 
	if test -e (omf.xdg.config_home)/fish/functions/fish_prompt.fish
	mv -f (omf.xdg.config_home)/fish/functions/fish_prompt.fish (omf.xdg.config_home)/fish/functions/fish_prompt.fish.old
	end	


	set themes_local_installed "$(omf.packages.list --theme)"
	set themes_in_omf_repository "$(omf.index.query --type=theme)"

	## pickup a theme_to_enable from omf official repo
	while true
		if test -n "$themes_in_omf_repository"
		set theme_to_enable "$(random choice (omf.index.query --type=theme))"
		else
		set theme_to_enable "$(random choice (omf.packages.list --theme))"
		end

		# if test -z "$theme_to_enable"
		# set theme_to_enable "$(random choice (omf.packages.list --theme))"
		# end

		if test "random" != "$theme_to_enable"
			if test "random_omf_theme" != "$theme_to_enable"
			break
			end
		end
	end


	
switch $themes_local_installed
case "*$theme_to_enable*" 
    ## debugging
    # echo "$theme_to_enable"
    omf theme "$theme_to_enable"
    echo  (omf::em)"✔ $theme_to_enable theme successfully enabled."(omf::off) 	

case '*'
    ## debugging
    # echo "$themes_local_installed"
    omf install "$theme_to_enable"
   omf theme "$theme_to_enable"
    echo  (omf::em)"✔ $theme_to_enable theme successfully enabled."(omf::off) 	

end


	## install remote theme if not available locally
	# omf.cli.install "$theme_to_enable"
	## use low level functions for performance
	## use high level functions for compatibility
	# if not contains "$theme_to_enable" "$themes_local_installed"
	# omf install "$theme_to_enable"
	# end

	# if test -n (string match -e "$theme_to_enable" "$(omf.packages.list --theme)")
	# omf install "$theme_to_enable"
	# end

	

        ## enable the new theme
	## use low level functions for performance
        # omf.theme.set "$theme_to_enable"
	## use high level functions for compatibility
	# omf theme "$theme_to_enable"
	

	## printf does not display text on terminal
	# echo  (omf::em)"✔ $theme_to_enable theme successfully enabled."(omf::off) 	
	

	## prompt line disappears after enabling new theme. That may be a bug of fish shell.


	## When random theme is enabled, omf reload command will cause dead loop.
	# omf.cli.reload
	
	
	## prompt line appears without theme after enabling a new theme.
	## The new theme will be enabled after a command returns.
	# printf " \r "


	## force omf to enable a new theme when fish source dotfiles (i.e. omf reload)
	echo "random_omf_theme" > "$OMF_CONFIG/theme"


	## prompt line disappears after enabling new theme. That may be a bug of fish shell.
	## The new theme will be enabled after a command returns.
	## make a fake prompt line for end users.
	pwd
	echo '>'

	
## function fish_prompt end	
end


## holding too many themes and plugins might cause issues.
function omf.theme.remove_all_themes
	rm -rf "$OMF_PATH"/themes/*
end


## enabling a theme will autoload the function fish_prompt once, but will not run other part of the script file.
