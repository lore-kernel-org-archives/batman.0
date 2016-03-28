Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 22:30:12 +0800
Message-ID: <3060601.PWvBBNIS4A@voltaire>
In-Reply-To: <20160310011545.GI13448@prodigo.lan>
References: <1457484919-3935-1-git-send-email-a@unstable.cc>
 <13752331.CEKO7ckMJS@sven-edge> <20160310011545.GI13448@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart132653844.k71UKteabV";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix typ0 in kerneldoc
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart132653844.k71UKteabV
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, March 10, 2016 09:15:45 Antonio Quartulli wrote:
> > > - * batadv_gw_tvlv_ogm_handler_v1 - process incoming dat tvlv container
> > > + * batadv_dat_tvlv_ogm_handler_v1 - process incoming dat tvlv container
> > >
> > >   * @bat_priv: the bat priv with all the soft interface information
> > >   * @orig: the orig_node of the ogm
> > >   * @flags: flags indicating the tvlv state (see
> > >batadv_tvlv_handler_flags)>
> > 
> >
> > You've missed some (see
> > https://git.open-mesh.org/batman-adv.git/commit/94399934a5e050073e1146ecfc
> > 48fe58ac3551b3
> > for the update patch):
> May I resend this patch with your sign-off as well ?

Is that updated patch yet to come ?

Cheers,
Marek

--nextPart132653844.k71UKteabV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEbBAABCAAGBQJW+T/0AAoJEFNVTo/uthzARR4H+O+C1g4W+jSN+Idl6m2hYB/a
QGh9HwQzNsZjf2/1kewSkG52uk/C1OMEM1sdaKnf6DRO3accLGrwdNBWy4+hRigC
izIGiaBns478xYGXJSxvntrvBkqqXn0GiA7UHy1kpJOR1eU80BsR4uUT7RovnqbR
jzVWJ1nzUSv9puegrxVqrhAui2N7MzoR1TjWJvQD4PLu86aej+JqO8EPqvsBJWWG
oJQzl7pdkjJgFM7B1A1y92j06f9Oe1QCcsWVMuxXJhwwKY2cN3usnxVVBmop0MXZ
9hUB2+ebkO9sNI3PXT1Oho+QGm5RUHs5dvVkMq38uYDRqZlO3H6xVg+LKum44Q==
=c5gN
-----END PGP SIGNATURE-----

--nextPart132653844.k71UKteabV--

