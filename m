Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201104032325.56687.sven@narfation.org>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103220001.48909.sven@narfation.org>
	<BANLkTinL7SPtofEQsacsckPqD3ySniJF_Q@mail.gmail.com>
	<201104032325.56687.sven@narfation.org>
Date: Tue, 19 Apr 2011 12:21:03 +0200
Message-ID: <BANLkTikzPsh6XNUv-YkZLKmwkKZ66JraZw@mail.gmail.com>
From: hlabishi kobo <hlabishik@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org

On 4/3/11, Sven Eckelmann <sven@narfation.org> wrote:
> hlabishi kobo wrote:
>> int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
>> {
>> 	int i,check, count = 0;
>> 	TYPE_OF_WORD word;
>>
>> 	for (i = 0; i < NUM_WORDS; i++) {
>> 		word = seq_bits[i];
>> 		int j = WORD_BIT_SIZE, k = 1;
>>
>> 		while (j > 0 && k <= 32){
>
> it is wrong to assume that unsigned long is 32 bit long.

> I would doubt that it is correct to give every set bit the same weight when
> they have the the distance of sizeof(unsigned long)*8. And I cannot find a
> good reason why an "old" unsigned long should get the same weights as the
> "newest" unsigned long - at least not when the actual weights should be
> reduced for "older" bits in a single unsigned long and the overall weights
> should be monotonic decreasing with the age.
I am looking at how i can deal with this part.
 And using WORD_BIT_SIZE for j
> is
> like assuming that we only have a single unsigned long in seq_bits... which
> is
> not true for many architectures.
During the debugging i realized that this can handle more than 1
unsigned long in seq_bits, i just need to prioritize the newer ones to
the old.
> And the code is overly complicated without any good reason.
I also thought so but so that it was the simplest i could come with,
still drawing up some other ways hopefully i will improve it with
time.
> Kind regards,
> 	Sven
>

I have been doing some tests using iperf/jperf to simulate traffic
between host. The results show lot of packet loss (though
inconsistent) and i am not sure if this could be the results of
overheads in the network. Is there anyway i could debug the amounts of
overheads on the network? What testing methods do you and your team
use?

-- 
Kind Regards
Hlabishi I. Kobo, Mr
Computer Science (Msc)
University of the Western Cape
Bellville, Cape Town, South Africa
+27 72 840 7719
+27 21 959 2461
