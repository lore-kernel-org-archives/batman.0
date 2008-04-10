From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] AHdemo mode
Date: Thu, 10 Apr 2008 12:22:16 +0800
References: <200804092052.12389.gfjl@ubbi.com>
	<200804092255.36474.gfjl@ubbi.com>
	<E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
In-Reply-To: <E3C3B297-FD0F-4708-AA7D-AEA1F979EA70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200804101222.16445.lindner_marek@yahoo.de>
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

On Thursday, 10. April 2008 10:23:58 Vinay Menon wrote:
> The problem I see here is the possibility of unwanted batman nodes
> joining in and announcing wrong/ false gateway. Since adhoc will only
> support WEP and imo its not viable having batman run only over VPN, i
> think a symmetric key arrangement where in all nodes have the same
> password to join in routing would be a great addition. This basically
> is the concept of olsr secure plugin.

But announcing a wrong/false gateway wont help - that is why we have a 
blackhole detection or the preferred gateway option. You can choose your 
gateway.

IMHO the olsr secure plugin idea has a good intention but the concept is 
broken. There are several aspects:
- As long as only a single instance (one admin) knows the key everything is 
fine. But every node joining the mesh will need that key. Either the admin 
has a _lot_ of freetime or you have to hand out the key. In the later case 
check Ebay from to time to time to find out about the value of your key.  ;-)
- Furthermore, batman is used for _community_ meshing. Everybody should be 
able to join quickly ...
- You give your users a FALSE impression of security: "We have the secure 
plugin enabled - we are secure!". Still everybody can sniff the data, man in 
the middle, etc
- Encryption on an embedded device like a router is a performance killer if 
the encryption is not done in the hardware itself.
- Most important: Nothing is better than end to end encryption / 
authentication / authorization.

Greetings,
Marek
