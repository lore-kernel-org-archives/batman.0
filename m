Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 03 Jun 2018 15:16:45 +0200
Message-ID: <1847557.dqDVcpqQQY@sven-edge>
In-Reply-To: <20180601172424.7821-2-sven@narfation.org>
References: <20180601172424.7821-1-sven@narfation.org>
 <20180601172424.7821-2-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2986545.dyvWTUP43T";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH maint 2/2] batman-adv: Fix debugfs path
 for renamed softif
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

--nextPart2986545.dyvWTUP43T
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Freitag, 1. Juni 2018 19:24:24 CEST Sven Eckelmann wrote:
> batman-adv is creating special debugfs directories in the init
> net_namespace for each created soft-interface (batadv net_device). But it
> is possible to rename a net_device to a completely different name then the
> original one.
> 
> It can therefore happen that a user registers a new batadv net_device with
> the name "bat0". batman-adv is then also adding a new directory under
> $debugfs/batman-adv/ with the name "wlan0".
> 
> The user then decides to rename this device to "bat1" and registers a
> different batadv device with the name "bat0". batman-adv will then try to
> create a directory with the name "bat0" under $debugfs/batman-adv/ again.
> But there already exists one with this name under this path and thus this
> fails. batman-adv will detect a problem and rollback the registering of
> this device.
> 
> batman-adv must therefore take care of renaming the debugfs directories for
> soft-interfaces whenever it detects such a net_device rename.
> 
> Fixes: 230202d4b530 ("batman-adv: Move device for icmp injection to debugfs")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>


Added as 3f2237bb191c [1]

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/3f2237bb191cd17654a4d5a5badfd6e7379c4b37
--nextPart2986545.dyvWTUP43T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlsT6j0ACgkQXYcKB8Em
e0ZNMg/+LnKUAm4G5nSxYD/1w7XLfG5uYzHJnnZEaAg805EIXOmldjWJMVL86E8m
vOwJY0zURxDvd3zZHVKdFLhBQsOsVuPfhz9OMpcAaig70943wbF7lpy/5vWglh7F
sl9VmOtPNSL7i9YBpU3Snat6NVySX6ofuyMkwFtkxzOy+EtFd7bGZfHeQiEfU+xO
q5qAlNOA36J8g+6bTl16AZlRb/f3CWqB8yPEZXgBx/Z/fQCrk2EddyIcrD8RgWfo
FbEznOQsSWok8izRo/0MCuH8wZbJ7yW5YpoGxo28nT9F2Tk2ZnpSXNI87StMOZvj
z3WgFhPyr0hKWahNi1wMnduN/pKTrVcsjp3sLQn66qySF3NGLXoYI0diuuUFrP0x
oNiCju/xd9i5ENhgBQfcXkGrXqIZvw4Z8akzFGuJSUlS9tRF+Hg2dLXn7BYkatFL
O0qlVo13JqaagHr29NqZES9U0l0XUX4Cy/pYgv9p1kU6D4991TCJbjkyUc5lGE/P
Bi7B4sByjx6Px4jce0BZSNuiVxRcpAZK2BYbzYV529tSQhcRRDgDlojTQJyRl0NK
3sjGKpXShTiWTKDDWCJwrOqdNunt32QwNkERbP9blA3SZzdPoa6Y/EqSnOll7rST
eG+dKATmhtpYdx4S9SkeiXcmmgCoYWe5HZBmOVc9vbQ2i3i5eeE=
=W1/N
-----END PGP SIGNATURE-----

--nextPart2986545.dyvWTUP43T--



