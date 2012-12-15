Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 15 Dec 2012 16:13:39 +0800
References: <cover.1355466678.git.martin@hundeboll.net>
In-Reply-To: <cover.1355466678.git.martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201212151613.39472.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 0/7] CATWOMAN: Network coding in
	batman-adv
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Martin =?utf-8?q?Hundeb=C3=B8ll?= <martin@hundeboll.net>

On Friday, December 14, 2012 14:32:45 Martin Hundeb=C3=B8ll wrote:
> I hereby bring you network coding in batman-adv. (Changed according
> to Antonios latest review). This allows a relay to send two packets
> (to two destinations) in a single transmission. Tests[1] have shown
> an increase in throughput up to 1.6 under the right circumstances.
>=20
> For this to work, you will need to compile batman-adv with
> CONFIG_BATMAN_ADV_NC=3Dy and a wireless interface with working
> promiscuous mode. The rest is taken care of by batman-adv and the
> following patches.

Next time, please provide a "patch changelog" to make it easier to follow y=
our=20
changes. Everybody else does this too.  :-)

A few examples:
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-November/008536.h=
tml
 * https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-October/008213.ht=
ml

The second example is from you ..

Thanks,
Marek
