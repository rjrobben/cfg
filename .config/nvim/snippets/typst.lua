return {
		-- sub super scripts
		s({ trig='(%a)(%d+)', regTrig=true, name='auto subscript', dscr='hi'},
			fmt([[<>_<>]],
			{ f(function(_, snip) return snip.captures[1] end),
			f(function(_, snip) return snip.captures[2] end) },
			{ delimiters='<>' })),

		-- subscript with e.g. A_1
		s({ trig='([A-Za-z]+)_', regTrig=true,  name='auto subscript 2', dscr='dscr'},
		fmt([[<>_(<>)]],
		{ f(function(_,snip) return snip.captures[1] end),
		i(0)},
		{ delimiters='<>' }
		)),

		-- 2x2
		s({ trig='tbl2x2', name='2x2 table'},
		  fmt([[
		#table(
		  columns: 2,
		  [<>], [<>],
		  [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4) },
		  { delimiters='<>' }
		)),

		-- 2x3
		s({ trig='tbl2x3', name='2x3 table'},
		  fmt([[
		#table(
		  columns: 3,
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6) },
		  { delimiters='<>' }
		)),

		-- 3x2
		s({ trig='tbl3x2', name='3x2 table'},
		  fmt([[
		#table(
		  columns: 2,
		  [<>], [<>],
		  [<>], [<>],
		  [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6) },
		  { delimiters='<>' }
		)),

		-- 3x3
		s({ trig='tbl3x3', name='3x3 table'},
		  fmt([[
		#table(
		  columns: 3,
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9) },
		  { delimiters='<>' }
		)),

		-- 3x4
		s({ trig='tbl3x4', name='3x4 table'},
		  fmt([[
		#table(
		  columns: 4,
		  [<>], [<>], [<>], [<>],
		  [<>], [<>], [<>], [<>],
		  [<>], [<>], [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12) },
		  { delimiters='<>' }
		)),

		-- 4x3
		s({ trig='tbl4x3', name='4x3 table'},
		  fmt([[
		#table(
		  columns: 3,
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		  [<>], [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12) },
		  { delimiters='<>' }
		)),

		-- 4x4
		s({ trig='tbl4x4', name='4x4 table'},
		  fmt([[
		#table(
		  columns: 4,
		  [<>], [<>], [<>], [<>],
		  [<>], [<>], [<>], [<>],
		  [<>], [<>], [<>], [<>],
		  [<>], [<>], [<>], [<>],
		)]], 
		  { i(1), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9), i(10), i(11), i(12), i(13), i(14), i(15), i(16) },
		  { delimiters='<>' }
		)),

		s({ trig='tblr', name='consequence table'},
		  fmt([[
		#table(
		  columns: (1fr, 1fr, 1fr, 1fr, 1fr),
		  [problem], [❗], [🥬], [✅], [💭],
		  [<>], [<>], [<>], [<>], [<>],
		  [後果], [<>], [<>], [<>], [<>],
		)]], 
		  { i(1, "A1"), i(2), i(3), i(4), i(5), i(6), i(7), i(8), i(9) },
		  { delimiters='<>' }
		)),

		-- A. Evoke details
		s({ trig='mra', name='mindful review A'},
		  fmt([[
		= A. Evoke the details during the event
		#text(fill: gray)[(thoughts and emotions)]
		<>
		]], 
		  { i(1) },
		  { delimiters='<>' }
		)),

		-- B. Mindfulness check
		s({ trig='mrb', name='mindful review B'},
		  fmt([[
		= B. 有幾 mindful?
		#text(fill: gray)[(where attention)]
		<>
		#text(fill: gray)[(larger situation)]
		<>
		#text(fill: gray)[(introspective awareness)]
		<>
		]], 
		  { i(1), i(2), i(3) },
		  { delimiters='<>' }
		)),

		-- C. Consequences
		s({ trig='mrc', name='mindful review C'},
		  fmt([[
		= C. 有咩後果?
		#text(fill: gray)[(immediate and subsequent)]
		<>
		#text(fill: gray)[(how affect you now)]
		<>
		#text(fill: gray)[(happy? worth it?)]
		<>
		]], 
		  { i(1), i(2), i(3) },
		  { delimiters='<>' }
		)),

		-- D. Regret, Resolve, Recompense
		s({ trig='mrd', name='mindful review D'},
		  fmt([[
		= D. Regret, Resolve, Recompense
		#text(fill: gray)[(want to respond differently?)]
		<>
		#text(fill: gray)[(greater mindfulness improves?)]
		<>
		#text(fill: gray)[(If so, form a strong resolve to bring more mindfulness to similar situations in the future.)]
		#text(fill: gray)[Not a place for guilt and self blame here. Be compassionate.]
		<>
		]], 
		  { i(1), i(2), i(3) },
		  { delimiters='<>' }
		)),

		-- E. Detect craving
		s({ trig='mre', name='mindful review E'},
		  fmt([[
		= E. Detect the craving behind the act or mental state
		<>
		]], 
		  { i(1) },
		  { delimiters='<>' }
		)),

		-- F. Attachment to Self
		s({ trig='mrf', name='mindful review F'},
		  fmt([[
		= F. See if you can tell how this craving is driven by attachment to the belief in separate Self whose happiness comes from the outside
		#text(fill: gray)[(If this is different, then I will be happy.)]
		<>
		#text(fill: gray)[(Assumption that our happiness depends on satisfying our cravings)]
		<>
		#text(fill: gray)[(Does the attachment tend to increase or decrease your suffering?)]
		<>
		#text(fill: gray)[(Can you renounce that belief?)]
		<>
		]], 
		  { i(1), i(2), i(3), i(4) },
		  { delimiters='<>' }
		)),

		-- G. Wholesome intentions
		s({ trig='mrg', name='mindful review G'},
		  fmt([[
		= G. Reflect on how the craving could have been replaced by more wholesome and selfless intentions
		<>
		]], 
		  { i(1) },
		  { delimiters='<>' }
		)),



}
