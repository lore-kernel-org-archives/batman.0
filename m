Return-Path: <jj.sarton@t-online.de>
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge> <20161106175007.GE9484@otheros>
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
Message-ID: <98acd005-3645-c5c5-683c-b898ca7a166d@t-online.de>
Date: Mon, 7 Nov 2016 23:03:02 +0100
MIME-Version: 1.0
In-Reply-To: <20161106175007.GE9484@otheros>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IvWmQCueImeIkvb2B5LK2O5sCa9U4tWMd"
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IvWmQCueImeIkvb2B5LK2O5sCa9U4tWMd
Content-Type: multipart/mixed; boundary="swUGmKR7kTisuj5xabsAuhbGKd16m6L72";
 protected-headers="v1"
From: Jean-Jacques Sarton <jj.sarton@t-online.de>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
Message-ID: <98acd005-3645-c5c5-683c-b898ca7a166d@t-online.de>
Subject: Re: [B.A.T.M.A.N.] Batman an more than one Gateway
References: <32cfb197-7944-7b9c-0d1c-6f6267d355de@t-online.de>
 <2562442.4W30obIVjL@lafayette>
 <0b99a1f3-aa99-eb62-46cf-f959011a05e6@t-online.de>
 <7866334.t3BPe0EmV2@sven-edge> <20161106175007.GE9484@otheros>
In-Reply-To: <20161106175007.GE9484@otheros>

--swUGmKR7kTisuj5xabsAuhbGKd16m6L72
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo Linusm

Soll ich es auf Franz=C3=B6sich schreoben ?
Am 06.11.2016 um 18:50 schrieb Linus L=C3=BCssing:
> On Sat, Nov 05, 2016 at 11:25:38PM +0100, Sven Eckelmann wrote:
>> This can be wrong (as explained in my last mail). Gluon only sets the
>> no_rebroadcast on the Freifunk router because it doesn't have to handl=
e
>> distribution of broadcast to multiple fastd endpoints. It would be
>> completely wrong when set on the fastd server (handling multiple clien=
ts).
>> See my other mail for details.
>=20
> Just as a small addition, I think I've said it in the ticket, too:
> Jean-Jacques, in one point, you're absolutely right:
>=20
> When there is just one neighbor on an interface, then rebroadcasts
> can easily be avoided. Which is the case in your scenario on the
> VPN client(!) side.
>=20
> Gluon has this extra patch for batman-adv, this no_rebroadcast
> knob. But an automatic detection which should cover this specific
> VPN client case, was merged into upstream batman-adv just a few
> days ago \o/ :).
>=20
>=20
> For any case with more than one neighbor on an interface it is
> very hard to detect whether upon receiving a broadcast all other
> neighbors have received this broadcast too.
>=20
OK with my previous mail I have wrote about my impressions.

I more as an neighbor is connected to an interface, you can not
be sure that all neighbor have received the broadcast.
Waiting and counting the rebroadcasts may be a solution but
rebroadcasting can be replaced by an acknowledgment frame.
If I have 3 node a b and c b will see a and c but a and c
may be to far from each other so that the rebroadcast from a
will not reach c until b repeat the broadcast which will
be rebroadcasted,...


> If we can't say for sure, then we unfortunately need to stay safe
> and rebroadcast to avoid horrible packet loss / broken connections /
> armageddon.
>=20
Holzhammer Methode ?

Gr=C3=BC=C3=9Fe,

Jean-Jacques


--swUGmKR7kTisuj5xabsAuhbGKd16m6L72--

--IvWmQCueImeIkvb2B5LK2O5sCa9U4tWMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF0EARECAB0FAlgg+hYWHGpqLnNhcnRvbkB0LW9ubGluZS5kZQAKCRAz0luJHcLB
C315AJwKi49cmX+zfmgXUA12Fu99yI+zGACeJDHlOEqgSxF2t0CVk/vOJ/JI/lY=
=cWdM
-----END PGP SIGNATURE-----

--IvWmQCueImeIkvb2B5LK2O5sCa9U4tWMd--
