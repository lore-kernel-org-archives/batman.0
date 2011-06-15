Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 15 Jun 2011 08:58:02 +0200
References: <20110614235132.3724.57632.stgit@warthog.procyon.org.uk>
In-Reply-To: <20110614235132.3724.57632.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3264376.0fnGVuv2M2";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201106150858.04851.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: count_real_packets() in
	batman-adv assumes char is signed
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
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <lindner_marek@yahoo.de>, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>

--nextPart3264376.0fnGVuv2M2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Wednesday 15 June 2011 01:51:32 David Howells wrote:
> count_real_packets() in batman-adv assumes char is signed, and returns -1
> through it:
>=20
> net/batman-adv/routing.c: In function 'receive_bat_packet':
> net/batman-adv/routing.c:739: warning: comparison is always false due to
> limited range of data type
>=20
> Use int instead.
>=20
> This is also looks a bit weird as (presumably signed) is_duplicate is
> constructed by OR'ding together the unsigned results of get_bit_status()
> (though the latter only returns 0 or 1).

Sry, had to catch the train and had no time to explain it further.

It is correct that is_duplicate will only have 0 and 1 stored, but the=20
window_protected function (called before the loop) may detect that the pack=
et=20
has to be dropped and we return in that case -1.

I don't know who started to use char in those places, but thanks for remind=
ing=20
me how much I hate it and that I wanted to check the rest of the code. :)

I will submit the corrected patch in a pull request later this week to Davi=
d=20
S. Miller.

Thanks,
	Sven

--nextPart3264376.0fnGVuv2M2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJN+Ff7AAoJEF2HCgfBJntGoeoP/iLF9U4vVDP4LqmyzaDO9ipR
WBSvSIw109/iiXFbYsdtg5WuC17mGKwN34qhaX2KjOCmqVvHAwFzeajcKlRJR1KX
I/g9qdF1Ic7jYMN755Jvn73dFL3QsqyIKnxWzt69bEZpGJX4SBcNRi7m272wrYbC
79TuP2bJPdG58tsZYrwCwNNNg6IgfOVMWlHafI2BCgBZIda4JlNMbH57rLBw4Odq
qYxiEaC6E/1dITqoGvkD/8XWqmfD3apREq2h3wDTfQNtzcwiwqpLQ5z5Wqef9VBD
gqcNbLPW7jOpWBYVvatPsVuXavtpq0ueAK9ngTldt5ixqCDo1FC2loY9gYPpOzK5
ix3dF9GhArcMQOzb+1Drcj0ul0/BtciZI8vbNzGDb9X+yjiImRjUTbp3gnNsshYn
QinP3Uplk0FEDKtGKZFTGxHJkRPEqF+xbXnP9Y1qgg7rVSfaHe4BwY5B/agYwQo8
vwAp6PwDF5uIksQD6/mk8enZ/vhrE9FYmACHHlTF9gfRYMa87N7wuu9FHWa/UOlW
lXNcTZczlsvWlQ2lPtYv/youNOkEbgdVqMufS5F/F/jAs3dkXtVMTI17GrWsFb+7
RViWp/YGbPWy3E3kT8WnWV0RE7s3SxCgm+dd5VcVnA0T4U9ICh9hbHhlaO+5b06i
JrHRGP0+0bxZgd9h9ynV
=R+hY
-----END PGP SIGNATURE-----

--nextPart3264376.0fnGVuv2M2--
