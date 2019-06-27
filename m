Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v2] batman-adv: Get inet(6) device inside RCU protected
 region
Date: Thu, 27 Jun 2019 19:48:35 +0200
Message-ID: <12109360.nt3nhxKV5M@sven-edge>
In-Reply-To: <20190627172206.22683-1-sven@narfation.org>
References: <20190627172206.22683-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12109360.yDq7mgzNbW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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

--nextPart12109360.yDq7mgzNbW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 27 June 2019 19:22:06 CEST Sven Eckelmann wrote:
> It is not necessary to get the inet(6)_dev outside of the rcu protected
> region by using reference counting. Instead, the in(6)_dev_get can be
> replaced by the non-refcnt function and everything can be moved inside the
> rcu protected region.
> 
> Fixes: 0a7733468f95 ("batman-adv: mcast: detect, distribute and maintain multicast router presence")


Fixes: 2b0f11124aad ("batman-adv: mcast: collect softif listeners from IP lists instead")

Kind regards,
	Sven
--nextPart12109360.yDq7mgzNbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0VAXMACgkQXYcKB8Em
e0bPPxAAyFPMCruRqDsrf9Igju9g54IJJattqrJHRgcEhG33ad6YAE3eeY0Km5pz
ohwLnJs3zMB2U9VHHf4sfzTjLOEjAcmbpjbMWDcnq0VytRl7+TbycHzZB06yYKzU
NfQ0ZEgw78nFFYlf+6931vUEkW3iOjIdXO99cL5LHKddWibig9T3vNyhCXYoy8Ed
CqDrbBSd1gPX4aV/RYFPr4NmF7j+O+ISZjlxjvQqnhKCoo/gIreTezjXI6mKHqvF
wIs9fIDKXpUn8Ek7GtnoQc1QsVr+BKR72DxgrECCqx/styLXxz26iNqfP3QGquJz
/ACJs+vbs8sVPNM3XWWH8JkjuZQAfX4gfklO/n1BMCbGpF9XIVr7s237I3u39eM6
QyVfQW3UaoOxAIw5JbT8tpwnfaIVItczG0Sb4UPQv64QG5Oc5Dkm81zF+kWvB946
/6dO4Uk1Re8hpLy33y0vkl4/ihLdWC6nEj0z2/fNOnQlQBSL03XKkWBeREVbkdZv
MToqm3qQJBoPvxTVy0x9MAWhh+p3h/JbMrzOjcFp/JBzzG0ZFhGwfj6c152pqrFS
iZI3Jv4LUdq3oSu8nG8RGWP/3YAK3UEg80/V4OpwPnr/OqrQfO5nKRrJFeuMIiD+
bOrucE/alNyxEDtTyN4chlVmPtgPz2fQFM4TjyY6/EOFrRwW3i8=
=8jvX
-----END PGP SIGNATURE-----

--nextPart12109360.yDq7mgzNbW--



