Return-Path: <antonio@meshcoding.com>
Message-ID: <52DBA5DE.9000609@meshcoding.com>
Date: Sun, 19 Jan 2014 11:15:58 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390086967-6047-1-git-send-email-linus.luessing@web.de>
 <1390086967-6047-2-git-send-email-linus.luessing@web.de>
In-Reply-To: <1390086967-6047-2-git-send-email-linus.luessing@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wa9qS781fPgpAkSeUqunmJU0hDqmXcGMi"
Subject: Re: [B.A.T.M.A.N.] [PATCHv5 1/2] batman-adv: use eth_hdr() instead
 of skb->data in interface_tx path
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wa9qS781fPgpAkSeUqunmJU0hDqmXcGMi
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 19/01/14 00:16, Linus L=C3=BCssing wrote:
> Our .ndo_start_xmit handler (batadv_interface_tx()) can rely on having
> the skb ether header pointer set correctly since the following commit
> present in kernels >=3D 3.9:
>=20
> "net: reset mac header in dev_start_xmit()" (6d1ccff627)
>=20
> Therefore we can safely use eth_hdr() instead of skb->data now, which
> spares us some ugly type casts.
>=20
> Signed-off-by: Linus L=C3=BCssing <linus.luessing@web.de>

Linus,

in interface_tx() we also have an assignment for vlan_hdr getting the
value of skb->data as well.

Would you mind switching it to vlan_eth_hdr() ?

Maybe you can have a quick look whether there are other occurrences to
change within interface_tx()?


Cheers,

--=20
Antonio Quartulli


--wa9qS781fPgpAkSeUqunmJU0hDqmXcGMi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS26XhAAoJEEKTMo6mOh1Vk/MP/jRFIW2G58gOEQYlfteztR1l
SWXGYxroRdw+JF/0bzqQHhp65EEA2WpbR5sZmWt03qvFNPOD1lnM1+vDrNFfnGQT
paVzb2aNbWYH9j2DONJ5S1Ub47EyFuVm7/QQHDMRSbMamQVdeOPilQU0wIDRkqoW
ISLBtaVjUJnLV/v1HHnGMypFevrVhTDXxZpjnC0cIFy7pEW7VAlJZ/SeMDgoHPis
MvCvauvPrVv9uY2UFGuSR0/0CGuLicPPsoXAj3QVXyXuga+gYy6DyfndrnwvW3wM
3jM0k4D1IGkYVbVRS9xUuLQVmvPHNMNNAos4Cv4ia8gCpOJ/jrMcuikuoDpsbku5
N5lAtuDQyj960GksBnNXHtIYiqlStYKTStk6bp7Nn/DsY4guByqP9ASbQ+eaEYyd
XPkBmnlrfhlMIoMnY4A9JzBHMX6Q+ovoQe5YBjKNVpbFzw2DY0RRAxb1azBSDFIl
zkACwmn38TxjkSpX08q0hIyP1fmBbdLJ75NDDzQPC8EtEZFwsf3vdUqWhNnSlLnd
FNBlSZ5GG4JgAcXsFR+a148Upz1awiYFJ6uzLQEPW7QxI1ZzQBO4Btc/MhtXfJnS
pKp8LLnXms3q/monVfY8uPllnEMRXAbRILXqk9amqy+++CcDMwsIVPWoPGPtTrZr
iEy/946WcbPUah1tL5st
=Ry+l
-----END PGP SIGNATURE-----

--wa9qS781fPgpAkSeUqunmJU0hDqmXcGMi--
