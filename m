Return-Path: <andrew@lunn.ch>
Date: Tue, 23 Mar 2010 07:32:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100323063231.GG15823@lunn.ch>
References: <56afad541003221528w13e61637tbfdd0e0890181d88@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56afad541003221528w13e61637tbfdd0e0890181d88@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Minor change in vis.c
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Mon, Mar 22, 2010 at 05:28:07PM -0500, Nathan Wharton wrote:
> With the emphasis on minor.
> 
> Could:
> printf("\"%s\" [label=\"%d.%d\"]\n",
> be:
> printf("\"%s\" [label=\"%d.%02d\"]\n",
> instead?

What range of values can the pseudo decimal take? Is 2 digit
sufficient?

int int_part = TQ_MAX_VALUE / tq;
int frac_part = (1000 * TQ_MAX_VALUE / tq) - (int_part * 1000);

I did this using oocalc, so there is no guarantee i got the same
rounding errors as using integer arithmetic, but i did scatter a few
INT() in the calculations.

tq	int_portfrac_port
0	#DIV/0!	#DIV/0!
1	256	0
2	128	0
3	85	333
4	64	0
5	51	200
6	42	666
7	36	571
8	32	0
9	28	444
10	25	600
11	23	272
12	21	333
13	19	692
14	18	285
15	17	66
16	16	0
17	15	58
18	14	222
19	13	473
20	12	800
21	12	190
22	11	636
23	11	130
24	10	666
25	10	240
26	9	846
27	9	481
28	9	142
29	8	827
30	8	533
31	8	258
32	8	0
33	7	757
34	7	529
35	7	314
36	7	111
37	6	918
38	6	736
39	6	564
40	6	400
41	6	243
42	6	95
43	5	953
44	5	818
45	5	688
46	5	565
47	5	446
48	5	333
49	5	224
50	5	120
51	5	19
52	4	923
53	4	830
54	4	740
55	4	654
56	4	571
57	4	491
58	4	413
59	4	338
60	4	266
61	4	196
62	4	129
63	4	63
64	4	0
65	3	938
66	3	878
67	3	820
68	3	764
69	3	710
70	3	657
71	3	605
72	3	555
73	3	506
74	3	459
75	3	413
76	3	368
77	3	324
78	3	282
79	3	240
80	3	200
81	3	160
82	3	121
83	3	84
84	3	47
85	3	11
86	2	976
87	2	942
88	2	909
89	2	876
90	2	844
91	2	813
92	2	782
93	2	752
94	2	723
95	2	694
96	2	666
97	2	639
98	2	612
99	2	585
100	2	560
101	2	534
102	2	509
103	2	485
104	2	461
105	2	438
106	2	415
107	2	392
108	2	370
109	2	348
110	2	327
111	2	306
112	2	285
113	2	265
114	2	245
115	2	226
116	2	206
117	2	188
118	2	169
119	2	151
120	2	133
121	2	115
122	2	98
123	2	81
124	2	64
125	2	48
126	2	31
127	2	15
128	2	0
129	1	984
130	1	969
131	1	954
132	1	939
133	1	924
134	1	910
135	1	896
136	1	882
137	1	868
138	1	855
139	1	841
140	1	828
141	1	815
142	1	802
143	1	790
144	1	777
145	1	765
146	1	753
147	1	741
148	1	729
149	1	718
150	1	706
151	1	695
152	1	684
153	1	673
154	1	662
155	1	651
156	1	641
157	1	630
158	1	620
159	1	610
160	1	600
161	1	590
162	1	580
163	1	570
164	1	560
165	1	551
166	1	542
167	1	532
168	1	523
169	1	514
170	1	505
171	1	497
172	1	488
173	1	479
174	1	471
175	1	462
176	1	454
177	1	446
178	1	438
179	1	430
180	1	422
181	1	414
182	1	406
183	1	398
184	1	391
185	1	383
186	1	376
187	1	368
188	1	361
189	1	354
190	1	347
191	1	340
192	1	333
193	1	326
194	1	319
195	1	312
196	1	306
197	1	299
198	1	292
199	1	286
200	1	280
201	1	273
202	1	267
203	1	261
204	1	254
205	1	248
206	1	242
207	1	236
208	1	230
209	1	224
210	1	219
211	1	213
212	1	207
213	1	201
214	1	196
215	1	190
216	1	185
217	1	179
218	1	174
219	1	168
220	1	163
221	1	158
222	1	153
223	1	147
224	1	142
225	1	137
226	1	132
227	1	127
228	1	122
229	1	117
230	1	113
231	1	108
232	1	103
233	1	98
234	1	94
235	1	89
236	1	84
237	1	80
238	1	75
239	1	71
240	1	66
241	1	62
242	1	57
243	1	53
244	1	49
245	1	44
246	1	40
247	1	36
248	1	32
249	1	28
250	1	24
251	1	19
252	1	15
253	1	11
254	1	7
255	1	3

So it looks like we need a field width of 3, not 2.

BTW: Is a TQ == 0 possible? batctl does not prevent the / 0 from
happening.

	Andrew
