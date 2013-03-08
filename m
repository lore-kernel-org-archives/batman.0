Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 9 Mar 2013 03:28:38 +0800
References: <1362764336-1591-1-git-send-email-linus.luessing@web.de>
 <1362764336-1591-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1362764336-1591-2-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201303090328.38621.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: make number of
	broadcasts configurable per hardif
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Saturday, March 09, 2013 01:38:56 Linus L=FCssing wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
>=20
> In heterogenous networks, setting the number of broadcasts to differing
> values on different interfaces can be beneficial.
>=20
> E.g., on wireless interfaces with high packet loss a higher number of
> broadcasts may be necessary, whereas on low-bandwidth interfaces with
> relatively high reliablily (such as VPN links over slow internet lines)
> sending only a single packet makes more sense to preserve bandwidth.

In general, I like the idea but the approach isn't the best. Can't we autom=
ate=20
these settings instead of adding hundreds of little knobs nobody will=20
understand ? Why not detecting wifi interfaces as such and configure the=20
broadcast value accordingly ? The same goes for ethernet / vpns ?

Cheers,
Marek
