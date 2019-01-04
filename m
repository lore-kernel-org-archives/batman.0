Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Jan 2019 08:59:30 +0100
Message-ID: <3089099.Wv1GCyR4Rs@sven-edge>
In-Reply-To: <20190104014005.GE21623@otheros>
References: <20181207135846.6152-1-sven@narfation.org>
 <20181207135846.6152-6-sven@narfation.org> <20190104014005.GE21623@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8228632.yFHLvNzKRA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC v3 05/19] batman-adv: Add aggregated_ogms
 mesh genl configuration
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, Marek Lindner <mareklindner@neomailbox.ch>, jiri@mellanox.com

--nextPart8228632.yFHLvNzKRA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, 4 January 2019 02.40.06 CET Linus L=FCssing wrote:
> On Fri, Dec 07, 2018 at 02:58:32PM +0100, Sven Eckelmann wrote:
> > +	/**
> > +	 * @BATADV_ATTR_AGGREGATED_OGMS: whether the batman protocol messages
> > +	 *  of the mesh mesh interface shall be aggregated or not.
> > +	 */
> > +	BATADV_ATTR_AGGREGATED_OGMS,
> > +
>=20
> I'm wondering, would it make sense to take this opportunity to
> rename this to BATADV_ATTR_AGGREGATION? In case we were adding
> aggregation support to something other than OGMs in the future.
>=20
> (and maybe even make it a u32 to be able to potentially use it as
> a bitfield with a useable length?)
>=20
> And I know, the generic aggregation patchset was rejected. But on
> the other hand I don't think that OGMs are that special that they
> will always be the only packet type worth aggregating.
>=20

Any suggestions from Jiri regarding this?

Kind regards,
	Sven

--nextPart8228632.yFHLvNzKRA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwvEmIACgkQXYcKB8Em
e0aF1RAAu6x+5GirtBznrq4QwdGMkRvqIHZHNm2VXUfz5Qo70wPhg0LUmZcxOEEB
LbAwlEGkl1b3RzAObpLsot2nxebG8PA+7Vk7XPD+trejCk4r1WcLe+RTa6VfWcDj
ud/D9hotHWjVcjVPjPXGEYHUPiXjA3h5fYVnIIFfFnmqPtC4V/i1JPAyb+VVtXsX
aTx/pKSJYy4brQ9jHRtw2xzPyfnnAsOSAfN2JY4SIyfgxuOICWC9noP8IEeAxTU+
k9b/6KogNqnVBM8i8InwfGzNrQwxlR7qL3FsjmMBK/XIGtNiiSMkKF8hn5Bwsag0
0BDm4L86Ayxtts4A21qH8K8yiTGL3YS4edhLbZlWRlbtfvLEWygmCieWHFeSBrjM
ifcmbrhDaVngxvkVUbzKCDH0RnSKtfxnaQZ9tDY9JJTUxD1KiTX6V9fXnCQ7DGe8
aagmm92eqf8h3PahNQok5ck2piv8uSmMTOZX3chFqHJ+l7I6hsB+5dme2nePgjpm
3CBf1vnRKFShcTwPZNcJxIfks88OvSaWCcj0dCSAS7Rn4SN/HLTCKiYNTYqTeM6+
0XJRMa6sPU7hcQ1iRjiGFRPk3D9KFG/9/MM7AImtpb8nr8XaG35o29Ft5acVoUIG
eC1DAlVtnqERk4SYQ8X8m1Bt9f3fNvCRCIREi+ZTDmhCcGYh1cc=
=hfE/
-----END PGP SIGNATURE-----

--nextPart8228632.yFHLvNzKRA--



