Return-Path: <a@unstable.cc>
Date: Mon, 2 May 2016 04:59:23 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160501205923.GX11201@prodigo.lan>
References: <1462124180-12104-1-git-send-email-a@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Sh7h4lnU5nPTsIof"
Content-Disposition: inline
In-Reply-To: <1462124180-12104-1-git-send-email-a@unstable.cc>
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: make sure ELP/OGM orig
 MAC is updated on address change
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


--Sh7h4lnU5nPTsIof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 02, 2016 at 01:36:20AM +0800, Antonio Quartulli wrote:
> When the MAC address of the primary interface is changed,
> update the originator address in the ELP and OGM skb buffers as
> well in order to reflect the change.

actually this patch is for "maint" and still misses the Fixes tag.

>=20
> Reported-by: Marek Lindner <marek@neomailbox.ch>
> Signed-off-by: Antonio Quartulli <a@unstable.cc>

--=20
Antonio Quartulli

--Sh7h4lnU5nPTsIof
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXJm4rAAoJEJ4aZjxxc6bKqgYQAJCajsCRfrSh1okuZwxaBBdG
AinrEWXPy4I7Q5DtaTZ27j+804t/V6ouJJY76jp7VzxrbTNtcSAsQyrm2CMj0K5P
KaBHagWFa+QAG4BfT+TjRG1B+hpdH3AqW67fpCYxaa6toemxLG7E3dgzFnlUUWBd
MnHj6/2YSnUMBM4jyqwSwt66wnJLG3saXx5J5Vbp1VCwy2NpC++yXSgyNFKlzmJz
mbWd4sSGiMIZ77/KlaaAvLlgXmnATezEGyKfAxAtbwoeyMHa0RMGm7ESE7LRNAWc
/ubJsK8wmUqVKGNfZ4bECvmAEjF8NmbiAMddh5JKWjD1AEfgDVOIifdGgOapYI24
GzWiZk9N/QsV0729YUXML/LVspWRuNuXMmDhnX2v2ePiP4GWn87Aso+oyh5dJ9E+
oL2hA80onI1XkIGnMEQ84EbxpL95w1ePa3S/S63UtS4inbC4GAQbAh0rQ4eN/qbm
e+g0nmLrKWBH+VmiRNlvtn4hBWBokdViZz2xC3/3QODl5yNH1Fcw1PdThwW2GiOe
rXuqSzxKI30JH9zuca0HSEcvmWnqRaShG/XqN6St6LMoX4d7pPR30yydBNpdlsPZ
xDZb60ay0KYPUtUXdpOcXi+TvM9IrXs6av5F62S9l1wOrftglh9tf2mQN9zbhIvn
8yGd7SSRcMaEHNzrusyn
=J7/b
-----END PGP SIGNATURE-----

--Sh7h4lnU5nPTsIof--
