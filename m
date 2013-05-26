Return-Path: <ordex@autistici.org>
Date: Sun, 26 May 2013 15:59:25 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130526135925.GN1679@ritirata.org>
References: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <1368793673-27539-1-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/4] batman-adv: renamed
 batadv_dat_snoop_*_arp_* functions to batadv_dat_snoop_*_msg_*
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


--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 03:27:49PM +0300, Mihail wrote:
> From: "mihail.costea90@gmail.com" <mihail.costea90@gmail.com>
>=20
> Renamed snooping functions in order to suggest that they should work on
> more protocols than ARP.

You are introducing the change now, therefore I'd rather speak using simple
present instead of past (at least this is what we usually do in all the
commits...same applies for the subject).

>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>  distributed-arp-table.c |   16 ++++++++--------
>  distributed-arp-table.h |   16 ++++++++--------
>  routing.c               |   12 ++++++------
>  soft-interface.c        |    6 +++---
>  4 files changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index af670d3..b2ca7e0 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -978,7 +978,7 @@ out:
>  }
> =20
>  /**
> - * batadv_dat_snoop_outgoing_arp_request - snoop the ARP request and try=
 to
> + * batadv_dat_snoop_outgoing_msg_request - snoop the ARP request and try=
 to

To be honest I do not really like this new naming schema..but I have no bet=
ter
idea now :)

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRohU9AAoJEADl0hg6qKeOLzEQAIgfe1OyrPcaE4HMj8Q22YXy
gKDxg9CpNc4eTF5kWuz6V5F7oS7O1bD+46tCQdA5Rj/GGdZlqZ2fTZHcOmYjkXq5
cH1vp/Q/YOkUCH3EbJtB9gHy7KbtNlSwQxh8H5dIUlBlRdthMYNB53gzzapUa75A
jYanBBBIg+SBAMkqXVkd5s7tRNpiXWydZqFm/rjk/Vq8ei/hEh/8sCjzBsviynwV
JKkMDgYHqeSIUDjuNa3k52CiYZoC2OJFTI6B0O32CW1WY0nZTnFgNYwpQdkXXj4x
hWbMVEIhP4EeEgRg7T741gnLapy4vVYIdJicIgbMov4NWuoTqq6INc1vJXHHU8yO
HsfzaxT44NCrGCydKMT+UI+tbBtvc2b8MTUFOqhQKuj/n48Nj12acu0J0ks0xX/7
IWLPvsrAyAX7TK9CWpogGRuzfXbuvaAj6fW3FMjaBCb1zevHJvbGX2xPU8qTNIEf
7s5+WBc0BubhrT+hzuScOqwwAIVqaR1oYHBxTmU0doCPD4pXb5vXy95vBlmfI+fG
hGTOH1nHuLLv4Ns7Dbcm2wi15FRP9zEsEpHb01NW3Ho/H8KRPxPFrVx3GaCGfIhB
5RqGb/pklmHkMyvCgpTQfBiYUFlX6I6HPvlGryX40LH+qAxQhpBN0z1CMg9zgZwf
I6rMNkXPDYgtG2shaMV4
=SPhX
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--
