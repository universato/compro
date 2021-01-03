require "spec"
require "../priority_queue.cr"

describe PriorityQueue do
  describe "priorityque" do
    it "is priorityque" do
      pq = PriorityQueue(Int32).new
      pq.push(5)
      pq.push(10)
      pq.push(3)
      pq.push(7)
      pq.size.should eq 4
      pq.pop.should eq 3
      pq.size.should eq 3
      pq.pop.should eq 5
      pq.top.should eq 7
      #pq.min.should eq 7
      pq.pop.should eq 7
      pq.any?.should eq true
      pq.pop.should eq 10
      pq.empty?.should eq true
    end
  end

  describe "priorityque" do
    it "is priorityque" do
      n = 100
      r = Array.new(n){|i| i }.shuffle
      pq0 = r.to_pq
      pq1 = PriorityQueue(Int32).new
      r.each{|e| pq1.push(e) }
      pq0.size.should eq n
      pq1.size.should eq n
      n.times{ pq0.pop.should eq pq1.pop }
      #n.times{|i| pq0.pop.should eq i }
      #n.times{|i| pq1.pop.should eq i }
    end
  end
end
