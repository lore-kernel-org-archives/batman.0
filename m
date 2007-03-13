From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] protocol performance
Date: Tue, 13 Mar 2007 14:34:58 +0100
References: <200703131145.07614.atis@mikrotik.com> <45F69EA5.6020505@gmx.net>
In-Reply-To: <45F69EA5.6020505@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703131434.58305.lindner_marek@yahoo.de>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net


Hi,


> After studying the source code, I understand that HNA information is
> included  in every originator message. Isn't such excessive amount of
> routing  information bad for typically limited-capacity wireless links?

> And if you concerned about its performance, too -  have you considered using 
> Fish-eye to improve the algorithm?

Please keep in mind that you will experience packet loss. After 2-3 hops only 
a few packets get rebroacasted. 
In other words: B.A.T.M.A.N. already has Fish-eye because only the direct 
neighbours get most of the packets. With each hop the numbers of retramsitted 
packets decreases due to packet loss.


> > And, finally, what exactly is batman-experimental?
>
> Basically Batman with layer 2.5 routing.  The very first implementation
> is already available in SVN.  It will use algorithm mark IV. Mark IV
> will also be available for layer 3.

batman-experimental is a testbed for future improvements of the B.A.T.M.A.N. 
protocol. Here we experiment with certain ideas. Do not use it in a 
production environment.

batman is the implemantation of B.A.T.M.A.N. on layer 3. It is pretty stable 
and usable.

batman-advanced is B.A.T.M.A.N.on layer 2. Its code is based on batman but it 
is fairly new. Expect heavy developement in this branch.

Regards,
Marek
