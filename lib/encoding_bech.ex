defmodule EncodingBech do

  defmodule Convert do
    @millisecond 1000
    @seconds @millisecond * 1000
    @minute @seconds*60
    @hour   @minute*60
    @day    @hour*24
    @week   @day*7
    @divisor [@week, @day, @hour, @minute, @seconds, @millisecond, 1]
   
    def msec_to_str(msec) do
      msec = Kernel.trunc(msec)
      {_, [us, ms, s, m, h, d, w]} =
          Enum.reduce(@divisor, {msec,[]}, fn divisor,{n,acc} ->
            {rem(n,divisor), [div(n,divisor) | acc]}
          end)
      ["#{w} wk", "#{d} d", "#{h} hr", "#{m} min", "#{s} sec", "#{ms} ms", "#{us} us"]
      |> Enum.reject(fn str -> String.starts_with?(str, "0") end)
      |> Enum.join(", ")
    end

    def to_ucs2(lib, text) do
      case lib do
          :unicode -> :unicode.characters_to_binary(text, :utf8, {:utf16, :little})
          :codepagex -> Codepagex.from_string!(text, "VENDORS/MICSFT/WINDOWS/CP1252")
          :iconv -> :iconv.convert("utf-8", "CP1252", text)
      end
    end

    def to_utf8(lib, text) do
      case lib do
          :unicode -> :unicode.characters_to_binary(text, {:utf16, :little}, :utf8)
          :codepagex -> Codepagex.to_string!(text, "VENDORS/MICSFT/WINDOWS/CP1252")
          :iconv -> :iconv.convert("CP1252", "utf-8", text)
      end
    end
  end
end
