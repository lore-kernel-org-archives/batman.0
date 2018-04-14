Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 14 Apr 2018 09:10:26 +0200
Message-ID: <1658833.3ZLkxubxK8@sven-edge>
In-Reply-To: <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
References: <20180413181618.24144-1-sven@narfation.org>
 <78ec0422-9046-3db1-6a81-4c1c7d0c9968@unstable.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3889612.qHIm1ln3XK";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Validate translated mac addresses
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, Andre Kasper <Andre.Kasper@gmx.de>, linus.luessing@c0d3.blue

--nextPart3889612.qHIm1ln3XK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Samstag, 14. April 2018 04:34:42 CEST Antonio Quartulli wrote:
> 
> On 14/04/18 02:16, Sven Eckelmann wrote:
[...]
> We already handle the case of multiple originators handling the same MAC
> address, no? In that case I think we pick the "best" originator.

Yes, but this doesn't make a lot of sense for multicast and zero mac 
addresses. The translate layer of batctl is usually used to ping/traceroute to 
some originator. But multicast and zero mac addresses don't represent a 
"client" which can be used to identify some originator. So it doesn't seem to 
make sense to allow them here.

Or even without the ping/traceroute stuff, the concept of calling `batctl 
translate` should give you an answer which you can understand. So it should 
tell you that batman-adv is very likely to transmit a unicast packet with this 
destination address to this originator. But this cannot work for multicast 
destination addresses because multiple answer should be given here - which is 
out of scope for this command. Which reminds me that I should propose a second 
patch which checks whether the input for translate_mac is "valid" before 
trying to translate it.

> This case sounds more like a validity check because "a zero MAC should
> not be in the translation table", or am I wrong?

Partially, yes. I personally don't care (at the moment) whether there is a 
zero mac address in the translation table. The current translation table code 
(batadv_tt_local_add) doesn't check whether there is a zero mac address 
(is_zero_ether_addr). But Linus had some ideas when zero mac addresses can be 
useful - maybe he tell us whether it makes sense/problems to have them in the 
translation table.

Kind regards,
	Sven
--nextPart3889612.qHIm1ln3XK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlrRqWIACgkQXYcKB8Em
e0Yjpw/8D/GvuTx8ay8Xg3rJUvjJuiqMozvMmfaAj23e61eLERQ485X+LIacuXss
ilwVOxgcDERGXMQmbg6TFIuvZvJJNh5hAEydtvkEfbV/h1Plzbm8Tp+7wVoUcMPK
SF0ha3QdOxaaDmHu+q/2CrRdrgETMbtbQRwHW84b6iihNuYmj7o6cfFlvC95TQHX
mrHOv/N5UYhRPUg7mTYNYbIIhBpIBFWx9YGQZH2Vc5kKF9OLkQxXNDmCXUMzqpJi
IAjCF2oPU/DrXkyF7YIphcaJVAfFtzHm7HQ64lWOYRJhc+rLrOgROm6BZ8iXC6qG
58Xvz5a9gtoMqV57J9NQrXZ5l+rD8yz0RlJ7N7/Dhdo7fQT98EPnIVvA/Llug5NQ
VmC3b6enQb960ZvHUHPV7E6i/VlntwOwKKLL3r8qWhOR0gsEjwvRLrMrR42Z+jxW
lKzRIlGlrUQv6ASpTqP7/T3Q289uLCNPjiCgeiiAkRB9K7YrHrlE7HSS7yRk6Wch
faCDF6vwQmfhaMWSTUct4tCEXw8TP4T49da9mshVxvToqlDAfpqmXFXD90zZM915
aSIw6g3delLGz9Or3IVzihP63DQt9c5f4VgubM/YcsBgyAFo9K89pqjsPlnaPjtv
os5rkO179Fl7Hwibbj0FQmb1Xzd+8Wb80TJdSMUJ8iL6Wxe8FvU=
=LIF/
-----END PGP SIGNATURE-----

--nextPart3889612.qHIm1ln3XK--



