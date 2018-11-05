Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 05 Nov 2018 13:41:17 +0100
Message-ID: <2356284.qJOkjcCIOy@bentobox>
In-Reply-To: <20181105114754.GE2095@nanopsycho>
References: <20181104193314.18104-1-sven@narfation.org>
 <39526497.qhSXs3GhTV@bentobox> <20181105114754.GE2095@nanopsycho>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1974096.HJgMmCSp1M";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add infrastructure for
 netlink config manipulation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Jiri Pirko <jiri@mellanox.com>
Cc: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart1974096.HJgMmCSp1M
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Montag, 5. November 2018 11:54:12 CET Jiri Pirko wrote:
[...]
> >
> >But let assume for now that you don't want to use this approach, we can also 
> >have for example something like:
> >
> >BATADV_CMD_SET_BRIDGE_LOOP_AVOIDANCE which then receives either one or no flag 
> >BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE to enable/disable bridge loop avoidance. And 
> >a command BATADV_CMD_GET_BRIDGE_LOOP_AVOIDANCE which tells the client using 
> >BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE whether it was enabled or not. A dump 
> >functionality for all options for this batadv object/class would then not 
> >exist.
> 
> Got it. That is possible to do it this way. But if you would be able to
> group the attrs somehow, that would be probably nice. 1:1 mapping
> between cmds and attrs looks a bit weird.
> 
> Sidenote: I suggest not to use NLA_FLAG attribute type. Better to use
> NLA_U8 of value 0/1. NLA_FLAG missing in message might mean 2 things:
> 1) user wants to set false
> 2) user is old and does not support this attribute

Ok, let me suggest something more specific (just to make sure we talk about 
the same thing). We could use the commands:

+       /**
+        * @BATADV_CMD_GET_OPTION: Get option(s) from softif
+        */
+       BATADV_CMD_GET_OPTION,
+
+       /**
+        * @BATADV_CMD_SET_OPTION: Set option for softif
+        */
+       BATADV_CMD_SET_OPTION,
+
+       /**
+        * @BATADV_CMD_GET_OPTION_HARDIF: Get option(s) from a hardif of the
+        *  current softif
+        */
+       BATADV_CMD_GET_OPTION_HARDIF,
+
+       /**
+        * @BATADV_CMD_SET_OPTION_HARDIF: Set option for hardif of the
+        *  current softif
+        */
+       BATADV_CMD_SET_OPTION_HARDIF,
+
+       /**
+        * @BATADV_CMD_GET_OPTION_VLAN: Get option(s) from a VLAN of the
+        *  current softif
+        */
+       BATADV_CMD_GET_OPTION_VLAN,
+
+       /**
+        * @BATADV_CMD_SET_OPTION_VLAN: Set option for VLAN of the
+        *  current softif
+        */
+       BATADV_CMD_SET_OPTION_VLAN,
+

But instead of using BATADV_ATTR_OPTION_NAME+BATADV_ATTR_OPTION_TYPE+
BATADV_ATTR_OPTION_VALUE to send the infos up, we have a number of specific 
netlink attributes [e.g. BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE (u8)] that are used 
to exchange the value directly.  Multiple attributes can be in the messages 
and dumping is possible but maybe requires to split all option in multiple 
messages. Informational dumping (user readable) is then only possible when the 
userspace part also knows all attributes. And sending things to the kernel is 
only possible when the userspace also has explicit support for the attribute.

This is at least similar to how I did it in two previous projects but dropped 
this approach when I saw that it was implemented differently for devlink and 
team.

Thanks,
	Sven
--nextPart1974096.HJgMmCSp1M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlvgOm0ACgkQXYcKB8Em
e0ZzYw/+NfIs+VGvUZsxOYRWiO47UFvbGXGDY6QIkowKFPMfEqAJq3sGEzZ2ckdn
NPxoFHZgT70kZHtsCuTCMRf6Uf0jgo4lOP/u7zboeYv6X0szGCAUX3pDSZtO7qUi
ry+QZ4H59Z2TZOqnY9s9nDcaAoUYgGOLuBJQTg2SdCTZzsmeW9VgU0OPwzvYKgu2
Ytj1g41n2WsopTHFMK/LStX6XRtf/fqMcnKeh5LlyBB+WqcXg1o+/LB18JDeZNet
0qUzvzGYTCF2g1VfU28BfCyliYIWW04NBAc1jltJIpoyB0HLOhRmplJuJNdBk+n7
JAtakpYtS4cHccFme5d0YP9ElbnZmgZdyWU1dvZsnLJd7XW2cf7xCIdE+AVZUunj
yUd6lTmZZ1ngH9XDQ13hkE0ukKrAMR2tH5AziNxHT4H/SpOLKUtur3n6yMjKe0FW
ZjWDeEykWaNsIxV4uOdh+nK7JMyvbdH88kyXTUDTyf3xdBPVr9rn/mV0OyNQW7wk
9Nz8sSGs+nkgVCVTmFBwaYmd65w2GnlPVDvGDYx2J7p9X0vzMb8cgByGIapvrnis
WF5DB5FUdOgKbTdML6xlZioC0lNOoU3uV6bdcF/L4wDrQ5eJSP1HngvP2BlU6Ik3
DYMZYPIL95F238WQ+j3e5nVdfc92BFs15wGcEXaE1N8CRCz1NFg=
=sUiy
-----END PGP SIGNATURE-----

--nextPart1974096.HJgMmCSp1M--

