Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 01 Sep 2018 11:08:45 +0200
Message-ID: <3277849.7XWcqIUx8F@sven-edge>
In-Reply-To: <3991773.ZLWj8GO7DM@bentobox>
References: <2791173.mX5NbDZpiX@sven-edge>
 <733b64f0.dcd9.1658f661fb2.Coremail.heishuihe2008@163.com>
 <3991773.ZLWj8GO7DM@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2637531.fTVqlZoqRh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Recent test result. Re:Re: Paper "Performance
 Evaluation of BATMAN-adv Wireless Mesh Network Routing Algorithms "
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ligang LIU <heishuihe2008@163.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org, a@unstable.cc, mareklindner@neomailbox.ch

--nextPart2637531.fTVqlZoqRh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 31. August 2018 12:30:00 CEST Sven Eckelmann wrote:
> Especially because this frame will now be dropped over some interfaces. We 
> already saw this in the past with fragmented frames [1]. You can increase the 
> size in batadv_v_elp_iface_enable by adding the number x to the alloc and the 
> skb_put. For example 44 to get to the minimum ethernet frame size:
> 
>     hard_iface->bat_v.elp_skb = dev_alloc_skb(size + 44);
>     ...
>     elp_buff = skb_put_zero(hard_iface->bat_v.elp_skb, BATADV_ELP_HLEN + 44);

Just as clarification: This should not be relevant for your problem. It was 
just observed that the ELP [0] documentation talks about more padding. The 
underlying driver is usually only adding extra padding when required (e.g. 60 
bytes ethernet).


More relevant here would be whether the duration in the RTS/CTS frames look 
odd. Or what else prevents the devices in your six node setup from sending 
between each other.

Kind regards,
	Sven

[0] https://www.open-mesh.org/projects/batman-adv/wiki/ELP#section-9
--nextPart2637531.fTVqlZoqRh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAluKVx0ACgkQXYcKB8Em
e0a9DQ//VkgL9F0u6UYQX5QGL903ysq1ajaRtJEFHJ+QAXCB+9twDpdG6bhX0N4s
nrwV60mXzO+/lPpDhpfaYIBY76MOG9rXBh8rMiGKz2uc7GHvvP8UydOC0KzR6AJh
8NzwPCVzX8otNTncuoAezGHECPLtGcDJ/qEuKrlWXC+EZnyKY7T+CKH4dJpld76C
70248l3Mr1Fg54abd2LZu9wlCq6k4WS5erJRHY7BsgwW0OoZlpAagku8KQBQ0MK0
tc+vjaj4C9Plv+gDpKXZ4st9NEubE00ecE1RHAE2kurLBq7ZaJj9nOqbSQ41ocZ6
AcrolDAiLx3v3stKOTDl2ZY72O/lx83aF0QP0idUc1HQlc8+lLp3AfCOBkH5MlLb
jgMJ8KumlKMT0eZWKKXm72ymXtuD/o//FzEAfI13zFMand22gJkFTOF0nyalr9du
LQfvd6awV7Ssexz/AWGrZM28qKF1/XrTKQm/HZ49v/oRH5iIJoXFqNr9RHA+iUKD
HeY5o1tjgzzOq0m8hRCCjzzWCUAiSacybtsMyyjV8v8NH2i2ZIxcougAeA3n5Vb7
RUE5V5rnBGJyqZuzaXK3QHSuGRsrVsrD1hZj85kqC2wfZda82Prh9Z3vECQcoJ8w
A18vtHVc5jdlTgVVwbbnkX2VHbjaVdf1YrAcwHqCfRSznjEBwr8=
=/Dbn
-----END PGP SIGNATURE-----

--nextPart2637531.fTVqlZoqRh--



