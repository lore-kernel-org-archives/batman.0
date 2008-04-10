From: bruno randolf <bruno@thinktube.com>
Subject: Re: [B.A.T.M.A.N.] AHdemo mode
Date: Thu, 10 Apr 2008 15:04:48 +0900
References: <200804092052.12389.gfjl@ubbi.com>
	<E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
	<200804101222.16445.lindner_marek@yahoo.de>
In-Reply-To: <200804101222.16445.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804101504.48485.bruno@thinktube.com>
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
To: b.a.t.m.a.n@open-mesh.net
Cc: Marek Lindner <lindner_marek@yahoo.de>

On Thursday 10 April 2008 13:22:16 Marek Lindner wrote:
> IMHO the olsr secure plugin idea has a good intention but the concept is
> broken. There are several aspects:
> - As long as only a single instance (one admin) knows the key everything is
> fine. But every node joining the mesh will need that key. Either the admin
> has a _lot_ of freetime or you have to hand out the key. In the later case
> check Ebay from to time to time to find out about the value of your key. 

still that can be better than no security at all...

> ;-) - Furthermore, batman is used for _community_ meshing. Everybody should
> be able to join quickly ...

i basically agree, but some people might like to set up a more controlled 
environment. even in a community network this might be useful at times, for 
example if you want to set up a backbone network.

one way to solve this without a static key which has to be known to all nodes 
is using a public key infrastructure (PKI) with a certificate authority (CA). 
the clients can generate their own private and public keys and send the 
public key to be signed by the CA. that could go hand in hand with adding 
their nodes to a map and accepting some basic agreement (pico peering). after 
it has been signed they could start using encryption for an extra level of 
mesh security.

> - You give your users a FALSE impression of security: "We have the secure
> plugin enabled - we are secure!". Still everybody can sniff the data, man
> in the middle, etc

yes people have to understand that only the mesh protocol will be encrypted, 
not the data.

> - Encryption on an embedded device like a router is a performance killer if
> the encryption is not done in the hardware itself.

it's not too bad as long as the bandwith is low, as it would be the case with 
protocol traffic.

> - Most important: Nothing is better than end to end encryption /
> authentication / authorization.

that's true, but it doesn't help if the underlying mesh protocol can be 
disturbed easily by un-authenticated nodes and your traffic never reaches the 
other endpoint.

there are two different layers of adding authentication and encryption. one is 
the mesh protocol itself the other one is end-to-end user encryption. both 
are necessary if you want to make your network secure.

bruno
