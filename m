Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 17 Jan 2012 07:00:12 +0800
References: <1326223162-15181-1-git-send-email-sven@narfation.org>
In-Reply-To: <1326223162-15181-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201201170700.13365.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: Replace bitarray operations
	with bitmap [aka. lets break batman-av]
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


Hi,

> bitarray.c consists mostly of functionality that is already available as
> part of the standard kernel API. batman-adv could use architecture
> optimized code and reduce the binary size by switching to the standard
> functions.

it took some time to read about the kernel bit functions but I think this is 
the right way to go. From my end it looks pretty solid. Though I have 2 
comments:
 * get_bit_status()/bit_mark()/bit_shift() now are wrapper functions of the 
linux kernel functions with an additional check. How about we follow the 
kernel naming convention plus a small prefix ? For example: 
bat_test_bit()/bat_set_bit()/bat_bitmap_shift_left() ? We probably could also 
inline those 3 functions since they don't do much.
 * Am I right assuming that you did not find something nice / handy for our 
bitarrays bcast_own/bcast_own_sum ? At the moment we deal with them in a 
"manual" fashion ..

Cheers,
Marek


