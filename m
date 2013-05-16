Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Thu, 16 May 2013 13:51:29 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130516115129.GA27948@pandem0nium>
References: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1368293014-30742-1-git-send-email-linus.luessing@web.de>
Subject: Re: [B.A.T.M.A.N.] Basic Multicast Optimizations
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Linus,

thanks for working and integrating this patchset!

On Sat, May 11, 2013 at 07:23:24PM +0200, Linus L=C3=BCssing wrote:
> This set of patches is the first one for a more efficient, group aware
> multicast forwarding infrastructure in batman-adv.
>=20
> This initial set mainly consists of the integration of announcing the
> location of multicast listeners via the translation table mechanism to
> be able to find out which batman-adv nodes are actually interested in
> certain multicast traffic. As well as the signalizing of this
> announcement capability via a new multicast TVLV.
>=20
> Finally some basic multicast forwarding opitimizations are introduced:
> If all nodes signalized the MLA capability then link-local IPv6 traffic
> will be dropped if there is no interested listener or gets forwarded
> via a batman-adv unicast packet if there is just one node interested
> in the data.

I've seen that you've only implemented that for IPv6, would it be possible
to use it for IPv4 too in the current state? (I use some media streaming
thingy at home where I could test ;])

>=20
> For now, these optimizations only apply if all nodes in the mesh have
> no bridge interface on top their bat0 interface. However making it
> possible with bridges, too, and other features are on the roadmap. See
> the according wiki page for details [1].

So from what I understand this means:

 * multicast support is working for non-bridged interfaces for now, because
   we lack proper multicast router discovery support (MRD) in the bridge co=
de
 --> you told me someone is working on that, or you'll pick up to get this =
done?

 * the current optimization is to handle multicast like:
   * no listener - drop
   * one listener - unicast
   * more listener - broadcast
 --> I think that is a good and simple optimization. :) The "tracker" packe=
ts
     can come later (as shown in your roadmap). This might require to annou=
nce
     that tracker packets are supported in the TVLV?

Would you consider Antonios comments and update your patchset? I would like=
 to
test it in the next days ...

Thanks,
	Simon

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGUyEEACgkQrzg/fFk7axbQ5ACfSi09O/i3+gTxRmXf9ZbQlBZ/
XKMAn38b3qIzM8G2JmE9+Nxe14iek/CC
=yg2F
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
