passwords = File.read("p079_passwords.txt").split
chains = {}

passwords.each do |pwd|
  pwd = pwd.split //
  before = pwd
  after = []
  pwd.each do |c|
    before -= [c]
    chains[c] ||= { 'before' => [], 'after' => [] }
    chains[c]['before'] |= before
    chains[c]['after'] |= after

    after += [c]
  end
end

pwd = ""
while chains.length > 0
  chains.each do |c,a|
    next if a['after'].length > 0

    puts "#{c} is before #{a['before'].join ','}"
    pwd += c
    chains.each do |ic,ia|
      chains[ic]['after'] -= [c]
    end
    chains.delete c
    break
  end
end

p pwd
