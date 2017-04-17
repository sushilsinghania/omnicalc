class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================




    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ","")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_cr = text_wo_linefeed.gsub("\r","")
    text_wo_tabs = text_wo_cr.gsub("\t","")


    @character_count_without_spaces = text_wo_tabs.length

    text_array = @text.downcase.split

    @word_count = text_array.length

    @special_word = @special_word.gsub(" ","").gsub("\n","").gsub("\r","").gsub("\t","").downcase

    @occurrences = text_array.count @special_word

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    monthly_rate = @apr/1200
    number_periods = @years*12.0

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @monthly_payment = (monthly_rate*@principal)/(1-((1+monthly_rate)**(0-number_periods)))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # //

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    if @count %2 != 0
      @median = @sorted_numbers[@count/2]
    else
      @median = (@sorted_numbers[@count/2]+@sorted_numbers[(@count/2)-1])/2.0
    end

    @sum = 0
    counter = 0
    while counter < (@count)
      @sum = @sum + @sorted_numbers[counter]
      counter = counter + 1
    end
    #
    # @sum = "Replace this string with your answer."

    @mean = @sum/(@count)

    square_sum = 0
    counter = 0
    while counter < @count
      square_sum = square_sum + (@sorted_numbers[counter] - @mean)**2
      counter = counter + 1
    end

    @variance = square_sum/@count

    @standard_deviation = @variance**0.5


    # frequency = []
    # counter1 = 0
    #
    # while counter1 < @count
    #   counter2=0
    #   while counter2 < (@count)
    #
    #     if @sorted_numbers[counter2+1] == @sorted_numbers[counter1]
    #       counter2 = counter2+1
    #     end
    #   end
    #   frequency[counter1] = counter2 + 1
    #   counter1 = counter1 + 1
    # end
    #
    # counter1 = 0
    # max = 0
    # while counter1<@count
    #   if frequency[counter1+1] < frequency[counter1]
    #     max = counter1
    #   end
    #   counter1 = counter1 + 1
    # end


    @mode = @sorted_numbers[0]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")


  end

end
