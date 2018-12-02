require "curses"

class TimerCount
    
    def initialize(count_list)
        @count_list = count_list
        @valid_list = Array.new(@count_list.size, false)
        @start_timer = Time.now
        @end_timer = get_end
    end

    def format_timer
        t = @end_timer - Time.now
        Time.at(t).utc.strftime("%H:%M:%S")
    end

    def format_ticks
        @valid_list.map{ |t| t ? "x" : "o"  }.join(" ")
    end

    def get_end
        idx = @valid_list.find_index(false)
        minutes = @count_list[idx].to_i
        end_t = @start_timer + minutes * 60
        @end_timer = Time.at end_t
    end

    def main_window
        Curses.init_screen
        Curses.curs_set(0)
        Curses.crmode
        Curses.nonl
        Curses.cbreak
        Curses.noecho

        begin
            while 1
                Curses.clear
                Curses.setpos( 0, 0 )
                Curses.addstr(format_ticks)
                Curses.setpos((Curses.lines) / 2, (Curses.cols - 10) / 2)
                Curses.addstr(format_timer)
                Curses.setpos(Curses.lines-1 , 0)
                Curses.addstr(Time.now.strftime("%H:%M:%S"))
                Curses.refresh
                sleep 1
            end
        ensure
            Curses.close_screen
        end
    end

end
