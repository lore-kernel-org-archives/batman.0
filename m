Return-Path: <ordex@autistici.org>
Date: Fri, 10 May 2013 08:16:47 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130510061647.GI1415@ritirata.org>
References: <1368109009-2100-1-git-send-email-ordex@autistici.org>
 <201305100007.08742.lindner_marek@yahoo.de>
 <20130509164426.GF1415@ritirata.org>
 <201305101137.55418.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <201305101137.55418.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 maint] batman-adv: fix VLAN Ethernet
 header access
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


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2013 at 11:37:55AM +0800, Marek Lindner wrote:
> On Friday, May 10, 2013 00:44:26 Antonio Quartulli wrote:
> >   On Fri, May 10, 2013 at 12:07:08AM +0800, Marek Lindner wrote:
> > > On Thursday, May 09, 2013 22:16:49 Antonio Quartulli wrote:
> > > > From: Antonio Quartulli <antonio@open-mesh.com>
> > > >
> > > >=20
> > > >
> > > > In interface_rx() skb->data cannot be directly used to
> > > > access the Ethernet header because it point to the batman
> > > > one.
> > >
> > >=20
> > >
> > > You don't believe that these calls (shortly before the code chunks you
> > > are  changing) are helpful ?
> > >
> > >=20
> > >
> > > skb_pull_rcsum(skb, hdr_size);
> > > skb_reset_mac_header(skb);
> >=20
> > You are right. Hence this is not fixing anything. It is just a
> > beautification and therefore we don't need it in maint.
>=20
> Are you going to resend the patch with an updated commit message and subj=
ect=20
> line ?


I'll take some time to find and beautify other similar spots.
Then I'll resend the updated patch for master.

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRjJDPAAoJEADl0hg6qKeON6gQALIVkztAct83cYxqVhPI4uMk
L5+F1bTOpBxZGHW61WtS/yEMV4v+I5waYQ8hLVJ67x4D1VVTFfsx4O5hie1bnGY6
4Jj5eD4D9dezwITCJ7VJ36oLI1Mm0+ScliSbNv0slTvUp9WNtNH0ZF/9TDUrfyUg
Hd2nNZs2iBWud8RyIEKpSojf3Bk0o2quNV8WjEJLOoGpDbvpsR8VdGJRvuMQZRJe
9QU5R2oNaePPzRBVlbUVVKCX32Ecg9FO16Nr72IsYctpKnNrBOrFm+ARQd+rURf9
3IeBB6Gc9rYnABVSnIq9M956pq4f3Qhy/lgdN8Ufno33NT0ObbqVbkOfnnzWcfLB
o9+kHpXSzCn9NJWvFxbkdLChvCJK1amKOZy0uNE+0xMjv4ADsNvb/mNCdRgvykci
pa8AdpGsHLDmhAmW5VuKKCZhark7/vRrTq23TrV20Ydja3/hgmYS5hxDtIsmoB9q
2ucmJ53xu28Guse1NsqiZbQWS1+ldCGqyE7YXS7e4vi5JzpRItRVTouirnX8AGVN
a1dFzLURE2o3/aKY5T6n0i6FmNaZc1x8HFG1gUoE7Grv8tCIFsUfFnRZLHAGV9Va
qdgsyMFPTHarxrNGhv6xhvxvxBiDv7IS5EYzf2I+SQwgwWCs80oB90l87IQbpyqT
Ija0IXySnibPaTaHbHEJ
=XE9g
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
