From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Newbe - almost have batman up and running (almost)
Date: Mon, 17 Nov 2008 10:21:07 +0800
References: <60517.149.5.32.200.1226874708.squirrel@www.rivertowermail.com>
	<48220.149.5.32.200.1226875683.squirrel@www.rivertowermail.com>
In-Reply-To: <48220.149.5.32.200.1226875683.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200811171021.07265.lindner_marek@yahoo.de>
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

On Monday 17 November 2008 06:48:03 Derek C wrote:
> Please ignore my message - I [rather stupidly] forgot to put a MASQUERADE
> rule into my gateway batmand board.  I put that in and was working!
>
> looking good (and very easy!) so far

Glad that you made it. Nat is often forgotten. I have an idea how to remove 
that masquerading problem but did not find the time to work on it.


> > I see that there is indeed a "gate0" tunnel NIC created and although I
> > don't see a new default route if I run "ip route list table 68" I CAN see
> > a line "default dev gate0  proto static  scope link  src 169.254.0.1".

That is the default route. It simply ends in a device instead of pointing 
towards a router.


> > Still - I don't much like the look of that 169.254.0.1 IP address ?

Also fine here. Batman uses these IP address space for its internal tunneling.


Regards,
Marek

