Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201103220001.48909.sven@narfation.org>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103181218.56535.sven@narfation.org>
	<AANLkTinPwwPP-kP9QajcgC5+90w1x-3-wc0S3MhJdF8F@mail.gmail.com>
	<201103220001.48909.sven@narfation.org>
Date: Sun, 3 Apr 2011 23:10:20 +0200
Message-ID: <BANLkTinL7SPtofEQsacsckPqD3ySniJF_Q@mail.gmail.com>
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

Thank you very much Sven, your feedback was very helpful. i ended up
with the code below which i am still testing.

int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
{
	int i,check, count = 0;
	TYPE_OF_WORD word;

	for (i = 0; i < NUM_WORDS; i++) {
		word = seq_bits[i];
		int j = WORD_BIT_SIZE, k = 1;			

		while (j > 0 && k <= 32){			
        		check = (word & (1 << j)) >> j;		
       		 	if (check == 1)
         		   count += k;
		j--;
		k++;
		}					
	}
	return count;
}

Kind Regards
Hlabishi

On 3/22/11, Sven Eckelmann <sven@narfation.org> wrote:
> On Monday 21 March 2011 23:40:57 hlabishi kobo wrote:
> [...]
>> I actually printed the seq_bits[i] and that is basically why i used 32
>> but that was just for debugging purpose. But actually if i use
>> NUM_WORDS, my weighted sum become very small whereas if i use 32 it
>> becomes very big, trying to understand what might be causing it to be
>> that way.
>
> NUM_WORDS == amount of unsigned long/words
> WORD_BIT_SIZE == amount of bits in a unsigned long
> TQ_LOCAL_WINDOW_SIZE == sum of bits in seq_bits
>
> Nothing really fancy here.
>
>> > you only calculate the weighted sum of a single "word" (which you static
>> > casted to int....?) and not all words.
>>
>> i actually dont understand this very well, how many words does seq_bits[i]
>> have?
>
> a single "word"/unsigned long. seq_bits consist of NUM_WORDS words (words
> are
> defined in context of seq_bits as unsigned long - that's why we removed
> TYPE_OF_WORD completely and just use unsigned long).
>
> Regards,
> 	Sven
>


-- 
Kind Regards
Hlabishi I. Kobo, Mr
B S.c Computer Science (Msc)
University of the Western Cape
Bellville, Cape Town, South Africa
+27 72 840 7719
+27 21 959 2461
