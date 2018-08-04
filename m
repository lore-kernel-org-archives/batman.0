Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 04 Aug 2018 17:35:22 +0800
Message-ID: <2763057.QNa6FE6mQo@rousseau>
In-Reply-To: <20180521144304.GN7162@otheros>
References: <20180518014754.23644-1-mareklindner@neomailbox.ch>
 <20180518014754.23644-7-mareklindner@neomailbox.ch>
 <20180521144304.GN7162@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1571988.zidiZlyoQQ";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 6/7] batman-adv: ELP - use tp meter to
 estimate the throughput if otherwise not available
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

--nextPart1571988.zidiZlyoQQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Monday, 21 May 2018 22:43:04 HKT Linus L=FCssing wrote:
> On Fri, May 18, 2018 at 09:47:53AM +0800, Marek Lindner wrote:
> > +fallback_throughput:
> > +       last_tp_run_jiffies =3D jiffies - neigh->bat_v.last_tp_meter_ru=
n;
> > +       last_tp_run_msecs =3D jiffies_to_msecs(last_tp_run_jiffies);
> > +
> > +       /* check the tp_meter_running flag before checking the timestamp
> > to
> > +        * avoid a race condition where a new tp meter session is
> > scheduled
> > +        * right after the previous tp meter session has completed
> > +        */
> > +       if (!neigh->bat_v.tp_meter_running &&
> > +           last_tp_run_msecs > BATADV_ELP_TP_RUN_INTERVAL)
> > +               batadv_v_elp_tp_start(neigh);
> > +
> > +       /* discard too old tp test results */
> > +       if (last_tp_run_msecs > 2 * BATADV_ELP_TP_RUN_INTERVAL)
> > +               neigh->bat_v.tp_meter_throughput =3D 0;
> > +
>=20
> So far we were either using time_before(), time_after_eq() or our
> own wrapper batadv_has_timed_out(). Would it make sense to use
> some of these here, too?

Good point. That changes has been staged for v3.

Cheers,
Marek


--nextPart1571988.zidiZlyoQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAltlc1oACgkQU1VOj+62
HMB8dwf+OVz9TbKXynZrEUv1XmzlAQPOV13y62BNHlSrZU6nNZkNSfk7trKwP5bf
o3EiLr5SUX8POPYDypMQLB9rx9+qxDMR7+fLMS1xB8ZK3NHebVqPBAaK9apqCR6e
G4oqe/unrLm0CZcKMcvpjrrMnMJkkSuVXnscIOQMGGtsKxSPr+FpkfMoNFAaRrhg
BAp+gqB9ML2zipL6Q7SI/B4bRXeVb1j42pICulMZ6Xb95DkJ89AJcfvBCsigZGoM
BoI4P71fMppH/NKEVcX+8FxUhooS6Pg2nwlY8fmkUaEGYTQ9AxZFmMoSl0hag6iE
AvGUvzthyeeC2DJEz6MugttsiPMZdA==
=nZ2A
-----END PGP SIGNATURE-----

--nextPart1571988.zidiZlyoQQ--



