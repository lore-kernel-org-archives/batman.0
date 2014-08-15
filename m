Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Aug 2014 13:13:13 +0800
Message-ID: <3486850.VCLybl6GSa@diderot>
In-Reply-To: <53EC7E6C.7000900@aliyun.com>
References: <53EC5D49.5000705@aliyun.com> <53EC7E6C.7000900@aliyun.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2258042.RPhkZY56ky";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] how to compile the latest version of batctl in
	OpenWrt 12.09
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


--nextPart2258042.RPhkZY56ky
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 14 August 2014 17:16:28 liu wrote:
> Now I switch to version '2013.4.0' of batman-adv.But when I run this
> command 'batctl if add wlan0-1', the system crash. And it works well in
> version '2012.3.0'. I want to know which version is suitable for OpenWrt
> 12.09?

We don't track which OpenWrt versions work with batman-adv. Technically, you 
have to check for kernel compatibilities. If the kernel is newer than batman-
adv it probably won't work. Newer batman-adv on older kernel has a good chance 
of success.

Cheers,
Marek

--nextPart2258042.RPhkZY56ky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJT7ZbpAAoJEFNVTo/uthzA6vEIALYxdVFAVB6SHD7DdexHhopD
RQZ4xt4A/lAw/YIm6Q1jNc2/mAmvUYzGW5t6Mozp5ATukpPtLck7O4BdDyk4slMA
/JHNbakCIFGWTiOXVL51xakQUUrGNeyPOyiPbA/NKUDZzhMc3s3looO1wA8PViYl
RSuNNzfN+1KVZ4sqDURkUivBScZz/KpBfZ3WUr5q8oWCCrwY270CeEgDTuB0/QVY
+H2Mw2JpO1JXBmdsjX6WZdyuWa4/hRi9ZJSg7JT76XoO/DDwihcfhvLLx4E06qGw
zJURG7DVpA1LDL3ebxK+FMkwRJMYFsMj2fkJHfrbBjzgxMklMg2YLwE6yNQaHHE=
=Qvfs
-----END PGP SIGNATURE-----

--nextPart2258042.RPhkZY56ky--

