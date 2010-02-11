Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 11 Feb 2010 17:20:16 +0800
References: <20100208193848.GA8545@Sellars>
	<20100211022543.GA6493@Linus-Debian>
In-Reply-To: <20100211022543.GA6493@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201002111720.16266.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] race condition with activate_module?
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

>I think I've seen this bug a couple of times but I've never been
>able to reproduce it. Now I added a little patch to slow down the
>activate_module() procedure and the bug occures every time now. My
>question is, did I make a race condition apparent or did I introduce
>a bug with this patch?

the race condition existed before - you just make it more visible. No matter 
how slow the code is being processed it should not lead to a crash.


> Okay, I could narrow it down a little further: There is a problem
> with the num_ifs variable. When activate_module() gets called in
> proc_interfaces_write() and an ogm of a neighbour arrives after
> this for the first time but before we've set 'num_ifs = if_num + 1;',
> then we're not allocating enough space in get_orig_node(), leading
> to a kernel panic.

I think you managed to uncover 2 race conditions:
* receiving a packet before the module is fully initialized
* concurrent activate_module() calls

Better than introducing some locking code which would need to halt the whole 
module we should make sure that batman-adv does not process packets before its 
initialization is complete.

Regards,
Marek
