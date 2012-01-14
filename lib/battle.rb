# coding: utf-8
class Battle

  def self.fight!(bots)

    play_game_command = 'cd ' + Rails.root.to_s + '/aitools; ./playgame.py --player_seed 42 --end_wait=0.25 --nolaunch --log_stdout --log_dir game_logs --turns 1000 --map_file maps/maze/maze_02p_02.map "$@" '


    bot_paths = []

    bots.each do |bot|
      bot_paths << (clean_and_setup_temp_path slugorize(bot.player_name), bot.source.to_file.path)
    end

    bot_paths.map!{|p| '"ruby -T2 '+ p + '"'}

    play_game_command += bot_paths.join(" ")

    puts play_game_command
    `#{play_game_command}`
  end

  private

  # Extract bot.zip to a temp directory
  def self.clean_and_setup_temp_path(username, zip_file_path)
    return nil if username.nil? || !File.exists?(zip_file_path)

    temp_zip_path = Rails.root.join("aitools", "bots", username)

    if File.exists? temp_zip_path
      `rm -rf #{temp_zip_path}`
    end

    Dir.mkdir(temp_zip_path)

    unzip_command = "unzip #{zip_file_path} -d #{temp_zip_path}"

    `#{unzip_command}`

    bot_path = get_my_bot_rb_path temp_zip_path
  end

  def self.get_my_bot_rb_path(source_path)
    list_of_files = Dir["#{source_path}/**/**"]
    result = ""
    list_of_files.each do |file|
      if File.basename(file) == "bot"
        result = file
      end
    end
    return result
  end

  def self.slugorize(string)
    result = string.downcase
    result.gsub!(/&([0-9a-z#])+;/, '')  # Ditch Entities
    result.gsub!(/['|’]/, '')           # Remove apostrophes
    result.gsub!('&', 'and')            # Replace & with 'and'
    result.gsub!(/[^a-z0-9\-]/, '-')    # Get rid of anything we don't like
    result.gsub!(/-+/, '-')             # collapse dashes
    result.gsub!(/-$/, '')              # trim dashes
    result.gsub!(/^-/, '')              # trim dashes
    result
  end
end
