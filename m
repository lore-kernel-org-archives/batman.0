Return-Path: <andrew@lunn.ch>
Date: Mon, 28 Nov 2011 19:47:22 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20111128184722.GC13600@lunn.ch>
References: <201111290028.01655.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201111290028.01655.lindner_marek@yahoo.de>
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

Hi Marek

>  * How do we design the algorithm registration. At the moment batman_init() 
> calls bat_iv_init() and possibly other algorithms in the future but this is 
> less than ideal. I had hoped to find a mechanism which allows an init function 
> to be declared and called inside of the respective routing algorithm files. 
> These files can be compiled into the module or not.

I would suggest looking at some other modular system. Generally the
core offers a _register() and a _unregister() function. The module
implementing an algorithm would call the _register function in its
module_init function and the _unregister in module_exit function. It
also makes sense to have a naming scheme for these modules. It then
becomes possible to use hotplug to load algorithms dynamically, when
userspace requests an algorithm which is not already loaded. I guess
you first need an algorithm when the soft interface is taken up. If
you don't have an algorithm loaded at that point, it makes sense to
have a hard coded (or maybe menuconfig) default algorithm, which you
try to load via hotplug.

> * The API and its implementation. It is highly likely that this API won't 
> survive for very long as it has been designed to satisfy one routing algorithm 
> only. However, changing it in the future should be easy.

It would be good to comment in the header file which functions can be
NULL and which must be implemented. It would be best to assume that
new methods added from now on will be NULL in older algorithms. There
are a few options for handling this. Check the method is not NULL
before calling it. Or the _register function can replace each NULL
with a nop function and throw an BUG_ON() when a must have function is
NULL.

	Andrew
