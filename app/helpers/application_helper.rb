module ApplicationHelper

  def recalculate_hotness
    popmeterAll = Popmeter.where(votable_type: "Post")

    popmeterAll.each do |popmeter|
      popmeter.recalculate_hotness
      if(popmeter.save)
        puts "Calculating hotness for popmeter #{popmeter.id}: #{popmeter.hotness}"
      else
        puts "Error saving popmeter with id: #{popmeter.id}"
      end

    end

    puts "All finished!"
  end
end
