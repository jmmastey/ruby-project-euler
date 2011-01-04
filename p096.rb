@@debug = false
class Sudoku
  attr_accessor :rows, :cols, :blocks, :cells, :marked

  def initialize
    @rows = (0..8).inject([]) { |r,i| r << Row.new(i) }
    @cols = (0..8).inject([]) { |r,i| r << Col.new(i) }

    @blocks = []
    0.upto 8 do |i|
      b = Block.new(i)
      rs = (i/3)*3
      b.rows = @rows[rs..rs+2]
      cs = (i%3)*3
      b.cols = @cols[cs..cs+2]
      @blocks << b
    end

    @marked = 0
    @cells = {}
  end

  def block(row,col)
    (col/3) + 3*(row/3)
  end

  def cell(row,col)
    return nil if row > 8 or col > 8

    key = "#{row}:#{col}"
    unless @cells.include? key
      @cells[key] = Cell.new(@rows[row],@cols[col],@blocks[block(row,col)])
    end
    @cells[key]
  end

  def mark(row, col, value)
    return if value.nil?
    #puts "marking #{row.to_s},#{col.to_s} with #{value} (#{@marked})" if @@debug
    cell(row,col).mark(value)
    @marked += 1
  end

  def solve
    n = 1
    puts " Solving for numbers" if @@debug
    while n <= 9
      n = solve_for(n) ? 1 : n+1
      return self if solved?
    end

    solve if solve_sets
    return self if solved?

    guess
  end

  def solve_sets
    puts " Solving sets" if @@debug
    found = false
    [@rows,@blocks,@cols].each do |set|
      set.each do |s|
        next if s.values.length == 9
        left = (1..9).to_a - s.values
        cells = s.cells.select { |c| c.value.nil? }
        left.each do |n|
          cand = cells.select { |c| !(c.row.include?(n) || c.col.include?(n) || c.block.include?(n)) }
          if 1 == cand.length
            cell = cand[0]
            puts "  #{s.class} exclusion solution #{cell.rnum},#{cell.cnum}: #{n}" if @@debug
            mark(cell.rnum,cell.cnum,n)
            found = true
          end
        end
      end
    end

    solve_sets if found
    found
  end

  def guess
    puzzle = self
    cells = (@cells.to_a.select { |k,v| v.value.nil? })
    puts " Guessing (#{cells.length})" if @@debug
    cell = cells[0][1]
    poss = (1..9).to_a - (cell.row.values + cell.col.values)
    raise "Someone else's guess was wrong!" if 0 == poss.length

    poss.each do |guess|
      begin
        puzzle = Marshal.load(Marshal.dump(self))
        puts "  *Guessing #{cell.rnum},#{cell.cnum}: #{guess}" if @@debug
        puzzle.mark(cell.rnum, cell.cnum, guess)
        ret = puzzle.solve
        puzzle = ret
        break
      rescue
        puts "  Guess was wrong. Backtracking." if @@debug
      end
    end

    raise "We're in a broken child guess" unless puzzle.solved?

    # clone back onto self
    @cells = puzzle.cells
    @rows = puzzle.rows
    @cols = puzzle.cols
    @blocks = puzzle.blocks
    @marked = puzzle.marked
    self
  end

  def solve_for n
    found = false

    # block solutions
    @blocks.each do |b|
      next if b.include? n

      # row-size exclusion
      row = b.rows.select { |r| !r.include?(n) }
      if 1 == row.length
        row = row[0].num
        col = b.cols.select { |c| !(c.include?(n) || c.filled?(row) || cell(row,c.num).block.include?(n)) }
        if col.length == 1
          col = col[0].num
          puts "  Row-wise block solution #{row},#{col}: #{n}" if @@debug
          found = mark(row, col, n)
        end
      end

      # col-wise exclusion
      col = b.cols.select { |c| !c.include?(n) }
      if 1 == col.length
        col = col[0].num
        row = b.rows.select { |r| !(r.include?(n) || r.filled?(col) || cell(r.num,col).block.include?(n)) }
        if row.length == 1
          row = row[0].num
          puts "  Col-wise block solution #{row},#{col}: #{n}" if @@debug
          found = mark(row, col, n)
        end
      end
    end

    # column solutions
    @cols.each do |c|
      next if c.include? n
      positions = ((0..8).to_a - c.positions).select { |r| !(@rows[r].include?(n) || cell(r,c.num).block.include?(n)) }
      if positions.length == 1
        puts "  Column solution #{positions[0]},#{c.num}: #{n}" if @@debug
        found = mark(positions[0], c.num, n)
      end
    end

    # row solutions
    @rows.each do |r|
      next if r.include? n
      positions = ((0..8).to_a - r.positions).select { |c| !(@cols[c].include?(n) || cell(r.num,c,).block.include?(n)) }
      if positions.length == 1
        puts "  Row solution #{r.num},#{positions[0]}: #{n}" if @@debug
        found = mark(r.num, positions[0], n)
      end
    end

    found
  end

  def to_s
    s = ""
    0.upto 8 do |r|
      0.upto 8 do |c|
        s += "#{cell(r,c).to_s} "
        s += "| " if c % 3 == 2 && c < 8
      end
      s += "\n"
      s += ("-" * 22)+"\n" if r % 3 == 2 && r < 8
    end
    s + "\n\n"
  end

  def solved?
    @marked == 81
  end

  class Set
    attr_accessor :values, :positions, :num, :cells
    def initialize num
      @num = num
      @cells, @values, @positions = [],[],[]
    end
    def include? val
      @values.include? val
    end
    def filled? pos
      @positions.include? pos
    end
    def set(value, pos, cell)
      raise "Tried to fill taken value for #{self.class} #{self.num} #{value}" if include? value
      raise "Tried to fill taken position for #{self.class} #{self.num} #{pos}" if filled? pos
      @values << value
      @positions << pos
    end
    def to_s
      @num
    end
  end

  class Row < Set; end
  class Col < Set; end
  class Block < Set
    attr_accessor :rows, :cols
    def filled?(pos); false; end
  end

  class Cell
    attr_accessor :rnum, :cnum, :value, :options, :row, :col, :block
    def initialize(row, col, block)
      @row = row
      @row.cells << self
      @rnum = row.num

      @col = col
      @col.cells << self
      @cnum = col.num

      @block = block
      @block.cells << self

      @value = nil
      @options = []
    end
    def mark value
      @value = value
      @row.set(value, @cnum, self)
      @col.set(value, @rnum, self)
      @block.set(value, nil, self)
    end
    def to_s
      (@value.nil? ? 0 : @value)
    end
  end

end


grids = {}
lines = File.read("p096_sudoku.txt").split(/\n/);
i = 0
while i < lines.length
  title = lines[i].chomp
  grid = []
  9.times do
    i += 1
    grid << lines[i].scan(/\d/)
  end
  grids[title] = grid
  i += 1
end

sum = 0
grids.each do |name,grid|
  puts "Building #{name}" if @@debug
  puzzle = Sudoku.new
  0.upto 8 do |row|
    0.upto 8 do |col|
      value = ('0' == grid[row][col] ? nil : grid[row][col].to_i)
      puzzle.mark(row, col, value)
    end
  end

  puts "Solving #{name}" if @@debug
  before = puzzle.to_s.split(/\n/)
  puzzle.solve

  puts "Solved #{name}"
  after = puzzle.to_s.split(/\n/)

  0.upto after.length do |n|
    print before[n]
    print "   "
    print after[n]
    print "\n"
  end

  sum += (puzzle.cell(0,0).value.to_s +
          puzzle.cell(0,1).value.to_s +
          puzzle.cell(0,2).value.to_s).to_i
end

puts sum
