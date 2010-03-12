Return-Path: <andrew@lunn.ch>
Date: Fri, 12 Mar 2010 08:45:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100312074552.GE29010@lunn.ch>
References: <1268325529-10998-1-git-send-email-linus.luessing@web.de>
	<201003112306.48652.sven.eckelmann@gmx.de>
	<201003112333.15318.sven.eckelmann@gmx.de>
	<201003120004.48753.sven.eckelmann@gmx.de>
	<20100312000931.GB13786@Linus-Debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100312000931.GB13786@Linus-Debian>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fixing wrap-around bug in vis
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

On Fri, Mar 12, 2010 at 01:09:31AM +0100, Linus L??ssing wrote:
> Sorry still does not seem to work :). Despite testing it on a
> setup in batman itself I also tested it with a small c program
> (which does not work as expected either):
> -----
> #include <stdio.h>
> #include <stdint.h>
> 
> #define seq_before(x,y) ((x - y) > 1 << 7 + 8 * (sizeof(x) - 1))
> #define seq_after(x,y) ((y - x) >= 1 << 7 + 8 * (sizeof(x) - 1))
> 
> int main() {
>         uint8_t old = 0;
>         uint8_t new = 1;
>         if (!seq_after(new,old))
>                 printf("foobar\n");
> 
>         return 0;
> }

It is worth taking a look at include/linux/jiffies.h. The macros
time_after(), time_after_eq() etc.

	      Andrew
