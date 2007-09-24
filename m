Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [B.A.T.M.A.N.] 0.3 alpha (today revison)
Date: Mon, 24 Sep 2007 11:32:55 -0700
Message-ID: <840E3F681DF3D043B353C0FDD4A6C3533F76B8@ex9.hostedexchange.local>
In-Reply-To: <200709222051.41244.lindner_marek@yahoo.de>
From: "Michael Burmeister-Brown" <mike@netequality.org>
Content-Transfer-Encoding: 8bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Marek,

I hate to bother you but you were so responsive before...

Antonio just put up a post.  We are both seeing the same problem -
computers associated with repeaters on 0.3 (MIPS) can't browse.  But ssh
into that node and do a wget and it works great!.  If we just replace
0.3 with 0.2 all works again.

Also, I am tracking memory and see it dropping steadily on the nodes
(500k in about 12 hours).  This didn't happen with 0.2 and that is all
that has changed.

Is there any way you can look into this ASAP?  We are very close to
having to give code to our supplier for the routers and we would very
much like to ship with 0.3 rather than 0.2.

Thank you for your help!

FYI, we sent you 6 merakis today.  I'll get you a tracking number
shortly.

Mike

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Marek Lindner
Sent: Saturday, September 22, 2007 11:52 AM
To: The list for a Better Approach To Mobile Ad-hoc Networking
Subject: Re: [B.A.T.M.A.N.] 0.3 alpha (today revison)

Am Samstag, 22. September 2007 20:00:04 schrieb
a.anselmi@oltrelinux.com:
> great work Marek,
> now client can ping outside mesh obtaining the correct IP from
gateway.
> Thanks!

Goooood. This makes the weekend even better.  ;-)


> Still remain the minor problem in arrangement of IPIPA subnet mask:
> 169.254.0.0/16 on clients
> 169.254.0.0/24 on gateway

I don't know where you can see that. The tun interface is a point to
point 
connection ...


Greetings,
Marek


PS: 2 hours reponse time isn't that bad, is it ?  :)
_______________________________________________
B.A.T.M.A.N mailing list
B.A.T.M.A.N@open-mesh.net
https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

