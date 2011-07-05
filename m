Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 05 Jul 2011 16:08:16 +0200
Message-ID: <1352247.13aSduvyXD@sven-laptop.home.narfation.org>
In-Reply-To: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
References: <CAOaDhSS0-EP6bPM+2kho3h9u8aGJXsP0QmaqFMAhHa_4Y=MA4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1678793.qJBpiz7UI1";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] batctl vd dot buggy
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart1678793.qJBpiz7UI1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Tuesday 05 July 2011 15:56:37 Gioacchino Mazzurco wrote:
> on our server we have batman-adv from 2.6.38 kernel
> 
> the output of batctl vd dot results buggy
> 
> eigenServer gioacchino # batctl -v
> batctl 2011.1.0
> 
> as you can see here http://eigenlab.org/status.php a lot of blue
> cluster are missing also on node with multiple interfaces so the
> topology draw is badly affected by this :|

What about providing the output of /sys/kernel/debug/batman_adv/bat0/vis_data 
and giving a better explanation what is missing? Showing some pictures and say 
that something is missing without any details will not help anyone. And no, I 
can't read italian.

Kind regards,
	Sven
--nextPart1678793.qJBpiz7UI1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOExrQAAoJEF2HCgfBJntGg4sP/0yyskyYIN77lxFt8ZJF/Cvo
Put7N/yftFJrNA40Mj0KQA1TN8pCodAzbpfNsT+RNB4sOzl0ZXB2SRxfy6wF+t9q
+Wnqn4Ig/4Rt3OwF8xM7RiPEzK6V4FILVRGs9RFv744Me+R7BnCj6+89roVFHc4B
fZw7q4vk01hHPcbTqnOFCIvw5AAK7sWqeoDhEINOmky18gXX1X/3ZrVRnIz1q52h
gQVPl1k6e+Z7FJzQHi0haNz50F/tL3jyxVUpfpqlMOEDh2OiEyG7YkVg+5Ef2ZbG
27xWxu2hzBr2VxjSR41zKdT3sIwc6DaRCdz9Via6tcl3mjwxBPtm2J0/rprqvfdG
CPM9bwHJJplQ9mLzPbQUCqUQyWn0PpGc3o7M+fy7hwkLcavXoJJFMAssI9ahBEu/
o1LDkXpsL/z9FBmLjrkNNN+Kp8wFjraAmjh1CNzwYwZfjFvdMT/wl72T2k7FurPF
eVcMNJ6IlUsiMHBDgWTkcm36OMkBPw6z5CPxcHBS2i1/xs5mAGEvH4YthbN/YpAa
RakAHt47+att8T7sOPsk6MF++1ilUhMJobZ/puH9p1ADbzxDFR8lfL+yk3amrNvr
R5S3gdnLbfuj3mNKHFe7Ddl88l8TadP6dedcneyY/sIqmVlFevXk2wWZLcqnwUW9
U/O4qy7dKbQzatWnVLRn
=tuhd
-----END PGP SIGNATURE-----

--nextPart1678793.qJBpiz7UI1--

