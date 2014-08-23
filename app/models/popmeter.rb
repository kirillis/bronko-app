class Popmeter < ActiveRecord::Base
  belongs_to :votable, polymorphic: true
  has_many :votes

  before_save :run_calcs

  def run_calcs
    calculate_total
    if(self.total > 0) 
      # save score to comment
      if self.votable_id and self.votable_type == "Comment"
        c = Comment.find(self.votable_id)
        if c.votes_diff <= 0
          c.score = 0
        else
          c.score = calculate_score
        end
        c.save
      end
    end

    if(self.votable_type == "Post")
      p = self.votable
      p.hotness = calculate_hotness(p.created_at)
      p.save
    end
  end

  # for cron job
  def recalculate_hotness
    calculate_hotness
  end

  private
  def calculate_total
    self.total = self.upvotes + self.downvotes    
  end

  def calculate_hotness(created_at_date)
    # The hot formula. Should match the equivalent function in postgres.
    # http://amix.dk/blog/post/19588
    x = totalUpvotes
    if x > 0 
      y = 1 
    elsif x < 0
      y = -1 
    else 
      y = 0
    end
    z = Math.log10([x.abs, 1].max)
    ts = created_at_date.to_f - 1134028003

    (z + y * ts / 45000).round(6)
  end
  
  def calculate_score
    # taken from http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
    n = self.total
    pos = self.upvotes
    # n = 12
    # pos = 10
    confidence = 0.95

    if n == 0
      return 0
    end

    z = 1.96
    phat = 1.0*pos/n
    
    (phat + z*z/(2*n) - z * Math.sqrt((phat*(1-phat)+z*z/(4*n))/n))/(1+z*z/n)
  end

  def totalUpvotes
    self.upvotes - self.downvotes
  end
end
