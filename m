Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 22 Jan 2017 13:51:14 +0100
Message-ID: <3122041.oyWN8MZ83e@sven-edge>
In-Reply-To: <20161220115550.GN6323@otheros>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <3954768.uotHLiEBeb@sven-edge> <20161220115550.GN6323@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3182169.HULXJGTCUi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/4] batman-adv: Introduce packet type
	independent TVLV handler API
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

--nextPart3182169.HULXJGTCUi
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 20. Dezember 2016 12:55:50 CET Linus L=FCssing wrote:
> On Mon, Dec 19, 2016 at 12:43:49PM +0100, Sven Eckelmann wrote:
> > On Montag, 19. Dezember 2016 12:37:43 CET Sven Eckelmann wrote:
> > > I was not talking about the packing functions.
> >=20
> > Just read my initial mails. Looks like I've copied the wrong function n=
ame=20
> > "batadv_tvlv_ogm_pack_ctx". But I was talking about the parameter in of=
=20
> > "batadv_tvlv_containers_process2". So I am the reason for the confusion=
 :)
>=20
> Just to check, you suggest removing this line:
> https://git.open-mesh.org/batman-adv.git/blob/1ddd189528fc332bf286ffd56b6=
29da26a6b149c:/net/batman-adv/tvlv.c#l662

Yes

> And to replace the passing of "ctx" with an "orig_node" here:
> https://git.open-mesh.org/batman-adv.git/blob/1ddd189528fc332bf286ffd56b6=
29da26a6b149c:/net/batman-adv/tvlv.c#l682

Yes

> (which works as a "void *" parameter accepts any type, without the
> need of casting explicitly)

Yes

> If that's what you mean, hm, not sure. Feels dangerous, such
> automatic casting, doesn't it?

It is not perfect but it is the way it is already done for many things in t=
he
kernel and also in userspace. Think for example about "the argument" when y=
ou
generate (k)threads and which you can then then retrieve again inside this
thread.

Your current extra functions also don't prevent that there is a wrong argum=
ent
added to this perticular function. They just introduce some weird extra
functions. (At least this is how feel about it - their might be different
opinions about that)

>=20
> I'm really wondering whether I should go for the approach of
> hiding the "void *" in a new type. And only having the "void *"
> fiddeling inside _pack()/_unpack() functions.

Hm, I personally don't see a reason for a new type at the moment. But when =
you
find a good one... at least their could be plenty of reasons which might ma=
ke
everything a little bit cleaner.

Just keep in mind that there are already many other things in the kernel li=
ke
container_of and similar things. So don't try to overengineer it :)

Kind regards,
	Sven
--nextPart3182169.HULXJGTCUi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAliEqsIACgkQXYcKB8Em
e0a8yxAAtzjiP8rEWbxebp05TfBEB0inCnEYWbFywGtRRXwVRXSPeER52tBZ5YL6
wPs88R2GkBWjPFYh7CAkiz5izIoqpmUZfpU5y2ZubYLt8hM465jr+s7849wGi6A+
q6fZ6tesA5Dyfg9CH27MMNtHPKOI79rr4e0OPczgiPNXc+j62EoCHvqebvFwaMud
x/7O7A2jM/g9/fQKDqEIgJlsbSZAjZoMXAFlqC5m1qoEUkqwE3YXQOgZi6M8h345
1R57dujukDOonLX3kT5/Zzly6F5xsR7Pq0DRv9iciyjJGfM66+dQ8ZBLAYcSXahN
1+uIjgvCRY+Ka0i++racjFvNJTFNbyxMEYZQmMxwKCLsQGJFNft5VB0ZCVu8Fdcg
sO2741zeu2PYg23JrjdR3iBJenKCkYiccTdsOCK3Pdeo3tLE2do6mbonOqkR2Boe
/FDScHYLhQdW42+f2u6VFkAHB/qMEX2ggMpNEy50wkemp8cZmg67/1CBG9Mp1Yh2
SwN75h42/gHhg6D6cmRXY3Q/gsu3xqK3czdOT4CMwQ4/Dy8Dnnp7yTUtLxsE0TLO
Uo/FNmKON2LFpcMFihzOWOJKPm0bYfMf3YYhoeAotQxBPoVRLmFZuKEuQGSHeoKz
TCgOHRNxXmDRoDkf3MIDw7fcgbdhS4O9deyxMgzLNaqxDfdNWpc=
=JlOq
-----END PGP SIGNATURE-----

--nextPart3182169.HULXJGTCUi--

