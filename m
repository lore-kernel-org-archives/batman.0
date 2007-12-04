From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Date: Tue, 4 Dec 2007 13:37:17 +0100
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<20071202043216.GB3923@apoderado.ometepe.net>
	<200712041101.06161.axel@open-mesh.net>
In-Reply-To: <200712041101.06161.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200712041337.17976.axel@open-mesh.net>
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

>
> Still I could not yet reproduce the problem but I am quite sure
> that this has something to do with the msn&co.coms' reluctance to
> respond to icmp messages.

Well, after a while my office colleague did.

Actually, it took me a while to understand that my experiments on our office 
server and his annoyance about an "unstable" imap account had something in 
common :-(

The only solution we found to circumvent such small-mtu paths was:
- avoid related web services OR (not so good)
- Use openvpn over the path with the reduced mtu. Seems like openvpn fragments 
and de-fragments the packets transparently between related end2end tun0 
interfaces. This even worked on his windows machine. 

Perhaps this might also become an outlook-item for the next batman tunnel 
implementation :-)

ciao,
axel

>
> ciao,
> axel
>
> > cheers
> >
> >   --Jan
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


