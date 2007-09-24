From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 alpha (today revison)
Date: Mon, 24 Sep 2007 20:58:02 +0200
References: <840E3F681DF3D043B353C0FDD4A6C3533F76B8@ex9.hostedexchange.local>
In-Reply-To: <840E3F681DF3D043B353C0FDD4A6C3533F76B8@ex9.hostedexchange.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200709242058.02187.lindner_marek@yahoo.de>
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


Hi,

> I hate to bother you but you were so responsive before...

no problem - I'm here.  :-)


> Antonio just put up a post.  We are both seeing the same problem -
> computers associated with repeaters on 0.3 (MIPS) can't browse.  But ssh
> into that node and do a wget and it works great!.  If we just replace
> 0.3 with 0.2 all works again.

From the client associated to AP_n you can ssh to your gateway ? Than you have 
a problem with your internet tunnel.


> Also, I am tracking memory and see it dropping steadily on the nodes
> (500k in about 12 hours).  This didn't happen with 0.2 and that is all
> that has changed.

What do you mean with "memory and see it dropping steadily" ?


> Is there any way you can look into this ASAP?  We are very close to
> having to give code to our supplier for the routers and we would very
> much like to ship with 0.3 rather than 0.2.

And you are sure to preinstall 0.3 ? It is not stable yet. There are a bunch 
of things to come soon: improved blackhole detection, BATMAN IV, a kernel 
modul for faster tunneling, bugfixes, etc ...
Especially the experimental branch is packed with a lot of additional testing 
features. I don't know wether it is wise to ship that ...


> FYI, we sent you 6 merakis today.  I'll get you a tracking number
> shortly.

Great - thanks.

Regards,
Marek

