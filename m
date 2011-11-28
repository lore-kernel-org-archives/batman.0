Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 03:42:30 +0800
References: <201111290028.01655.lindner_marek@yahoo.de>
	<20111128184722.GC13600@lunn.ch>
In-Reply-To: <20111128184722.GC13600@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201111290342.31065.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: switch routing algorithm at
	runtime
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


Andrew,

> I would suggest looking at some other modular system. Generally the
> core offers a _register() and a _unregister() function. The module
> implementing an algorithm would call the _register function in its
> module_init function and the _unregister in module_exit function. It
> also makes sense to have a naming scheme for these modules. It then
> becomes possible to use hotplug to load algorithms dynamically, when
> userspace requests an algorithm which is not already loaded. I guess
> you first need an algorithm when the soft interface is taken up. If
> you don't have an algorithm loaded at that point, it makes sense to
> have a hard coded (or maybe menuconfig) default algorithm, which you
> try to load via hotplug.

not sure where we got out of alignment. If you check the patches you will see 
that it is a modular design. As I described in my initial mail, each routing 
algorithm is supposed to register itself. The functions / default algorithm / 
etc already there ..

And no, I am not going to implement a hotplugging system. At first I wanted a 
compile time option before I was convinced to work on a system which allows to 
switch the routing algorithm at runtime. This is as far as I will go. Feel 
free to propose your own patches if want this feature.


> > * The API and its implementation. It is highly likely that this API won't
> > survive for very long as it has been designed to satisfy one routing
> > algorithm only. However, changing it in the future should be easy.
> 
> It would be good to comment in the header file which functions can be
> NULL and which must be implemented. It would be best to assume that
> new methods added from now on will be NULL in older algorithms. There
> are a few options for handling this. Check the method is not NULL
> before calling it. Or the _register function can replace each NULL
> with a nop function and throw an BUG_ON() when a must have function is
> NULL.

All functions are checked right now and all functions can be NULL. 
Check the patch #2 ...

Cheers,
Marek
