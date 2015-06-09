Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 09 Jun 2015 22:43:47 +0800
Message-ID: <2189944.odvLXYXy1N@voltaire>
In-Reply-To: <1432658067-14370-2-git-send-email-sven@narfation.org>
References: <1432658067-14370-1-git-send-email-sven@narfation.org>
 <1432658067-14370-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4961776.GhFVKNDXy4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: Avoid u32 overflow
	during gateway select
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Ruben Wisniewsi <ruben@vfn-nrw.de>


--nextPart4961776.GhFVKNDXy4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, May 26, 2015 18:34:27 Sven Eckelmann wrote:
> From: Ruben Wisniewski <ruben@freifunk-nrw.de>
> 
> The gateway selection based on fast connections is using a single value
> calculated from the average tq (0-255) and the download bandwidth (in
> 100Kibit). The formula for the first step (tq ** 2 * 10000 * bandwidth)
> tends to overflow a u32 with low bandwidth settings like 50 [100KiBit]
> and a tq value of over 92.
> 
> Changing this to a 64 bit unsigned integer allows to support a
> bandwidth_down with up to ~2.8e10 [100KiBit] and a perfect tq of 255. This
> is ~6.6 times higher than the maximum possible value of the gateway
> announcement TVLV.
> 
> This problem only affects the non-default gw_sel_class 1.
> 
> Signed-off-by: Ruben Wisniewsi <ruben@vfn-nrw.de>
> [sven@narfation.org: rewritten commit message, changed to kernel type]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> I am sending this because Ruben Wisniewski didn't fix the commit message
> (yet) and my earlier patch broke his proposed one.
> ---
>  net/batman-adv/gateway_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision f63c54b.

Thanks,
Marek

--nextPart4961776.GhFVKNDXy4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVdvujAAoJEFNVTo/uthzA8JgH/0oe+7e75ufCst9+hteBiwkx
HTlOG/EDThcU7s/WFauUNYKviCJiG7iG4S6B5FSDFunKwErz9OmtNfSKUGef5ufH
cri7Fwf7e+F7DpJmA+dxnaQ8XL71TNxyvpIs0tbF9N305/FOCPMMAMs6yMkEr+Aw
cjatM1KkwqwkeZ6aiPa6DXv8AFDfwpKCGoUgkQvicGGxdZr79MGZF/WveDMXTrqg
BQNdUmIa18+SSZG37u8k7kXGpaeHJ49DpZ+lhLp2Mbt3+V6hn8zIV5P12JmkR6hZ
Ze7VI/jE1cmiXlOVq5Rh7S8CcoUFCoirMNqajL2PAnL8gG2KLxi9oK3ZJAIWwB8=
=Zq4l
-----END PGP SIGNATURE-----

--nextPart4961776.GhFVKNDXy4--

