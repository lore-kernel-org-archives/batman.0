Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 Dec 2017 17:32:55 +0100
Message-ID: <11825316.UcSexh8Yfb@sven-edge>
In-Reply-To: <20171215114320.13645-10-sw@simonwunderlich.de>
References: <20171215114320.13645-1-sw@simonwunderlich.de>
 <20171215114320.13645-10-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart79652519.eghhCSY85Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 09/20] batman-adv: include build_bug.h
 for BUILD_BUG_ON define
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: davem@davemloft.net, netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org

--nextPart79652519.eghhCSY85Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 15. Dezember 2017 12:43:09 CET Simon Wunderlich wrote:
>  compat-include/linux/build_bug.h   | 34 ++++++++++++++++++++++++++++++++++

This backport change slipped in. Sorry, this was my fault when I initially 
integrating it. 

Kind regards,
Sven
--nextPart79652519.eghhCSY85Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAloz+TcACgkQXYcKB8Em
e0Z6bRAAlpQQhUIgwzNxWeBIrd43+hDSQPsa81UgMQeEzRasf10KvhMYKEfzLRRy
3ephM5NM1jC1fg/7PWG8QFqCXGi5WmP8HchKrqV1/QNH5/a1f3TwDQylvdR/M75l
JrLQdzV3VHU6X2AlaFTOWSyHrF6mVg/FSiPxiqtLiSs7VSyQIWSQuGE+5TZ9Z07Q
mtH+kAMrq1K9yXaEUoFyLscuVS5G+9aiY9I1Z/ta6YyG39c72nSKorFiyJE8H3Ux
boros1hwrQ2DaMQlTNQM9o1gjAkKz2LJlQIdBYGnh4ekZ2yMVvKLEMDjKccui3ma
JBlUFZuXayXl+ARe1mJX/RoS5VUSp/l0efUpzadJnPJR8cBgtfE393ChyrAqy/7t
qfTxgHfo2G3Gd2w8BJAfPY5Ddu77VMdsgiE1+Pe0kvjgBNuQcuem/omOrYH6FEM+
Xvr9aTCIyz0y/jI8HJufk/2rr1r9W5SMuSQCpwJPhuAqBYbwu9G+QTsxJBY2jsFc
v56Gr0Jm9erpIXurDA3gNGk2uG5HT8pXW3YXEfL6qjYm4tfiTkKr3FxNuG3HXv2I
QIIpPO6DGiBDQ6CAFZFeYiBHX2bXc8No4hKeT7/vo7xbnaMSn/andLlSz0Uw02wJ
fBkGLMulZss5MD1Q/uPNnrqTxXQyuoFkwuaDOTV9q4R2g28tmzg=
=Gg6a
-----END PGP SIGNATURE-----

--nextPart79652519.eghhCSY85Z--

