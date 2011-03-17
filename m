Return-Path: <hlabishik@gmail.com>
MIME-Version: 1.0
In-Reply-To: <201103081052.58143.sven@narfation.org>
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<201102282029.05802.sven@narfation.org>
	<AANLkTikj8oj26P_F1LTiGWnt2R=29VESfpD1ZsfeL4X0@mail.gmail.com>
	<201103081052.58143.sven@narfation.org>
Date: Fri, 18 Mar 2011 00:40:06 +0200
Message-ID: <AANLkTiniFmA3qES=1vfU_Y6Y+aMgTXzTOnDdSkpndxVX@mail.gmail.com>
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

Hi thank you very much for your suggestions Sven, they were really
helpful. i actually now put the below code down which i am still busy
trying to test it.

int weighted_bit_packet_count(TYPE_OF_WORD *seq_bits)
{
	int i,check, count = 0;
	int j;
	//TYPE_OF_WORD *word;
	int word;

	for (i = 0; i < NUM_WORDS; i++) {
		word = seq_bits[i];
		
		for (j = 0; j < 32; j++){			
        		check = (word & (1 << j)) >> j;
       		 	if (check == 1)
         		   count += j;
		}
	printk("our count is %d\n", count);
	return count;				
	}
	//printk("our count is %d\n", count);
	//return count;
}
When i am using it on two PC's my ping seems to be recording much
delay. I will appreciate your feedback in this regard.
Thank you and kind Regards
Hlabishi

On 3/8/11, Sven Eckelmann <sven@narfation.org> wrote:
> On Monday 07 March 2011 22:00:25 hlabishi kobo wrote:
>> Linus suggested to me that i should print the window and see how it
>> looks, I did that and it returns this ef0fffffe, ffbffff, f70fffff,
>> eb1b53c0, eb3950b8, eb1749c0. I am not sure if this are hexadecimal
>> number or what.
>
> I would think that you wrote the part which prints out this values. This
> means
> that you know which parameters you gave printk and that you should know the
> conversation specifiers and length modifiers that you used in the format
> string.
>
> But I would guess without having any of these information that you used %x
> to
> print these values. Whatever you used as argument - 32 bit (size of single
> int) of it were printed in unsigned in hexidecimal notation. Maybe you
> should
> think about using %lx to print unsigned long ints in hexidecimal notation in
> case you really used %x.
>
> Which brings me to another question: Why to I see 6 numbers in your post and
> why has the first one 9 nibbles?
>
> As said before (and also recommended by Linus): try to write a small c
> program
> which uses these values, print the single bits, try to write some test
> algorithm using these decoded bits and play a little bit around with other
> test inputs before trying random things inside the kernel.
>
>> Again this is the results of printing seq_bits, so far
>> i have not been able to print real_bits as this cannot even make a
>> network ping. Could you enlighten me in this case.
>
> I cannot understand how pings and printks are related...
>
>
> May I ask how these things are related to your work/studies? It is ok to
> play
> around a little bit as small side project/hobby without having the time and
> knowledge to understand what you are really doing. That is usually a good
> way
> to find new interesting topics and maybe to learn something (or blow up a
> building...). But I would highly recommend to switch the topic in case this
> is
> part of your thesis or work.
>
> It is not meant as harsh criticism of what you try to do, but it seems that
> right now you aren't able to efficiently work with it and to gain enough
> knowledge by yourself to be able to understand simple parts the thing you
> are
> working with.
>
> Best regards,
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
