Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Apr 2010 15:55:59 +0800
References: <20100425165152.GA1577@pandem0nium>
	<201004252248.20341.sven.eckelmann@gmx.de>
In-Reply-To: <201004252248.20341.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201004261555.59856.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] 32bit sequence number and TTL for
	broadcasts
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

On Monday 26 April 2010 04:48:13 Sven Eckelmann wrote:
> First thing: it doesn't compile here :( (UML), but I am quite unsure if
>  this is a UML problem like many other things or a bigger problem.... it
>  seems that it is uml specific as ATOMIC64_INIT and other thingss are
>  defined, but the implementation of specific functions are missing... but
>  this is not the first time such thing happens with uml. Maybe someone with
>  some time can check different openwrt builds.
> 
> For example other architecture seems to use the generic implementation of
>  it: * arm
>  * parisc
>  * powerpc
>  * sh

I think Sven got a point here. It seems that for atomic64_t to work one needs 
a CPU which supports 64Bit operations otherwise the linux kernel will use its 
generic implementation. Apparently it uses an array of 16 spinlocks to provide 
this functionality. I wonder whether this might be a lot of overhead for our 
needs. Furthermore the generic implementation was added recently (as far as I 
can tell 2.6.30 does not have it) which raises the question of backward 
compatibility.

Regards,
Marek
