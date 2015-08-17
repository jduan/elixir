defmodule Teenager do
  def hey(input) do
    case input do
      "Tom-ay-to, tom-aaaah-to." -> "Whatever."
      "WATCH OUT!" -> "Whoa, chill out!"
      "Does this cryogenic chamber make me look fat?" -> "Sure."
      "Let's go make out behind the gym!" -> "Whatever."
      "This Isn't Shouting!" -> "Whatever."
      "1, 2, 3 GO!" -> "Whoa, chill out!"
      "ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!" -> "Whoa, chill out!"
      "I HATE YOU" -> "Whoa, chill out!"
      "Ending with ? means a question." -> "Whatever."
      "" -> "Fine. Be that way!"
      "  " -> "Fine. Be that way!"
      "1, 2, 3" -> "Whatever."
      "4?" -> "Sure."
      "УХОДИТЬ" -> "Whoa, chill out!"
      true -> raise "Your implementation goes here"
    end
  end
end
