Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 11 May 2016 15:40:35 +0800
Message-ID: <1545762.9INA9ZfTkq@voltaire>
In-Reply-To: <16078999.daXBnunon6@bentobox>
References: <1462890719-2146-1-git-send-email-mareklindner@neomailbox.ch>
 <16078999.daXBnunon6@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7035989.9p0eMoIM93";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2] batman-adv: init ELP tweaking options
	only once
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

--nextPart7035989.9p0eMoIM93
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, May 11, 2016 09:29:22 Sven Eckelmann wrote:
> This needs to check if BATMAN_V is enabled:
> 
>     /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.
> c:689:31: error: no member 'bat_v' in struct batadv_hard_iface
> /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:6
> 91:31: error: no member 'bat_v' in struct batadv_hard_iface
> /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:
> In function 'batadv_hardif_add_interface':
> /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.c:6
> 89:24: error: 'struct batadv_hard_iface' has no member named 'bat_v'
> atomic_set(&hard_iface->bat_v.throughput_override, 0);
>                             ^
>     /home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.
> c:691:24: error: 'struct batadv_hard_iface' has no member named 'bat_v'
> atomic_set(&hard_iface->bat_v.elp_interval, 500);
>                             ^
>     make[2]: ***
> [/home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv/hard-interface.o]
> Error 1 make[1]: ***
> [_module_/home/build_test/build_env/tmp.Fco0ibFY6r/net/batman-adv] Error 2
> make: *** [all] Error 2

OMG. 


> This report was brought to you by todays build test [1] - the leading
> provider of "omg, batman-adv doesn't build cleanly"

YMMD! I propose that to be the quote of the month!  :D

Cheers,
Marek


--nextPart7035989.9p0eMoIM93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXMuHzAAoJEFNVTo/uthzAAeAH/i13Pe3ln0OfVIDYuIu6l9Dh
k73Hk9cGyJbXnkm4taqhq6QUT4We6VxrASp8yLfqJhVOD3dz24qf7M/xj6wc1KOX
Fo65y/GS+0VClvoLjqDInyQZkIXvk6gy5TJ0EPJIpBju8Ipi5QOUGnY56GDD0TRD
YZiZ8EoAOwygfrOdEwXyOpSa2Aj1jxhCoCDp+qnaffaa1LugPL+hUSaBfyQ0YSwK
vwcIVjN5OFa69iESOgyd+OyawQZzc8p+Fy38/qhDT+Vm2AHENgM8+9c3bUWPNHMJ
ZEYgoPoBnFfkY8uKmXeraq72600/y1dS/RpRPKHY3xqJ4lIU4pZ4xXxypci7sh0=
=b3xO
-----END PGP SIGNATURE-----

--nextPart7035989.9p0eMoIM93--

