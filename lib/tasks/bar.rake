class BarOutput
  def self.banner text
    puts '*' * 60
    puts " #{text}"
    puts '*' * 60
  end

  def self.puts string
    puts string
  end
end

namespace :foo do
  desc "bake some bars"
  task bake_a_bar: :environment do
    BarOutput.banner " Step back: baking in action!"
    BarOutput.puts Bar.new.bake
    BarOutput.banner " All done. Thank you for your patience."
  end
end
