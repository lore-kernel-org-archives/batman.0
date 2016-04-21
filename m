Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 21 Apr 2016 18:40:30 +0800
Message-ID: <5665150.3O6JYoqodr@voltaire>
In-Reply-To: <20160421102252.GB23886@prodigo>
References: <1457711046-4603-1-git-send-email-sven@narfation.org>
 <20160421102252.GB23886@prodigo>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1851112.Eaiq9lLQ0E";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix reference counting
	of vlan object for tt_local_entry
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

--nextPart1851112.Eaiq9lLQ0E
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, April 21, 2016 18:22:52 Antonio Quartulli wrote:
> On Fri, Mar 11, 2016 at 04:44:05PM +0100, Sven Eckelmann wrote:
> > The batadv_tt_local_entry was specific to a batadv_softif_vlan and held an
> > implicit reference to it. But this reference was never stored in form of a
> > pointer in the tt_local_entry itself. Instead batadv_tt_local_remove,
> > batadv_tt_local_table_free and batadv_tt_local_purge_pending_clients
> > depend
> > on a consistent state of bat_priv->softif_vlan_list and that
> > batadv_softif_vlan_get always returns the batadv_softif_vlan object which
> > it has a reference for. But batadv_softif_vlan_get cannot guarantee that
> > because it is working only with rcu_read_lock on this list. It can
> > therefore happen that an vid is in this list twice or that
> > batadv_softif_vlan_get cannot find the batadv_softif_vlan for an vid due
> > to
> > some other list operations taking place at the same time.
> >
> > 
> >
> > Instead add a batadv_softif_vlan pointer directly in batadv_tt_local_entry
> > which will be used for the reference counter decremented on release of
> > batadv_tt_local_entry.
> >
> > 
> >
> > Fixes: 9729d2085c0f ("batman-adv: fix TT VLAN inconsistency on VLAN
> > re-add") Signed-off-by: Sven Eckelmann <sven@narfation.org>
> 
> Thanks a lot Sven ! This change, on top of fixing the ref issue, also
> simplified the code quite a lot!
> 
> Acked-by: Antonio Quartulli <a@unstable.cc>

Applied in revision 20ca393.

Thanks,
Marek


--nextPart1851112.Eaiq9lLQ0E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXGK4eAAoJEFNVTo/uthzA64YIAK8Cn85nvwr5o0Ln3rwyeNLy
9TcUgUniRVNsZbyBKE0yyYpuXJzrMytm+Uh/cc29L4TaQzOM5tNZnaXUZhGaITpx
+N7rEHHj7KiA096UrkdHWokNXNNFvXAtPRlfqlOtFlTCfrzqRt6Umxb7uBFVUxsF
sU0wPVeIVFVjL150OKcHfG7YX/OJRCWJFw1waZJ/eCDSI0LnB5pFHGLXokvKdqTE
ba0oNlnB4lvq7KzbYE+qvd2MDigeZ2yoCa812es1HjqXBiGY4N5r/7zp+hfErZRY
ni1HkzcHWUBqlylEYxSYqbsIMSqMG4jOvuxke9dfuwaUkOg6++/Szvto1EMesho=
=ZFhN
-----END PGP SIGNATURE-----

--nextPart1851112.Eaiq9lLQ0E--

