Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Feb 2010 19:09:52 +0800
References: <4B6F288E.8050406@muc.ccc.de> <20100211023909.GB6493@Linus-Debian>
	<4B740D82.3030101@muc.ccc.de>
In-Reply-To: <4B740D82.3030101@muc.ccc.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201002121909.52617.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv 0.2 on openwrt
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

On Thursday 11 February 2010 22:00:34 x@muc.ccc.de wrote:
> i guess this needs a kernel compile, just compiling the module after
>  setting these options will probably not work or not help? i can't compile
>  a kernel for the box because i wasn't able to find the config and possible
>  patches used to build the cambria kernel, so i'm currently kind of stuck
>  with the released 8.09.2 binary kernel...

You can try only recompiling the module. Not sure whether it will work or not.
Otherwise we have to fallback to the old-style (printk) debugging.  :-)

Cheers,
Marek
