Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 01 Mar 2015 10:13:52 +0100
Message-ID: <2578854.YNfMvSverJ@sven-edge>
In-Reply-To: <95034253.ejT9KvNpcM@giomium>
References: <1425199578-6392-1-git-send-email-sven@narfation.org>
 <95034253.ejT9KvNpcM@giomium>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart19524941.1Ia1TABAlL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: Use common Jenkins Hash
	implementation
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
To: Gio <gio@eigenlab.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart19524941.1Ia1TABAlL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 01 March 2015 10:09:46 Gio wrote:
> On Sunday, March 01, 2015 09:46:18 AM Sven Eckelmann wrote:
> > Only the DAT code must use the old implementation because it is used as
> > distributed hash function which has to be common for all nodes.
> 
> Does the kernel shared version change behavior often across kernel versions
> ?

It should not. But the output is different when comparing it with the current 
internal function (jhash uses some special initialization). At least it was 
three years ago when I've submitted the patch.

Kind regards,
	Sven
--nextPart19524941.1Ia1TABAlL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJU8thVAAoJEF2HCgfBJntGgrQP/i4deMX+/F7Fx4ftBUoqBXdZ
T1T3lkBMOHxnnGRs4SZmwP5z30wQ+Of+1dH3w2YNUaEVbnxtfaOLKWMkzPkSyID5
2UxUschd7VC6/yNZ0PmGehS7E/b8MgDwDuwIsNwmkNh64HqFddVZ+Mij1wXuJ1lP
RBwCFTE1nBt32KXTFzQ5KF6u9b50xDxwrmJgdoyQlbhVABZSaTZMwkEKH0iTeh71
66hKcOnm0lJqmc5D6oKNDb4t4pdAe9ST5R5WPxSh2JWh5KTS0DUhYE/KP/W1Flzc
qTlFof5YI6siAgbTNhUc/6cyeo64a9jDp0Y0RwGNveI0JORC5u4CdrPeiKLGYztt
QJhR5qnu/knTlpJOyO33WDKEvedJ/dIL17IQ5hvnioTvI/okKPNlbw5DWxQKb2j5
WaqjgcJh5VoV8l0/8iLTvRm+uUHylte8uE2o6ir8FFp48ilWOyne/VVmq19AubhO
EvwP0ei4tjafbkRr4YQNHllQ7Fo8cT7K9Kuw7Y6tJuDDu37o+u6vuxANiMG30zrR
r4+ad6CuhNulNFNJm+CFZk91uFRKhAiFo9QQ45i3qm7+MAA+jX+Vz0sswJ5offEu
voW/l99js4AcVBIPEPo9M6ccHrpVzX+Nb0P4/rpeIVtD62iwn0a3gPTi06raA6iB
QUjnByE1mnw99ZW9Ut78
=osBJ
-----END PGP SIGNATURE-----

--nextPart19524941.1Ia1TABAlL--

