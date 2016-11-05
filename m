Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 05 Nov 2016 12:25:46 +0100
Message-ID: <6878609.IJnMAHbfGn@sven-edge>
In-Reply-To: <20161101084444.17429-1-linus.luessing@c0d3.blue>
References: <20161101084444.17429-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4428769.mg2ty1LU7H";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] batman-adv: fix rare race conditions
	on interface removal
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

--nextPart4428769.mg2ty1LU7H
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 1. November 2016 09:44:44 CET Linus L=FCssing wrote:
[...]
> ---
>=20
> Changes in v4:
> * rebased to master
> * tried to better explain the severity in the commit message
> * trimmed call trace in commit message
> * made code comments and the WARN_ONCE less funny, but more informative
> * reworded bm_list to cleanup_list
> * shortened batadv_forw_packet_steal() declaration in send.h
>   to avoid a faulty checkpatch warning.
> * removed unnecessary hlist_add_head() in batadv_forw_packet_steal()
> * changed hlist_del() to hlist_del_init() in batadv_forw_packet_steal()
>   -> to be able to reach WARN_ONCE instead of crashing upon calling
>      hlist_del()

Thanks for all the changes. Lets see if we finally got this one (please no
regression, please no regressions, ...) :)

Applied in 8a436b94d731873bd3d771aa146956420fbec458 [1].

Thanks,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/8a436b94d731873bd3d771a=
a146956420fbec458
--nextPart4428769.mg2ty1LU7H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYHcG6AAoJEF2HCgfBJntGtUEP/j1KlVCWZYubmuoW2D4zNvei
DcKeEk4QICjRp1XmYcyNcCp31ToI4YlqwO28VJ8G+HWCxH7vkOQj8jgvZhBNUcHC
u6DI3g9RqPMg/N7YvbQ5u4gHCPyfiWGg0xReQVF3bQJkGCBRt+kclO1UPDF8YtzJ
p3hIzvHvlHcWTM8UvTRDLN2/jSFXaw3hAbF9j8u/Heh0oWCQ5O/Cmk2fHy9yTgTC
4+T3tGfcGeDudz1/iwgbGO21+Ng7UFN70hH39TDA9DLFwUz3uRTi9Veqaw9OlAIk
RGatDmqquFuUIwdC2dxIpZUlOGvdTs3dOa437n/tJYdUrkM+T+3nfup9HnkyO34E
KFd9ascja3vJu0jBpRq6ngKCBuIXifIzZwIFq2BHurKKr3Wd+I59w6+d+qnIMEOX
2Qn88NLHALr/d/YbwhMfMDLjr1Vc2cU+UETpqUb9Hrauw5xw/TusqJBRIu237Dqi
OGMeEXK5cUjek2jicZqtuZQHcP0Itjv9SDrJjuOVZ3SugLKu3yAhk4dsHVSDesbw
BX2Nr2GeNKfx807q9TMqKSDVdIw+3jkpE3TmkPhpX1cLIpTw+xHQL030+mVRT+7Z
J+UkP9WrWxP3AX3UyeaSrRqXlCKJv4JLH53fk3GqE07qatbsQuUWSOL3H/4llVf4
iiScj1M5bjnYVuSPZKET
=61Sx
-----END PGP SIGNATURE-----

--nextPart4428769.mg2ty1LU7H--

