Return-Path: <davem@davemloft.net>
Date: Wed, 01 Dec 2010 10:43:14 -0800 (PST)
Message-Id: <20101201.104314.112592938.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1289136377-18350-1-git-send-email-sven.eckelmann@gmx.de>
References: <1289136377-18350-1-git-send-email-sven.eckelmann@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv6] net: Add batman-adv meshing protocol
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
To: sven.eckelmann@gmx.de
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sun,  7 Nov 2010 14:26:17 +0100

> +		if (seq_bits[word_num] & 1 << word_offset)
 ...
> +	seq_bits[word_num] |= 1 << word_offset;	/* turn the position on */
 ...
> +#define TYPE_OF_WORD unsigned long

"1" is an 'int' and won't get promoted to unsigned long which means
this code won't work on 64-bit, you need to explicitly say "1UL".

This seems to duplicate a lot of existing functionality, we have
properly bit set/clear/change/test routines, that operate on
"unsigned long" just as your code does.

And since you don't use the existing facilities, you end up with
bugs like this one.  Bug which are completely unnecessary.

The badman-adv code is full of duplicated functionality, and until
all of these cases are cured I refuse to integrate this code.  I
already complained about the hashing stuff, and now there's this
stuff too.

Every time I review the batman-adv code I find a bug, and the bug is
often in facilities which the kernel has already and are being
duplicated.  That is by definition a waste of my and everyone else's
time.

Probably your submission will be almost half the size that it is
currently once you take care of this issue. :-)

