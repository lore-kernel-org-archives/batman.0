Return-Path: <Linus.Luessing@ascom.ch>
In-Reply-To: <201011101206.18881.lindner_marek@yahoo.de>
References: <1289148361-16019-1-git-send-email-linus.luessing@web.de>
	<1289350093-5782-2-git-send-email-linus.luessing@ascom.ch>
	<201011101206.18881.lindner_marek@yahoo.de>
MIME-Version: 1.0
Message-ID: <OFD539991B.AC1A53B7-ONC12577D7.0055C780-C12577D7.0055E665@ln.ascom.ch>
From: Linus Luessing <Linus.Luessing@ascom.ch>
Date: Wed, 10 Nov 2010 16:38:15 +0100
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCHv2] batman-adv: Allow promiscuous
 reception of unicast packets
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Marek Lindner <lindner=5Fmarek@yahoo.de> schrieb am 10.11.2010 12:06:18:

> [Bild entfernt]=20
>=20
> Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Allow promiscuous reception
> of unicast packets
>=20
> Marek Lindner=20
>=20
> an:
>=20
> The list for a Better Approach To Mobile Ad-hoc Networking, Linus=20
L=FCssing
>=20
> 10.11.2010 12:08
>=20
> [Bild entfernt]=20
>=20
> Von:
>=20
> Marek Lindner <lindner=5Fmarek@yahoo.de>
>=20
> An:
>=20
> "The list for a Better Approach To Mobile Ad-hoc Networking"=20
> <b.a.t.m.a.n@lists.open-mesh.org>, Linus L=FCssing=20
<linus.luessing@ascom.ch>
>=20
> On Wednesday 10 November 2010 01:48:13 Linus L=FCssing wrote:
> > Firstly, a very mobile node moving towards the sender along the hop=20
path
> > benefits from this as for such a mobility pattern the reception=20
probability
> > increases, no matter how slow the topology convergence speed is.
>=20
> Would you mind explaining why you think it helps for mobile nodes in the =


> scenario you mention ?
> If I understand it correctly it helps for data originating from a=20
non-mobile=20
> node traveling towards the mobile node but this is less critical=20
> (assuming the=20
> mobile node has a higher orig interval).
Correct, I was assuming equal intervals ;). Yes, this is usually not=20
critical, but just
found it note worthy anyway, that you could possibly move towards the=20
sender along the
path as fast as you wish without losing the stream from the sender, being=20
independent
of the receivers OGM interval.

> For data originating at the mobile=20
> node traveling towards the non-mobile node it will only help if=20
bothnodes are=20
> single hop neighbors.
That's not what I've been claiming afaik :). And if both nodes are just=20
one hop away, then
you don't have any advantage of this promisc-reception anyway.

Hope that paragraph did not cause too much confusion, if you think there's =

something misleading
in it, I can change it, no problem.

>=20
> Regards,
> Marek

Cheers,
Linus
