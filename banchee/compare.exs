alias EncodingBech.Convert

lorem = "Lorem Ipsum is simply dummy text of the printing and typesetting industry." <> 
        " Lorem Ipsum has been the industry's standard dummy text ever since the " <>
        "1500s, when an unknown printer took a galley of type and scrambled it to " <>
        "make a type specimen book. It has survived not only five centuries, but " <>
        "also the leap into electronic typesetting, remaining essentially unchanged. " <> 
        "It was popularised in the 1960s with the release of Letraset sheets containing " <>
        "Lorem Ipsum passages, and more recently with desktop p"

size = 2_000_000
chunks = Kernel.trunc(size / String.length(lorem))
text = Enum.map(1..chunks, fn _ -> lorem end) |> IO.iodata_to_binary()

Benchee.run(%{

        "conver to and from" => fn lib ->
            text_ucs2 = Convert.to_ucs2(lib, text) 
            Convert.to_utf8(:iconv, text_ucs2)
        end


    }, 
    parallel: 8, 
    inputs: %{"iconv" => :iconv, "codepagex" => :codepagex, "unicode" => :unicode}
)