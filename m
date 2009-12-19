Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 19 Dec 2009 10:57:00 +0800
References: <84e340bd0912181430i39ab586ck614e0116ab05c33d@mail.gmail.com>
In-Reply-To: <84e340bd0912181430i39ab586ck614e0116ab05c33d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200912191057.00380.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Mesh network advice
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Hi,

> I would like to hear your thoughts / advice on batman vs batman-advanced. I
> read the wiki entry on the pros and cons of batman-adv but I am still in
> doubt about which one to use. For instance, batman-adv doesnt have gateway
> support, but it has ipv6 which if I understand correctly can automatically
> configure gateways/routes.

I believe the wiki page is a bit misleading - I just corrected it. We were 
trying to convey that batman-adv users can't expect batmand gateway behaviour. 
The kernel module won't help you to choose you best gateway (regarding wifi 
link qualities / bandwidth / etc). You always can run DHCP, IPv6 autoconf or 
any mechanism you like.

In reality it means if you have multiple DHCP gateways in your network the 
clients might not always choose the "best" one. Although this is going to 
change in the upcoming batman-adv 0.3 branch over the next weeks.


> For a practical scenario like mine, what is the factors I should consider
> when choosing between the two and which one would you suggest?

On one hand it depends the applications you want to run over the mesh. Things 
like autoconfiguration via DHCP, filesharing amongst clients, roaming, mDNS, etc 
require a layer 2 mesh. Otherwise you are free to choose.

Regards,
Marek
