Return-Path: <michael.rack@rsm-freilassing.de>
Message-ID: <4AA39E02.7030201@rsm-freilassing.de>
Date: Sun, 06 Sep 2009 13:33:22 +0200
From: Michael Rack <michael.rack@rsm-freilassing.de>
MIME-Version: 1.0
References: <4AA34865.9000203@rsm-freilassing.de>
	<200909061250.40558.onelektra@gmx.net>
In-Reply-To: <200909061250.40558.onelektra@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Problems with Gateway-Selection without option -g
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

Hi Elektra,

thanks for your trick. This trick works for me, but it is a bad solution 
:-) I switched back to OLSR, although i like the concept of BATMAN more 
then that of OLSR.

Announcing 0.0.0.0/0 can really be a problem, but why does BATMAN tunnel 
the internet-traffic through gate0?

It will be nice, if there will be a option in the next release, where 
users can decide to use routing or tunneling internet-traffic.

Cheers,
Michael.

Am 06.09.2009 12:50, schrieb elektra:
> Hello Michael!
>
> Batmand checks and deliberately blocks users from announcing 0.0.0.0/0 - this
> could cause the notorious black-hole problem we have experienced in the old
> days when using OLSR. Also we think it is important that we can explicitly
> tell a Batman node to use Internet gateway functionality or not.
>
> Default routes in a mesh can be really annoying and break network
> functionality. If you only have one default gateway in your Batmand network
> and really know what you are doing you can actually override this check with a
> simple trick.
>
> As a workaround you can announce two subnetworks 0.0.0.0/1 and 128.0.0.0/1
> instead of 0.0.0.0/0.
>
> batmand -a 0.0.0.0/1,128.0.0.0/1<your interface>
>
> Cheers,
> Elektra
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@lists.open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

