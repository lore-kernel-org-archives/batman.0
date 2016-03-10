Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 18:48:23 +0100
Message-ID: <2877704.F65L7Zjf4e@bentobox>
In-Reply-To: <1379759294-1481-1-git-send-email-antonio@meshcoding.com>
References: <1379759294-1481-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4191287.idDQlLLrEW";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: fix DAT candidate
	selection (must use vid)
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart4191287.idDQlLLrEW
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 21 September 2013 12:28:14 Antonio Quartulli wrote:
> Now that DAT is VLAN aware, it must use the VID when
> computing the DHT address of the candidate nodes where
> an entry is going to be stored/retrieved.
> 
> Introduced by: 3e26722bc9f248ec4316749fc1957365c0fa5e4b
> ("batman-adv: make the Distributed ARP Table vlan aware")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---

It looks like this patch doesn't apply anymore. Can you please resent it or
mark it correctly in patchwork [1].

Thanks,
	Sven

[1] https://patchwork.open-mesh.org/patch/3427/

--nextPart4191287.idDQlLLrEW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4bNnAAoJEF2HCgfBJntGlhIP/3oWJKnqbH5BYNlJxvXwdmNj
Gf0hc9D3ZhzWVvdF215E5Tt264iij5QH1IYQ2OfC40CODelXQ42MXlP5hRyW3iki
RqUsPDLB33Mu6hsA7u7q2K1e4TO68XOOFiDjE95mNGE2pxTQdlREVffIAEGU0DVn
mIkWGGu/eUDil9OuXGtJAsKN1XAHIX9XQAhFz5YcXz4utxQM2b1ZttMRdpcBxUpz
ovZyzOhtiMTxf4mMgz1XNsLcdiEsPSmybauyWnkSk8w9wWcuMzTiKu3QZ7go01oo
u49cpbBAKsltdFBIqWkv0DDeRtB0XvTZyTDER+8ZJbUhwgWYYt2rpiAyrcH0ykO9
IUnWfqAUwAZGFhPzAQJqpZ9p8EF2hjOxQ8UV+uasDQiS8QfTAijJHhfSuUksxMki
BNG7yKO3G9kG8fL6m+Xr+fLtxuHdXQUoQuRyIvkmKUaqAqiZ0jCBeUaRwdDuE5dS
JghSApBTgxWvMw1KMD579g+uolFkzFGDy7DlFQLPWZutyoxlYfXWXt4zV1EqSqoD
Vdyg1LySFXir9rZSqo/24R0Yix9HtudxsY/9cwP0XZ7UeuPSgBL8i0nN8sj3yKTM
HuEPojk6Ezn5IkbxaaMNAbFCa6yXLs25tmde+EdlwS2a4KIw9j21qCIDVanPRuCZ
dXydpbn0j+7HkHAQGHOe
=cVP3
-----END PGP SIGNATURE-----

--nextPart4191287.idDQlLLrEW--

