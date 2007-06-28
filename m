From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] securing batman gateway
Date: Thu, 28 Jun 2007 15:46:03 +0200
References: <2bda28cd0706260823h3c1e4d78m27f8eb9809e655cd@mail.gmail.com>
	<200706271208.19749.lindner_marek@yahoo.de>
	<46839CDF.30106@dd19.de>
In-Reply-To: <46839CDF.30106@dd19.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706281546.03324.lindner_marek@yahoo.de>
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


> What is lightweight encryption? Does lightweight means insecure?

No. I don't know how much you know about encryption technologies but let me 
tell you that there is technologly which works better on embedded devices 
than other technologly. Simply because it was optimized for that purpose. 
Using a CPU intense encryption does not make the communication more or less 
insecure. The key is the overall security concept.
Since the focus of batman are embedded devices it seems obvious that we should 
choose that direction.


> Is it easier, because you are not familiar with IPSEC?

You misunderstand. It is not a question of you and me. There are people in 
this world who would like to use batman / mesh technology without being an IT 
expert. That applies to most of our users ...


> building unsecure crypto ist worse then having no crypto, it would be a
> "sicherheitsimulation". building strong crypto is not easy, so many
> failed to develop and implement it with more and better
> cryptospecialists the the batman team has.

I totally agree. I never proposed to reinvent the wheel by building our own 
encryption technology. I'm well aware of the many issues which arise once you 
choose that path. 


> Some batman developer once told me, that implementing/supporting service
> discovery inside batman is a bad idea, as they want to have batman as
> slim as possible. how does integrating cryptotunnels in a routingprotocol
> does get conform to that?

I don't see the connection between your example and the current context. 
Batman already builds that tunnel. Why should we not extend that existing 
feature ? Sure, you could create another tunnel in the tunnel.
The question is whether we give the ordinary user a tool at hand which enables 
him to control the access of his internet gateway. What do you think ?

Regards,
Marek

