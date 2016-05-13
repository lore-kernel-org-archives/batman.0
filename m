Return-Path: <a@unstable.cc>
Date: Fri, 13 May 2016 21:21:52 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160513132152.GI21549@prodigo.lan>
References: <1462874769-5077-1-git-send-email-a@unstable.cc>
 <1891745.mZd9gkqG93@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6lCXDTVICvIQMz0h"
Content-Disposition: inline
In-Reply-To: <1891745.mZd9gkqG93@voltaire>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 1/5] batman-adv: make the GW selection
 class algorithm specific
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--6lCXDTVICvIQMz0h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 13, 2016 at 06:44:02PM +0800, Marek Lindner wrote:
> On Tuesday, May 10, 2016 18:06:05 Antonio Quartulli wrote:
> > +       return __batadv_store_uint_attr(buff, count, 0, BATADV_TQ_MAX_V=
ALUE,
> > +                                       batadv_post_gw_reselect, attr,
> > +                                       &bat_priv->gw.sel_class,
> > +                                       bat_priv->soft_iface);
> > +}
>=20
> Why are you changing the allowed minimum from '1' to '0' ?

previous change that I did not "undo". Will fix that.

>=20
>=20
> >  /**
> > + * struct batadv_algo_gw_ops - mesh algorithm callbacks (GW specific)
> > + * @bat_store_sel_class: parse and stores a new GW selection class
> > + * @bat_show_sel_class: prints the current GW selection class
> > + */
> > +struct batadv_algo_gw_ops {
> > +       ssize_t (*bat_store_sel_class)(struct batadv_priv *bat_priv, ch=
ar
> > *buff, +                                      size_t count);
> > +       ssize_t (*bat_show_sel_class)(struct batadv_priv *bat_priv, char
> > *buff); +};
>=20
> No need to introduce the 'bat_' prefix if the next patch removes it.

I wanted to be consistent. I will invert the patches then.

Thanks !

Cheers,

--=20
Antonio Quartulli

--6lCXDTVICvIQMz0h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXNdTwAAoJEJ4aZjxxc6bKHpYP/1fd1KHjb/o2/ShqYVFvSdGi
we3Y+sLTCEvHBrqVvUeLRXPIPN2E3UAu3EkvEisOxFVianHuK0/5kiBugnsSouoR
99F1uc5yCDg4qYAa+o3B/U0bHY1rL0LUAAFBz05HRhXVcIJsN4AOLBmLnPMzoKF8
9xApKs3fkyQcBAwqNBXCqpIsEfHRyTmkIGSw8e+aKsT3//k8FGQP/CuRmSfEamvc
dguBukXhyI12az1AHbc9M/LsANKc1Shi9V3ktccKwuXScgCz1JNwDnaZHrjvKeKV
qLe8lPomsUoe8qkStRq/9vsIM2UEvt1txTeNe1ljKaPzVlsegaA9PcPtfgJgC4Dt
yLdAWEb9Y+Nnxqog5xuiJvmT51On28nyNj6hEhsXagaR/Yk0412hvUDFXDZOF5oO
WtkJeb68EOLU0j+mcGFer5PLOy2MkFSb8ZubrDYLLrKDN31kiHqGsj6cFdXcdaGO
shDFt5Riq+BocpP2OBhvw73sIHTWghARCPV/zwWe6saaXTIowRtonhWWo2i2F20s
t5wyUu9/SElp5o7MXfeoclGKilDTNINwjynyqRQutIv+CNSygY1/dNoZ8GEhzHCR
+vNtF3hHdbnKSmQbtjARxLFGdEpe7ISpdFP9bPhTC1CZ2S9p5bWrygzsDkUTYKY5
jDk7htE8wYufVWXHJmQR
=RPGH
-----END PGP SIGNATURE-----

--6lCXDTVICvIQMz0h--
