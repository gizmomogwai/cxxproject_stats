cxx_plugin do |ruby_dsl, building_blocks, log|
  require 'haml'

  def count_sources(bbs)
    return bbs.inject(0) do |memo, bb|
      memo += bb.sources.size if bb.kind_of?(Cxxproject::HasSources)
      memo
    end
  end

  def print_sources(io, bbs, indent)
    io.puts(indent + '%div.details')
    bbs.each do |bb|
      if bb.kind_of?(Cxxproject::HasSources)
        io.puts(indent + "  %p Sources of #{bb.name}: #{bb.sources.size}")
        io.puts(indent + '  %ul')
        bb.sources.each do |s|
          io.puts(indent + "    %li #{s}")
        end
      end
    end
  end

  def handle_exe(io, building_blocks, bb, indent, log)
    if bb.kind_of?(Cxxproject::Executable)
      io.puts(indent + "%h1")
      bbs = bb.all_dependencies
      io.puts(indent + "  %p.details_toggle Executable '#{bb.name}' total sources: #{count_sources(bbs)}")
      print_sources(io, bbs, indent)
    end
  end

  directory ruby_dsl.build_dir

  desc 'print building block stats'
  task :stats => ruby_dsl.build_dir do
    io = StringIO.new
    io.puts('%html')
    io.puts('  %head')
    io.puts('    %title Some Stats')
    io.puts('    %script{ :type => "text/javascript", :src=>"http://ajax.googleapis.com/ajax/libs/jquery/1.5/jquery.min.js"}')
    io.puts('    :javascript')
    io.puts('      $(document).ready(function() {$("div.details").hide();$("h1").click(function() {$(this).next().toggle();});});')
    io.puts('  %body')
    res = building_blocks.inject(io) do |memo, pair|
      key, bb = pair
      log.error building_blocks.size
      handle_exe(memo, building_blocks, bb, ' '*4, log)
      memo
    end
    engine = Haml::Engine.new(io.string)
    File.open(File.join(ruby_dsl.build_dir, 'stats.out.html'), 'w') do |out|
      out.puts(engine.render)
    end
  end
end
