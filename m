Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 20 Apr 2012 16:13:05 +0800
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<1334756157-7257-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1334756157-7257-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204201613.05738.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Add get_ethtool_stats()
	support
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wednesday, April 18, 2012 21:35:57 Martin Hundeb=C3=B8ll wrote:
> Added additional counters in a bat_stats structure, which are exported
> through the ethtool api. The counters are specific to batman-adv and
> includes:
>  forwarded packets
>  management packets (OGMs at this point)
>  translation table packets
>  distributed arp table packets
>=20
> I would like you all to check if the increments are added at the right
> locations and also if more counters would be relevant. (E.g. in bridge
> loop avoidance code?)
>=20
> This is the reworked approach from the previous stat counters patch I
> send, where ethtool stats was suggested.

This patch looks pretty good! I'd say we can merge it unless someone object=
s?!

Would it possible to count the number of bytes for the forwarded packets in=
=20
addition to the packet count ? As I recall you also wanted to move=20
free_percpu() into mesh_free() ?

Regards,
Marek
