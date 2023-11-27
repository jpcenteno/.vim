local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
    s({ trig = "modtest", dscr = "Test module" },
        fmt(
            [[
                #[cfg(test)]
                mod test {
                    use super::*;

                    <>
                }
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    ),
    s(
        { trig = "print_debug", dscr = "Debug print a value" },
        fmt(
            [[
                println!("{:#?}", <>);
            ]],
            { i(1) },
            { delimiters = "<>" }
        )
    )
}
