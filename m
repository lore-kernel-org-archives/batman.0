Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201103181218.56535.sven@narfation.org>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201103081052.58143.sven@narfation.org>
	<AANLkTiniFmA3qES=1vfU_Y6Y+aMgTXzTOnDdSkpndxVX@mail.gmail.com>
	<201103181218.56535.sven@narfation.org>
Date: Tue, 22 Mar 2011 00:40:57 +0200
Message-ID: <AANLkTinPwwPP-kP9QajcgC5+90w1x-3-wc0S3MhJdF8F@mail.gmail.com>
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

On 3/18/11, Sven Eckelmann <sven@narfation.org> wrote:
> On Thursday 17 March 2011 23:40:06 hlabishi kobo wrote:
>> Hi thank you very much for your suggestions Sven, they were really
>> helpful. i actually now put the below code down which i am still busy
>> trying to test it.
>>
>> int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
>> {
>> 	int i,check, count = 0;
>> 	int j;
>> 	//TYPE_OF_WORD *word;
>> 	int word;
>>
>> 	for (i = 0; i < NUM_WORDS; i++) {
>> 		word = seq_bits[i];
>>
>> 		for (j = 0; j < 32; j++){
>>         		check = (word & (1 << j)) >> j;
>>        		 	if (check == 1)
>>          		   count += j;
>> 		}
>> 	printk("our count is %d\n", count);
>> 	return count;
>> 	}
>> 	//printk("our count is %d\n", count);
>> 	//return count;
>> }
>> When i am using it on two PC's my ping seems to be recording much
>> delay. I will appreciate your feedback in this regard.
>> Thank you and kind Regards
>

Thank you very much Sven. Your feedback have been really helpful.

> Ehrm, you know that you ignore the fact that seq_bits[i] may be 64 bits?
I actually printed the seq_bits[i] and that is basically why i used 32
but that was just for debugging purpose. But actually if i use
NUM_WORDS, my weighted sum become very small whereas if i use 32 it
becomes very big, trying to understand what might be causing it to be
that way.
And
> you only calculate the weighted sum of a single "word" (which you static
> casted to int....?) and not all words.
i actually dont understand this very well, how many words does seq_bits[i] have?
 And the sum is still wrong weighted
> (you still give zero weight for the newest one and increase the weight for the older).
Thanks for letting alerting me about this, i hv now changed from
ascending to descending order.
 And the way you check the bits is even for a sequential
> implementation
> overly complex. And it is normal that printk heavily increase the amount of
> time... maybe you meant that by delay.
even if i comment out the printk() statement its still carries with the delay.
> Sry, I have really no idea what I should say to it.
>
> Regards,
> 	Sven
>

Kind Regards
Hlabishi
