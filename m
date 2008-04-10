Subject: Re: [B.A.T.M.A.N.] AHdemo mode
Content-Disposition: inline
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 10 Apr 2008 17:41:03 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200804101741.03733.lindner_marek@yahoo.de>
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



> still that can be better than no security at all...

I think before you start throwing crypto, keys, certificates, etc on something 
you/we should evaluate whether there are others ways.
Also, it is important to realize that encryption itself does not make things 
secure (encryption != security). If we start talking about "no security at 
all" I'd rather ask first what we are securing and against whom ...


> i basically agree, but some people might like to set up a more controlled
> environment. even in a community network this might be useful at times, for
> example if you want to set up a backbone network.

So, we are starting to talk about these rare cases, right ?


> one way to solve this without a static key which has to be known to all
> nodes is using a public key infrastructure (PKI) with a certificate
> authority (CA). the clients can generate their own private and public keys
> and send the public key to be signed by the CA. that could go hand in hand
> with adding their nodes to a map and accepting some basic agreement (pico
> peering). after it has been signed they could start using encryption for an
> extra level of mesh security.

I think many things would be _possible_ but I don't see that happen. But why 
everything has to be so complicated ? Do you read that: static key, PKI, CA, 
private and public keys, signed by the CA, ....
Only a few people master this kind of security properly. The only end user PKI 
that "works" out there are web certificates and their level of security is 
more ashaming.


> that's true, but it doesn't help if the underlying mesh protocol can be
> disturbed easily by un-authenticated nodes and your traffic never reaches
> the other endpoint.
>
> there are two different layers of adding authentication and encryption. one
> is the mesh protocol itself the other one is end-to-end user encryption.
> both are necessary if you want to make your network secure.

I can't agree here. I believe a well designed mesh protocol which is more 
resistant out of the box is mucher better than this encryption bloat. 
If you *really* need the encryption, please use one of the established and 
widely tested security protocols for the lower layers. Encryption is 
incredible hard to do right and we are definitely no experts in this area. We 
want to develop a slick, fast routing protocol. If you want this level of 
security I *strongly* vote against a home made "security plugin".

Keep in mind that security is a concept and not something you can simply 
enable.

Greetings,
Marek
