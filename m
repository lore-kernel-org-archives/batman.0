From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] adding network announce
Date: Sun, 18 Nov 2007 11:37:39 +0100
References: <20071117191401.GA4836@apoderado.ometepe.net>
In-Reply-To: <20071117191401.GA4836@apoderado.ometepe.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711181137.39473.axel@open-mesh.net>
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

On Samstag 17 November 2007, Jan Hetges wrote:
> Hi
> is that supposed to work?
> at least, first it says it does, but second it doesn't:
> root@bla:~# bmxd -c -a 172.16.x.x/32
> WARNING: You are using BatMan-eXp 0.3-alpha rv802 (compatibility version 9)
> ! adding HNA 172.16.x.x/32, atype 1
> bmxd -r 3 -a 172.17.x.x/24 eth1:bmx
No, that does not (yet) work - even if it says so :-(
So fare you can only define HNA announcements during startup.
Actually, other people have also asked for exactly this feature. The 
preparations to support dynamic add-and-removal of HNA announcement with -c 
is almost done and I think this can be supported soon.

ciao,
axel

>
> (172.17.x.x/24 is the network already announced at startup)
that should be just fine.
>
> cheers
>
>   --Jan


