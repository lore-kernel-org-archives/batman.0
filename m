Return-Path: <a@unstable.cc>
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
 <20180710202344.GB1525@otheros>
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <9a8ec036-0138-4b9e-566b-a02fbae88f70@unstable.cc>
Date: Fri, 20 Jul 2018 12:47:35 +0800
MIME-Version: 1.0
In-Reply-To: <20180710202344.GB1525@otheros>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="smY0VmElwsjjiybKLXnzGYeTM1nZtGQQB"
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped
 DAT entry purge timeout in DHT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--smY0VmElwsjjiybKLXnzGYeTM1nZtGQQB
Content-Type: multipart/mixed; boundary="Gh4IweABdIUMagPvSC6UaofZv2AXtfCBt";
 protected-headers="v1"
From: Antonio Quartulli <a@unstable.cc>
To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>, =?UTF-8?Q?Linus_L=c3=bcssing?=
 <linus.luessing@c0d3.blue>
Message-ID: <9a8ec036-0138-4b9e-566b-a02fbae88f70@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [RFC PATCH] batman-adv: Increase DHCP snooped DAT
 entry purge timeout in DHT
References: <20180515234859.1167-1-linus.luessing@c0d3.blue>
 <2744691.dbA1SKQ1ei@lafayette> <20180625172919.GA2433@otheros>
 <20180710202344.GB1525@otheros>
In-Reply-To: <20180710202344.GB1525@otheros>

--Gh4IweABdIUMagPvSC6UaofZv2AXtfCBt
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On 11/07/18 04:23, Linus L=C3=BCssing wrote:
> On Mon, Jun 25, 2018 at 07:29:19PM +0200, Linus L=C3=BCssing wrote:
>> Currently, we only update the DHT on outgoing (=3D into the mesh)
>> ARP Replies. I'm worried that an ARP Request would never reach
>> this node (B) during the whole extended timeout, therefore not
>> triggering the necessary ARP Reply, therefore leaving this
>> node unreachable over this whole time frame. Which would probably
>> result in a lot of confusion, I guess.
>=20
> Another option I was wondering about is whether we could go for
> the original, simpler idea and add snooping of outgoing hw-src/IP-src
> pairs from ARP Requests. And whether that could be frequent and
> reliable enough to avoid confusion for the previously mentioned
> scenario.
>=20
> I'm also wondering why we do not snoop outgoing ARP Requests yet,
> why we only snoop ARP Replies. Currently, in
> batadv_dat_snoop_outgoing_arp_request() there is only a:
>=20
>   batadv_dat_entry_add(bat_priv, ip_src, hw_src, vid);
>=20
> to fill the local DAT cache. But something like a
> "batadv_dat_send_data(bat_priv, skb, ip_src, vid, BATADV_P_DAT_DHT_PUT)=
;"
> to update the DHT seems absent.
>=20
> Am I missing something?
>=20

We actually snoop ARP requests, but we use the extracted information to
update the local cache only.
You are right when saying that we don't update the DHT in this case.

We snoop ARP replies because we consider them "authoritative answers"
that we can effectively trust.

Unless somebody has any objection, I think we could consider as such
also the "source IP/MAC" in an ARP request and apply the same logic.


Cheers,



--=20
Antonio Quartulli


--Gh4IweABdIUMagPvSC6UaofZv2AXtfCBt--

--smY0VmElwsjjiybKLXnzGYeTM1nZtGQQB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltRaWcACgkQB6U8WA7y
zXQ9kg//eA70zMjg3/73VDhnXed7z+gAiy9CEd8JA6LyvkUpyNT5HIsYmQaD2LuQ
eDihmMuoEc0dG6j9ufTOo8I8yzqDdfFGA5LglBOo/IctnYpVY/EdHoxOMbsNrtf5
XmmlA6a4OB4rMg4K+ABeYfHPl4zYHIyDDRuAe0/7XaPD3hVhc6i8NbnXodNopCJS
4UeoYe2Mg0CRPMkZLg+FKkoOBPbbSEZPk+Gr5S2BobH1kc7+hELzZ5hcuyVUThrG
67qap+zA9gAB6iIue2lOFf+9RFlVhRS/jPuH0CjYdyOJkBDLEPkkEI2VNoFkVRhz
lU1Bm6Tuq9wPh2YwEspRGNFTryVBWV8hATuAbNR3G+VW8p/wl9DJTTCtPmocS3vl
+0XR7bod3LfRSzbufRmf3weK01F3Qc16fE1rvNZSZHzIDsHShltpyCxyBXScp+86
l/qyzIQ7OPW4MGNhDQtGMsb7tFEAhnkCjnVQz4Y2q3GoNB7eiSnEMHolCziVRljU
c5dWZteAfsPxF8YsZEoB6UIXcr7v/wYNQlOpmPEkXHE9RkBEs8Mni+ENsWdx8A9s
sMOnCHTud6ROubVNAA5gI3RMfGTvmofYSaybQcFOcrKREd9LU/nRr3Zx0cWt46xG
D/5QLHchAu1fuFBxxZQjM4VjFGHOrjF73vy5g3CJVxB9zMn60XM=
=wmTO
-----END PGP SIGNATURE-----

--smY0VmElwsjjiybKLXnzGYeTM1nZtGQQB--
