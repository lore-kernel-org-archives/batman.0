Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 22 Apr 2012 17:03:10 +0800
References: <1334618695-28338-1-git-send-email-martin@hundeboll.net>
	<1334934165-17430-1-git-send-email-martin@hundeboll.net>
In-Reply-To: <1334934165-17430-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204221703.11609.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv4] batman-adv: Add get_ethtool_stats()
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

On Friday, April 20, 2012 23:02:45 Martin Hundeb=C3=B8ll wrote:
> Added additional counters in a bat_stats structure, which are exported
> through the ethtool api. The counters are specific to batman-adv and
> includes:
>  forwarded packets and bytes
>  management packets and bytes (aggregated OGMs at this point)
>  translation table packets
>  distributed arp table packets
>=20
> New counters are added by extending "enum bat_counters" in types.h and
> adding corresponding  descriptive string(s) to bat_counters_strings in
> soft-iface.c.
>=20
> Counters are increased by calling add_counter() and incremented by one
> by calling inc_counter().

Applied in revision 560985e.

Thanks,
Marek
